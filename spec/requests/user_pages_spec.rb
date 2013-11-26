require 'spec_helper'

describe "User pages" do
  
  subject { page }

  describe "sign in page" do
    before { visit new_user_session_path }

    it { should have_selector('h1',    text: 'Sign in') }
    it { should have_selector('title', text: full_title('Sign in')) }
  end

  # describe "sign up" do
  #   before { visit new_user_registration_path }

  #   let(:submit) { "Sign up" }

  #   describe "with invalid information" do
  #     it "should not create user" do
  #       expect { click_button submit }.not_to change(User, :count)
  #     end
  #   end

  #   describe "with valid information" do
  #     before do
  #       user = create(:user)
  #       puts user.password
  #       fill_in "Username", with: user.username
  #       fill_in "Email", with: user.email
  #       fill_in "Password", with: user.password
  #       fill_in "Password confirmation", with: user.password_confirmation
  #       user.save!
  #     end

  #     it "should create a user" do
  #       expect { click_button submit }.to change(User, :count).by(1)
  #     end
  #   end
  # end


  describe "profile page" do
    let(:user) { create(:user) }
    let!(:w1) { create(:wiki, user: user, title: "Foobar Nova Scotia", body: "Foobar nova scotia foobar") }
    let!(:w2) { create(:wiki, user: user, title: "Foobar2 Nova Scotia", body: "Foobar nova2 scotia foobar") }
    before { visit user_path(user) }

    it { should have_selector('h1', text: user.username) }
    it { should have_selector('title', text: user.username) }

    describe "wikis" do
      it { should have_content(w1.title)}
      it { should have_content(w1.body)}
      it { should have_content(w2.title)}
      it { should have_content(w2.body)}
      it { should have_content(user.wikis.count) }
    end
  end

end
