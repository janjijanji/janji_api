defmodule JanjiApiWeb.UserView do
  use JanjiApiWeb, :view
  alias JanjiApiWeb.UserView

  def render("index.json", %{users: users}) do
    %{data: %{items: render_many(users, UserView, "user.json")}}
  end

  def render("show.json", %{user: user}) do
    %{data: render_one(user, UserView, "user.json")}
  end

  def render("user.json", %{user: user}) do
    %{id: user.id,
      username: user.username,
      email: user.email,
      name: user.name}
  end
end
