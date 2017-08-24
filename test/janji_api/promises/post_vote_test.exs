defmodule JanjiApi.Promises.PostVoteTest do
  use JanjiApi.DataCase

  alias JanjiApi.Promises
  alias JanjiApi.Promises.PostVote

  @invalid_attrs %{promise_post_id: nil, inserted_by_id: nil}

  test "changeset with valid attributes" do
    changeset = PostVote.changeset(%PostVote{}, params_with_assocs(:promise_post_vote))
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = PostVote.changeset(%PostVote{}, @invalid_attrs)
    refute changeset.valid?
  end

  test "changeset with valid attributes populate promise" do
    attrs = params_with_assocs(:promise_post_vote)
    changeset = PostVote.changeset(%PostVote{}, attrs)
    %{promise_id: promise_id, promise_post_id: promise_post_id} = changeset.changes

    assert changeset.valid?
    assert promise_id == Promises.get_post!(promise_post_id).promise_id
  end
end
