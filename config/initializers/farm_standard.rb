class ActiveRecord::Base
  def self.symbols_and_strings(symbol_array)
    symbol_array.collect{ |sym| [sym, sym.to_s] }.flatten
  end
end
