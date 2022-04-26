require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do

    before do
      @category = Category.create(:name => "Electronics")
    end

    before(:each) do
      @valid_test_record = {
        :name => 'iPad',
        :price => Money.from_cents(123400),
        :quantity => 5,
        :category => @category
      }
    end

    context "When given name, price, quantity and category" do
      it "all validations pass" do
        product = Product.create(@valid_test_record)
        expect(product.valid?).to eq(true)
        expect(product.name).to eq('iPad') 
        expect(product.price.to_i).to eq(1234) 
        expect(product.quantity).to eq(5) 
        expect(product.category).to eq(@category) 
      end
    end

    context "When product name is missing" do
      it "saving the record fails" do
        @valid_test_record.delete(:name)
        product = Product.new(@valid_test_record)
        expect(product.save).to eq(false)
        #puts product.errors.full_messages[0] => "Name can't be blank"
      end
    end

    context "When product price is missing" do
      it "saving the record fails" do
        @valid_test_record.delete(:price)
        product = Product.new(@valid_test_record)
        expect(product.save).to eq(false)
        #puts product.errors.full_messages[0] => "Price cents is not a number"
      end
    end
    
    context "When product quantity is missing" do
      it "saving the record fails" do
        @valid_test_record.delete(:quantity)
        product = Product.new(@valid_test_record)
        expect(product.save).to eq(false)
        #puts product.errors.full_messages[0] => "Quantity can't be blank"
      end
    end

    context "When product category is missing" do
      it "saving the record fails" do
        @valid_test_record.delete(:category)
        product = Product.new(@valid_test_record)
        expect(product.save).to eq(false)
        #puts product.errors.full_messages[0] => "Category can't be blank"
      end
    end

  end
end
