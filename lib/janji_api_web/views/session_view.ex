defmodule JanjiApiWeb.SessionView do
  use JanjiApiWeb, :view

  alias JanjiApiWeb.UserView

  def render("login.json", %{user: user, jwt: jwt, exp: exp}) do
    %{data: %{
      user: render_one(user, UserView, "user.json"),
      jwt: jwt,
      exp: exp,
    }}
  end

  def render("logout.json", _opts) do
    %{data: %{
      status: "ok"
    }}
  end
end
