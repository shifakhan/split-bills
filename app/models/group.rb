class Group
  include Mongoid::Document

  field :name

  has_many :transactions
  has_many :payments
  has_many :debts
  has_and_belongs_to_many :users 

  validates :name, presence: true
end
