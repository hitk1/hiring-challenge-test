defmodule Api.Repositories.Services.RequestRepo do
  require Logger

  def call(repo_path) do
    try do
      base_url = "https://api.github.com/repos#{repo_path}"

      response =
        base_url
        |> HTTPoison.get!()

      data = Poison.decode!(response.body)
      {:ok, data}
    rescue
      error in RuntimeError ->
        %{message: message} = error
        {:error, message}

      error in MatchError ->
        %{"message" => message} = error
        {:error, message}

      _ ->
        {:error, "Something went wrong"}
    end
  end
end
