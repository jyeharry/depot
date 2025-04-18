require "test_helper"

class LineItemsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @line_item = line_items(:one)
  end

  test "should get index" do
    get line_items_url
    assert_response :success
  end

  test "should get new" do
    get new_line_item_url
    assert_response :success
  end

  test "should create line_item" do
    assert_difference("LineItem.count") do
      post line_items_url, params: { product_id: products(:pragprog).id }
    end

    follow_redirect!

    item = LineItem.order(:updated_at).last
    assert_select "h2", "Your Cart"
    assert_select "tr" do
      assert_select "td", item.quantity.to_s
      assert_select "td", "\u00D7"
      assert_select "td", products(:pragprog).title
    end
  end

  test "should create a line_item via turbo_stream" do
    assert_difference("LineItem.count") do
      post line_items_url, params: { product_id: products(:pragprog).id }, as: :turbo_stream
    end

    assert_response :success
    assert_match (/<tr class=.line-item-highlight.>/), @response.body
  end

  test "should show line_item" do
    get line_item_url(@line_item)
    assert_response :success
  end

  test "should get edit" do
    get edit_line_item_url(@line_item)
    assert_response :success
  end

  test "should update line_item" do
    patch line_item_url(@line_item), params: { line_item: { product_id: @line_item.product_id } }
    assert_redirected_to cart_url(@line_item.cart)
  end

  test "should destroy line_item" do
    assert_difference("LineItem.count", -1) do
      delete line_item_url(@line_item)
    end

    assert_redirected_to cart_url(@line_item.cart)
  end
end
