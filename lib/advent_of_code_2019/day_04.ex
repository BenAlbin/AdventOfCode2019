defmodule AdventOfCode2019.Day04 do
  def part1(input) do
    input
    |> String.split("-")
    |> Enum.map(&String.to_integer/1)
    |> (&apply(Range, :new, &1)).()
    |> Enum.count(
      fn number ->
        digits = Integer.digits(number)
        increasing?(digits, []) && has_pair?(digits)
      end
    )
  end

  def part2(input) do
    input
    |> String.split("-")
    |> Enum.map(&String.to_integer/1)
    |> (&apply(Range, :new, &1)).()
    |> Enum.count(
      fn number ->
        digits = Integer.digits(number)
        increasing?(digits, []) && has_pair_not_in_larger_group?(digits)
      end
    )
  end

  defp increasing?([], _), do: true
  defp increasing?([next_char | rest], []), do: increasing?(rest, [next_char])
  defp increasing?([next_char | rest], [previous_char | _ ] = previous) when next_char >= previous_char, do: increasing?(rest, [next_char | previous])
  defp increasing?(_, _), do: false

  defp has_pair?(digits) do
    digits
    |> Enum.chunk_by(& &1)
    |> Enum.any?(& length(&1) >= 2)
  end

  defp has_pair_not_in_larger_group?(digits) do
    digits
    |> Enum.chunk_by(& &1)
    |> Enum.any?(& length(&1) === 2)
  end
end
