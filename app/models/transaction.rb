class Transaction
  include Mongoid::Document
  include Mongoid::Timestamps::Short
  field :name
  field :amount, type: BigDecimal

  has_many :payments, dependent: :destroy
  has_and_belongs_to_many :receivers, class_name: 'Member', inverse_of: 'bills'

  belongs_to :group
  belongs_to :buyer, class_name: 'Member', inverse_of: 'paid_bills'

  validates :amount, :group_id, :buyer_id, presence: true
  validates :receiver_ids, length: {minimum: 1}
  def split_amount
    amount/receiver_ids.count
  end

  def invalid_payments
    payments.where(:user_id.nin => users)
  end

  def users
    [buyer_id] + receiver_ids
  end

  # def update_payments
  #   TransactionProcessing.new(self).update_payments
  # end
end
