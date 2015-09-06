class Debt
  include Mongoid::Document

  field :amount, type: BigDecimal

  belongs_to :group
  belongs_to :lender, class_name: 'Member', inverse_of: 'credits'
  belongs_to :borrower, class_name: 'Member', inverse_of: 'debits'

  validates :lender_id, :borrower_id, :group_id, :amount, presence: true

  def self.print
    p '---------------------------'
    Debt.all.to_a.each do |debt|
      p "#{Member.find(debt.borrower_id).name} -> #{debt.amount.to_f} -> #{Member.find(debt.lender_id).name}"
    end
    p '---------------------------'
  end
end
