defmodule JanjiApiWeb.PromiseView do
  use JanjiApiWeb, :view
  alias JanjiApiWeb.PromiseMakerView
  alias JanjiApiWeb.PromiseView
  alias JanjiApiWeb.UserView

  def render("index.json", %{promises: promises}) do
    %{data: %{items: render_many(promises, PromiseView, "promise.json")}}
  end

  def render("show.json", %{promise: promise}) do
    %{data: render_one(promise, PromiseView, "promise.json")}
  end

  def render("promise.json", %{promise: promise}) do
    %{
      id: promise.id,
      promise_maker: render_one(promise.promise_maker, PromiseMakerView, "promise_maker_no_rel.json"),
      title: promise.title,
      promised_at: promise.promised_at,
      description: promise.description,
      url: promise.url,
      inserted_by: render_one(promise.inserted_by, UserView, "user.json"),
    }
  end

  def render("promise_no_rel.json", %{promise: promise}) do
    %{
      id: promise.id,
      title: promise.title,
      promised_at: promise.promised_at,
      description: promise.description,
      url: promise.url,
    }
  end
end
