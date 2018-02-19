require('pry-byebug')
require_relative( '../db/sql_runner' )
require_relative( 'transaction' )

class MoneyConverter

  def self.convert_to_r(int)
    return '%.2f' % (int.to_i/100.0)
  end

  def self.convert_to_i(rat)
    return (100 * rat).to_i
  end

end
