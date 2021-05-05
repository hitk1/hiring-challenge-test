defmodule ApiWeb.RepositoryController do
  use ApiWeb, :controller

  alias Api.Repositories.Services.GetRepos
  alias Api.Repositories.Services.GetSingleRepo

  action_fallback(ApiWeb.FallbackController)

  def get_repos(conn, _params) do
    IO.inspect(System.get_env("DB_HOST"))

    with {:ok, data} <- GetRepos.call() do
      conn
      |> put_status(:ok)
      |> render("repos.json", repos: data)
    end
  end

  def get_repo_by_id(conn, params) do
    with {:ok, single_repo} <- GetSingleRepo.call(params) do
      conn
      |> put_status(:ok)
      |> render("single.json", repo: single_repo)
    end
  end
end
