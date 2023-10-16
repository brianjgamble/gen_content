defmodule GenContentTest do
  use ExUnit.Case
  doctest GenContent

  alias GenContent.FakeStore

  describe "child_specification/3" do
    test "creates a child specification map for a supervisor" do
      map = GenContent.child_specification(:test_id, :blog, FakeStore)

      assert map.id == :test_id
      assert map.start == {GenContent, :start_link, [{:blog, FakeStore}]}
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

    test "name must be an atom" do
      args = {"foo", FakeStore}

      assert_raise ArgumentError, "name must be an atom", fn ->
        assert {:ok, _pid} = GenContent.start_link(args)
      end
    end
  end
end
