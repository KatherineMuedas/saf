require 'pry'
class Receipt
  #Receive input from user
  #Convert it into an array
  #set items details from array
  def menu
    puts "What would you like to order?"
    input = gets.chomp.split

    unless input.size < 3
      clean_input(input)
      set_requested_items_details(input)
      p @requested_items
    else
      puts 'NOT ENOUGH INFORMARTION. Enter quantity, product and price. (Example: 2 book at 12.49)'
      menu
    end
  end

  def set_requested_items_details(input)
    item_name = input[1..-2].join(" ")
    item_price = input[-1].to_f
    quantity = input[0].to_i

    @requested_items = {
      item_name: item_name,
      item_price: item_price,
      quantity: quantity
    }
  end

  private

  def clean_input(input)
   input.delete( 'at') if input.include?('at')
  end

end

Receipt.new.menu
