 class PurchaseLog
  def initialize(log_entries, balance)
    @log_entries = []
  end

  def log_entry(sku, count)
    LogEntry.new(sku, count)
  end

  def update_log_entries(sku)
    if log_entries.any?{|entry| sku == entry.sku}
      count += 1
    else
      log_entries << log_entry(sku, count)
      count = 1
    end
    count
  end

  def fetch_log_entry_count(sku)
    log_entries.select{|entry| entry.sku == sku}.count
  end
end
