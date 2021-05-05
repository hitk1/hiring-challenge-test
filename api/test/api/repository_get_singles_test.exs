defmodule Api.Repositories.Services.GetSingleRepoTest do
  use Api.DataCase

  alias Api.Repositories.Services.CreateRepo
  alias Api.Repositories.Services.GetSingleRepo
  alias Api.Repositories.Services.RequestRepo

  describe "GetSingleRepo/1" do
    test "When received id does not exists" do
      result = GetSingleRepo.call(%{"id" => "dcd88616-f48f-43f6-985a-860a6e233471"})

      assert {:error, "Repo not found!"} = result
    end

    test "When repo exists" do
      {:ok, raw_data} = RequestRepo.call("/facebook/react")

      inserted = CreateRepo.call(raw_data)

      {:ok, %{id: id}} = inserted

      result = GetSingleRepo.call(%{"id" => id})

      assert {:ok, %{full_name: "facebook/react"}}
    end
  end
end
