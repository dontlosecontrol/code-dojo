defmodule SumParser do
  def parse_token(token) do
    token = String.trim(token)

    cond do
      token == "" ->
        0

      String.starts_with?(token, "0x") or String.starts_with?(token, "0X") ->
        hex_digits = String.slice(token, 2..-1//1)
        String.to_integer(hex_digits, 16)

      String.starts_with?(token, "0o") or String.starts_with?(token, "0O") ->
        oct_digits = String.slice(token, 2..-1//1)
        String.to_integer(oct_digits, 8)

      String.starts_with?(token, "0b") or String.starts_with?(token, "0B") ->
        bin_digits = String.slice(token, 2..-1//1)
        String.to_integer(bin_digits, 2)

      Regex.match?(~r/^-?\d+$/, token) ->
        String.to_integer(token)

      String.length(token) == 1 ->
        :binary.first(token)

      true ->
        case Integer.parse(token) do
          {num, ""} -> num
          _ -> token |> to_charlist() |> Enum.sum()
        end
    end
  end

  def process_line(line) do
    line
    |> String.trim()
    |> String.split()
    |> Enum.map(&parse_token/1)
    |> Enum.sum()
  end

  def main do
    IO.stream(:stdio, :line)
    |> Stream.map(&String.trim/1)
    |> Stream.reject(&(&1 == ""))
    |> Stream.map(&process_line/1)
    |> Enum.each(&IO.puts/1)
  end
end

SumParser.main()
