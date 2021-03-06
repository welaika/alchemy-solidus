require 'alchemy/version'
require 'rails_helper'
begin
  require 'factory_girl'
rescue LoadError
end
require 'spree/testing_support/factories/address_factory'

RSpec.feature "Admin Integration", type: :feature do
  it 'gets redirected to login if accessing admin' do
    visit '/admin'

    expect(page).to have_field 'user_login'
  end

  it 'it is possible to login and visit Alchemy admin' do
    login!
    visit '/admin/dashboard'

    expect(page).to have_content 'Welcome back'
  end

  it 'it is possible to login and visit Spree admin' do
    login!
    visit '/admin/orders'

    expect(page).to have_content 'No Orders found'
  end

  private

  def login!
    visit '/admin/login'

    expect(page).to have_field 'user_login'
    fill_in 'user_login', with: 'admin'
    fill_in 'user_password', with: 'test1234'
    click_button Alchemy.version > '4.1.0' ? 'Login' : 'login'
  end
end
