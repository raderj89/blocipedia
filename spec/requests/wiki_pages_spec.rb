require 'spec_helper'
include Warden::Test::Helpers
Warden.test_mode!

# As a user, I want to go to the page to create a new wiki

describe "Wiki pages" do
  subject { page }

  describe "wiki creation page" do
    before { visit new_wiki_path }
    it { should have_selector('h1', text: 'New Wiki') }
    it { should have_selector('title', text: 'New Wiki') }
  end

  let(:user) { FactoryGirl.create(:user) }
  before { login_as(user, :scope => :user) }

  describe "wiki creation" do
    before { visit new_wiki_path }

    # If I enter a wiki with bad information (too short)
    # It should not create a wiki

    describe "with invalid information" do
      it "should not create a wiki" do
        expect { click_button 'Publish' }.not_to change(Wiki, :count)
      end

      # If I enter a wiki with bad information
      # I should see error messages

      describe "error messages" do
        before { click_button 'Publish' }
        it { should have_content('error') }
      end
    end

    describe "with valid information" do

      before do
        fill_in 'wiki_title', with: "Lorem ipsum"
        fill_in 'wiki_body', with: "Lorem ipsum totalis charactus shi at least 20 characters."
      end
      it "should create a wiki" do
        expect { click_button "Publish"}.to change(Wiki, :count).by(1)
      end
    end
  end
end