defmodule JanjiApiWeb.Auth do
  import Plug.Conn
  import Comeonin.Bcrypt, only: [checkpw: 2, dummy_checkpw: 0]
  import Phoenix.Controller

  alias JanjiApi.Accounts

  def init(_opts) do
    # NOP
  end

  def call(conn, _opts) do
    user = Guardian.Plug.current_resource(conn)

    cond do
      user ->
        assign(conn, :current_user, user)
      true ->
        assign(conn, :current_user, nil)
    end
  end

  def login(conn, user) do
    new_conn = Guardian.Plug.api_sign_in(conn, user)
    jwt = Guardian.Plug.current_token(new_conn)
    {:ok, claims} = Guardian.Plug.claims(new_conn)
    exp = Map.get(claims, "exp")

    new_conn
    |> put_resp_header("authorization", "Bearer #{jwt}")
    |> put_resp_header("x-expires", "#{exp}")

    {:ok, new_conn, %{user: user, jwt: jwt, exp: exp}}
  end

  def login_by_username_and_pass(conn, username, given_pass) do
    user = Accounts.get_user_by(username: username)

    cond do
      user && checkpw(given_pass, user.password_hash) ->
        login(conn, user)
      user ->
        {:error, :unauthorized, conn}
      true ->
        dummy_checkpw()
        {:error, :not_found, conn}
    end
  end

  # Remember the client must also destroy token that they held, else it still can be reused
  def logout(conn) do
    jwt = Guardian.Plug.current_token(conn)
    case Guardian.Plug.claims(conn) do
      {:ok, claims} ->
        Guardian.revoke!(jwt, claims)
      {:error, _} ->
        :ok
    end
  end

  def unauthenticated(conn, _params) do
    conn
    |> put_status(401)
    |> put_view(JanjiApiWeb.ErrorView)
    |> render("401.json")
  end
end
