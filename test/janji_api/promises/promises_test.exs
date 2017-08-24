defmodule JanjiApi.PromisesTest do
  use JanjiApi.DataCase

  alias JanjiApi.Promises

  describe "promises" do
    alias JanjiApi.Promises.Promise

    @invalid_attrs %{promise_maker: nil, title: nil, promised_at: nil, description: nil, inserted_by: nil}

    test "list_promises/0 returns all promises" do
      %Promise{id: id} = insert(:promise)
      assert [%Promise{id: ^id}] = Promises.list_promises()
    end

    test "get_promise!/1 returns the promise with given id" do
      %Promise{id: id} = insert(:promise)
      assert %Promise{id: ^id} = Promises.get_promise!(id)
    end

    test "get_promise_by/1 returns the promise with given attributes" do
      %Promise{id: id} = insert(:promise)
      assert %Promise{id: ^id} = Promises.get_promise_by(id: id)
    end

    test "create_promise/1 with valid data creates a promise" do
      attrs = params_with_assocs(:promise)
      assert {:ok, %Promise{}} = Promises.create_promise(attrs)
    end

    test "create_promise/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Promises.create_promise(@invalid_attrs)
    end

    test "update_promise/2 with valid data updates the promise" do
      promise = insert(:promise)
      update_attrs = params_with_assocs(:promise)
      assert {:ok, %Promise{}} = Promises.update_promise(promise, update_attrs)
    end

    test "update_promise/2 with invalid data returns error changeset" do
      promise = insert(:promise)
      assert {:error, %Ecto.Changeset{}} = Promises.update_promise(promise, @invalid_attrs)
    end

    test "delete_promise/1 deletes the promise" do
      promise = insert(:promise)
      assert {:ok, %Promise{}} = Promises.delete_promise(promise)
      assert_raise Ecto.NoResultsError, fn -> Promises.get_promise!(promise.id) end
    end

    test "change_promise/1 returns a promise changeset" do
      promise = insert(:promise)
      assert %Ecto.Changeset{} = Promises.change_promise(promise)
    end
  end
end
