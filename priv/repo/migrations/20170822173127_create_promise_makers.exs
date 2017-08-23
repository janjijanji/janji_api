defmodule JanjiApi.Repo.Migrations.CreatePromiseMakers do
  use Ecto.Migration

  def change do
    create table(:promise_makers) do
      add :full_name, :string, null: false
      add :gender, :string
      add :birthplace, :string
      add :birthdate, :date
      add :bio, :text
      add :inserted_by_id, references(:users), null: false

      timestamps()
    end
  end
end
