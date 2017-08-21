defmodule JanjiApi.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias JanjiApi.Accounts.User

  schema "users" do
    field :email, :string
    field :name, :string
    field :password_hash, :string
    field :username, :string

    timestamps()
  end

  @doc false
  def changeset(%User{} = user, attrs) do
    user
    |> cast(attrs, [:username, :email, :name])
    |> validate_required([:username, :email, :name])
    |> unique_constraint(:username)
    |> unique_constraint(:email)
  end
end
