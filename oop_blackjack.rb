require 'pry'
#This is the object oriented version of the blackjack game
# game # that can be player
#   That manages turns of player and dealer
#   Calculates scores of palyer and dealer
#     determines whether aces are 11 or 1
#   Determines who has won or lost
# player # by player
#   that hits or stays
# dealer # and dealer
#   that hits until <= 17
# deck # with a deck
#   that has 11 values across 4 suits
#   can be shuffled
#   (can have more than 1 deck)
#   Deals the cards to player and dealer
# cards # of cards
#   have a suit and a value

class Card
  attr_accessor :suit, :value
  
  def initialize s, v
    @suit = s
    @value = v
  end

  def to_s
    "card is #{value} of #{suit}"
  end

end

class Deck
  attr_accessor :cards

  def initialize(d_num)
    @cards = []
    ["Hearts", "Diamonds", "Spades", "Clubs"].each do |suit|
      ["2", "3", "4", "5", "6", "7", "8", "9", "Jack", "Queen", "King", "Ace"].each do |value|
        @cards << Card.new(suit, value)
      end
    end

    @cards *= d_num
  end

  def scramble!
    cards.shuffle!
  end

  def deal(hand)
    hand << cards.pop
  end
end

class Player
  attr_accessor :hand, :name, :bankroll, :score, :wager

  def initialize(name, bankroll)
    @hand = []
    @name = name
    @bankroll = bankroll
    @score = 0
    @wager = 0
  end

  def bet(w)
    self.wager = w
  end

  def hit(deck)
    deck.deal(hand)
    score_calc
  end

  def score_calc
    val = hand.last.value
    if val == "Jack" || val == "Queen" || val == "King"
      val = 10
    end
    if val == "Ace"
      val = 11
    end
    self.score += val.to_i

    hand.each do |card|
      if score > 21 && card.value == "Ace"
        self.score -= 10
      end
    end
  end

  def reveal
    puts "#{name} : #{hand.last}"
  end
end

class Dealer < Player

end

class Game

  attr_accessor :deck, :player, :dealer

  def setup
    puts "Hello, what is your name?"
    name = gets.chomp
    puts "What is your bankroll?"
    bankroll = gets.chomp.to_i
    self.player = Player.new(name, bankroll)
    self.dealer = Dealer.new('Dealer',0)
  end

  def initial_deal
    player.score = 0
    dealer.score = 0
    player.hand = []
    dealer.hand = []
    puts "We are beginning a new round, how much is your wager?"
    wager = gets.chomp.to_i
    player.bet(wager)
    self.deck = Deck.new(8)
    deck.scramble!

    player.hit(deck)
    player.reveal

    dealer.hit(deck)
    dealer.reveal

    player.hit(deck)
    player.reveal

    blackjack?(player)

    dealer.hit(deck)
    blackjack?(dealer)
  end

  def turn(player)
    if player.name == 'Dealer'
      if player.score < 17
        player.hit(self.deck)
        blackjack?(player)
        busted?(player)
        turn(player)
      end
      blackjack?(player)
      busted?(player)
    else
      puts "It is #{player.name}'s turn."
      puts "Your score is #{player.score}"
      puts "Do you want to 'hit' or 'stay'?"
      puts "=>"
      response = gets.chomp
      if response == 'hit'
        player.hit(self.deck)
        blackjack?(player)
        busted?(player)
        turn(player)
      elsif response != 'stay'
        puts "Please say either 'hit' or 'stay'"
        puts "=>"
        turn(player)
      end
    end
  end

  def blackjack?(player)
    if player.score == 21
      puts "#{player.name} got blackjack, winner!"
      player.bankroll += player.wager
      self.again
    end
  end

  def busted?(player)
    if player.score > 21
      puts "#{player.name} busted, loser!"
      player.bankroll -= player.wager
      self.again
    end
  end

  def compare(player, dealer)
    if player.score < dealer.score
      puts "#{player.name} loses!"
      player.bankroll -= player.wager
    elsif player.score > dealer.score
      puts "#{player.name} wins!"
      player.bankroll += player.wager
    else
      puts "Its a tie!"
    end
    self.again
  end

  def again
    binding.pry
    puts "Do you want to play again? 'yes' or 'no'?"
    puts "=>"
    response = gets.chomp
    if response == 'yes'
      self.initial_deal
    elsif response == 'no'
      exit
    else
      puts "Please say either 'yes' or 'no'"
      puts "=>"
      self.again
    end
  end

  def game_play
    self.initial_deal
    self.turn(player)
    self.turn(dealer)
    puts "Player's score is #{player.score}"
    puts "Dealer's score is #{dealer.score}"
    self.compare(player, dealer)
  end

  def run
    self.setup
    self.game_play
  end
end

Game.new.run












