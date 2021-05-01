defmodule Api.Repositories.Services.GetRepos do
  import Ecto.Query, only: [from: 2]
  require Logger

  alias Api.Repo
  alias Api.Repositories.Infra.Database.Schema, as: RepoSchema
  alias Api.Repositories.Services.CreateRepo
  alias Api.Repositories.Services.RequestRepo

  defmodule State do
    @type t :: %__MODULE__{
            repos: []
          }

    defstruct repos: [
                "/facebook/react-native",
                "/facebook/react",
                "/Automattic/mongoose",
                "/prisma/prisma",
                "/Nozbe/WatermelonDB"
              ]
  end

  def call() do
    %{repos: repos} = %State{}

    tasks =
      repos
      |> Enum.map(fn item ->
        Task.async(fn ->
          with {:ok, data} <- RequestRepo.call(item),
               {:ok, _} <- CreateRepo.call(data) do
            Logger.info("Repo created successfully!")
          end
        end)
      end)

    Enum.map(tasks, &Task.await/1)

    with {:ok, data} <- getRepoFromDB() do
      {:ok, data}
    else
      _ -> {:error, ""}
    end
  end

  defp getRepoFromDB() do
    # query = from(repo in RepoSchema)

    result = Repo.all(RepoSchema)
    IO.inspect(Enum.at(result, 0))

    if length(result) > 0 do
      {:ok, result}
    else
      {:error, "Data not found!"}
    end
  end
end
