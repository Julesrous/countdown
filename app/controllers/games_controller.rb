require "json"
require "open-uri"

class GamesController < ApplicationController
  def new
    @letters =('A'..'Z').to_a.sample(10)
    @word = ""
    @letters.each{ |letter| @word += letter}
  end

  def score
    chars = params[:word].split(//)
    chars.each do |char|
      if params[:token].include?(char) == false
        return @result = "Sorry but #{params[:word]} can't be built out of #{params[:token]}"
      end
    end
    url = "https://wagon-dictionary.herokuapp.com/#{params[:word]}"
    dictionary_serialized = URI.open(url).read
    dictionary = JSON.parse(dictionary_serialized)
    if dictionary["found"] == false
      return @result = "Sorry but #{params[:word]} does not seem to be a valid English word..."
    else
      return @result = "Congruatulations! #{params[:word]} is a valid English word!"
    end
  end
end
