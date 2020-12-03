require './lib/card'
require './lib/deck'
require './lib/player'
require './lib/turn'
require './lib/game'
require'pry'


cards = []
suits = [:Diamond, :Heart, :Spade, :Club]
values = ["2", "3", "4", "5", "6", "7", "8", "9", "10", "Jack", "Queen", "King", "Ace"]
rank_of_cards = {"2"=> 2, "3"=> 3, "4"=> 4, "5"=> 5, "6"=>6 , "7"=>7, "8"=>8, "9"=>9, "10"=>10, "Jack"=>11, "Queen"=>12, "King"=>13, "Ace"=>14}

suits.each do |suit|
  values.each do |value|
    rank = rank_of_cards[value]
    cards << Card.new(suit,value,rank)
  end
end
deck1 = Deck.new(cards.shuffle[0..25])
deck2 = Deck.new(cards.shuffle[26..51])

p deck1.sort
p deck2.sort
