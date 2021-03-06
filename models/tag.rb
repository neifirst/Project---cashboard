require_relative( '../db/sql_runner' )

class Tag

  attr_accessor(:name, :budget)
  attr_reader(:id)

  def initialize( options )
    @id = options['id'].to_i if options['id']
    @name = options['name']
    @budget = options['budget']
  end


  def save()
    sql = "INSERT INTO tags(name, budget)
          VALUES($1, $2)
          RETURNING id"
    values = [@name, ((100 * @budget.to_r).to_i)]
    results = SqlRunner.run(sql, values)
    @id = results.first()['id'].to_i
  end

  def total_amount()
    sql = "SELECT amount
          FROM transactions
          WHERE transactions.tag_id = $1"
    values = [@id]
    results = (SqlRunner.run(sql, values)).map {|x| x.values}
    pence = results.flatten.inject(0) {|sum, x| sum + x.to_i}
    return '%.2f' % (pence.to_i/100.0)
  end

  def update()
    sql = "UPDATE tags
          SET(name, budget) = ($1, $2)
          WHERE id = $3"
    values = [@name, ((100 * @budget.to_f).to_i), @id]
    SqlRunner.run(sql, values)
  end

  def get_name()
    sql = "SELECT name
          FROM tags
          WHERE id = $1"
    values = [@id]
    return ((SqlRunner.run(sql, values)).values)[0]
  end

  def get_budget()
    sql = "SELECT budget
          FROM tags
          WHERE id = $1"
    values = [@id]
    return ((SqlRunner.run(sql, values)).values)[0]
  end

  def get_transactions()
    sql = "SELECT *
          FROM transactions
          WHERE tag_id = $1"
    values = [@id]
    transactions = SqlRunner.run(sql, values)
    return transactions.map{|transaction| Transaction.new(transaction)}
  end

  def self.find( id )
    sql = "SELECT * FROM tags
    WHERE id = $1"
    values = [id]
    results = SqlRunner.run( sql, values )
    return Tag.new( results.first )
  end

  def self.all()
    sql = "SELECT * FROM tags"
    results = SqlRunner.run( sql )
    return results.map { |hash| Tag.new( hash ) }
  end

  def self.total_budget()
    sql = "SELECT budget
          FROM tags"
    results = (SqlRunner.run(sql)).map {|x| x.values}
    pence = results.flatten.inject(0) {|sum, x| sum + x.to_i}
    return '%.2f' % (pence.to_i/100.0)
  end

  def self.delete_all
    sql = "DELETE FROM tags"
    SqlRunner.run( sql )
  end


end
