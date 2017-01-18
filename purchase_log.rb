require './inventory'

class PurchaseLog
  attr_reader :log_entries, :inventory
  LogEntry = Struct.new(:sku, :count)
  
  def initialize()
    @log_entries = []
    @inventory =  Inventory.new([
      [000, "card", 0],
      [123, "chips", 200],
      [456, "salsa", 100],
      [789, "wine", 1000],
      [111, "cigarettes", 550]
      ])
  end

  def log_entry(sku)
    LogEntry.new(sku)
  end

  def tally
    Hash[inventory.items.collect {|item| [item, fetch_log_entry_count(item.sku)]}]
  end

  def update_log_entries(sku)
    existing_entry = log_entries.select {|entry| sku == entry.sku}.first
    log_entries << log_entry(sku)
  end

  def fetch_log_entry_count(sku)
    log_entries.select{|entry| entry.sku == sku}.count
  end
end
