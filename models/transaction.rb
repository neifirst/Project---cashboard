require('pry-byebug')
require_relative( '../db/sql_runner' )

class Transaction

  attr_accessor( :vendor, :amount, :tag_id )
  attr_reader(:id, :date_time)

  def initialize( options )
    @id = options['id'].to_i if options['id']
    @date_time = options['date_time']
    @vendor = options['vendor']
    @amount = options['amount']
    @tag_id = options['tag_id']
    @details = options['details']
  end

  def save()
    sql = "INSERT INTO transactions(vendor, amount, tag_id, details)
          VALUES($1, $2, $3, $4)
          RETURNING id"
    values = [@vendor, @amount, @tag_id, @details]
    results = SqlRunner.run(sql, values)
    @id = results.first()['id'].to_i
  end


  def self.all()
    sql = "SELECT * FROM transactions"
    results = SqlRunner.run( sql )
    return results.map { |x| Transaction.new(x) }
  end

  def self.total_amount()
    sql = "SELECT amount FROM transactions"
    results = (SqlRunner.run(sql)).map {|x| x.values}
    return results.flatten.inject(0) {|sum, x| sum + x.to_i}
  end

  def self.find( id )
    sql = "SELECT * FROM transactions
    WHERE id = $1"
    values = [id]
    results = SqlRunner.run( sql, values )
    return Transaction.new( results.first )
  end


  def self.delete_all
    sql = "DELETE FROM transactions"
    SqlRunner.run( sql )
  end




end