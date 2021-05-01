defmodule ApiWeb.RepositoryView do
  def render("foi.json", %{data: data}) do
    %{
      data: data
    }
  end
end
