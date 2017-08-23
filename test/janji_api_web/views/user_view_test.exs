defmodule JanjiApiWeb.UserViewTest do
  use JanjiApiWeb.ConnCase, async: true
  import Phoenix.View

  alias JanjiApiWeb.UserView
  alias JanjiApi.Accounts.User

  test "user.json" do
    user = %User{id: "1", username: "username", email: "email", name: "name"}
    content = UserView.render("user.json", %{user: user})
    assert content == %{
      id: user.id,
      username: user.username,
      email: user.email,
      name: user.name,
    }
  end

  test "index.json" do
    users =
      [%User{id: "1", username: "username_1", email: "email_1", name: "name_1"},
       %User{id: "2", username: "username_2", email: "email_2", name: "name_2"}]
      |> render_many(UserView, "user.json")
    content = UserView.render("index.json", %{users: users})
    assert content == %{
      data: %{
        items: users
      }
    }
  end

  test "show.json" do
    user =
      %User{id: "1", username: "username", email: "email", name: "name"}
      |> render_one(UserView, "user.json")
    content = UserView.render("show.json", %{user: user})
    assert content == %{
      data: user
    }
  end
end
