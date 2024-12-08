namespace :votes do
  desc "Clear all votes at the end of the day"
  task clear: :environment do
    puts "Clearing all votes..."
    Vote.delete_all
    puts "All votes cleared successfully!"
  end
end