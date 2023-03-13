# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

users = User.create([{ name: 'John Doe' }, { name: 'Jane Smith' }, { name: 'Bart Simpson' }, { name: 'Lisa Simpson' }])
puts 'Created Users'

Follow.create([
                { from_user_id: users.first.id, to_user_id: users.second.id },
                { from_user_id: users.first.id, to_user_id: users.third.id },
                { from_user_id: users.first.id, to_user_id: users.fourth.id },
                { from_user_id: users.second.id, to_user_id: users.third.id },
                { from_user_id: users.second.id, to_user_id: users.fourth.id }
              ])

puts 'Created Follows'

# date = Date.today
users.each do |user|
  (1..10).each do |n|
    sleep_date = n.days.ago(Date.today)
    clockin = n.days.ago(DateTime.now)
    sleep_duration = rand(4..10)
    sleep_duration_seconds = sleep_duration * 3600
    clockout = n.days.ago(DateTime.now) + sleep_duration.hours

    Sleep.create!(
      user_id: user.id,
      date: sleep_date,
      clockin_at: clockin,
      clockout_at: clockout,
      duration: sleep_duration_seconds,
      created_at: clockin,
      updated_at: clockout
    )
  end
end

puts 'Created Sleeps'
