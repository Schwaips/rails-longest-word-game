# games controller
require 'json'
require 'open-uri'

class GamesController < ApplicationController
  def new
    @vowels = ["A", "E", "I", "O", "U"].sample(3)
    @other_letters = Array.new(7) { ('A'..'Z').to_a.sample }
    @letters = @vowels + @other_letters
  end

  def score
    @letters = params[:letters].split(" ")
    @url_check = "https://wagon-dictionary.herokuapp.com/#{params[:word]}"
    @serialized_word = open(@url_check).read
    @word = JSON.parse(@serialized_word)
    @check_word = checkword?(params[:word].upcase, @letters)
  end

  def checkword?(word, letters)
    word.chars.all? { |letter| word.count(letter) <= letters.count(letter) }
  end

end
