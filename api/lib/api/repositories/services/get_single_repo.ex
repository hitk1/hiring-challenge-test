defmodule Api.Repositories.Services.GetSingleRepo do
  import Ecto.Query, only: [from: 2]
  require Logger

  alias Api.Repo
  alias Api.Repositories.Infra.Database.Schema, as: RepoSchema

  def call(params) do
    %{"id" => id} = params

    query =
      from repo in RepoSchema,
        where: repo.id == ^id

    result = Repo.all(query)

    if length(result) > 0 do
      formated_data =
        result
        |> Enum.at(0)
        |> Map.delete(:__meta__)
        |> Map.delete(:__struct__)

      {:ok, formated_data}
    else
      {:error, "Repo not found!"}
    end
  end
end
