defmodule JanjiApiWeb.SessionController do
  use JanjiApiWeb, :controller

  alias JanjiApiWeb.Auth

  def create(conn, %{"session" => %{"username" => username, "password" => password}}) do
    case Auth.login_by_username_and_pass(conn, username, password) do
      {:ok, conn, attrs} ->
        render(conn, "login.json", user: attrs.user, jwt: attrs.jwt, exp: attrs.exp)
      {:error, _reason, conn} ->
        conn
        |> put_status(422)
        |> put_view(JanjiApiWeb.ErrorView)
        |> render("error.json", message: "Invalid username/password combination")
    end
  end

  def delete(conn, _) do
    Auth.logout(conn)
    conn
    |> put_status(204)
    |> render("logout.json")
  end
end
