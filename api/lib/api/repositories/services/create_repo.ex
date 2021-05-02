defmodule Api.Repositories.Services.CreateRepo do
  require Logger

  alias Api.Repo
  alias Api.Repositories.Infra.Database.Schema, as: RepoModel

  def call(data) do
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
      "forks_count" => forks_count
    } = data

    %{
      name: name,
      full_name: full_name,
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
  end

  defp execute(repoChangeset) do
    case Repo.insert(repoChangeset) do
      {:ok, result} -> {:ok, result}
      {:error, reason} -> Logger.info("had to do something")
    end
  end
end
