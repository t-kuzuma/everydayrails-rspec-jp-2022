require 'rails_helper'

RSpec.describe "Notes", type: :system do
  scenario "user creates a new note" do
    user = FactoryBot.create(:user, email: 'alice@example.com', password: 'pass1234')
    project = FactoryBot.create(:project, owner: user, name: "Test Project")

    visit root_path
    click_link "Sign in"
    fill_in "Email", with: 'alice@example.com'
    fill_in "Password", with: 'pass1234'
    click_button "Log in"
    expect(page).to have_content "Signed in successfully."

    expect {
      click_link "Test Project"
      click_link "Add Note"
      fill_in "Message", with: "Test Message"
      click_button "Create Note"

      expect(page).to have_content "Note was successfully created"
      expect(page).to have_content "Test Message"
    }.to change(project.notes, :count).by(1)
  end
end
