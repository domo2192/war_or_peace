require './lib/card'
require './lib/deck'
require './lib/player'
require './lib/turn'
require './lib/game'
require 'pry'

def random_gen
  suits = %i[Diamond Heart Spade Club]
  values = %w[2 3 4 5 6 7 8 9 10 Jack Queen King Ace]
  cards = []

  suits.each do |suit|
    values.each.with_index(2) do |value, index|
      cards << Card.new(suit, value, index)
    end
  end
  cards
end

deck1 = Deck.new(random_gen.shuffle[0..25])
deck2 = Deck.new(random_gen.shuffle[26..51])

player1 = Player.new('Megan', deck1)
player2 = Player.new('Aurora', deck2)
intro_message =
  puts ''"Welcome to War! (or Peace) This game will be played with 52 cards.
    The players today are #{player1.name} and #{player2.name}.
    Type 'GO' to start the game
    -----------------------------------------------------------"''
intro_message
user_input = gets.chomp.upcase

if user_input == 'GO'
  game = Game.new(player1, player2)
  game.start
else
  puts 'Alright bye'
end
