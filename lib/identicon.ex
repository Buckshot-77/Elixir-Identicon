defmodule Identicon do
  @moduledoc """
  Documentation for `Identicon`.
  """

  def main(input) do
    input
    |> hash_input()
    |> pick_colour()
    |> generate_grid()
  end

  def pick_colour(%Identicon.Image{hex: [red, green, blue | _tail]} = image) do
    %Identicon.Image{image | colour: {red, green, blue}}
  end

  def generate_grid(%Identicon.Image{hex: hex} = image) do
    grid =
      hex
      |> Enum.chunk_every(3, 3, :discard)
      |> Enum.map(&mirror_row/1)
    %Identicon.Image{image | grid: grid}
  end

  def mirror_row([first, second, third]) do
    [first, second, third, second, first]
  end
  def hash_input(input) do
    hex =
      :crypto.hash(:md5, input)
      |> :binary.bin_to_list()

    %Identicon.Image{hex: hex}
  end
end
