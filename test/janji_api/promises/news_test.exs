defmodule JanjiApi.Promises.NewsTest do
  use JanjiApi.DataCase

  alias JanjiApi.Promises.News

  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = News.changeset(%News{}, params_with_assocs(:promise_news))
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = News.changeset(%News{}, @invalid_attrs)
    refute changeset.valid?
  end

  test "changeset title must be at least 3 chars long" do
    attrs = Map.put(params_for(:promise_news), :title, "AA")
    changeset = News.changeset(%News{}, attrs)
    assert {:title, {"should be at least %{count} character(s)", count: 3, validation: :length, min: 3}} in changeset.errors
  end
end
