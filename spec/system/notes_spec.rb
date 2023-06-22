require 'rails_helper'

RSpec.describe "Notes", type: :system do
  scenario "user creates a new note" do
    user = FactoryBot.create(:user)
    project = FactoryBot.create(:project, owner: user, name: "Test Project")

    visit root_path
    click_link "Sign in"
    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
    click_button "Log in"

    expect {
      click_link "Test Project"
      click_link "Add Note"
      fill_in "Message", with: "Test Message"
      click_button "Create Note"

      expect(page).to have_content "Note was successfully created"
      expect(page).to have_content "Test Message"
      expect(page).to have_content "Test Message"
    }.to change(project.notes, :count).by(1)
  end
end
