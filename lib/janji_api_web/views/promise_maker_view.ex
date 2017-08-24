defmodule JanjiApiWeb.PromiseMakerView do
  use JanjiApiWeb, :view
  alias JanjiApiWeb.PromiseMakerView
  alias JanjiApiWeb.UserView

  def render("index.json", %{promise_makers: promise_makers}) do
    %{data: %{items: render_many(promise_makers, PromiseMakerView, "promise_maker.json")}}
  end

  def render("show.json", %{promise_maker: promise_maker}) do
    %{data: render_one(promise_maker, PromiseMakerView, "promise_maker.json")}
  end

  def render("promise_maker.json", %{promise_maker: promise_maker}) do
    %{id: promise_maker.id,
      full_name: promise_maker.full_name,
      gender: promise_maker.gender,
      birthplace: promise_maker.birthplace,
      birthdate: promise_maker.birthdate,
      bio: promise_maker.bio,
      inserted_by: render_one(promise_maker.inserted_by, UserView, "user.json")}
  end

  def render("promise_maker_no_rel.json", %{promise_maker: promise_maker}) do
    %{id: promise_maker.id,
      full_name: promise_maker.full_name,
      gender: promise_maker.gender,
      birthplace: promise_maker.birthplace,
      birthdate: promise_maker.birthdate,
      bio: promise_maker.bio}
  end
end
