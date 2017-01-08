class PurchaseLog
  attr_reader :log_entries
  LogEntry = Struct.new(:sku, :count)
  
  def initialize()
    @log_entries = []
  end

  def log_entry(sku)
    LogEntry.new(sku)
  end

  def update_log_entries(sku)
    existing_entry = log_entries.select {|entry| sku == entry.sku}.first
    log_entries << log_entry(sku)
  end

  def fetch_log_entry_count(sku)
    log_entries.select{|entry| entry.sku == sku}.count
  end
end
