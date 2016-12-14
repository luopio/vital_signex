defmodule Model.Snitch do
  require Amnesia
  require Amnesia.Helper
  use Database

  def read(id) do
    Amnesia.transaction do
      Database.Snitch.read(id)
    end
  end

  def delete(id) do
    Amnesia.transaction do
      Database.Snitch.delete(id)
    end
  end

  # %Database.Snitch{name: "Macellum UI", alert_email: "some@email.com", slack_webhook: nil, tags: []}
  def write(snitch) do
    Amnesia.transaction do
      snitch |> Database.Snitch.write
    end
  end

  def all do
    Amnesia.transaction do
      selection = Database.Snitch.where(id > 0)
      selection |> Amnesia.Selection.values |> Enum.map &(&1)
     end
  end

end
