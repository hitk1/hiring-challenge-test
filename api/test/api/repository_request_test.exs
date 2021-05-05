defmodule Api.Repositories.Services.RequestRepoTest do
  use ExUnit.Case

  alias Api.Repositories.Services.RequestRepo

  describe "RequestRepo/1" do
    test "When repo exists" do
      params = "/facebook/react"

      result = RequestRepo.call(params)
      {atom_response, _} = result

      assert atom_response == :ok
    end

    test "When repo does not exists" do
      params = "/asgasfg/adsfgasf"

      result = RequestRepo.call(params)
      {atom_response, _} = result

      assert atom_response == :error
    end
  end
end
