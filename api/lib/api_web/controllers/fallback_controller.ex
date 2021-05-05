defmodule ApiWeb.FallbackController do
  use ApiWeb, :controller

  def call(conn, {:error, result}) do
    conn
    |> put_status(:bad_request)
    |> put_view(ApiWeb.ErrorView)
    |> render("400.json", result: result)
  end

  def call(conn, error) do
    conn
    |> put_status(:bad_request)
    |> put_view(ApiWeb.ErrorView)
    |> render("400.json", result: "Something went wrong")
  end
end
