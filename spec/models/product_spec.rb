require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do
    it 'should save successfully if all 4 params met' do
      @category = Category.new({name: 'cats'})
      @product = Product.new({name: 'kitten', price: '200', quantity: '3', category: @category})

      expect(@product).to be_valid
    end

    it 'should not save if no name provided' do
      @category = Category.new({name: 'cats'})
      @product = Product.new({price: '200', quantity: '3', category: @category})

      expect(@product).to_not be_valid
      expect(@product.errors.messages[:name]).to include("can't be blank")
    end

    it 'should not save if no price provided' do
      @category = Category.new({name: 'cats'})
      @product = Product.new({name: 'kitten', quantity: '3', category: @category})

      expect(@product).to_not be_valid
      expect(@product.errors.messages[:price]).to include("can't be blank")
    end

    it 'should not save if no quantity provided' do
      @category = Category.new({name: 'cats'})
      @product = Product.new({name: 'kitten', price: '200', category: @category})

      expect(@product).to_not be_valid
      expect(@product.errors.messages[:quantity]).to include("can't be blank")
    end

    it 'should not save if no category provided' do
      @category = Category.new({name: 'cats'})
      @product = Product.new({name: 'kitten', price: '200', quantity: '3'})

      expect(@product).to_not be_valid
      expect(@product.errors.messages[:category]).to include("can't be blank")
    end
  end
end
