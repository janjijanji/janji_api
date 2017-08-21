defmodule JanjiApiWeb.PageControllerTest do
  use JanjiApiWeb.ConnCase

  test "GET /", %{conn: conn} do
    conn = get conn, "/"
    assert html_response(conn, 200) =~ "Janji-janji API"
  end
end
