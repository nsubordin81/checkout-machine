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
   if _bonus_card_scanned
    _subtract_discounts
   end
   _add_items
   @balance
  end 

  def _bonus_card_scanned
    bonus_card = _get_item_by_name("card") 
    purchase_log.fetch_log_entry_count(bonus_card.sku) > 0
  end

  def _subtract_discounts
    inventory.items.each do |item|
      @balance -= _determine_discount(item.sku, item.price)
    end
  end

  def _add_items
    inventory.items.each do |item|
      @balance += item.price * _item_count(item.sku)
    end
  end

  def _get_item_by_name(name)
    inventory.get_item_by_name(name)
  end

  def _determine_discount(sku, price)
    discount_manager.determine_discount(sku, price,_item_count(sku))
  end

  def _item_count(sku)
    purchase_log.fetch_log_entry_count(sku)
  end

end
