defmodule ApiWeb.RepositoryController do
  use ApiWeb, :controller

  alias Api.Repositories.Services.GetRepos

  action_fallback ApiWeb.FallbackController

  def get_repos(conn, _params) do
    with {:ok, data} <- GetRepos.call() do
      conn
      |> put_status(:ok)
      |> render("repos.json", repos: data)
    end
  end
end
