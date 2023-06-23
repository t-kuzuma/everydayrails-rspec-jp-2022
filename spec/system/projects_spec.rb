require 'rails_helper'

RSpec.describe "Projects", type: :system do
  let(:user) { FactoryBot.create(:user) }

  before do
    sign_in user
    visit root_path
  end

  def create_project
    click_link "New Project"
    fill_in "Name", with: "Test Project"
    fill_in "Description", with: "Trying out Capybara"
    click_button "Create Project"
  end

  def edit_project
    click_link "Edit"
    fill_in "Name", with: "Edit Project"
    click_button "Update Project"
  end

  scenario "user creates a new project" do
    expect {
      create_project
      aggregate_failures do
        expect(page).to have_content "Project was successfully created"
        expect(page).to have_content "Test Project"
        expect(page).to have_content "Owner: #{user.name}"
      end
    }.to change(user.projects, :count).by(1)
  end

  scenario "user edits a project" do
    create_project
    edit_project
    expect(page).to have_content "Project was successfully updated"
    expect(page).to have_content "Edit Project"
  end
end
