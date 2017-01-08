require './inventory'
require './purchase_log'
require './discount_manager'

class CheckoutMachine
  attr_reader :discount_manager, :inventory, :purchase_log

  def initialize(purchase_log, inventory, discount_manager)
    @purchase_log = purchase_log
    @inventory = inventory
    @discount_manager = discount_manager
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
    bonus_card = get_item_by_name("card") 
    purchase_log.fetch_log_entry_count(bonus_card.sku) > 0
  end

  def subtract_discounts
    inventory.items.each do |item|
      @balance -= determine_discount(item.sku, item.price)
    end
  end

  def add_items
    inventory.items.each do |item|
      @balance += item.price * item_count(item.sku)
    end
  end

  def get_item_by_name(name)
    inventory.get_item_by_name(name)
  end

  def determine_discount(sku, price)
    discount_manager.determine_discount(sku, price, item_count(sku))
  end

  def item_count(sku)
    purchase_log.fetch_log_entry_count(sku)
  end

end
