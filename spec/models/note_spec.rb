require 'rails_helper'

RSpec.describe Note, type: :model do
  before do
    user = FactoryBot.create(:user)
    @project = FactoryBot.create(:project, owner: user)
  end

  it "is valid with a user, project, and message" do
    note = FactoryBot.create(:note, project: @project)
    expect(note).to be_valid
  end

  it "is invalid without a message" do
    note = FactoryBot.build(:note, project: @project, message: nil)
    note.valid?
    expect(note.errors[:message]).to include("can't be blank")
  end

  describe "search message for a term" do
    before do
      @note1 = FactoryBot.create(:note, project: @project, message: "This is the first note.")
      @note2 = FactoryBot.create(:note, project: @project, message: "This is the second note.")
      @note3 = FactoryBot.create(:note, project: @project, message: "First, preheat the oven.")
    end

    context "when a match is found" do
      it "returns notes that match the search term" do
        expect(Note.search("first")).to include(@note1, @note3)
      end
    end

    context "when no match is found" do
      it "returns an empty collection" do
        expect(Note.search("message")).to be_empty
      end
    end
  end
end
