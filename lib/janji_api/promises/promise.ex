defmodule JanjiApi.Promises.Promise do
  use Ecto.Schema
  import Ecto.Changeset
  alias JanjiApi.Promises.Promise

  schema "promises" do
    belongs_to :promise_maker, JanjiApi.PromiseMakers.PromiseMaker, foreign_key: :promise_maker_id
    field :title, :string
    field :promised_at, :naive_datetime
    field :description, :string
    field :url, :string
    belongs_to :inserted_by, JanjiApi.Accounts.User, foreign_key: :inserted_by_id

    timestamps()
  end

  @doc false
  def changeset(%Promise{} = promise, attrs) do
    promise
    |> cast(attrs, [:promise_maker_id, :title, :promised_at, :description, :url, :inserted_by_id])
    |> validate_required([:promise_maker_id, :title, :promised_at, :description, :inserted_by_id])
    |> validate_length(:title, min: 3)
    |> assoc_constraint(:promise_maker)
    |> assoc_constraint(:inserted_by)
  end
end
