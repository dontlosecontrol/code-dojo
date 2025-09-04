defmodule Compressor do
  @moduledoc """
  Simple run-length encoding compression.
  If a character repeats more than twice in a row, replace it with <count><character>.
  """

  def compress_line(line) do
    line
    |> String.trim()
    |> String.graphemes()
    |> group_consecutive()
    |> Enum.map(&format_group/1)
    |> Enum.join()
  end

  defp group_consecutive(chars) do
    chars
    |> Enum.chunk_by(&(&1))
    |> Enum.map(fn group -> {hd(group), length(group)} end)
  end

  defp format_group({char, count}) when count > 1 do
    "#{count}#{char}"
  end

  defp format_group({char, count}) do
    String.duplicate(char, count)
  end

  def process_input() do
    IO.stream(:stdio, :line)
    |> Enum.each(fn line ->
      line
      |> compress_line()
      |> IO.puts()
    end)
  end
end

# Main execution
Compressor.process_input()
