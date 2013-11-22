# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  username               :string(255)      not null
#  email                  :string(255)      default(""), not null
#  encrypted_password     :string(255)      default(""), not null
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
#  confirmation_token     :string(255)
#  confirmed_at           :datetime
#  confirmation_sent_at   :datetime
#  unconfirmed_email      :string(255)
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#

require 'spec_helper'

describe User do

  before { @user = User.new(username: "Jared Rader", email: "raderj89@gmail.com", password: "helloworld", password_confirmation: "helloworld") }

  subject { @user }

  it { should respond_to(:username) }
  it { should respond_to(:email) }

  it { should be_valid }

  it { should respond_to(:wikis) }

  # describe "when name is not present" do
  #   before { @user.username = " " }
  #   it { should_not be_valid }
  # end

  # describe "when name is too long" do
  #   before { @user.username = "J" * 51}
    
  #   it { should_not be_valid }
  # end

  # describe "when email is not present" do
  #   before { @user.email = " " }

  #   it { should_not be_valid }
  # end

  # describe "when email format is invalid" do
  #   it "should be invalid" do
  #     addresses = %w[user@foo,com user_at_foo.org example.user@foo.
  #                      foo@bar_baz.com foo@bar+baz.com]
  #     addresses.each do |invalid_address|
  #         @user.email = invalid_address
  #         @user.should_not be_valid
  #     end
  #   end
  # end
end
