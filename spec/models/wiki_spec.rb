# == Schema Information
#
# Table name: wikis
#
#  id         :integer          not null, primary key
#  title      :string(255)
#  body       :text
#  public     :boolean          default(TRUE)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :integer
#

require 'spec_helper'

describe Wiki do
  let(:user) { FactoryGirl.create(:user) }
  # before { @wiki = user.wikis.build(title: "Foobar", body: "Foobar nova scotia" * 10 ) }

  # subject { @wiki }

  # it { should respond_to(:title) }
  # it { should respond_to(:body) }
  # it { should respond_to(:user_id) }
  # its(:user) { should == user }

  it "is valid with title, body and a user_id associated with user creating it" do
    w = user.wikis.build(title: "Foobar", body: "Foobar nova scotia" * 10)
    expect(w).to be_valid
  end

  it "should not allow access to user_id" do
    expect do
      Wiki.create(title: "Foobar", body: "Foobar nova scotia" * 10, user_id: 10)
    end.to raise_error(ActiveModel::MassAssignmentSecurity::Error)
  end

  it "should not create a wiki without a user id" do
    w = Wiki.create(title: "Foobar", body: "Foobar nova scotia" * 10)
    expect(w).to be_invalid
  end

  it "should not create a wiki with no body content" do
    w = user.wikis.build(title: "Foobar", body: "")
    expect(w).to be_invalid
  end

  it "should not create a wiki with too short of content" do
    w = user.wikis.build(title: "Foobar", body: "hi")
    expect(w).to be_invalid
  end

  it "should not create a wiki with no title" do
    w = user.wikis.build(title: "", body: "Foobar nova scotia" * 10)
    expect(w).to be_invalid
  end

  it "should not create a wiki with too long a title" do
    w = user.wikis.build(title: "Foobar" * 50, body: "Foobar nova scotia" * 10)
    expect(w).to be_invalid
  end

    # describe "with blank content" do
    #   before { @wiki.body = ""}
    #   it { should_not be_valid }
    # end

    # describe "when wiki is too short" do
    #   before { @wiki.body = "hello world"}
    #   it { should_not be_valid }
    # end
end