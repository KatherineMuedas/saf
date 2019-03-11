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
    item_name.include?('chocolate') || item_name.include?('book') || item_name.include?('pill') ? sales_tax = 0 : sales_tax = 0.1
    item_name.include?('imported') ? import_duty = 0.05 : import_duty = 0
    item_total_taxes = sales_tax_rounding((item_price * sales_tax) + (item_price * import_duty))
    item_total_price = (item_price + item_total_taxes).round(2)

    quantity = input[0].to_i
    line_items_total_price = (item_total_price * quantity).round(2)
    line_items_total_taxes = (item_total_taxes * quantity).round(2)

    @requested_line_items = {
      item_name: item_name,
      sales_tax: sales_tax,
      import_duty: import_duty,
      quantity: quantity,
      item_total_taxes: item_total_taxes,
      line_items_total_price: line_items_total_price,
      line_items_total_taxes: line_items_total_taxes
    }
  end

  def add_to_basket(requested_line_items)
    @basket.push(@requested_line_items)
  end

  def receipt(basket)
    puts "************************"
    puts "************************"
    puts "RECEIPT"
    basket.each do |line_item|
      puts "#{line_item[:quantity]} #{line_item[:item_name]}: #{line_item[:line_items_total_price]}"
    end
    puts "Sales Taxes:#{basket.map{|line_item| line_item[:line_items_total_taxes]}.inject(&:+).round(2)}"
    puts "Total: #{basket.map{|line_item| line_item[:line_items_total_price]}.inject(&:+).round(2)}"
    puts "************************"
    puts "************************"
  end

  private

  def clean_input(input)
   input.delete( 'at') if input.include?('at')
  end

  def sales_tax_rounding(taxes_amount)
    (taxes_amount * 20).ceil / 20.00
  end

end

Receipt.new.menu
