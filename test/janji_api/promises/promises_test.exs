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

  describe "posts" do
    alias JanjiApi.Promises.Post

    @invalid_attrs %{promise: nil, title: nil, body: nil, inserted_by: nil}

    test "list_posts/0 returns all posts" do
      %Post{id: id} = insert(:promise_post)
      assert [%Post{id: ^id}] = Promises.list_posts()
    end

    test "get_post!/1 returns the post with given id" do
      %Post{id: id} = insert(:promise_post)
      assert %Post{id: ^id} = Promises.get_post!(id)
    end

    test "get_post_by/1 returns the post with given attributes" do
      %Post{id: id} = insert(:promise_post)
      assert %Post{id: ^id} = Promises.get_post_by(id: id)
    end

    test "create_post/1 with valid data creates a post" do
      attrs = params_with_assocs(:promise_post)
      assert {:ok, %Post{}} = Promises.create_post(attrs)
    end

    test "create_post/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Promises.create_post(@invalid_attrs)
    end

    test "update_post/2 with valid data updates the post" do
      post = insert(:promise_post)
      update_attrs = params_with_assocs(:promise_post)
      assert {:ok, %Post{}} = Promises.update_post(post, update_attrs)
    end

    test "update_post/2 with invalid data returns error changeset" do
      post = insert(:promise_post)
      assert {:error, %Ecto.Changeset{}} = Promises.update_post(post, @invalid_attrs)
    end

    test "delete_post/1 deletes the post" do
      post = insert(:promise_post)
      assert {:ok, %Post{}} = Promises.delete_post(post)
      assert_raise Ecto.NoResultsError, fn -> Promises.get_post!(post.id) end
    end

    test "change_post/1 returns a post changeset" do
      post = insert(:promise_post)
      assert %Ecto.Changeset{} = Promises.change_post(post)
    end
  end

  describe "post_votes" do
    alias JanjiApi.Promises.PostVote

    @invalid_attrs %{promise_post_id: nil, inserted_by: nil}

    test "list_post_votes/0 returns all post_votes" do
      %PostVote{id: id} = insert(:promise_post_vote)
      assert [%PostVote{id: ^id}] = Promises.list_post_votes()
    end

    test "get_post_vote!/1 returns the post_vote with given id" do
      %PostVote{id: id} = insert(:promise_post_vote)
      assert %PostVote{id: ^id} = Promises.get_post_vote!(id)
    end

    test "get_post_vote_by/1 returns the post_vote with given attributes" do
      %PostVote{id: id} = insert(:promise_post_vote)
      assert %PostVote{id: ^id} = Promises.get_post_vote_by(id: id)
    end

    test "create_post_vote/1 with valid data creates a post_vote" do
      attrs = params_with_assocs(:promise_post_vote)
      assert {:ok, %PostVote{}} = Promises.create_post_vote(attrs)
    end

    test "create_post_vote/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Promises.create_post_vote(@invalid_attrs)
    end

    test "update_post_vote/2 with valid data updates the post_vote" do
      post_vote = insert(:promise_post_vote)
      update_attrs = params_with_assocs(:promise_post_vote)
      assert {:ok, %PostVote{}} = Promises.update_post_vote(post_vote, update_attrs)
    end

    test "update_post_vote/2 with invalid data returns error changeset" do
      post_vote = insert(:promise_post_vote)
      assert {:error, %Ecto.Changeset{}} = Promises.update_post_vote(post_vote, @invalid_attrs)
    end

    test "delete_post_vote/1 deletes the post_vote" do
      post_vote = insert(:promise_post_vote)
      assert {:ok, %PostVote{}} = Promises.delete_post_vote(post_vote)
      assert_raise Ecto.NoResultsError, fn -> Promises.get_post_vote!(post_vote.id) end
    end

    test "change_post_vote/1 returns a post_vote changeset" do
      post_vote = insert(:promise_post_vote)
      assert %Ecto.Changeset{} = Promises.change_post_vote(post_vote)
    end
  end
end
