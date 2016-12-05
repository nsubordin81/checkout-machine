class CheckoutMachine
  attr_accessor :balance, :bonus_card_scanned, :inventory
  Item = Struct.new(:sku, :price, :counter, :discount_type)

  def initialize(balance = 0, bonus_card_scanned = false, inventory = {})
    @balance = balance
    @bonus_card_scanned = bonus_card_scanned

    @inventory = inventory
    @inventory[000] = Item.new(000, 0, 0)
    @inventory[123] = Item.new(123, 200, 0)
    @inventory[456] = Item.new(456, 100, 0)
    @inventory[789] = Item.new(789, 1000, 0)
    @inventory[111] = Item.new(111, 550, 0)
  end

  def scan(sku)
    update_item_count(sku)
    update_balance(sku)
    check_if_bonus(sku)
  end

  def total
    apply_discount
    self.balance
  end

  private

  def check_if_bonus(sku)
    self.bonus_card_scanned = true if sku == 000
  end

  def apply_discount
    if self.bonus_card_scanned
      apply_salsa_discount
      apply_chips_discount
    end
  end

  def apply_salsa_discount
    salsa = self.inventory[456]
    self.balance -= salsa.price * percentage_off(0.5, salsa.counter)
  end

  def apply_chips_discount
    chips = self.inventory[123]
    self.balance -= chips.price * buy_x_get_one(2, chips.counter)
  end

  def percentage_off(percentage, counter)
    percentage * counter
  end

  def buy_x_get_one(x, counter)
    (counter/(x + 1)).floor
  end

  def update_item_count(sku)
    self.inventory[sku].counter += 1
  end

  def update_balance(sku)
    self.balance += self.inventory[sku].price
  end
end
