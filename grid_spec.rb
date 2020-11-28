require 'rspec'
require_relative 'grid'

describe Grid do
  it 'should tick' do
    initial_state = [
      [0, 1, 0, 0],
      [0, 0, 1, 0],
      [1, 1, 1, 0],
      [0, 0, 0, 0],
    ]

    grid = Grid.new(initial_state)

    generation_1 = [
      [0, 0, 0, 0],
      [1, 0, 1, 0],
      [0, 1, 1, 0],
      [0, 1, 0, 0],
    ]
    generation_2 = [
      [0, 0, 0, 0],
      [0, 0, 1, 0],
      [1, 0, 1, 0],
      [0, 1, 1, 0],
    ]
    generation_3 = [
      [0, 0, 0, 0],
      [0, 1, 0, 0],
      [0, 0, 1, 1],
      [0, 1, 1, 0],
    ]

    expect(grid.tick).to eq(generation_1)
    expect(grid.tick).to eq(generation_2)
    expect(grid.tick).to eq(generation_3)
  end
end
