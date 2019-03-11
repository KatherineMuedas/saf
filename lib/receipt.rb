require 'pry'
  #Receive input from user
  #Convert it into an array
  #set items details from array
  #save details in a hash
  #add requested line items into a basket
  #print receipt base on basket information
class Receipt
  def initialize
    @basket = []
  end

  def menu
    puts "What would you like to order?"
    input = gets.chomp.split

    unless input.size < 3
      clean_input(input)
      set_requested_line_items_details(input)
      add_to_basket(@requested_line_items)
      receipt(@basket)
    else
      puts 'NOT ENOUGH INFORMARTION. Enter quantity, product and price. (Example: 2 book at 12.49)'
      menu
    end
  end

  def set_requested_line_items_details(input)
    item_name = input[1..-2].join(" ")
    item_price = input[-1].to_f.round(2)
    quantity = input[0].to_i

    @requested_line_items = {
      item_name: item_name,
      item_price: item_price,
      quantity: quantity
    }
  end

  def add_to_basket(requested_line_items)
    @basket.push(@requested_line_items)
  end

  def receipt(basket)
    puts "************************"
    puts "************************"
    puts "RECEIPT"
    @basket.each do |line_item|
      puts "#{line_item[:quantity]} #{line_item[:item_name]}: #{line_item[:item_price]}"
    end
    puts "************************"
    puts "************************"
  end

  private

  def clean_input(input)
   input.delete( 'at') if input.include?('at')
  end

end

Receipt.new.menu
