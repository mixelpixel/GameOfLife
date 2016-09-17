=begin
FROM: https://gist.github.com/netmute/1761463
=end

# The code with some animation logic for demonstration.
#
# One-liner
# life=->g,s{(0..s*s-1).map{|i|->n{n==3||(g[i]&&n==2)||nil}[[g[i-s-1],g[i-s],g[i-s+1],g[i-1],g[i+1],g[i+s-1],g[i+s],g[i+s+1]].compact.count]}}

# Expanded version for better readability.
#
life = lambda do |grid, size|
  (0..size*size-1).map do |i|
    lambda do |neighbours|
      neighbours == 3 || ( grid[i] && neighbours == 2 )|| nil
    end.call (
      [
        grid[i-size-1], grid[i-size], grid[i-size+1],
        grid[i-1],                    grid[i+1],
        grid[i+size-1], grid[i+size], grid[i+size+1]
      ].compact.count
    )
  end
end

size = 20
grid = (1..size*size).map { rand(0..1)==1 ? 1 : nil }

while true do
  system 'clear'
  grid = life[grid, size]
  (0..size-1).each do |y|
    (0..size-1).each do |x|
      print "#{(grid[x+(y*size)] ? 'O' : '.')}"
    end
    puts
  end
  sleep 0.1
end