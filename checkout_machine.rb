require './inventory'
require './purchase_log'
require './discount_manager'

class CheckoutMachine
  attr_reader :discount_manager, :inventory, :purchase_log

  def initialize()
    @purchase_log = PurchaseLog.new
    @inventory = Inventory.new([
      [000, "card", 0],
      [123, "chips", 200],
      [456, "salsa", 100],
      [789, "wine", 1000],
      [111, "cigarettes", 550]
    ])
    @discount_manager = DiscountManager.new
    @balance = 0
  end

  def scan(sku)
    purchase_log.update_log_entries(sku)
  end

  def total
   if bonus_card_scanned
    subtract_discounts
   end
   add_items
   @balance
  end

  private 

  def bonus_card_scanned
    bonus_card = inventory.get_item_by_name("card") 
    purchase_log.fetch_log_entry_count(bonus_card.sku) > 0
  end

  def subtract_discounts
    inventory.items.each do |item|
      @balance -= discount_manager.determine_discount(item.sku, item.price, purchase_log.fetch_log_entry_count(item.sku))
    end
  end

  def add_items
    inventory.items.each do |item|
      @balance += item.price * purchase_log.fetch_log_entry_count(item.sku)
    end
  end

end
