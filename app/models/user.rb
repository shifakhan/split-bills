class User
  include Mongoid::Document

  field :name
  field :email

  has_many :transactions
  has_many :payments
  has_and_belongs_to_many :groups

  validates :name, presence: true
  
end
