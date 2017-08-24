defmodule JanjiApi.PromiseMakers.TermTest do
  use JanjiApi.DataCase

  alias JanjiApi.PromiseMakers.Term

  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Term.changeset(%Term{}, params_for(:promise_maker_term))
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Term.changeset(%Term{}, @invalid_attrs)
    refute changeset.valid?
  end
end
