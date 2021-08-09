require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def new
    @letters = ('A'..'Z').to_a.sample(10)
  end

  def score
    @guess = params[:guess]
    @letters = params[:letters]
    @score = 0
    @url = "https://wagon-dictionary.herokuapp.com/#{@guess}"
    json = open(@url).read
    objs = JSON.parse(json)
    if objs['found']
      @guess.split('').each do |letter|
        if @letters.include?(letter)
          @score += 1
        else
          @message = "Sorry but #{@guess} can't be built out of #{@letters}"
          break
        end
      end
    else
      @message = "Thats not a english word."
    end
  end
end
