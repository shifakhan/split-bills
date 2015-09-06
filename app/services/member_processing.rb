class MemberProcessing
  attr_accessor :member

  def initialize(member)
    @member = member
  end

  def destroy
    if member.destroy
      member.bills.each{|bill| TransactionProcessing.new(bill).update_payments}
    end
    DebtCalculation.new(member.group).calculate
  end

  def assign_email(email)
    user = User.where(email: email).first_or_create
    member.user_id = user.id
    member.save
  end
end