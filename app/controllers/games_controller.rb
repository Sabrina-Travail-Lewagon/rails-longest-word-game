require 'open-uri'

class GamesController < ApplicationController
  def new
    # @letters = [*('A'..'Z')].sample(10)
    @letters = ('A'..'Z').to_a.shuffle.first(10)
  end

  def score
    # On initialise le score :
    ### Soit le joueur a dejà commencé, du coup, le score aura la valeur de la session
    ### Soit il débute la partie, le score = 0
    @score = session[:score] || 0
    @word = params[:word]
    response = URI.open("https://wagon-dictionary.herokuapp.com/#{@word}")
    json = JSON.parse(response.read)
    if json['found'] == true
      @reponse = "Congratulation! #{@word} is a valid English word"
      # 1 - On incrémente le score avec la valeur du nombre des mots que l'user à saisi
      @score += @word.length
      # 2 - On stocke dans la session le score
      session[:score] = @score
    else
      @reponse = "Sorry but #{@word} doesn't seem to be a valid English word..."
    end
  end
end
