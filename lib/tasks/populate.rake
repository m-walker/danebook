namespace :db do
  desc 'Clear the database and fill with excellent fake data'
  task :populate => :environment do
    require 'populator'
    require 'faker'

    puts "Starting populator...\n\n"
    start_time = Time.now
    MULTIPLIER = 5




    # Blow away the existing data
    puts "Removing old data..."
    tables = [Post, Profile, User]

    tables.each do |table|
      table.destroy_all
      ActiveRecord::Base.connection.reset_pk_sequence!(table.table_name)
    end
    puts "Old data removed.\n\n"




    # Add new data
    puts "Adding users, profiles, and posts..."
    password = "password"
    User.populate(MULTIPLIER * 5) do |user|
      user.first_name = Faker::Name.first_name
      user.last_name = Faker::Name.last_name
      user.email = "#{user.first_name}.#{user.last_name}@gmail.com".downcase
      user.password_digest = User.new(:password => password).password_digest

      Profile.populate(1) do |profile|
        profile.user_id = user.id
        profile.dob = Date.new( rand(1950..1990), rand(1..12), rand(1..28) )
        profile.gender = ['male', 'female', 'other'].sample
        profile.college = Faker::University.name
        profile.hometown = "#{Faker::Address.city}, #{Faker::Address.state_abbr}"
        profile.current_city = "#{Faker::Address.city}, #{Faker::Address.state_abbr}"
        profile.phone = Faker::PhoneNumber.phone_number
        profile.words_to_live_by = Faker::Hacker.say_something_smart
        profile.about = Faker::Hipster.paragraph
      end

      Post.populate(2..10) do |post|
        post.user_id = user.id
        post.content = Faker::Hipster.sentences(rand(1..4)).join(' ')
        post.created_at = Faker::Time.between(DateTime.now - 3000, DateTime.now)
      end

    end # User

    u = User.first
    u.email = "siakaramalegos@gmail.com"
    u.save

    puts "Done populating!"


  end #task
end #namespace
