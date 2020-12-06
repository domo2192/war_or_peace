class Turn
  attr_reader :player1,
              :player2,
              :spoils_of_war,
              :players,
              :removed_cards

  def initialize(player1, player2)
    @player1 = player1
    @player2 = player2
    @spoils_of_war = []
    @players = [@player1, @player2]
    @removed_cards = []
  end

  def type
    if @player1.deck.rank_of_card_at(0) == @player2.deck.rank_of_card_at(0) &&
       @player1.deck.rank_of_card_at(2) == @player2.deck.rank_of_card_at(2)
      :mutually_assured_destruction
    elsif @player1.deck.rank_of_card_at(0) == @player2.deck.rank_of_card_at(0)
      :war
    else
      :basic
    end
  end

  def winner
    case type
    when :basic
      @players.max_by do |player|
        player.deck.rank_of_card_at(0)
      end
    when :war
      @players.max_by do |player|
        player.deck.rank_of_card_at(2)
      end
    else
      'No Winner'
    end
  end

  def pile_cards
    case type
    when :basic
      @spoils_of_war << player1.deck.remove_card
      @spoils_of_war << player2.deck.remove_card
    when :war
      3.times do
        @spoils_of_war << player1.deck.remove_card
        @spoils_of_war << player2.deck.remove_card
      end
    else
      type == :mutually_assured_destruction
      3.times do
        @removed_cards << player1.deck.remove_card
        @removed_cards << player2.deck.remove_card
      end
    end
  end

  def award_spoils(winner)
    @spoils_of_war.each do |spoil|
      winner.deck.add_card(spoil)
    end
  end
end
