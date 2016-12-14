defmodule Mix.Tasks.Setup.Install do
  use Mix.Task
  import Mix.Generator
  use Database
  require Amnesia.Helper

  @shortdoc "Create Mnesia DB"

  @moduledoc """
    A task for generating model struct, its database migration and Repo if one does not yet exist.
  """
  def run(args) do
    Amnesia.Schema.create
    IO.puts "Schema created..."

    # Once the schema has been created, you can start mnesia.
    Amnesia.start
    IO.puts "Amnesia started..."

    Database.create(disk: [node])
    IO.puts "Disc started..."

    Database.wait

    Amnesia.transaction do
      # ... initial data creation
    end

    Amnesia.stop
  end

end


defmodule Mix.Tasks.Setup.Uninstall do
  use Mix.Task
  import Mix.Generator
  use Database

  @shortdoc "Drop Mnesia DB"

  def run(_) do
    # Start mnesia, or we can't do much.
    Amnesia.start

    # Destroy the database.
    Database.destroy
    IO.puts "DB destroyed..."

    # Stop mnesia, so it flushes everything.
    Amnesia.stop

    # Destroy the schema for the node.
    Amnesia.Schema.destroy
    IO.puts "Schema destroyed..."
  end
end

