require 'rails_helper'

RSpec.describe "Projects", type: :system do
  let(:user) { FactoryBot.create(:user) }

  before do
    sign_in user
    visit root_path
  end

  def create_project(name:, description:)
    click_link "New Project"
    fill_in "Name", with: name
    fill_in "Description", with: description
    click_button "Create Project"
  end

  scenario "user creates a new project" do
    expect {
      create_project(name: 'RSpec Practice', description: 'fjord bootcamp')
      aggregate_failures do
        expect(page).to have_content "Project was successfully created"
        expect(page).to have_content 'RSpec Practice'
        expect(page).to have_content "Owner: #{user.name}"
      end
    }.to change(user.projects, :count).by(1)
  end

  scenario "user edits a project" do
    create_project(name: 'RSpec Practice', description: 'fjord bootcamp')

    click_link "Edit"
    fill_in "Name", with: 'Minitest Practice'
    click_button "Update Project"
    
    expect(page).to have_content "Project was successfully updated"
    expect(page).to have_content "Minitest Practice"
  end
end
