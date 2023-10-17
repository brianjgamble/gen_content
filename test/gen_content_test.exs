defmodule GenContentTest do
  use ExUnit.Case
  doctest GenContent

  alias GenContent.FakeStore

  describe "child_spec/1" do
    test "creates a child specification map" do
      map = GenContent.child_spec({:blog, FakeStore})

      assert is_map(map)
      assert map.id == :id_blog
      assert map.start == {GenContent, :start_link, [{:blog, FakeStore}]}
    end

    test "name must be an atom" do
      assert_raise ArgumentError, "name must be an atom", fn ->
        GenContent.child_spec({"blog", FakeStore})
      end
    end
  end

  describe "start_link/1" do
    test "accepts a name and store on start" do
      args = {:foo, FakeStore}
      assert {:ok, _pid} = GenContent.start_link(args)
    end

    test "store can be nil" do
      args = {:foo, nil}
      assert {:ok, _pid} = GenContent.start_link(args)
    end
  end
end
