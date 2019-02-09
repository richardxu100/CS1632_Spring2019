# There are three methods and the "main" execution at the bottom to do.
# I have marked the locations to fill in with TODO tags.
# I recommend tackling these in order - I have numbered them in the
# order I recommend working on them.
# Remember you can use irb to test out your methods and try out syntax!

# Print the array to the screen, with x representing a living
# cell and . representing a dead cell.
# Finish the printing with a single line of asterisks, exactly
# as long as the array is wide.
# There is no need to return anything
# Example:
# ...........
# ...........
# ...........
# ...........
# ...........
# ...........
# .........x.
# ........x.x
# .......x..x
# ........xx.
# ...........
# ***********

def print_arr(arr)
  arr.each do |line|
    line.each do |cell|
      cell ? (print 'X') : (print '.')
    end
    puts
  end
  puts '*' * arr.length
end

# Should return the # of living neighbors of cell in location x, y
# in array arr (i.e., this will return a value between 0 - no living
# neighbors and 8 - every cell around this cell is living)

def get_num_neighbors(x_coord, y_coord, arr)
  neighbor_coords = get_neighbors_coords(x_coord, y_coord, arr)
  num_living_neighbors = 0
  neighbor_coords.each do |coord|
    x, y = coord
    num_living_neighbors += 1 if arr[x][y]
  end
  num_living_neighbors
end

def get_neighbors_coords(x_coord, y_coord, arr)
  [
    [(x_coord + 1) % arr.length, y_coord],
    [(x_coord + 1) % arr.length, (y_coord + 1) % arr.length],
    [(x_coord + 1) % arr.length, (y_coord - 1) % arr.length],
    [(x_coord - 1) % arr.length, y_coord],
    [(x_coord - 1) % arr.length, (y_coord + 1) % arr.length],
    [(x_coord - 1) % arr.length, (y_coord - 1) % arr.length],
    [x_coord, (y_coord + 1) % arr.length],
    [x_coord, (y_coord - 1) % arr.length]
  ]
end

# Should perform one iteration of Conway's game of life, as
# described in exercise1.md
def generate_new_cell(x_coord, y_coord, arr, cell)
  num_neighbors = get_num_neighbors(x_coord, y_coord, arr)
  if !cell && num_neighbors == 3
    true
  elsif cell && [2, 3].include?(num_neighbors)
    true
  else
    false
  end
end

def iterate(arr)
  new_arr = arr.map.with_index do |line, x|
    line.map.with_index do |cell, y|
      generate_new_cell(x, y, arr, cell)
    end
  end
  new_arr
end

# Given a pseudorandom number generator, a size, and a percentage
# of cells to be alive, make a size x size array (e.g., a 10 x 10 array
# if size = 10), and randomly assign percent % of them to be living.
# Return the newly created array to the caller.

def create_arr(prng, size, percent)
  arr = []
  (0...size).each do |x|
    arr[x] = []
    (0...size).each do |y|
      arr[x][y] = prng.rand(101) <= percent
    end
  end
  arr
end


# EXECUTION STARTS HERE

# TODO 4

raise 'Enter integers for size, percentage (1..100), and number of iterations at command line' unless ARGV.count == 3
size, percent, iters = ARGV[0].to_i, ARGV[1].to_i, ARGV[2].to_i


# All of these can be done in one line.
# If size is not >0, inform the user and exit
# If percent is not an integer between 0 and 100, inform the user and exit
# If number of iterations is not an integer that is 0 or greater, inform the user and exit
if size <= 0
  puts 'size must be greater than 0'
  exit
elsif percent < 0 || percent > 100
  puts 'percent must be between 0 and 100'
  exit
elsif iters < 0
  puts 'number of iterations must be greater than or equal to 0!'
  exit
end

# Create a pseudo-random number generator to pass in to the create_array method
prng = Random.new

# Create the array and assign it a new array from the create_array method
arr = create_arr(prng, size, percent)

# Iterate for _iters_ iterations
while iters >= 0
  print_arr(arr)
  arr = iterate(arr)
  iters -= 1
end
