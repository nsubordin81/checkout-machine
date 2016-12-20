class Inventory
  def initialize(item_list)
    @items = item_list.collect {|item|
      Item.new(item[0], item[1], item[2])
    }
  end

  def get_item_by_sku(sku)
    @items.select {|item| item.sku == sku}[0]
  end

  def get_item_price(sku)
    get_item_by_sku(sku).price
  end
end
