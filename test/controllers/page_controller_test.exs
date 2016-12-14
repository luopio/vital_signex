defmodule VitalSignex.PageControllerTest do
  use VitalSignex.ConnCase

  test "GET /" do
    conn = get build_conn(), "/"
    assert html_response(conn, 200) =~ "Welcome to Phoenix!"
  end
end
