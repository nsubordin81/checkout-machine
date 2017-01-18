require './purchase_log'
require './totaler'

class CheckoutMachine
  attr_reader :purchase_log, :totaler

  def initialize(purchase_log, totaler)
    @purchase_log = purchase_log
    @totaler = totaler
  end

  def scan(sku)
    purchase_log.update_log_entries(sku)
  end

  def total
   totaler.total
  end 

end
