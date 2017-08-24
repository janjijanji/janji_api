defmodule JanjiApi.Repo.Migrations.CreatePromiseMakerPositions do
  use Ecto.Migration

  def change do
    create table(:promise_maker_positions) do
      add :title, :string, null: false
      add :description, :text
      add :inserted_by_id, references(:users), null: false

      timestamps()
    end
  end
end
