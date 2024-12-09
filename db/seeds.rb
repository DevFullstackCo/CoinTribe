# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

# Assurez-vous que la crypto avec id = 1 existe
crypto = Crypto.find_by(id: 1)

if crypto.present?
  # Créer plusieurs enregistrements de VotesHistory pour le crypto_id 1
  VotesHistory.create(crypto_id: 1, user_id: 1, is_bullished: true, voted_at: Date.today, created_at: Time.now)
  VotesHistory.create(crypto_id: 1, user_id: 2, is_bullished: false, voted_at: Date.yesterday, created_at: Time.now - 1.day)
  VotesHistory.create(crypto_id: 1, user_id: 3, is_bullished: true, voted_at: Date.yesterday - 1.day, created_at: Time.now - 2.days)
  VotesHistory.create(crypto_id: 1, user_id: 4, is_bullished: false, voted_at: Date.today - 10.days, created_at: Time.now - 10.days)
  VotesHistory.create(crypto_id: 1, user_id: 5, is_bullished: true, voted_at: '2024-12-01', created_at: '2024-12-01 10:00:00')
  VotesHistory.create(crypto_id: 1, user_id: 6, is_bullished: false, voted_at: '2024-12-02', created_at: '2024-12-02 14:30:00')
  VotesHistory.create(crypto_id: 1, user_id: 7, is_bullished: true, voted_at: '2024-12-05', created_at: '2024-12-05 17:45:00')
  VotesHistory.create(crypto_id: 1, user_id: 8, is_bullished: false, voted_at: '2024-11-25', created_at: '2024-11-25 11:00:00')
  VotesHistory.create(crypto_id: 1, user_id: 9, is_bullished: true, voted_at: '2024-10-15', created_at: '2024-10-15 08:00:00')
  VotesHistory.create(crypto_id: 1, user_id: 10, is_bullished: false, voted_at: '2024-09-30', created_at: '2024-09-30 16:30:00')

  puts "VotesHistory pour crypto_id 1 ont été créés avec succès."
else
  puts "Crypto avec id 1 non trouvé."
end

