class SearchKeywords
  include ActiveModel::Model
  attr_accessor :keywords
  
  validates :keywords, presence: true,  length: { minimum: 1 }
end
