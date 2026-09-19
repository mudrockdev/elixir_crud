defmodule ElixirCrud.SubRouter do
  use Plug.Router

  plug(Plug.Logger)
  plug(:match)
  plug(:dispatch)

  get "/" do
    send_resp(conn, 200, "pong")
  end

  match _ do
    send_resp(conn, 404, "not found")
  end
end

defmodule ElixirCrud.Router do
  use Plug.Router

  plug(Plug.Logger)

  plug(Plug.Static,
    at: "/",
    from: {:elixir_crud, "priv/static"},
    only: ~w(_app favicon.svg robots.txt)
  )

  get "/" do
    send_resp(conn)
  end

  plug(:match)
  plug(:dispatch)

  forward("/api", to: ElixirCrud.SubRouter, init_opts: [])

  match _ do
    send_spa(conn)
  end

  defp send_spa(conn) do
    conn
    |> put_resp_content_type("text/html")
    |> send_file(200, Application.app_dir(:elixir_crud, "priv/static/200.html"))
  end
end
