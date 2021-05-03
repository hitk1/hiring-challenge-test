defmodule Api.Repositories.Services.RequestRepo do
  require Logger

  def call(repo_path) do
    try do
      base_url = "https://api.github.com/repos#{repo_path}"

      response =
        base_url
        |> HTTPoison.get!()

      data = Poison.decode!(response.body)

      case data do
        %{"message" => message} -> raise message
        %{"organization" => _} -> {:ok, data}
      end
    rescue
      error in RuntimeError ->
        %{message: message} = error
        {:error, message}

      error in MatchError ->
        %{term: %{"message" => message}} = error
        {:error, message}

      _ ->
        {:error, "Something went wrong"}
    end
  end
end
