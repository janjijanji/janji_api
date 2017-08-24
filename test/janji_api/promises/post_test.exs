defmodule JanjiApi.Promises.PostTest do
  use JanjiApi.DataCase

  alias JanjiApi.Promises.Post

  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Post.changeset(%Post{}, params_with_assocs(:promise_post))
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Post.changeset(%Post{}, @invalid_attrs)
    refute changeset.valid?
  end

  test "changeset title must be at least 3 chars long" do
    attrs = Map.put(params_for(:promise_post), :title, "AA")
    changeset = Post.changeset(%Post{}, attrs)
    assert {:title, {"should be at least %{count} character(s)", count: 3, validation: :length, min: 3}} in changeset.errors
  end
end
