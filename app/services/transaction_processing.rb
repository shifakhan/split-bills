class TransactionProcessing
  attr_accessor :tx
  
  def initialize(transaction)
    @tx = transaction
  end

  def approve(params = {})
    update_payments if (params.present? ? tx.update!(params) : tx.save!)
    DebtCalculation.new(tx.group).calculate
    Debt.print
  # rescue return validation errors
  end

  def update_payments
    tx.invalid_payments.destroy
    find_or_create_payment(tx.buyer_id, buyer_amount)
    (tx.receiver_ids - [tx.buyer_id]).each{ |receiver_id| find_or_create_payment(receiver_id) }
    tx.payments
  end

  private

  def find_or_create_payment(member_id, amount = -tx.split_amount)
    payment = Payment.where(transaction_id: tx.id, member_id: member_id).first_or_create
    payment.amount = amount
    payment.save!
  end

  def destroy
    DebtCalculation.new(tx.group).calculate if tx.destroy
  end

  def buyer_amount
    tx.receiver_ids.include?(tx.buyer_id) ? (tx.amount - tx.split_amount) : tx.amount
  end
end