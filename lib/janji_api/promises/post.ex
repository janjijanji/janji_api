defmodule JanjiApi.Promises.Post do
  use Ecto.Schema
  import Ecto.Changeset
  alias JanjiApi.Promises.Post

  schema "promise_posts" do
    belongs_to :promise, JanjiApi.Promises.Promise, foreign_key: :promise_id
    belongs_to :promise_maker_term, JanjiApi.PromiseMakers.Term, foreign_key: :promise_maker_term_id
    field :title, :string
    field :body, :string
    belongs_to :inserted_by, JanjiApi.Accounts.User, foreign_key: :inserted_by_id

    timestamps()
  end

  @doc false
  def changeset(%Post{} = post, attrs) do
    post
    |> cast(attrs, [:promise_id, :promise_maker_term_id, :title, :body, :inserted_by_id])
    |> validate_required([:promise_id, :title, :body, :inserted_by_id])
    |> validate_length(:title, min: 3)
    |> assoc_constraint(:promise)
    |> assoc_constraint(:inserted_by)
  end
end
