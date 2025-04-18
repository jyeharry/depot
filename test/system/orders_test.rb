require "application_system_test_case"

class OrdersTest < ApplicationSystemTestCase
  setup do
    @order = orders(:one)
  end

  test "visiting the index" do
    visit orders_url
    assert_selector "h1", text: "Orders"
  end

  test "should create order" do
    skip "Revisiting this test later"
    visit orders_url
    click_on "New order"

    fill_in "Address", with: @order.address
    fill_in "Email", with: @order.email
    fill_in "Name", with: @order.name
    select @order.pay_type, from: "Pay type"
    click_on "Place Order"

    assert_text "Order was successfully created"
    click_on "Back"
  end

  test "should update Order" do
    visit order_url(@order)
    click_on "Edit this order", match: :first

    fill_in "Address", with: @order.address
    fill_in "Email", with: @order.email
    fill_in "Name", with: @order.name
    select @order.pay_type, from: "Pay type"
    click_on "Place Order"

    assert_text "Order was successfully updated"
    click_on "Back"
  end

  test "should destroy Order" do
    visit order_url(@order)

    accept_alert do
      click_on "Destroy this order", match: :first
    end

    assert_text "Order was successfully destroyed"
  end

  test "revealing and hiding cart" do
    visit store_index_url

    assert has_no_css? "div#cart"
    assert has_no_css? "tr.line-item-highlight"

    click_on "Add to cart", match: :first

    assert has_css? "div#cart"
    assert has_css? "tr.line-item-highlight"

    click_on "Empty Cart"

    assert has_no_css? "div#cart"
    assert has_no_css? "tr.line-item-highlight"
  end

  test "check dynamic fields" do
    visit store_index_url

    click_on "Add to cart", match: :first
    has_css? "tr.line-item-highlight"

    click_on "Checkout"

    assert has_no_field? "Routing number"
    assert has_no_field? "Account number"
    assert has_no_field? "Credit card number"
    assert has_no_field? "Expiration date"
    assert has_no_field? "Po number"

    select "Check", from: "Pay type"

    assert has_field? "Routing number"
    assert has_field? "Account number"
    assert has_no_field? "Credit card number"
    assert has_no_field? "Expiration date"
    assert has_no_field? "Po number"

    select "Credit card", from: "Pay type"

    assert has_no_field? "Routing number"
    assert has_no_field? "Account number"
    assert has_field? "Credit card number"
    assert has_field? "Expiration date"
    assert has_no_field? "Po number"

    select "Purchase order", from: "Pay type"

    assert has_no_field? "Routing number"
    assert has_no_field? "Account number"
    assert has_no_field? "Credit card number"
    assert has_no_field? "Expiration date"
    assert has_field? "Po number"
  end
end
