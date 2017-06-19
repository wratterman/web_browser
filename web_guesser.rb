require 'sinatra'
require 'sinatra/reloader'

get '/' do
  guess = params["guess"].to_i
  message = check_guess(guess)
  cheater = i_am_a_cheater?
  erb :index, :locals => {:number => SECRET_NUMBER, :message => message,
                          :cheater => cheater}
end

SECRET_NUMBER = rand(1..100)

@correct = false
@over_five = false
@under_five = false
@nil = false

def check_guess(guess)
  if guess == 0
    @nil = true
    message = "Guess a secret number between 1 and 100."
  elsif guess == SECRET_NUMBER
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
    @over_five = true
    message = "Your guess was #{guess}, way too high!"
  elsif guess > SECRET_NUMBER
    @under_five = true
    message = "Your guess was #{guess}, too high!"
  else
    check_how_low(guess)
  end
end

def check_how_low(guess)
  if guess < SECRET_NUMBER - 5
    @over_five = true
    message = "Your guess was #{guess}, way too low!"
  else
    @under_five = true
    message = "Your guess was #{guess}, too low!"
  end
end

def i_am_a_cheater?
  params["cheat"] == "true"
end
