class User
  include Mongoid::Document

  field :name
  field :email

  has_many :members

  validates :name, presence: true
  validates :email, presence: true, uniqueness: {case_sensitive: false}
end
