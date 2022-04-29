require 'rails_helper'

RSpec.feature "Users can login", type: :feature, js:true do

  before do
    user = User.create!(
      name: "Bob",
      email: "test@gmail.com", 
      password: "abcdefgh", 
      password_confirmation: "abcdefgh"
    )
  end

  scenario "attempt with correct credentials succeeds, get redirected to home page" do
    #ACT
    visit login_path
    fill_in 'email', with: 'test@gmail.com'
    fill_in 'password', with: 'abcdefgh'
    click_button 'Login'

    #VERIFY
    page.find('li', text: "Logout Bob")

    #DEBUG
    save_screenshot
  end  
  
  scenario "attempt with incorrect credentials fails, gets error message" do
    #ACT
    visit login_path
    fill_in 'email', with: 'test@gmail.com'
    fill_in 'password', with: 'incorrect'
    click_button 'Login'

    #VERIFY
    flash_div = page.find('.alert')
    has_invalid_creds_error = flash_div['innerHTML'].match(/invalid credentials/i)!=nil
    expect(has_invalid_creds_error).to eq true

    #DEBUG
    save_screenshot
  end  

end
