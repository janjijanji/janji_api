defmodule JanjiApiWeb.PromiseMakerPositionView do
  use JanjiApiWeb, :view
  alias JanjiApiWeb.PromiseMakerPositionView
  alias JanjiApiWeb.UserView

  def render("index.json", %{promise_maker_positions: promise_maker_positions}) do
    %{data: %{items: render_many(promise_maker_positions, PromiseMakerPositionView, "promise_maker_position.json")}}
  end

  def render("show.json", %{promise_maker_position: promise_maker_position}) do
    %{data: render_one(promise_maker_position, PromiseMakerPositionView, "promise_maker_position.json")}
  end

  def render("promise_maker_position.json", %{promise_maker_position: promise_maker_position}) do
    %{id: promise_maker_position.id,
      title: promise_maker_position.title,
      description: promise_maker_position.description,
      inserted_by: render_one(promise_maker_position.inserted_by, UserView, "user.json")}
  end
end
