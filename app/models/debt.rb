class Debt
  include Mongoid::Document

  field :sender
  field :receiver
  field :amount

  belongs_to :group
end
