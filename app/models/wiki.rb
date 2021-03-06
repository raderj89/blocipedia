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
  extend FriendlyId
  friendly_id :title, use: [:slugged, :history]

  attr_accessible :body, :public, :title

  belongs_to :user
  has_many :wiki_collaborations
  has_many :users, through: :wiki_collaborations

  validates :user_id, presence: true
  validates :title, presence: true, length: { maximum: 220 }
  validates :body, presence: true, length: { minimum: 20 }

  default_scope order: 'wikis.created_at DESC'

  # From Railscasts #343 http://railscasts.com/episodes/343-full-text-search-in-postgresql
  def self.text_search(query)
    if query.present?
      # ilike makes search case insensitive
      # @@ full text search in Postgres
      #where("title @@ :q or body @@ :q", q: query)
      search(query)
    else
      scoped
    end
  end
end
