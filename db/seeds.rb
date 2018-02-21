require_relative( "../models/transaction.rb" )
require_relative( "../models/tag.rb" )
require("pry-byebug")

Transaction.delete_all()
Tag.delete_all()


tag1 = Tag.new({
  "name" => "Food",
  "budget" => "200.00"
  })

tag1.save

tag2 = Tag.new({
  "name" => "Utilities",
  "budget" => "100.00"
  })

tag2.save

tag3 = Tag.new({
  "name" => "Housing",
  "budget" => "150.00"
  })

tag3.save

tag4 = Tag.new({
  "name" => "Transport",
  "budget" => "50.00"
  })

tag4.save

tag5 = Tag.new({
  "name" => "Clothing",
  "budget" => "50.00"
  })

tag5.save

tag6 = Tag.new({
  "name" => "Health and Beauty",
  "budget" => "30.00"
  })

tag6.save

tag7 = Tag.new({
  "name" => "Education",
  "budget" => "50.00"
  })

tag7.save

tag8 = Tag.new({
  "name" => "Entertainment",
  "budget" => "70.00"
  })

tag8.save

tag9 = Tag.new({
  "name" => "Treats and Luxuries",
  "budget" => "50.00"
  })

tag9.save

tag10 = Tag.new({
  "name" => "Miscellaneous",
  "budget" => "50.00"
  })

tag10.save





tran1 = Transaction.new({
  "vendor" => "Tesco",
  "amount" => "35.99",
  "tag_id" => tag1.id,
  "details" => "Weekly shop"
})

tran1.save()

tran2 = Transaction.new({
  "vendor" => "Amazon",
  "amount" => "25.97",
  "tag_id" => tag6.id,
  "details" => "Bed Head hair stuff x 3"
})

tran2.save()

tran3 = Transaction.new({
  "vendor" => "Blackfriars",
  "amount" => "2.20",
  "tag_id" => tag9.id,
  "details" => "Diet Coke"
})

tran3.save()

tran4 = Transaction.new({
  "vendor" => "Past Horizons",
  "amount" => "70.98",
  "tag_id" => tag7.id,
  "details" => "Work Tools"
})

tran4.save()

tran5 = Transaction.new({
  "vendor" => "Millets",
  "amount" => "68.99",
  "tag_id" => tag5.id,
  "details" => "Waterproofs"
})

tran5.save()



binding.pry
nil
