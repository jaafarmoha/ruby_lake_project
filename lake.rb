# Positive values: height of water, negatives: height of blocks.
LAKE1 = [
  [-5, -1, -1, 99],
  [0, 0, 0, 0],
  [0, -8, -5, -5],
  [0, 0, 0, 0]
]

LAKE2 = [
  [30, 0, -14, -8, 0],
  [30, 0, -14, -8, 0],
  [30, 0, -14, -8, 0],
  [30, 0, -20, 0, 0],
  [30, 0, -14, -8, 0]
]

LAKE3 = [
  [20, 0, -20, -8, 0],
  [20, 0, -20, -8, 0],
  [20, 0, -20, -8, 0],
  [20, 0, -2, 0, 0],
  [20, 0, -20, -8, 0]
]

# Display a lake using the puts function to output results.
def display_lake(lake)
  return if lake.empty?

  width = lake[0].length
  puts '-' * (width * 4 + 2)
  0.upto(lake.length - 1) do |y|
    row_printable = []
    (0..width - 1).each do |x|
      cell = lake[y][x]
      # formats string so as to align column values
      row_printable << format(' %<cell>.2i ', cell: cell) unless cell.negative?
      row_printable << format('[%<cell>.2i]', cell: -cell) if cell.negative?
    end
    puts "|#{row_printable.join('')}|"
  end
  puts '-' * (width * 4 + 2)
end

def coordValid(lake, x, y)
 end


def flow(lake, dx, dy, wind)
 end


def waveOverBlocks(lake, x, y, dx, dy)
 end


def waveSim(lake)
  return if lake.empty?

  sizeY = lake.length
  sizeX = lake[0].length

  0.upto(sizeY - 1) do |y|
    0.upto(sizeX - 1) do |x|
      waveOverBlocks(lake, x, y, 0, -1)
      waveOverBlocks(lake, x, y, -1, 0)
      waveOverBlocks(lake, x, y, 0, 1)
      waveOverBlocks(lake, x, y, 1, 0)
    end
  end
end

def gradient(lake, x, y, dx, dy)
  0
end

def crush(lake, strength)
end

def runSimulation(lake, steps, wind, strength)
  0.upto(steps - 1) do
    flow(lake, 0, -1, 0)
    flow(lake, -1, 0, 0)
    flow(lake, 0, 1, 0)
    flow(lake, 1, 0, wind) # wind is in the direction left-to-right horizontally
    waveSim(lake)
    crush(lake, strength)
  end
end

if __FILE__ == $PROGRAM_NAME
  #	lake = LAKE1
  #	0.upto(5) do
  #		runSimulation(lake,18,2,3)
  #		display_lake(lake)
  #	end

  lake = LAKE2
  0.upto(5) do
	runSimulation(lake,1,0,8)
  display_lake(lake)
  end

  # lake = LAKE2
  #	0.upto(5) do
  #		runSimulation(lake,1,4,8)
  #		display_lake(lake)
  #	end

  #	lake = LAKE3
  #	0.upto(5) do
  #		runSimulation(lake,1,4,2)
  #		display_lake(lake)
  #	end
end
