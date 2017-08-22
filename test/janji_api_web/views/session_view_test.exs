defmodule JanjiApiWeb.SessionViewTest do
  use JanjiApiWeb.ConnCase, async: true

  # Bring render/3 and render_to_string/3 for testing custom views
  import Phoenix.View

  alias JanjiApi.Accounts.User
  alias JanjiApiWeb.UserView

  test "render login.json" do
    attrs = %{user: %User{}, jwt: "jwt", exp: "exp"}
    assert render(JanjiApiWeb.SessionView, "login.json", attrs) ==
      %{data: %{
        user: render_one(%User{}, UserView, "user.json"),
        jwt: "jwt",
        exp: "exp",
      }}
  end
end
