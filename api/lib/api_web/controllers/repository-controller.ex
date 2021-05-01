defmodule ApiWeb.RepositoryController do
  use ApiWeb, :controller

  alias Api.Repositories.Services.GetRepos

  def get_repos(conn, params) do
    with {:ok, data} <- GetRepos.call() do
      conn
      |> put_status(:ok)
      |> render("repos.json", %{data: data})
    end
  end
end
