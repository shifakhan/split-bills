class DebtCalculation
  attr_accessor :group
  
  MAX_USERS = 9
  MIN_SET_SIZE = 2

  def initialize(group)
    @group = group
  end

  UserBalance = Struct.new(:id, :balance)

  def calculate
    list = balance_list
    group.debts.destroy
    if group.members.count < MAX_USERS
      optimum_solution(list)
    else
      basic_solution(list)
    end
    return list.empty?
  end

  private

  def basic_solution(list)
    while list.length > 1
      borrower = list[0]
      lender = list[-1]
      if borrower.balance.abs > lender.balance.abs
        borrower.balance += lender.balance
        group.debts.create!( amount: lender.balance.abs, borrower_id: borrower.id, lender_id: lender.id )
        lender.balance = 0
      else
        lender.balance += borrower.balance
        group.debts.create!( amount: borrower.balance.abs, borrower_id: borrower.id, lender_id: lender.id )
        borrower.balance = 0
      end
      list.reject!{ |user_balance| user_balance.balance == 0}.to_a.sort_by!(&:balance)
    end
  end

  def optimum_solution(list)
    set_size = MIN_SET_SIZE
    while list.length > set_size
      set = list.combination(set_size).select{|set| set.sum(&:balance) == 0}.first
      if set
        list -= set #remove sets from list
        basic_solution(set) #create debts amongst them 
      else
        set_size += 1 #increase set size
      end
    end
    basic_solution(list) if list.present?
  end

  def balance_list
    group.members.to_a.sort_by(&:balance).collect{|m| UserBalance.new(m.id, m.balance)}
  end
end