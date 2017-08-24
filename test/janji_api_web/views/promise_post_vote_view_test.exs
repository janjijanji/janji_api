defmodule JanjiApiWeb.PromisePostVoteViewTest do
  use JanjiApiWeb.ConnCase, async: true
  import Phoenix.View

  alias JanjiApiWeb.PromisePostVoteView
  alias JanjiApiWeb.PromiseView
  alias JanjiApiWeb.PromisePostView
  alias JanjiApiWeb.UserView

  alias JanjiApi.Promises.Promise
  alias JanjiApi.Promises.Post
  alias JanjiApi.Accounts.User

  test "promise_post_vote.json" do
    promise_post_vote = create_promise_post_vote()
    content = PromisePostVoteView.render("promise_post_vote.json", %{promise_post_vote: promise_post_vote})
    assert content == %{
      id: promise_post_vote.id,
      promise: PromiseView.render("promise_no_rel.json", %{promise: promise_post_vote.promise}),
      promise_post: PromisePostView.render("promise_post_no_rel.json", %{promise_post: promise_post_vote.promise_post}),
      inserted_by: UserView.render("user.json", %{user: promise_post_vote.inserted_by}),
    }
  end

  test "index.json" do
    promise_post_votes = [create_promise_post_vote(), create_promise_post_vote()]
      |> render_many(PromisePostVoteView, "promise_post_vote.json")
    content = PromisePostVoteView.render("index.json", %{promise_post_votes: promise_post_votes})
    assert content == %{
      data: %{
        items: promise_post_votes
      }
    }
  end

  test "show.json" do
    promise_post_vote = create_promise_post_vote()
      |> render_one(PromisePostVoteView, "promise_post_vote.json")
    content = PromisePostVoteView.render("show.json", %{promise_post_vote: promise_post_vote})
    assert content == %{
      data: promise_post_vote
    }
  end

  defp create_promise_post_vote do
    params_for(:promise_post_vote)
      |> Map.put(:id, 1)
      |> Map.put(:promise, %Promise{})
      |> Map.put(:promise_post, %Post{})
      |> Map.put(:inserted_by, %User{})
  end
end
