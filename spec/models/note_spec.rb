require 'rails_helper'

RSpec.describe Note, type: :model do
  let(:user) { FactoryBot.create(:user) }
  let(:project) { FactoryBot.create(:project, owner: user) }

  it { is_expected.to validate_presence_of :message }

  it 'has one attached attachment' do
    note = FactoryBot.create(:note, :with_attachment)
    expect(note.attachment).to be_attached
  end

  describe "search message for a term" do
    let!(:note1) {
      FactoryBot.create(:note,
        project: project,
        user: user,
        message: "This is the first note.",
      )
    }

    let!(:note2) {
      FactoryBot.create(:note,
        project: project,
        user: user,
        message: "This is the second note.",
      )
    }

    let!(:note3) {
      FactoryBot.create(:note,
        project: project,
        user: user,
        message: "First, preheat the oven.",
      )
    }

    context "when a match is found" do
      it "returns notes that match the search term" do
        expect(Note.search("first")).to include(note1, note3)
        expect(Note.search("first")).to_not include(note2)
      end
    end

    context "when no match is found" do
      it "returns an empty collection" do
        expect(Note.search("message")).to be_empty
        expect(Note.count).to eq 3
      end
    end
  end

  it "delegates name to the user who created it" do
    user = instance_double("User", name: "Fake User")
    note = Note.new
    allow(note).to receive(:user).and_return(user)
    expect(note.user_name).to eq "Fake User"
  end
end
