
# README


# Crypto Voting Project

[![Crypto Voting Project on Heroku](https://img.shields.io/badge/Heroku-Deployed-brightgreen)](https://cryptovotingproject-cc7f6a61a180.herokuapp.com/)
https://cryptovotingproject-cc7f6a61a180.herokuapp.com/

## Table of Contents

1. [Introduction](#introduction)
2. [Core Features](#core-features)
3. [Objectives](#objectives)
4. [Technologies Used](#technologies-used)
5. [Setup and Installation](#setup-and-installation)
6. [Usage](#usage)
7. [Contributors](#contributors)
8. [License](#license)
9. [Additional Links](#additional-links)

## Introduction

Crypto Voting Project is a community-driven platform for cryptocurrency enthusiasts. It combines real-time market analysis, sentiment voting, and vibrant discussions, addressing the need for an interactive space in the rapidly expanding crypto market.

### [Live Application on Heroku](https://cryptovotingproject-cc7f6a61a180.herokuapp.com/)

---

## Core Features

- **Dashboard**: Displays real-time cryptocurrency data and dynamic charts using APIs like CoinGecko and TradingView.
- **Sentiment Voting**: Users can vote Bullish or Bearish on individual cryptocurrencies.
- **Community Discussions**: Each cryptocurrency has a dedicated discussion section.
- **Favorites Management**: Users can personalize their experience by tracking favorite cryptocurrencies.
- **Administrator Panel**: Admins can manage cryptocurrencies and moderate community activity.
- **Gamification**: A points system rewards user engagement and accurate predictions.

---

## Objectives

### Short-Term Goals (MVP)

- Deploy a functional Minimum Viable Product (MVP).
- Implement core features like sentiment voting, community discussions, and a real-time dashboard.

### Long-Term Goals

- Enhance user engagement with gamification features.
- Expand functionalities with premium subscription plans offering advanced features like custom notifications.

---

## Technologies Used

- **Backend**: Ruby 3.2.2, Rails 8
- **Database**: PostgreSQL 1.1
- **Frontend**: JavaScript, CSS
- **Authentication**: Devise
- **Payments**: Stripe
- **Emailing**: Mailjet
- **Deployment**: Heroku

---

## Setup and Installation

### Prerequisites

- Ruby 3.2.2
- Rails 8
- PostgreSQL

### Installation Steps

1. Clone the repository:
   ```bash
   git clone <repository-url>
   cd Crypto-Voting-Project-main
   ```

2. Install dependencies:
   ```bash
   bundle install
   yarn install
   ```

3. Setup the database:
   ```bash
   rails db:create
   rails db:migrate
   rails db:seed
   ```

4. Start the server:
   ```bash
   rails server
   ```

5. Visit the application at `http://localhost:3000`.

---

## Usage

- Navigate to the [Live Application](https://cryptovotingproject-cc7f6a61a180.herokuapp.com/).
- Sign up or log in to access full features like voting and discussions.
- Admins can manage cryptocurrencies and moderate activity via the admin panel.

---

## Contributors

- **Florian Tribout**
- **Alexe Marichal**
- **Paul Moulin**
- **James Barthée**
- **Caroline Olivier**

---

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.

---

## Additional Links

- [Trello Board for the Project](https://trello.com/b/QAaB0KZ0/crypto)
- [Executive Summary Document](https://docs.google.com/document/d/1q29IyqbOnZ7NYARIGE5facmB-I31Vpd8y4DoW87DG8g/edit?tab=t.0)
- [Database Schema](https://lucid.app/lucidchart/811203c0-667e-4bfe-9a13-a60813fcb3dd/edit?invitationId=inv_6e255649-ab61-40cb-a69a-2b2afd9acfe8)
- [Figma Maquettes](https://www.figma.com/design/C45RQ27ofXu7LBsclNEzXi/Untitled?node-id=580-640&node-type=frame&t=Q0WQYodgIUnEjQaJ-0)
- [Wireframes on Miro](https://miro.com/app/board/uXjVL9eGfJ0=/)

