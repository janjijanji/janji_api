defmodule JanjiApi.Promises.PostVote do
  use Ecto.Schema
  import Ecto.Changeset
  alias JanjiApi.Promises
  alias JanjiApi.Promises.PostVote

  schema "promise_post_votes" do
    belongs_to :promise, JanjiApi.Promises.Promise, foreign_key: :promise_id
    belongs_to :promise_post, JanjiApi.Promises.Post, foreign_key: :promise_post_id
    belongs_to :inserted_by, JanjiApi.Accounts.User, foreign_key: :inserted_by_id

    timestamps()
  end

  @doc false
  def changeset(%PostVote{} = post_vote, attrs) do
    post_vote
    |> cast(attrs, [:promise_post_id, :inserted_by_id])
    |> validate_required([:promise_post_id, :inserted_by_id])
    |> assoc_constraint(:promise_post)
    |> assoc_constraint(:inserted_by)
    |> put_promise()
  end

  @doc false
  defp put_promise(changeset) do
    case changeset do
      %Ecto.Changeset{valid?: true, changes: %{promise_post_id: promise_post_id}} ->
        promise_post = Promises.get_post!(promise_post_id)
        put_change(changeset, :promise_id, promise_post.promise_id)
      _ ->
        changeset
    end
  end
end
