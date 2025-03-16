defmodule HelloworldWeb.PageController do
  use HelloworldWeb, :controller

  def home(conn, _params) do
    # The home page is often custom made,
    # so skip the default app layout.
    if conn.assigns[:current_user] do
      render(conn, :home, layout: false)
    else
      redirect(conn, to: ~p"/users/log_in")
    end
  end
end
