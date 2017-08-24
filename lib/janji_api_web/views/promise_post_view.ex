defmodule JanjiApiWeb.PromisePostView do
  use JanjiApiWeb, :view
  alias JanjiApiWeb.PromisePostView
  alias JanjiApiWeb.PromiseView
  alias JanjiApiWeb.PromiseMakerTermView
  alias JanjiApiWeb.UserView

  def render("index.json", %{promise_posts: promise_posts}) do
    %{data: %{items: render_many(promise_posts, PromisePostView, "promise_post.json")}}
  end

  def render("show.json", %{promise_post: promise_post}) do
    %{data: render_one(promise_post, PromisePostView, "promise_post.json")}
  end

  def render("promise_post.json", %{promise_post: promise_post}) do
    %{
      id: promise_post.id,
      promise: render_one(promise_post.promise, PromiseView, "promise_no_rel.json"),
      promise_maker_term: render_one(promise_post.promise_maker_term, PromiseMakerTermView, "promise_maker_term_no_rel.json"),
      title: promise_post.title,
      body: promise_post.body,
      inserted_by: render_one(promise_post.inserted_by, UserView, "user.json"),
    }
  end

  def render("promise_post_no_rel.json", %{promise_post: promise_post}) do
    %{
      id: promise_post.id,
      title: promise_post.title,
      body: promise_post.body,
    }
  end
end
