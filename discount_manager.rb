class DiscountManager

  def determine_discount(sku, price, count)
    if sku == 456
     discount = price * percentage_off(0.5, count)
    elsif sku == 123
     discount = price * buy_x_get_one(2, count)
    end
    discount
  end

  def percentage_off(percentage, counter)
    percentage * counter
  end

  def buy_x_get_one(x, counter)
    (counter/(x + 1)).floor
  end
end
