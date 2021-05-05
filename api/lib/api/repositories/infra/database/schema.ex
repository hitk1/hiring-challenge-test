defmodule Api.Repositories.Infra.Database.Schema do
  use Ecto.Schema
  import Ecto.Changeset

  alias Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @required_params [
    :name,
    :full_name,
    :language,
    :owner,
    :avatar,
    :owner_page,
    :repo_page,
    :repo_description,
    :repo_homepage,
    :created_at,
    :stars_count,
    :watchers_count,
    :forks_count
  ]
  schema "repos" do
    field(:name, :string)
    field(:full_name, :string)
    field(:language, :string)
    field(:owner, :string)
    field(:avatar, :string)
    field(:owner_page, :string)
    field(:repo_page, :string)
    field(:repo_description, :string)
    field(:repo_homepage, :string)
    field(:created_at, :string)
    field(:stars_count, :integer)
    field(:watchers_count, :integer)
    field(:forks_count, :integer)
  end

  def changeset(params) do
    %__MODULE__{}
    |> cast(params, @required_params)
  end
end
