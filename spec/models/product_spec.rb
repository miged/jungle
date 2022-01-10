require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do
    before :each do
      @category = Category.create(name: 'Category')
      @product = Product.new(
                  name: 'Product Name',
                  description: 'Product Description',
                  category_id: @category.id,
                  quantity: 10,
                  price: 999
      )
    end

    it 'should save to the database' do
      expect(@product.save).to be_truthy
    end

    it 'should validate that name is present' do
      @product.name = nil
      expect(@product.save).to_not be_truthy
      error = @product.errors.full_messages
      expect(error).to include("Name can't be blank")
    end

    it 'should validate that price is present' do
      @product.price = ''
      expect(@product.save).to_not be_truthy
      error = @product.errors.full_messages
      expect(error).to include('Price is not a number')
    end

    it 'should validate that quantity is present' do
      @product.quantity = nil
      expect(@product.save).to_not be_truthy
      error = @product.errors.full_messages
      expect(error).to include("Quantity can't be blank")
    end

    it 'should validate that category is present' do
      @product.category = nil
      expect(@product.save).to_not be_truthy
      error = @product.errors.full_messages
      expect(error).to include("Category can't be blank")
    end
  end
end
