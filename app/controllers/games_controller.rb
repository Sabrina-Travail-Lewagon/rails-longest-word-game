require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def new
    # @letters = [*('A'..'Z')].sample(10)
    @letters = ('A'..'Z').to_a.shuffle.first(10)
  end

  def score
    @word = params[:word]
    response = URI.open("https://wagon-dictionary.herokuapp.com/#{@word}")
    json = JSON.parse(response.read)
    if json['found'] == true
      @reponse = "Congratulation! #{@word} is a valid English word"
    else
      @reponse = "Sorry but #{@word} doesn't seem to be a valid English word..."
    end
  end
end
