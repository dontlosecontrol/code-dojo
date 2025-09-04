IO.stream(:stdio, :line)
|> Enum.map(&String.replace(&1, ~r/[#.]/, fn "#" -> "1"; "." -> "0" end))
|> Enum.map(&String.to_integer(String.trim(&1), 2))
|> Enum.each(&IO.puts/1)
