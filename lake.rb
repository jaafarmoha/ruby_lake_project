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
  if y < 0 || y >= lake.length || x < 0 || x >= lake[0].length 
    then return false
  else
     true
  end
end


def flow(lake, dx, dy, wind)
  (0...lake.length).each do |y|
    (0...lake.length).each do |x|
      if coordValid(lake, x + dx, y + dy) then
        if lake[y][x] > 0 && lake[y+dy] [x+dx] >= 0 then
          heightDiff = (lake[y][x] - lake[y + dy][x + dx]) + wind
          if heightDiff > 0 then 
            flow = 1 + heightDiff/4
            lake[y][x] -= flow
            lake[y + dy][x + dx] += flow
          end
        end
      end
    end
  end
end



def waveOverBlocks(lake, x, y, dx, dy)
  tallestBlock = 0
  if lake[y][x] > 0 then
    (0...lake.length).each do |s|
      newX = x + s * dx 
      newY = y + s * dy
      nextCell = lake[newY][newX]
      if !coordValid(lake, newX, newY) then
        break
      end
        if nextCell < 0 then
          tallestBlock = [tallestBlock, nextCell.abs].max
        elsif nextCell >= 0 && lake[y][x] - nextCell > 0 then
          heightDiff = (lake[y][x] - tallestBlock)
          if heightDiff > 0 then
            flow = heightDiff/4
            if flow > 0 then
              lake[y][x] -= flow
              lake[newY][newX] += flow
            end
          end 
        end
     end
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
  return 0 unless coordValid(lake, x, y) && lake[y][x] < 0
    forward_x = x + dx
    forward_y = y + dy
    backward_x = x - dx
    backward_y = y - dy
    unless coordValid(lake, forward_x, forward_y) && coordValid(lake, backward_x, backward_y)
      return 0
    end

      forward_cell = lake[forward_y][forward_x]
      backward_cell = lake[backward_y][backward_x]

      if forward_cell > 0 && backward_cell > 0
        return (forward_cell - backward_cell).abs
      end
  end
  return 0
end


def crush(lake, strength)
  (0...lake.length).each do |y|
    (0...lake.length).each do |x|
      if lake[y][x] < 0
        height = lake[y][x].abs
      end
      max_pressure = 0
      most_stressed = nil
       
      lr_gradient = gradient(lake, x, y, 1, 0) 
        up_gradient = gradient(lake, x, y, 0, 1) 

        pressure = [lr_gradient, up_gradient].max
        if pressure > strength * height && pressure > max_pressure
          max_pressure = pressure
          most_stressed = [x, y]
        end
      end
    end
  end
  if most_stressed
    x, y = most_stressed
    lake[y][x] = 0
  end
 return most_stressed



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

 # lake = LAKE2
 # 0.upto(5) do
	#runSimulation(lake,1,0,8)
  #display_lake(lake)
  #end

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

