# Heroku Postgres Backup Downloader

This Ruby script creates a new backup of your Heroku app's Postgres database and downloads it to your local computer.

## How it works

[Heroku's pg:backups](https://devcenter.heroku.com/articles/heroku-postgres-backups) tool provides a command line interface for managing your app's database backups. This script executes a series of commands that generates a new database backup and downloads it to your computer.

Here's an example of how to use it:

```ruby heroku-pgbackup-downloader.rb myappname /Users/username/backups```

 The script will then download a database backup to a file called `myappname - timestamp.dump` in the supplied directory where timestamp is replaced with a timestamp indicating when the backup was created.

 You can schedule this in a cron job to download periodic backups of your app's database.

## Contact

If you have any suggestions or find a bug drop me a note at [@mhmazur](https://twitter.com/mhmazur) on Twitter or by email at matthew.h.mazur@gmail.com.

## License

MIT © [Matt Mazur](http://mattmazur.com)
