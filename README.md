# Goodnight API

## Primary Functions
1. Clock In operation, and return all clocked-in times, ordered by created time.
2. Users can follow and unfollow other users.
3. See the sleep records over the past week for their friends, ordered by the length of their sleep.

## Additional Functions
* Included seed data
* Returns a message after a successful clockout
* Returns a message after following a user
* Return error messages for the following cases:
  * User tries to clockin while there is an incomplete sleep (has clockin without clockout)
  * User tries to clockout without a clockin
  * User tries to follow the same user more than once
  * User tries to unfollow a user not currently being followed
  * User tries to follow themselves
  * User tries to get the sleeps of a user they are not currently following
  * Invalid user IDs are used on the endpoints

## Runtime requirements
* Ruby version `3.2.1` installed
* Rails version `7.0.4.2` installed

## Starting the API
* After downloading/cloning, open a terminal, `cd` into project directory and run `bundle install`
* Create the database. Run `rails db:create`
* Run the migrations. Run `rails db:migrate`
* Seed the database. Run `rails db:seed`
  * All seeded `Users` have `Sleeps` but not all are following other `Users`
* Start the server. Run `rails s`

## API Endpoints
* (GET) `/users`
* (GET) `/users/:id`
* (POST) `/sleeps/:user_id/clockin` - Primary function 1
* (PUT) `/sleeps/:user_id/clockout`
* (POST) `/users/:user_id/follow?user_id=:user_id`  - Primary function 2
* (DELETE) `/users/:user_id/unfollow?user_id=:user_id` - Primary function 2
* (GET) `/users/:user_id/following?user_id=:user_id` - Primary function 3
