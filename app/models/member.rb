class Member
  include Mongoid::Document

  field :name

  belongs_to :user
  belongs_to :group

  has_many :payments

  has_many :credits, class_name: 'Debt', inverse_of: 'lender'
  has_many :debits, class_name: 'Debt', inverse_of: 'borrower'

  has_many :paid_bills, class_name: 'Transaction', inverse_of: 'buyer', dependent: :destroy
  has_and_belongs_to_many :bills, class_name: 'Transaction', inverse_of: 'receivers'


  validates :name, :group_id, presence: true

  def balance
    payments.sum(&:amount)
  end
end
