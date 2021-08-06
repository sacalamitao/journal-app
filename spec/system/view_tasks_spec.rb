require 'rails_helper'

RSpec.describe "ViewTasks", type: :system do
  before do
    driven_by(:rack_test)
  end

  before :all do
    Task.destroy_all
  end

  let(:date) { DateTime.new(2021, 8, 4, 18, 24, 0)}
  let!(:task) {Task.create(todo:'sample todo', due: date, notes: 'sample notes' )}

describe 'index view' do
  it 'display all tasks' do

    visit tasks_path
    expect(Task.count).to eq(1)
    # visit tasks_path

    within 'tbody' do
    expect(page).to have_selector('tr', count: 1)
    end
  end

  it 'loads the edit view when edit button is clicked' do
    visit tasks_path
    within 'tbody' do
      find_link('Edit').click
    end
    expect(page).to have_current_path(edit_task_path(task))
    expect(find_field('Todo').value).to eq task.todo
    expect(find_field('Due').value).to eq task.due.strftime("%FT%T")
    expect(find_field('Notes').value).to eq task.notes
  end

  it 'loads the show view when the show button is clicked' do
    visit tasks_path
    within 'tbody' do
      find_link('Show').click
    end
    expect(page).to have_current_path(task_path(task))
    expect(page).to have_content(task.todo)
    expect(page).to have_content(task.due)
    expect(page).to have_content(task.notes)
  end

  it 'destroys task when the delete button is clicked' do
    visit tasks_path
    expect{ click_link('Delete') }.to change(Task, :count).by(-1)
  expect(page).to have_current_path(tasks_path)
  expect(page).to have_content('Task was deleted successfully')
end


end

end
