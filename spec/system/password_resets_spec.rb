require 'rails_helper'

RSpec.describe "Password Resets", type: :system do
  include ActiveJob::TestHelper

  let(:user) { FactoryBot.create(:user) }

  scenario "user successfully resets password" do
    visit root_path
    click_link "Sign In"
    click_link "Forgot your password?"

    perform_enqueued_jobs do
      fill_in "Email", with: user.email
      click_button "Send me reset password instructions"

      expect(page).to \
        have_content "You will receive an email with instructions on how to reset your password in a few minutes."
    end

    mail = ActionMailer::Base.deliveries.last
    reset_token = mail.body.encoded.scan(/reset_password_token=(.*?)"/).flatten.first
    visit edit_user_password_path(reset_password_token: reset_token)
    
    fill_in "New password", with: "new_password"
    fill_in "Confirm new password", with: "new_password"
    click_button "Change my password"

    expect(page).to \
      have_content "Your password has been changed successfully. You are now signed in."
  end
end