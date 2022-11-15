defmodule Papyrus.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Telemetry supervisor
      PapyrusWeb.Telemetry,
      # Start the Ecto repository
      Papyrus.Repo,
      # Start the PubSub system
      {Phoenix.PubSub, name: Papyrus.PubSub},
      # Start Finch
      {Finch, name: Papyrus.Finch},
      # Start the Endpoint (http/https)
      PapyrusWeb.Endpoint
      # Start a worker by calling: Papyrus.Worker.start_link(arg)
      # {Papyrus.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Papyrus.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    PapyrusWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
