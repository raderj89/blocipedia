class WikiCollaboration < ActiveRecord::Base
  belongs_to :wiki
  belongs_to :user

  attr_accessible :wiki_id, :user_id

end
