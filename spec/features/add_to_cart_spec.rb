require 'rails_helper'

RSpec.feature "AddToCarts", type: :feature, js:true do

  before :each do
    @category = Category.create! name: 'Apparel'

    10.times do |n|
      @category.products.create!(
        name: Faker::Hipster.sentence(3),
        description: Faker::Hipster.paragraph(4),
        quantity: (rand(10)+1)*(rand(10)+1),
        price: 64.99 * rand(15),
        image: open_asset('apparel1.jpg')        
      )
    end
  end

  feature "They can add an item to the cart" do

    scenario "They click the Add-to-cart button on a product in the list" do
      #ACT
      visit root_path
      a = page.find('a', text: 'Cart')

      #VERIFY
      item_count_before = a['innerHTML'].match( /\d/).values_at(0)[0].to_i
      expect(item_count_before).to eq 0

      #ACT
      click_on 'Add', match: :first
      
      #VERIFY
      item_count_after = a['innerHTML'].match( /\d/).values_at(0)[0].to_i
      expect(item_count_after).to eq 1

      #DEBUG
      save_screenshot      

      # Note:
      #  Could simply check for text "My Cart (0)", and "My Cart (1)", respectively
      #  but I feel that would be too dependent on UI decisions that may change,
      #  causing the example to break if the wording changed
    end

  end

end
