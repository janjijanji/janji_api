defmodule JanjiApi.PromiseMakers.PromiseMaker do
  use Ecto.Schema
  import Ecto.Changeset
  alias JanjiApi.PromiseMakers.PromiseMaker

  schema "promise_makers" do
    field :full_name, :string
    field :gender, :string
    field :birthplace, :string
    field :birthdate, :date
    field :bio, :string
    belongs_to :inserted_by, JanjiApi.Accounts.User, foreign_key: :inserted_by_id

    timestamps()
  end

  @doc false
  def changeset(%PromiseMaker{} = promise_maker, attrs) do
    promise_maker
    |> cast(attrs, [:full_name, :gender, :birthplace, :birthdate, :bio, :inserted_by_id])
    |> validate_required([:full_name, :inserted_by_id])
    |> validate_length(:full_name, min: 3)
    |> validate_inclusion(:gender, ["MALE", "FEMALE"])
    |> assoc_constraint(:inserted_by)
  end
end
