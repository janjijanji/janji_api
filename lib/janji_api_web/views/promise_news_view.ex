defmodule JanjiApiWeb.PromiseNewsView do
  use JanjiApiWeb, :view
  alias JanjiApiWeb.PromiseNewsView
  alias JanjiApiWeb.PromiseView
  alias JanjiApiWeb.UserView

  def render("index.json", %{promise_news: promise_news}) do
    %{data: %{items: render_many(promise_news, PromiseNewsView, "promise_news.json")}}
  end

  def render("show.json", %{promise_news: promise_news}) do
    %{data: render_one(promise_news, PromiseNewsView, "promise_news.json")}
  end

  def render("promise_news.json", %{promise_news: promise_news}) do
    %{
      id: promise_news.id,
      promise: render_one(promise_news.promise, PromiseView, "promise_no_rel.json"),
      title: promise_news.title,
      published_at: promise_news.published_at,
      summary: promise_news.summary,
      body: promise_news.body,
      url: promise_news.url,
      inserted_by: render_one(promise_news.inserted_by, UserView, "user.json"),
    }
  end

  def render("promise_news_no_rel.json", %{promise_news: promise_news}) do
    %{
      id: promise_news.id,
      title: promise_news.title,
      published_at: promise_news.published_at,
      summary: promise_news.summary,
      body: promise_news.body,
      url: promise_news.url,
    }
  end
end
