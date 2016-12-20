require './item'
# halfway through refactor, moving methods around to give a clearer idea of where dependencies are living.

class Scanner
  attr_accessor :purchase_log, :inventory
  LogEntry = Struct.new(:sku, :count)

  def initialize(item_list)
    @balance = 0

    @inventory = inventory(item_list)

    @purchase_log = purchase_log
  end

  def purchase_log
    PurchaseLog.new
  end

  def inventory(item_list)
    Inventory.new(item_list)
  end

  def scan_item(sku)
    @purchase_log.update_log_entries(sku)
  end

  #have scanner be responsible for getting total price for items scanned

  def bonus_card_scanned
    @purchase_log.fetch_log_entry_count(000) > 0
  end
end
