defmodule ParenthesesChecker do
  def is_balanced(line) do
    line
    |> to_charlist() # for comfortable pattern_matching
    |> check_balance(0)
  end

  defp check_balance([], count), do: count == 0

  defp check_balance([?( | rest], count) do
    check_balance(rest, count + 1)
  end

  defp check_balance([?) | rest], count) when count > 0 do
    check_balance(rest, count - 1)
  end

  defp check_balance([?) | _rest], 0), do: false

  defp check_balance([_char | rest], count) do
    check_balance(rest, count)
  end

  def main do
    IO.stream(:stdio, :line)
    |> Stream.map(&String.trim/1)
    |> Stream.reject(&(&1 == ""))
    |> Stream.map(fn line ->
      if is_balanced(line), do: "yes", else: "no"
    end)
    |> Enum.each(&IO.puts/1)
  end
end

ParenthesesChecker.main()
