defmodule ApiWeb.RepositoryView do
  def render("repos.json", %{repos: data}) do
    %{
      message: "Repositories fetched successfully!",
      data: data
    }
  end
end
