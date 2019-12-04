defmodule AdventOfCode2019.Day04Test do
  use ExUnit.Case

  import AdventOfCode2019.Day04

  test "part1" do
    input = "111111-111111"
    result = part1(input)

    assert result === 1

    input = "223450-223450"
    result = part1(input)

    assert result === 0

    input = "123789-123789"
    result = part1(input)

    assert result === 0
  end

  test "part2" do
    input = "111111-111111"
    result = part2(input)

    assert result === 0
  end
end
