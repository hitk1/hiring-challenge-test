defmodule Api.Repositories.Services.RequestRepo do
  require Logger

  def call(repo_path) do
    base_url = "https://api.github.com/repos#{repo_path}"

    response =
      base_url
      |> HTTPoison.get!()

    data = Poison.decode!(response.body)
    {:ok, data}
  end
end
