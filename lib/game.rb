class Game
  attr_reader :player1,
              :player2,
              :turn_counter

  def initialize(player1, player2)
    @player1 = player1
    @player2 = player2
    @turn_counter = 1
  end

  def start
      each_turn
      game_results 
  end

  def each_turn
    turn = Turn.new(player1, player2)
      until turn.player1.has_lost? || turn.player2.has_lost?
    @turn_counter += 1
    turn_type = turn.type
    turn_win = turn.winner
    turn.pile_cards
    p turn_results(turn, turn_win, turn_type)
    turn.award_spoils(turn_win)
    end
  end

  def winner_declared
   @player1.has_lost? || @player2.has_lost? || @turn_counter == 100_000
  end

  def game_results
    if @player1.has_lost?
      "*~*~*~* #{@player2.name} has won the game! *~*~*~*"
    elsif @player2.has_lost?
      "*~*~*~* #{@player1.name} has won the game! *~*~*~*"
    else
      "---- DRAW -----"
    end
  end

  def turn_results(turn, turn_win, turn_type)
    case turn_type
    when :basic
      "Turn #{@turn_counter}: #{turn_win.name} won 2 cards
      #{@player1.name} #{@player1.deck.cards.count}"

    when :war
      "Turn #{@turn_counter}: WAR - #{turn_win.name} won 6 cards
      #{@player2.name} #{@player2.deck.cards.count}"

    when :mutually_assured_destruction
      "Turn #{@turn_counter}: *mutually assured destruction* - #{turn.removed_cards.count} cards removed from play"
    end
  end
end
