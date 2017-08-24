defmodule JanjiApi.Repo.Migrations.CreatePromisePostVotes do
  use Ecto.Migration

  def change do
    create table(:promise_post_votes) do
      add :promise_id, references(:promises), null: false
      add :promise_post_id, references(:promise_posts), null: false
      add :inserted_by_id, references(:users), null: false

      timestamps()
    end

    create unique_index(:promise_post_votes, [:promise_id])
  end
end
