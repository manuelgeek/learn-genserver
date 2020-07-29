defmodule LearnGenserverTest do
  use ExUnit.Case
  doctest LearnGenserver

  test "greets the world" do
    assert LearnGenserver.hello() == :world
  end
end
