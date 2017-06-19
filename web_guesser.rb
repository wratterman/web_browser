require 'sinatra'
require 'sinatra/reloader'

get '/' do
  guess = params["guess"].to_i
  message = check_guess(guess)
  erb :index, :locals => {:number => SECRET_NUMBER, :message => message}
end

SECRET_NUMBER = rand(100)

@correct = false

def check_guess(guess)
  if guess == SECRET_NUMBER
    correct_message
  else
    check_for_difference(guess)
  end
end

def correct_message
  @correct = true
  message = "You got it right!"
end

def check_for_difference(guess)
  if guess > SECRET_NUMBER + 5
    message = "Way too high!"
  elsif guess > SECRET_NUMBER
    message = "Too high!"
  else
    check_how_low(guess)
  end
end

def check_how_low(guess)
  if guess < SECRET_NUMBER - 5
    message = "Way too low!"
  else
    message = "Too low!"
  end
end
