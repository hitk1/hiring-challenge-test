defmodule Api.Repositories.Services.CreateRepo do
  require Logger

  alias Api.Repo
  alias Api.Repositories.Infra.Database.Schema, as: RepoModel

  def call(data) do
    try do
      %{
        "name" => name,
        "full_name" => full_name,
        "owner" => %{
          "login" => owner,
          "avatar_url" => avatar,
          "html_url" => owner_page
        },
        "html_url" => repo_page,
        "description" => repo_description,
        "homepage" => repo_homepage,
        "created_at" => created_at,
        "stargazers_count" => stars_count,
        "watchers_count" => watchers_count,
        "forks_count" => forks_count,
        "language" => language
      } = data

      %{
        name: name,
        full_name: full_name,
        language: language,
        owner: owner,
        avatar: avatar,
        owner_page: owner_page,
        repo_page: repo_page,
        repo_description: repo_description,
        repo_homepage: repo_homepage,
        created_at: created_at,
        stars_count: stars_count,
        watchers_count: watchers_count,
        forks_count: forks_count
      }
      |> RepoModel.changeset()
      |> execute()
    rescue
      error -> {:error, error}
    end
  end

  defp execute(repoChangeset) do
    case Repo.insert(repoChangeset) do
      {:ok, result} -> {:ok, result}
      {:error, reason} -> {:error, reason}
    end
  end
end
