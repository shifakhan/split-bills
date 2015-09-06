class Payment
  include Mongoid::Document

  field :amount, type: BigDecimal

  belongs_to :member
  belongs_to :transaction

  # validates :member_id, :transaction_id, presence: true

  scope :positive, -> { where({'amount' => {'$gt' => 0}}) }
  scope :negative, -> { where({'amount' => {'$lte' => 0}}) }

end
