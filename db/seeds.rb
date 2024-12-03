# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

# db/seeds.rb

# db/seeds.rb

# Suppression des données existantes
User.destroy_all
Crypto.destroy_all
Post.destroy_all

# Création des utilisateurs avec des mots de passe valides
users = User.create!([
  { email: "admin@example.com", password: "password123", password_confirmation: "password123", is_admin: true, is_subscriber: true, username: "Admin" },
  { email: "user1@example.com", password: "password123", password_confirmation: "password123", is_admin: false, is_subscriber: true, username: "User1" },
  { email: "user2@example.com", password: "password123", password_confirmation: "password123", is_admin: false, is_subscriber: false, username: "User2" }
])

# Création des cryptomonnaies
cryptos = Crypto.create!([
  { name: "Bitcoin", price: 35000.0, symbol: "BTC", volume_24h: 2000000000, market_cap: 600000000000, variation_24h: 2.5 },
  { name: "Ethereum", price: 2500.0, symbol: "ETH", volume_24h: 1500000000, market_cap: 300000000000, variation_24h: -1.3 },
  { name: "Litecoin", price: 150.0, symbol: "LTC", volume_24h: 500000000, market_cap: 10000000000, variation_24h: 0.7 },
  { name: "Binance Coin", price: 400.0, symbol: "BNB", volume_24h: 700000000, market_cap: 60000000000, variation_24h: 1.2 },
  { name: "Cardano", price: 1.5, symbol: "ADA", volume_24h: 300000000, market_cap: 50000000000, variation_24h: -0.4 },
  { name: "Solana", price: 35.0, symbol: "SOL", volume_24h: 250000000, market_cap: 20000000000, variation_24h: 3.0 },
  { name: "Dogecoin", price: 0.25, symbol: "DOGE", volume_24h: 1000000000, market_cap: 30000000000, variation_24h: 0.9 },
  { name: "Polkadot", price: 25.0, symbol: "DOT", volume_24h: 150000000, market_cap: 20000000000, variation_24h: 1.5 },
  { name: "Ripple", price: 0.8, symbol: "XRP", volume_24h: 500000000, market_cap: 40000000000, variation_24h: -0.8 },
  { name: "Shiba Inu", price: 0.00007, symbol: "SHIB", volume_24h: 200000000, market_cap: 10000000000, variation_24h: 5.0 },
  { name: "Avalanche", price: 70.0, symbol: "AVAX", volume_24h: 120000000, market_cap: 15000000000, variation_24h: 2.1 },
  { name: "Polygon", price: 2.0, symbol: "MATIC", volume_24h: 180000000, market_cap: 12000000000, variation_24h: 1.8 },
  { name: "Chainlink", price: 15.0, symbol: "LINK", volume_24h: 80000000, market_cap: 7000000000, variation_24h: -2.0 },
  { name: "Stellar", price: 0.3, symbol: "XLM", volume_24h: 90000000, market_cap: 6000000000, variation_24h: 0.5 },
  { name: "VeChain", price: 0.1, symbol: "VET", volume_24h: 70000000, market_cap: 5000000000, variation_24h: -0.2 },
  { name: "Cosmos", price: 30.0, symbol: "ATOM", volume_24h: 60000000, market_cap: 8000000000, variation_24h: 1.3 },
  { name: "Algorand", price: 1.5, symbol: "ALGO", volume_24h: 50000000, market_cap: 4000000000, variation_24h: 2.2 },
  { name: "Tezos", price: 4.0, symbol: "XTZ", volume_24h: 40000000, market_cap: 3000000000, variation_24h: 0.7 },
  { name: "Filecoin", price: 100.0, symbol: "FIL", volume_24h: 30000000, market_cap: 2000000000, variation_24h: -3.5 },
  { name: "Aave", price: 300.0, symbol: "AAVE", volume_24h: 20000000, market_cap: 1000000000, variation_24h: 1.0 }
])

# Création des posts
posts = Post.create!([
  { user: users[0], crypto: cryptos[0], content: "Bitcoin est en pleine expansion. Que pensez-vous de son avenir ?" },
  { user: users[1], crypto: cryptos[1], content: "Ethereum pourrait exploser cette année, vous êtes d'accord ?" },
  { user: users[2], crypto: cryptos[2], content: "Litecoin reste stable, une bonne opportunité pour débuter ?" }
])

puts "Seed data successfully created!"
