require './item'

class Inventory
  attr_accessor :item_list, :checkout_counter, :balance
  ItemCount = Struct.new(:sku, :count)

  def initialize(item_list)
    @balance = 0

    @item_list = item_list.collect {|item|
      Item.new(item[0], item[1], item[2])
    }

    @checkout_counter = item_list.collect {|item|
      ItemCount.new(item[0], 0)
    }
  end

  def scan_item(sku)
    update_item_count(sku)
    update_balance(sku)
  end

  def bonus_card_scanned
    get_item_count_by_sku(000) > 0
  end

  def get_item_price(sku)
    get_item_by_sku(sku).price
  end

  def get_item_count_by_sku(sku)
    get_item_counter_by_sku(sku).count
  end

  private

  def get_item_by_sku(sku)
    self.item_list.select {|item| item.sku == sku}[0]
  end

  def get_item_counter_by_sku(sku)
    self.checkout_counter.select {|counter| counter.sku == sku}[0]
  end

  def update_item_count(sku)
    get_item_counter_by_sku(sku).count += 1
  end

  def update_balance(sku)
    self.balance += get_item_by_sku(sku).price
  end
end
