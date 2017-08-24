defmodule JanjiApiWeb.PromiseMakerTermView do
  use JanjiApiWeb, :view

  alias JanjiApiWeb.PromiseMakerView
  alias JanjiApiWeb.PromiseMakerPositionView
  alias JanjiApiWeb.PromiseMakerTermView
  alias JanjiApiWeb.UserView

  def render("index.json", %{promise_maker_terms: promise_maker_terms}) do
    %{data: %{
      items: render_many(promise_maker_terms, PromiseMakerTermView, "promise_maker_term.json")
    }}
  end

  def render("show.json", %{promise_maker_term: promise_maker_term}) do
    %{data: render_one(promise_maker_term, PromiseMakerTermView, "promise_maker_term.json")}
  end

  def render("promise_maker_term.json", %{promise_maker_term: promise_maker_term}) do
    %{id: promise_maker_term.id,
      promise_maker_position: render_one(promise_maker_term.promise_maker_position,
        PromiseMakerPositionView, "promise_maker_position_no_rel.json"),
      promise_maker: render_one(promise_maker_term.promise_maker,
        PromiseMakerView, "promise_maker_no_rel.json"),
      from_time: promise_maker_term.from_time,
      thru_time: promise_maker_term.thru_time,
      inserted_by: render_one(promise_maker_term.inserted_by, UserView, "user.json")}
  end
end
