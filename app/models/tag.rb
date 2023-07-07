class Tag < ApplicationRecord
  has_many :tag_relations, dependent: :destroy
  has_many :posts, through: :tag_relations
  
  validates :name, uniqueness: :true
end
