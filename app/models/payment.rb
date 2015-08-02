class Payment
  include Mongoid::Document

  field :amount

  belongs_to :user
  belongs_to :transaction

end
