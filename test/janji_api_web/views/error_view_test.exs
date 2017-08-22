defmodule JanjiApiWeb.ErrorViewTest do
  use JanjiApiWeb.ConnCase, async: true

  # Bring render/3 and render_to_string/3 for testing custom views
  import Phoenix.View

  test "renders 401.json" do
    assert render(JanjiApiWeb.ErrorView, "401.json", []) ==
           %{errors: %{detail: "Authentication required"}}
  end

  test "renders 404.json" do
    assert render(JanjiApiWeb.ErrorView, "404.json", []) ==
           %{errors: %{detail: "Page not found"}}
  end

  test "render 500.json" do
    assert render(JanjiApiWeb.ErrorView, "500.json", []) ==
           %{errors: %{detail: "Internal server error"}}
  end

  test "render any other" do
    assert render(JanjiApiWeb.ErrorView, "505.json", []) ==
           %{errors: %{detail: "Internal server error"}}
  end
end
