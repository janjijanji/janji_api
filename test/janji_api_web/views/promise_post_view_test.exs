defmodule JanjiApiWeb.PromisePostViewTest do
  use JanjiApiWeb.ConnCase, async: true
  import Phoenix.View

  alias JanjiApiWeb.PromisePostView
  alias JanjiApiWeb.PromiseView
  alias JanjiApiWeb.PromiseMakerTermView
  alias JanjiApiWeb.UserView

  alias JanjiApi.Promises.Promise
  alias JanjiApi.PromiseMakers.Term
  alias JanjiApi.Accounts.User

  test "promise_post.json" do
    promise_post = create_promise_post()
    content = PromisePostView.render("promise_post.json", %{promise_post: promise_post})
    assert content == %{
      id: promise_post.id,
      promise: PromiseView.render("promise_no_rel.json", %{promise: promise_post.promise}),
      promise_maker_term: PromiseMakerTermView.render("promise_maker_term_no_rel.json", %{promise_maker_term: promise_post.promise_maker_term}),
      title: promise_post.title,
      body: promise_post.body,
      inserted_by: UserView.render("user.json", %{user: promise_post.inserted_by}),
    }
  end

  test "index.json" do
    promise_posts = [create_promise_post(), create_promise_post()]
      |> render_many(PromisePostView, "promise_post.json")
    content = PromisePostView.render("index.json", %{promise_posts: promise_posts})
    assert content == %{
      data: %{
        items: promise_posts
      }
    }
  end

  test "show.json" do
    promise_post = create_promise_post()
      |> render_one(PromisePostView, "promise_post.json")
    content = PromisePostView.render("show.json", %{promise_post: promise_post})
    assert content == %{
      data: promise_post
    }
  end

  defp create_promise_post do
    params_for(:promise_post)
      |> Map.put(:id, 1)
      |> Map.put(:promise, %Promise{})
      |> Map.put(:promise_maker_term, %Term{})
      |> Map.put(:inserted_by, %User{})
  end
end
