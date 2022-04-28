require 'rails_helper'

RSpec.feature "ProductDetails", type: :feature, js: true do

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

  feature "They can navigate from the home page to the product detail page" do

    scenario "click on a product partial in the product list" do
      #ACT
      visit root_path      
      click_on 'Details', match: :first

      #VERIFY
      section = page.find('section')
      expect(section.assert_matches_selector '.products-show').to eq true  
      expect(section.has_css?('.product-detail')).to eq true
      
      #DEBUG
      save_screenshot
    end

  end

end
