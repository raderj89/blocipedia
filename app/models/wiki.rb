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

class Wiki < ActiveRecord::Base
  attr_accessible :body, :public, :title

  belongs_to :user

  validates :user_id, presence: true
end
