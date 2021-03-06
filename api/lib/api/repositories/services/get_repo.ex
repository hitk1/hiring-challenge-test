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

  def call do
    %{repos: repos} = %State{}

    existing_data = repo_from_db

    case existing_data do
      {:error, _} ->
        tasks =
          repos
          |> Enum.map(fn item ->
            Task.async(fn ->
              with {:ok, data} <- RequestRepo.call(item),
                   {:ok, _} <- CreateRepo.call(data) do
                Logger.info("Repo created successfully!")
              else
                {:error, reason} -> Logger.info(reason)
              end
            end)
          end)

        Enum.map(tasks, &Task.await/1)

        with {:ok, data} <- repo_from_db() do
          {:ok, data}
        else
          {:error, reason} -> {:error, reason}
        end

      {:ok, data} ->
        {:ok, data}
    end
  end

  defp repo_from_db do
    try do
      query =
        from(repo in RepoSchema,
          select: {
            repo.id,
            repo.name,
            repo.avatar,
            repo.repo_description,
            repo.language
          }
        )

      result = Repo.all(query)

      if length(result) > 0 do
        formated_data =
          result
          |> Enum.map(fn item ->
            {id, name, avatar, repo_description, language} = item

            %{
              id: id,
              avatar_url: avatar,
              name: name,
              description: repo_description,
              language: language
            }
          end)

        {:ok, formated_data}
      else
        {:error, "Something went wrong"}
      end
    rescue
      error in RuntimeError ->
        %{message: message} = error
        {:error, message}

      _ ->
        {:error, "Something went wrong"}
    end
  end
end
