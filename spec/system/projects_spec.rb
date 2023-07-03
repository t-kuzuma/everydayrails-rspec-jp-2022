require 'rails_helper'

RSpec.describe "Projects", type: :system do
  let(:user) { FactoryBot.create(:user) }

  before do
    sign_in user
    visit root_path
  end

  def create_project(options)
    click_link "New Project"
    fill_in "Name", with: options[:name]
    fill_in "Description", with: options[:description]
    click_button "Create Project"
  end

  def edit_project(options)
    click_link "Edit"
    fill_in "Name", with: options[:name]
    click_button "Update Project"
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
    edit_project(name: 'Minitest Practice')
    expect(page).to have_content "Project was successfully updated"
    expect(page).to have_content "Minitest Practice"
  end
end
