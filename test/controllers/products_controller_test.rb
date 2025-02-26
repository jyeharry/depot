require "test_helper"

class ProductsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @product = products(:one)
    @title = "The Great Book #{rand(1000)}"
  end

  test "should get index" do
    get products_url
    assert_response :success
    assert_select "tbody tr", 3
    assert_select "h1", "The Pragmatic Programmer"
    assert_select "div", /\$[,\d]+\.\d\d/
  end

  test "should get new" do
    get new_product_url
    assert_response :success
    assert_select "input", 4
    assert_select "textarea", 1
    assert_select "input[type=submit]", { value: "Create Product" }
    assert_select "a", { text: "Back to products" }
  end

  test "should create product" do
    assert_difference("Product.count") do
      post products_url, params: { product: {
        description: @product.description,
        image: file_fixture_upload("lorem.jpg", "image/jpeg"),
        price: @product.price,
        title: @title
      } }
    end

    assert_redirected_to product_url(Product.last)
  end

  test "should show product" do
    get product_url(@product)
    assert_response :success
    assert_select "div", /#{@product.title}/
    assert_select "div", /#{@product.description}/
    assert_select "div", /#{@product.image.filename}/
    assert_select "div", /#{@product.price}/
  end

  test "should get edit" do
    get edit_product_url(@product)
    assert_response :success
    assert_select "input", value: @product.title
    assert_select "textarea", value: @product.description
    assert_select "input[type=file]"
    assert_select "input", value: @product.price
  end

  test "should update product" do
    patch product_url(@product), params: { product: {
        description: @product.description,
        image: file_fixture_upload("lorem.jpg", "image/jpeg"),
        price: @product.price,
        title: @title
      } }
    assert_redirected_to product_url(@product)
  end

  test "should destroy product" do
    assert_difference("Product.count", -1) do
      delete product_url(@product)
    end

    assert_redirected_to products_url
  end

  test "should not destroy product that's in a cart" do
    product_in_cart = carts(:one).line_items.first.product
    assert_raises(ActiveRecord::RecordNotDestroyed, "Product should be destroyed when not in a cart") do
      delete product_url(product_in_cart)
    end

    assert Product.exists? product_in_cart.id
  end
end
