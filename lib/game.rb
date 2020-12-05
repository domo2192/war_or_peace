class Game
  attr_reader:player1,
             :player2,
             :turn_counter
  def initialize(player1, player2)
    @player1 = player1
    @player2 = player2
    @turn_counter = 1
  end


  def start
    while @turn_counter < 100000
    turn = Turn.new(player1, player2)
     turn_winner = turn.winner
     turn_type = turn.type

     turn.pile_cards
     turn.award_spoils(turn_winner)

    p turn_results(turn, turn_winner, turn_type)
    @turn_counter += 1
    end
    p "---- DRAW ----" if @turn_counter == 100000
  end

  def game_over?
    @player1.has_lost? || @player2.has_lost? || @turn_counter == 100000
  end

  def turn_results(turn, turn_winner, turn_type)
    if turn_type == :basic
      "Turn #{@turn_counter}: #{turn_winner.name} won 2 cards
      #{@player1.name} #{@player1.deck.cards.count}"

    elsif turn_type == :war
      "Turn #{@turn_counter}: WAR - #{turn_winner.name} won 6 cards
      #{@player2.name} #{@player2.deck.cards.count}"

    else turn_type == :mutually_assured_destruction
      "Turn #{@turn_counter}: *mutually assured destruction* - 6 cards removed from play"
    end
  end
end
