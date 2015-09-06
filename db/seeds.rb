# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

user = User.create(name:'Default', email: 'no_user@splitbills.com')
p 'Creating a group'
group = Group.create(name: 'Test')
p 'Creating users'
("A".."H").each { |i| group.members.create(name: "#{i}")}
p 'creating transactions'
test_sets = [
  {'A' => 800, 'B' => 260, 'C' => 200},
  {'A' => 200, 'B' => 200, 'C' => 200, 'D' => 200},
]
test_sets[1].each do |m, amt|
  buyer_id = group.members.find_by(name: m).id
  group.transactions.create!(buyer_id: buyer_id, amount: amt, receivers: group.members)
end
Transaction.all.to_a.each {|t| TransactionProcessing.new(t).approve}