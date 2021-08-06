require 'rails_helper'
require './spec/support/helpers/authentication'
RSpec.configure do |c|
  c.include Helpers::Authentication
end

RSpec.describe "CreateCategories", type: :system, js: true do
  before do
    @user = User.create(username: 'johndoe', firstname: 'John', lastname: 'Doe', password: 'password', password_confirmation: 'password')
    sign_in_as(@user)
  end
  context 'valid inputs' do
    it 'saves and displays new category' do
      visit new_category_path
      # Fill in form
      expect do
        within 'form' do
          fill_in 'Name', with: 'Sports'
          click_on 'Create Category'
        end
        # Page should show success message
        expect(page).to have_content('Category was created successfully')

        # Page redirected to show view
        expect(page).to have_content('Sports')

      end.to change(Category, :count).by(1)
      expect(Category.last.name).to eq('sports')
    end
  end
  context 'invalid inputs' do
    it 'renders new view and displays error' do
      visit new_category_path
      # Fill in form
      expect do
        within 'form' do
          click_on 'Create Category'
        end

        # Page redirected to show view
        expect(page).to have_content("Name can't be blank")

      end.to_not change(Category, :count)

    end
  end
end
