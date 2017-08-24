defmodule JanjiApi.Promises.PromiseTest do
  use JanjiApi.DataCase

  alias JanjiApi.Promises.Promise

  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Promise.changeset(%Promise{}, params_with_assocs(:promise))
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Promise.changeset(%Promise{}, @invalid_attrs)
    refute changeset.valid?
  end

  test "changeset title must be at least 3 chars long" do
    attrs = Map.put(params_for(:promise), :title, "AA")
    changeset = Promise.changeset(%Promise{}, attrs)
    assert {:title, {"should be at least %{count} character(s)", count: 3, validation: :length, min: 3}} in changeset.errors
  end
end
