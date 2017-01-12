class DiscountManager

  def determine_discount(sku, price, count)
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
