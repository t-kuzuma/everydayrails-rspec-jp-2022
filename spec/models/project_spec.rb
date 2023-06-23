require 'rails_helper'

RSpec.describe Project, type: :model do
  it { is_expected.to validate_uniqueness_of(:name).scoped_to(:user_id) }

  describe "late status" do
    it "is late when the due date is past today" do
      travel_to Time.current do
        project = FactoryBot.create(:project, due_on: 1.day.ago)
        expect(project).to be_late
      end
    end

    it "is on time when the due date is today" do
      travel_to Time.current do
        project = FactoryBot.create(:project, due_on: Time.current)
        expect(project).to_not be_late
      end
    end

    it "is on time when the due date is in the future" do
      travel_to Time.current do
        project = FactoryBot.create(:project, due_on: 1.day.from_now)
        expect(project).to_not be_late
      end
    end
  end

  it "can have many notes" do
    project = FactoryBot.create(:project, :with_notes)
    expect(project.notes.length).to eq 5
  end
end
