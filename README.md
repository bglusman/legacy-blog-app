# legacy-blog-app

This project is a [Rails](http://rubyonrails.org/) application used to try out
[coverband](https://github.com/danmayer/coverband) on Heroku.

## Dependencies

To run this project you need to have:

* Ruby 2.1.2 - You can use [RVM](http://rvm.io)
* [PostgreSQL](http://www.postgresql.org/)
* [Redis](http://redis.io/)

## Running the project

1. `$ bundle exec foreman start` - Opens the server
2. Open [http://localhost:3000](http://localhost:3000)

## Collecting coverband coverage during development

After trying out the app:

1. `$ bundle exec rake coverband:coverage`
2. Open the `coverage/index.html` file that was generated on a browser and have a look at the results.

## Collecting coverband coverage from heroku

After trying using the app for a while over there:

1. `$ bundle exec rake coverband:heroku:coverage`
2. Open the `coverage/index.html` file that was generated on a browser and have a look at the results.

## Cleaning up coverband coverage stats from heroku app

1. `$ bundle exec rake coverband:heroku:clear`

## Generated with PAH

Generated with [PAH](https://github.com/Helabs/pah), an open source project created and maintained by [HE:labs](http://helabs.com.br).
