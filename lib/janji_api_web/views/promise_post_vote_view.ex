defmodule JanjiApiWeb.PromisePostVoteView do
  use JanjiApiWeb, :view
  alias JanjiApiWeb.PromisePostVoteView
  alias JanjiApiWeb.PromiseView
  alias JanjiApiWeb.PromisePostView
  alias JanjiApiWeb.UserView

  def render("index.json", %{promise_post_votes: promise_post_votes}) do
    %{data: %{items: render_many(promise_post_votes, PromisePostVoteView, "promise_post_vote.json")}}
  end

  def render("show.json", %{promise_post_vote: promise_post_vote}) do
    %{data: render_one(promise_post_vote, PromisePostVoteView, "promise_post_vote.json")}
  end

  def render("promise_post_vote.json", %{promise_post_vote: promise_post_vote}) do
    %{
      id: promise_post_vote.id,
      promise: render_one(promise_post_vote.promise, PromiseView, "promise_no_rel.json"),
      promise_post: render_one(promise_post_vote.promise_post, PromisePostView, "promise_post_no_rel.json"),
      inserted_by: render_one(promise_post_vote.inserted_by, UserView, "user.json"),
    }
  end

  def render("promise_post_vote_no_rel.json", %{promise_post_vote: promise_post_vote}) do
    %{
      id: promise_post_vote.id,
    }
  end
end
