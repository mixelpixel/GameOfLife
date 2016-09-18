# basic file

class World
  attr_accessor :rows, :cols        # These methods are now accessible to rspec
  def initialize(rows=3, cols=3)    # default argument "=values"
    @rows      = rows
    @cols      = cols
  end                               # These methods are now initialized

end


