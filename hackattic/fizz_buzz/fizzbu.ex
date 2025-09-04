defmodule FizzBuzz do
  @moduledoc """
  Simple implementation of FizzBuzz
  """

  def main() do
    process_input()
    |> gen_fizzbuzz
    |> IO.puts()
  end

  def gen_fizzbuzz([from, to]) do
    from..to
    |> Enum.map(&fizzbuzz/1)
    |> Enum.join(" ")
  end

  defp fizzbuzz(n) when rem(n, 15) == 0, do: "FizzBuzz"
  defp fizzbuzz(n) when rem(n, 3) == 0, do: "Fizz"
  defp fizzbuzz(n) when rem(n, 5) == 0, do: "Buzz"
  defp fizzbuzz(n), do: to_string(n)

  def process_input() do
    IO.read(:stdio, :line)
    |> String.trim
    |> String.split(" ")
    |> Enum.map(&String.to_integer/1)
  end

end

FizzBuzz.main()
