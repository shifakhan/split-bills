class Transaction
  include Mongoid::Document
  include Mongoid::Timestamps::Short
  field :name

  has_many :payments

  belongs_to :group
  belongs_to :user

end
