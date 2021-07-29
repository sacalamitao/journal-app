require 'rails_helper'

RSpec.describe "Creating a category", type: :system, js: true do
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
