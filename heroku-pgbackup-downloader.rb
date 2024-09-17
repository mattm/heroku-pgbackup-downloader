module HerokuPGBackupDownloader
	HEROKU_PATH = "/usr/local/bin/heroku"

	# Download a backup for an app to the local disk
	def self.run(app, local_directory)
		puts "Running backup script for #{app}..."

		# Create a new backup
		new_backup_id = capture(app)
		puts "  New backup id: #{new_backup_id}"

		# And finally download a local copy of that backup
		new_backup_url = url(app, new_backup_id)
		download(app, new_backup_url, local_directory)

		puts "Done"
	end

	# Create a new backup and return the backup id
	def self.capture(app)
		puts "Capturing a new backup..."
		`#{HEROKU_PATH} pg:backups capture --app #{app}`

		info = `#{HEROKU_PATH} pg:backups:info --app #{app}`

		# Extract the backup id
		backup_id_regex = /===\sBackup\s(.+)\n/
		backup_match = backup_id_regex.match(info)

		# Return the new backup id
		backup_match.captures.first
	end

	# Returns the URL for an app's backup
	def self.url(app, backup_id)
		raw = `#{HEROKU_PATH} pg:backups:url #{backup_id} --app #{app}`

		# There's a new line character at the end we need to remove
		raw.gsub("\n", "")
	end

	# Download a backup given its URL
	def self.download(app, backup_url, local_destination_directory)
		puts "  Downloading new backup..."

		timestamp = Time.now.strftime("%Y%m%d%H%M%S")
		local_destination_filename = "#{app} - #{timestamp}.dump"
		local_destination_path = "#{local_destination_directory}/#{local_destination_filename}"

		cmd = %Q{curl --silent --output "#{local_destination_path}" --location "#{backup_url}"}

    `#{cmd}`
	end
end

raise "This script expects two arguments: the app name and the local directory to download the backup" unless ARGV.length === 2

HerokuPGBackupDownloader.run(ARGV[0], ARGV[1])
