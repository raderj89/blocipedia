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
  before { @wiki = user.wikis.build(title: "Foobar", body: "Foobar nova scotia" * 10 ) }

  subject { @wiki }

  it { should respond_to(:title) }
  it { should respond_to(:body) }
  it { should respond_to(:user_id) }
  its(:user) { should == user }

  describe "accessible attributes" do
    it "should not allow access to user_id" do
      expect do
        Wiki.new(user_id: user.id)
      end.to raise_error(ActiveModel::MassAssignmentSecurity::Error)
    end
  end

  describe "when user id is not present" do
    before { @wiki.user_id = nil }
    it { should_not be_valid }
  end
end
