require "test_helper"

class ProductFlowTest < ActionDispatch::IntegrationTest
  setup do
    @product = products(:one)
    @title = "The Great Book #{rand(1000)}"
  end

  test "can create a product" do
    get new_product_url
    assert_response :success

    assert_difference("Product.count") do
      post products_url, params: { product: {
        description: @product.description,
        image: file_fixture_upload("lorem.jpg", "image/jpeg"),
        price: @product.price,
        title: @title
      } }
    end

    assert_redirected_to product_url(Product.last)
    follow_redirect!
    assert_response :success
    assert_select "div", /#{@title}/
  end

  test "can edit a product" do
    get edit_product_url(@product)
    assert_response :success
    assert_select "input", value: @product.title
    assert_select "textarea", value: @product.description
    assert_select "input[type=file]"
    assert_select "input", value: @product.price

    patch product_url(@product), params: { product: {
      description: @product.description,
      image: file_fixture_upload("lorem.jpg", "image/jpeg"),
      price: @product.price,
      title: @title
    } }
    assert_redirected_to product_url(@product)
    follow_redirect!
    assert_response :success
    assert_select "div", /#{@title}/
  end
end
