defmodule JanjiApiWeb.PromiseNewsViewTest do
  use JanjiApiWeb.ConnCase, async: true
  import Phoenix.View

  alias JanjiApiWeb.PromiseNewsView
  alias JanjiApiWeb.PromiseView
  alias JanjiApiWeb.UserView

  alias JanjiApi.Promises.Promise
  alias JanjiApi.Accounts.User

  test "promise_news.json" do
    promise_news = create_promise_news()
    content = PromiseNewsView.render("promise_news.json", %{promise_news: promise_news})
    assert content == %{
      id: promise_news.id,
      promise: PromiseView.render("promise_no_rel.json", %{promise: promise_news.promise}),
      title: promise_news.title,
      published_at: promise_news.published_at,
      summary: promise_news.summary,
      body: promise_news.body,
      url: promise_news.url,
      inserted_by: UserView.render("user.json", %{user: promise_news.inserted_by}),
    }
  end

  test "index.json" do
    promise_news = [create_promise_news(), create_promise_news()]
      |> render_many(PromiseNewsView, "promise_news.json")
    content = PromiseNewsView.render("index.json", %{promise_news: promise_news})
    assert content == %{
      data: %{
        items: promise_news
      }
    }
  end

  test "show.json" do
    promise_news = create_promise_news()
      |> render_one(PromiseNewsView, "promise_news.json")
    content = PromiseNewsView.render("show.json", %{promise_news: promise_news})
    assert content == %{
      data: promise_news
    }
  end

  defp create_promise_news do
    params_for(:promise_news)
      |> Map.put(:id, 1)
      |> Map.put(:promise, %Promise{})
      |> Map.put(:inserted_by, %User{})
  end
end
