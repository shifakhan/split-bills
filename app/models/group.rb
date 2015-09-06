class Group
  include Mongoid::Document

  field :name

  has_many :transactions, dependent: :destroy
  has_many :debts, dependent: :destroy
  has_many :members, dependent: :destroy

  validates :name, presence: true

end
