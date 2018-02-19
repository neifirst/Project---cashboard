require_relative( '../db/sql_runner' )

class Tag

  attr_accessor(:name)
  attr_reader(:id)

  def initialize( options )
    @id = options['id'].to_i if options['id']
    @name = options['name']
  end


  def save()
    sql = "INSERT INTO tags(name)
          VALUES($1)
          RETURNING id"
    values = [@name]
    results = SqlRunner.run(sql, values)
    @id = results.first()['id'].to_i
  end

  def total_amount()
    sql = "SELECT amount
          FROM transactions
          WHERE transactions.tag_id = $1"
    values = [@id]
    results = (SqlRunner.run(sql, values)).map {|x| x.values}
    return results.flatten.inject(0) {|sum, x| sum + x.to_i}
  end

  def get_name()
    sql = "SELECT name
          FROM tags
          WHERE id = $1"
    values = [@id]
    return ((SqlRunner.run(sql, values)).values)[0]
  end

  def self.all()
    sql = "SELECT * FROM tags"
    results = SqlRunner.run( sql )
    return results.map { |hash| Tag.new( hash ) }
  end

  def self.delete_all
    sql = "DELETE FROM tags"
    SqlRunner.run( sql )
  end

end
