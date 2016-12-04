class CheckoutMachine
  attr_accessor :balance, :bonus_card_scanned, :salsa_counter, :chip_counter
  def initialize(balance = 0, bonus_card_scanned = false, salsa_counter = 0, chip_counter = 0)
    @balance = balance
    @bonus_card_scanned = bonus_card_scanned
    @salsa_counter = salsa_counter
    @chip_counter = chip_counter
  end

  def scan(sku)
    process_item(sku)

    self.bonus_card_scanned = true if sku == 000
  end

  def total
    apply_discount
    self.balance
  end

  private

  def apply_discount
    if self.bonus_card_scanned
      self.balance -= 50 * self.salsa_counter
      self.balance -= 200 * (@chip_counter/3).floor
    end
  end

  def process_item(sku)
    if sku == 123
      self.chip_counter += 1
      update_balance(200)
    elsif sku == 456
      self.salsa_counter += 1
      update_balance(100)
    elsif sku == 789
      update_balance(1000)
    elsif sku == 111
      update_balance(550)
    end
  end

  def update_balance(item_cost)
    self.balance += item_cost
  end
end
