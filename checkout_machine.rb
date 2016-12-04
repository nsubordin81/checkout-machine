class CheckoutMachine
  attr_accessor :balance, :bonus_card_scanned, :salsa_counter, :chip_counter
  def initialize(balance = 0, bonus_card_scanned = false, salsa_counter = 0, chip_counter = 0)
    @balance = balance
    @bonus_card_scanned = bonus_card_scanned
    @salsa_counter = salsa_counter
    @chip_counter = chip_counter
  end

  def scan(sku)
    update_balance(sku)

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

  def update_balance(sku)
    if sku == 123
      self.chip_counter += 1
      self.balance += 200
    elsif sku == 456
      self.salsa_counter += 1
      self.balance += 100
    elsif sku == 789
      self.balance += 1000
    elsif sku == 111
      self.balance += 550
    end
  end
end
