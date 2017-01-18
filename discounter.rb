class Discounter

  def transact(tally)
    has_bonus_card = !tally.select {|item, count| item.name == "card" && count > 0}.empty?
    return 0 unless has_bonus_card
    tally.reduce(0) {|memo, (item, count)| memo -= _determine_discount(item.sku, item.price, count)}
  end

  def _determine_discount(sku, price, count)
    discount = 0
    if sku == 456
     discount = price * _percentage_off(0.5, count)
    elsif sku == 123
     discount = price * _buy_x_get_one(2, count)
    end
    discount
  end

  def _percentage_off(percentage, counter)
    percentage * counter
  end

  def _buy_x_get_one(x, counter)
    (counter/(x + 1)).floor
  end
end
