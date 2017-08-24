defmodule JanjiApiWeb.PromiseViewTest do
  use JanjiApiWeb.ConnCase, async: true
  import Phoenix.View

  alias JanjiApiWeb.PromiseMakerView
  alias JanjiApiWeb.PromiseView
  alias JanjiApiWeb.UserView

  alias JanjiApi.PromiseMakers.PromiseMaker
  alias JanjiApi.Accounts.User

  test "promise.json" do
    promise = create_promise()
    content = PromiseView.render("promise.json", %{promise: promise})
    assert content == %{
      id: promise.id,
      promise_maker: PromiseMakerView.render("promise_maker_no_rel.json", %{promise_maker: promise.promise_maker}),
      title: promise.title,
      promised_at: promise.promised_at,
      description: promise.description,
      url: promise.url,
      inserted_by: UserView.render("user.json", %{user: promise.inserted_by}),
    }
  end

  test "index.json" do
    promises = [create_promise(), create_promise()]
      |> render_many(PromiseView, "promise.json")
    content = PromiseView.render("index.json", %{promises: promises})
    assert content == %{
      data: %{
        items: promises
      }
    }
  end

  test "show.json" do
    promise = create_promise()
      |> render_one(PromiseView, "promise.json")
    content = PromiseView.render("show.json", %{promise: promise})
    assert content == %{
      data: promise
    }
  end

  defp create_promise do
    params_for(:promise)
      |> Map.put(:id, 1)
      |> Map.put(:promise_maker, %PromiseMaker{})
      |> Map.put(:inserted_by, %User{})
  end
end
