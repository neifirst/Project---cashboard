require('pry-byebug')
require_relative( '../db/sql_runner' )

class Transaction

  attr_accessor( :vendor, :amount, :tag_id, :details)
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
    values = [@vendor, ((100 * @amount.to_r).to_i), @tag_id, @details]
    results = SqlRunner.run(sql, values)
    @id = results.first()['id'].to_i
  end


  def get_tag()
    sql = "SELECT name
          FROM tags
          WHERE tags.id = $1"
    values = [@tag_id]
    return ((SqlRunner.run(sql, values)).values)[0][0]
  end


  def update()
    sql = "UPDATE transactions
          SET(vendor, amount, tag_id, details) = ($1, $2, $3, $4)
          WHERE id = $5"
    values = [@vendor, ((100 * @amount.to_f).to_i), @tag_id, @details, @id]
    SqlRunner.run(sql, values)
  end


  def delete()
    sql = "DELETE FROM transactions
          WHERE id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end




  def self.all()
    sql = "SELECT * FROM transactions"
    results = SqlRunner.run( sql )
    return results.map { |x| Transaction.new(x) }
  end


  def self.total_amount()
    sql = "SELECT amount FROM transactions"
    results = (SqlRunner.run(sql)).map {|x| x.values}
    pence = results.flatten.inject(0) {|sum, x| sum + x.to_i}
    return '%.2f' % (pence.to_i/100.0)
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
