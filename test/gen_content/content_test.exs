defmodule GenContent.ContentTest do
  use ExUnit.Case, async: true

  alias GenContent.Content

  describe "new/0" do
    test "creates an empty struct" do
      struct = Content.new()

      assert %Content{} = struct
      assert struct.slug == ""
      assert struct.title == ""
      assert is_nil(struct.date)
      assert struct.text == ""
      assert Enum.empty?(struct.tags)
    end
  end

  describe "new/1" do
    setup do
      data = %{
        title: " A Test Title ",
        date: "2023-05-29",
        text: "Hello world!",
        tags: ["foo", "bar"]
      }

      %{data: data}
    end

    test "transforms and populates a map to the given struct", %{data: data} do
      struct = Content.new(data)

      assert struct.slug == "a-test-title"
      assert struct.title == "A Test Title"
      assert struct.date == ~D[2023-05-29]
      assert struct.text == "Hello world!"
      assert struct.tags == ["foo", "bar"]
    end

    test "slugified title removes special characters", %{data: data} do
      struct = Content.new(%{data | title: "Hello - world!"})
      assert struct.slug == "hello-world"

      struct = Content.new(%{data | title: "Répétez!"})
      assert struct.slug == "repetez"

      struct = Content.new(%{data | title: "L’accent Aigu"})
      assert struct.slug == "laccent-aigu"

      struct = Content.new(%{data | title: "Mr. Smith"})
      assert struct.slug == "mr-smith"
    end

    test "tags should be a list of strings", %{data: data} do
      assert_raise ArgumentError, fn ->
        Content.new(%{data | tags: [:foo, "bar"]})
      end
    end
  end
end
