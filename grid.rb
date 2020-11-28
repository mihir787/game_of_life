# Rules:
# 1 (live) -> (< 2 live) -> 0
# 1 (live) -> (2 || 3 live) -> 1
# 1 (live) -> (> 3 live) -> 0
# 0 (dead) -> ( 3 live) -> 1

class Grid
  DEAD = 0
  ALIVE = 1

  def initialize(initial_state, rows = 5, columns = 5)
    @initial_state = initial_state
    @grid = initialize_grid(rows, columns)
    @rows = grid.length
    @columns = grid.first.length

    puts("Initial Grid: ")
    print_grid(grid)
  end

  def tick
    new_state = grid.map(&:clone)

    grid.each_with_index do |row, row_index|
      row.each_with_index do |_column, column_index|
        cell_status = grid[row_index][column_index]
        sum = sum_neighbors(row_index, column_index)

        if cell_status == ALIVE
          if sum < 2 || sum > 3
            new_state[row_index][column_index] = DEAD
          end
        elsif cell_status == DEAD && sum == 3
          new_state[row_index][column_index] = ALIVE
        end
      end
    end

    puts("\n\nRules Applied: ")
    @grid = new_state
    print_grid(grid)
    grid
  end

  private

  attr_accessor :grid
  attr_reader :rows, :columns, :initial_state

  def print_grid(g)
    g.each_with_index do |row, index|
      if index == 0
        print("#{row}")
      else
        print("\n#{row}")
      end
    end
  end

  def initialize_grid(rows, columns)
    return initial_state unless initial_state.nil?

    grid = []
    rows.times do
      grid << Array.new(columns) { [ DEAD, ALIVE ].sample() }
    end
    grid
  end

  def sum_neighbors(row_index, column_index)
    row_above = row_index - 1 >= 0 ? row_index - 1 : rows
    row_below = row_index + 1 < rows ? row_index + 1 : rows
    column_left = column_index - 1 >= 0 ? column_index - 1 : columns
    column_right = column_index + 1 < columns ? column_index + 1 : columns

    [
      grid.fetch(row_above, []).fetch(column_left, DEAD),
      grid.fetch(row_above, []).fetch(column_index, DEAD),
      grid.fetch(row_above, []).fetch(column_right, DEAD),
      grid.fetch(row_index, []).fetch(column_left, DEAD),
      grid.fetch(row_index, []).fetch(column_right, DEAD),
      grid.fetch(row_below, []).fetch(column_left, DEAD),
      grid.fetch(row_below, []).fetch(column_index, DEAD),
      grid.fetch(row_below, []).fetch(column_right, DEAD),
    ].reduce(:+)
  end
end

puts "Generation: 0"
grid = Grid.new(nil)
5.times do |n|
  if n != 0
    puts "\n\nGeneration: #{n}"
  end
  grid.tick
end

