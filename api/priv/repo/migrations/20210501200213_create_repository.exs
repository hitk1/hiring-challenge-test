defmodule Api.Repo.Migrations.CreateRepository do
  use Ecto.Migration

  def change do
    create table(:repos) do
      add(:name, :string)
      add(:full_name, :string)
      add(:owner, :string)
      add(:avatar, :string)
      add(:owner_page, :string)
      add(:repo_page, :string)
      add(:repo_description, :string)
      add(:repo_homepage, :string)
      add(:created_at, :string)
      add(:stars_count, :integer)
      add(:watchers_count, :integer)
      add(:forks_count, :integer)
    end
  end
end
