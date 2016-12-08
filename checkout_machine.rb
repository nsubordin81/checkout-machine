require './inventory'
require './discount_manager'

class CheckoutMachine
  attr_reader :discount_manager, :inventory

  def initialize()
    @inventory = Inventory.new([
      [000, "card", 0],
      [123, "chips", 200],
      [456, "salsa", 100],
      [789, "wine", 1000],
      [111, "cigarettes", 550]
    ])

    @discount_manager = DiscountManager.new
  end

  def scan(sku)
    inventory.scan_item(sku)
  end

  def total
   if inventory.bonus_card_scanned
    inventory.balance -= discount_manager.determine_discount(456, inventory.get_item_price(456), inventory.get_item_count_by_sku(456))
    inventory.balance -= discount_manager.determine_discount(123, inventory.get_item_price(123), inventory.get_item_count_by_sku(123))
   end
   inventory.balance
  end

end
