defmodule ApiWeb.FallbackController do
  use ApiWeb, :controller

  def call(conn, {:error, result}) do
    conn
    |> put_status(:bad_request)
    |> put_view(ApiWeb.ErrorView)
    |> render("400.json", result: result)
  end
end
