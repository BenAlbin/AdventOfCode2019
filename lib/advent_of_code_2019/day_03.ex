defmodule AdventOfCode2019.Day03 do
  def part1(input) do
    {wire_1_path, wire_2_path} = parse_input(input)
    [{0, 0} | wire_1_coords] = get_travelled_coords(wire_1_path)
    [{0, 0} | wire_2_coords] = get_travelled_coords(wire_2_path)
    get_crossed_points(wire_1_coords, wire_2_coords)
    |> Enum.map(&manhattan_distance/1)
    |> Enum.min()
  end

  def part2(input) do
    {wire_1_path, wire_2_path} = parse_input(input)
    [{0, 0} | wire_1_coords] = get_travelled_coords(wire_1_path)
    [{0, 0} | wire_2_coords] = get_travelled_coords(wire_2_path)
    get_crossed_points(wire_1_coords, wire_2_coords)
    |> Enum.map(fn coord ->
        step_distance( coord, wire_1_coords) + step_distance(coord, wire_2_coords)
    end)
    |> Enum.min()
  end

  defp manhattan_distance({x,y}) do
    abs(x) + abs(y)
  end

  defp step_distance(coord, list_of_coords) do
    Enum.find_index(list_of_coords, fn v -> v == coord end) + 1
  end

  defp parse_input(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.map(&String.split(&1, ",", trim: true))
    |> List.to_tuple()
  end

  defp get_travelled_coords(path) do
    Enum.reduce(path, [{0, 0}], fn command, [current_position | _] = acc ->
      travelled_positions = move(command, current_position)
      travelled_positions ++ acc
    end)
    |> Enum.reverse
  end

  defp move(<< letter :: binary-size(1), amount_as_string :: binary() >>, {x,y}) do
    amount = String.to_integer(amount_as_string)
    1..amount
    |> Enum.map(fn offset ->
      case letter do
        "R" -> { x + offset, y }
        "L" -> { x - offset, y }
        "U" -> { x, y + offset }
        "D" -> { x, y - offset }
      end
    end)
    |> Enum.reverse
  end

  defp get_crossed_points(coords_1, coords_2) do
    both_coords = Enum.uniq(coords_1) ++ Enum.uniq(coords_2)
    both_coords -- Enum.uniq(both_coords)
  end
end
