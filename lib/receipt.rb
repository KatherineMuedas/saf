require 'pry'
class Receipt
  #Receive input from user
  #Convert it into an array

  def menu
    puts "What would you like to order?"
    input = gets.chomp.split

    unless input.size < 3
      clean_input(input)
      p input
    else
      puts 'NOT ENOUGH INFORMARTION. Enter quantity, product and price. Example: 2 book at 12.49.'
      menu
    end
  end


  private

  def clean_input(input)
   input.delete( 'at') if input.include?('at')
  end







end

Receipt.new.menu
