# README

Parking administration fully functional, demo app.

- Ruby version

  2.3.3

- Setup

  git clone https://github.com/c0mrade/ParkingApp.git && cd ParkingApp

  Install the correct ruby version and necessary gems:

  - Use a Ruby manager such as rvm or rbenv. These will pickup the ruby-version
    and ruby-gemset from their respective dotfiles.
  - Install the gem `bundler`

    Bundle:

        bundle install

    Setup databases, using sqlite, should work after you've bundled without changing your `database.yml`:

        bundle exec rake db:create:all db:migrate && bundle exec rake db:seed

    Boot the app server after completing above:

        bundle exec rails s

    You can restart to seed data by using:

        bundle exec rake db:reset

- Demo Configuration

  App data for demo has 2 garages:

  1. 'LA Garage' has 2 floors, with each floor having 2 parking spaces, with total capacity of 4
  2. 'NYC Garage' has only 1 floor, with 2 parking space and total capacity of 2

  For the demo purposes 'LA Garage' first floor is fully occupied, and second floor completely vacant.
  Our 'NYC Garage' has one parking space occupied, and one available space left.
  Making our overall garage occupancy at 50% initially, accross all garages.
  Garage metrics can be seen on the app dashboard/landing page.

- Running test suite

        bundle exec rspec
