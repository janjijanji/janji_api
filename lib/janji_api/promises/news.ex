defmodule JanjiApi.Promises.News do
  use Ecto.Schema
  import Ecto.Changeset
  alias JanjiApi.Promises.News

  schema "promise_news" do
    belongs_to :promise, JanjiApi.Promises.Promise, foreign_key: :promise_id
    field :title, :string
    field :published_at, :naive_datetime
    field :summary, :string
    field :body, :string
    field :url, :string
    belongs_to :inserted_by, JanjiApi.Accounts.User, foreign_key: :inserted_by_id

    timestamps()
  end

  @doc false
  def changeset(%News{} = news, attrs) do
    news
    |> cast(attrs, [:promise_id, :title, :published_at, :summary, :body, :url, :inserted_by_id])
    |> validate_required([:promise_id, :title, :published_at, :body, :inserted_by_id])
    |> validate_length(:title, min: 3)
    |> assoc_constraint(:promise)
    |> assoc_constraint(:inserted_by)
  end
end
