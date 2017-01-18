require 'minitest/autorun'
require_relative '../checkout_machine'
require_relative '../purchase_log'
require_relative '../totaler'

class CheckoutMachineTest < Minitest::Test
  def setup
    purchase_log = PurchaseLog.new
    @cm = CheckoutMachine.new(purchase_log, Totaler.new(purchase_log))
  end

  def test_scan_chips_expects_total_200
    # Arrange

    # Act
    @cm.scan(123)

    # Assert
    assert_equal 200, @cm.total
  end

  def test_scan_salsa_expects_total_100
    # Arrange

    # Act
    @cm.scan(456)

    # Assert
    assert_equal 100, @cm.total
  end

  def test_scan_wine_expects_total_1000
    # Arrange

    # Act
    @cm.scan(789)

    # Assert
    assert_equal 1000, @cm.total
  end

  def test_scan_cigarettes_expects_total_550
    # Arrange

    # Act
    @cm.scan(111)

    # Assert
    assert_equal 550, @cm.total
  end

  def test_scan_all_products_expects_total_1850
    # Arrange

    # Act
    @cm.scan(123)
    @cm.scan(456)
    @cm.scan(789)
    @cm.scan(111)

     # Assert
    assert_equal 1850, @cm.total
  end

  def test_scan_chips_with_bonus_card_expect_200
    # Arrange
    @cm.scan(123) # chips

    # Act
    @cm.scan(000)


    # Assert
    assert_equal 200, @cm.total
  end

  def test_scan_salsa_with_bonus_card_expects_50
    # Arrange

    @cm.scan(456) # salsa
    
    # Act
    @cm.scan(000)

    # Assert
    assert_equal 50, @cm.total
  end

  def test_scan_three_chips_with_bonus_card_expects_400
    # Arrange

    # Act
    3.times { @cm.scan(123) }
    @cm.scan(000)

    # Assert
    assert_equal 400, @cm.total
  end

  def test_scan_four_chips_with_bonus_card_expects_600
    # Arrange

    # Act
    4.times { @cm.scan(123) }
    @cm.scan(000)

    # Assert
    assert_equal 600, @cm.total
  end

  def test_scan_seven_chips_with_bonus_card_expects_1000
    # Arrange

    # Act
    7.times { @cm.scan(123) }
    @cm.scan(000)

    # Assert
    assert_equal 1000, @cm.total
  end
end
