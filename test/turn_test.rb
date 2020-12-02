require 'minitest/autorun'
require 'minitest/pride'
require './lib/card'
require'./lib/deck'
require './lib/player'
require './lib/turn'

class TurnTest < Minitest:: Test

  def setup
    @card1 = Card.new(:heart, 'Jack', 11)
    @card2 = Card.new(:heart, '10', 10)
    @card3 = Card.new(:heart, '9', 9)
    @card4 = Card.new(:diamond, 'Jack', 11)
    @card5 = Card.new(:heart, '8', 8)
    @card6 = Card.new(:diamond, 'Queen', 12)
    @card7 = Card.new(:heart, '3', 3)
    @card8 = Card.new(:diamond, '2', 2)
    @deck1 = Deck.new([@card1, @card2, @card5, @card8])
    @deck2 = Deck.new([@card3, @card4, @card6, @card7])
    @player1 = Player.new("Megan", @deck1)
    @player2 = Player.new("Aurora", @deck2)
    @turn = Turn.new(@player1, @player2)
    @winner = @turn.winner
  end

  def test_player_exists_and_has_attributes
    assert_instance_of Turn, @turn
    assert_equal @player1, @turn.player1
    assert_equal @player2, @turn.player2
    assert_equal [], @turn.spoils_of_war
  end

  def test_turn_type
    assert_equal :basic, @turn.type
  end

  def test_winner_returns_higher_ranking
    assert_equal @player1, @turn.winner
  end

  def test_we_can_pile_cards_for_basic
    @turn.pile_cards
    assert_equal [@card1, @card3], @turn.spoils_of_war
    assert_equal [@card2, @card5, @card8], @player1.deck.cards
    assert_equal [@card4, @card6, @card7], @player2.deck.cards
  end

  def test_we_can_award_spoils_to_winner
    @turn.pile_cards
    @turn.award_spoils(@winner)
    assert_equal [@card2, @card5, @card8, @card1, @card3], @player1.deck.cards
    assert_equal [@card4, @card6, @card7], @player2.deck.cards
  end

  def test_turn_type_for_war
    deck1 = Deck.new([@card1, @card2, @card5, @card8])
    deck2 = Deck.new([@card4, @card3, @card6, @card7])
    player1 = Player.new("Megan", deck1)
    player2 = Player.new("Aurora", deck2)
    turn = Turn.new(player1, player2)
    assert_equal :war, turn.type
  end

  def test_winner_is_changed_to_player_two
    deck1 = Deck.new([@card1, @card2, @card5, @card8])
    deck2 = Deck.new([@card4, @card3, @card6, @card7])
    player1 = Player.new("Megan", deck1)
    player2 = Player.new("Aurora", deck2)
    turn = Turn.new(player1, player2)
    assert_equal player2, turn.winner
  end

  def test_spoils_of_war_is_piled_for_war
    deck1 = Deck.new([@card1, @card2, @card5, @card8])
    deck2 = Deck.new([@card4, @card3, @card6, @card7])
    player1 = Player.new("Megan", deck1)
    player2 = Player.new("Aurora", deck2)
    turn = Turn.new(player1, player2)
    turn.pile_cards
    assert_equal [@card1, @card4, @card2, @card3, @card5, @card6], turn.spoils_of_war
    assert_equal [@card8], player1.deck
    assert_equal [@card7], player2.deck
    turn.award_spoils(winner)
    assert_equal [@card8], player1.deck
    assert_equal [@card7, @card1, @card4, @card2, @card3, @card5, @card6], player2.deck
  end
end
