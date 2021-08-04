require 'rails_helper'

RSpec.describe "CreateTasks", type: :system do
  before do
    driven_by(:rack_test)
  end

  it 'saves and display task' do
    visit '/tasks/new'
    fill_in 'Todo', with: 'sample task'
    fill_in 'Due', with: 'datetime'
    fill_in 'Notes', with: 'sample notes'
    click_on 'Submit task'

    expect(page).to have_content('sample task')
    expect(page).to have_content('datetime')
    expect(page).to have_content('sample notes')

    task = Task.order("id").last
    expect(task.text).to eq('sample task')
    expect(task.due).to eq('datetime')
    expect(task.notes).to eq('sample notes')


  end

  pending "add some scenarios (or delete) #{__FILE__}"
end
