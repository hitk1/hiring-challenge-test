defmodule Api.Repositories.Services.CreateRepoTest do
  use Api.DataCase

  alias Api.Repositories.Services.CreateRepo
  alias Api.Repositories.Services.RequestRepo

  describe "CreateRepo/1" do
    test "When repo created successfully on database" do
      {:ok, raw_data} = RequestRepo.call("/facebook/react")

      result = CreateRepo.call(raw_data)

      assert {:ok, %Api.Repositories.Infra.Database.Schema{full_name: "facebook/react"}} = result
    end

    test "When repo can't pattern match" do
      result = CreateRepo.call(%{"testing" => "asdfgasfg"})

      assert result == {:error, %MatchError{term: %{"testing" => "asdfgasfg"}}}
    end

    test "When repo is missing attributes" do
      result = CreateRepo.call(%{})
    end
  end
end
