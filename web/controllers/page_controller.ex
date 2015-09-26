defmodule VitalSignex.PageController do
  use VitalSignex.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
