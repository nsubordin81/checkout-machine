class Item
  attr_accessor :sku, :name, :price

  def initialize(sku, name, price)
    @sku = sku
    @name = name
    @price = price
  end
end
