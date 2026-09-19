defmodule ElixirCrud.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    # children = [
    #   # Starts a worker by calling: ElixirCrud.Worker.start_link(arg)
    #   # {ElixirCrud.Worker, arg}
    # ]

    require Logger

    port = 4000

    children = [
      {Plug.Cowboy, plug: ElixirCrud.Router, scheme: :http, options: [port: port]}
    ]

    Logger.info("Server started on http://localhost:#{port}.")
    Supervisor.start_link(children, strategy: :one_for_one, name: ElixirCrud.Supervisor)
  end
end
