require 'rails_helper'

RSpec.describe Project, type: :model do
  it { is_expected.to validate_uniqueness_of(:name).scoped_to(:user_id) }

  describe "late status" do
    let(:current_time) { Time.current }

    before do
      allow(Time).to receive(:current).and_return(current_time)
    end

    it "is late when the due date is past today" do
      project = FactoryBot.create(:project, due_on: current_time - 1.day)
      expect(project).to be_late
    end

    it "is on time when the due date is today" do
      project = FactoryBot.create(:project, due_on: current_time)
      expect(project).to_not be_late
    end

    it "is on time when the due date is in the future" do
      project = FactoryBot.create(:project, due_on: current_time + 1.day)
      expect(project).to_not be_late
    end
  end

  it "can have many notes" do
    project = FactoryBot.create(:project, :with_notes)
    expect(project.notes.length).to eq 5
  end
end
