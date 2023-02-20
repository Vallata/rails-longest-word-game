require'open-uri'
require'json'

class GamesController < ApplicationController
  def new
    @letters = ('a'..'z').to_a.sample(10).join(' ').upcase
  end

  def score
    @letters = params[:letters].split
    @word = (params[:word] || "").upcase
    @included = included?(@word, @letters)
    @english_word = english?(@word)
  end

  def english?(word)
    url = URI.open("https://wagon-dictionary.herokuapp.com/#{word}").read
    result = JSON.parse(url)
    result['found'] == true
  end

  def included?(word, letters)
    word.chars.all? { |letter| word.count(letter) <= letters.count(letter) }
  end

end
