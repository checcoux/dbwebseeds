ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require 'minitest/rails/capybara'

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  def logon_as_administrator
    visit '/'
    click_on 'login'
    fill_in 'user_email', :with => "test@donboscoland.it"
    fill_in 'user_password', :with => "testtest"
    click_on 'Accedi'
  end

  def logon_as_designer
    visit '/'
    click_on 'login'
    fill_in 'user_email', :with => "test2@donboscoland.it"
    fill_in 'user_password', :with => "test2test"
    click_on 'Accedi'
  end

  def logon_as_editor
    visit '/'
    click_on 'login'
    fill_in 'user_email', :with => "test3@donboscoland.it"
    fill_in 'user_password', :with => "test3test"
    click_on 'Accedi'
  end

  def logon_as_user
    visit '/'
    click_on 'login'
    fill_in 'user_email', :with => "test4@donboscoland.it"
    fill_in 'user_password', :with => "test4test"
    click_on 'Accedi'
  end
end
