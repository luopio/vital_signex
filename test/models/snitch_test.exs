defmodule VitalSignex.SnitchTest do
  use Database
  require Amnesia.Helper
  use ShouldI, async: true

  @snitch1 %Database.Snitch{name: "Macellum UI test", alert_email: "some@email.com", slack_webhook: nil, tags: []}
  @snitch2 %Database.Snitch{name: "Macellum UI test 2", alert_email: "some@email.com", slack_webhook: nil, tags: []}
  @snitch_updated %Database.Snitch{name: "To be updated", alert_email: "some@email.com", slack_webhook: nil, tags: []}
  @snitch_deleted %Database.Snitch{name: "To be deleted", alert_email: "some@email.com", slack_webhook: nil, tags: []}

  with "model crud" do

    setup _context do
      Amnesia.Schema.create
      Database.create(ram: [node])
      Amnesia.transaction do
        @snitch1 |> Database.Snitch.write
        @snitch2 |> Database.Snitch.write
      end

      %{ok: []}
    end

    should "read snitch" do
      assert Model.Snitch.read(1).name == @snitch1.name
    end

    should "delete snitch" do
      snitch = Model.Snitch.write(@snitch_deleted)
      assert :ok == Model.Snitch.delete(snitch.id)
      refute Model.Snitch.read(snitch.id)
    end

    should "read all" do
      all = Model.Snitch.all
      assert length(all) >= 2
      assert all |> Enum.map(&(&1.name)) |> Enum.member?(@snitch1.name)
    end

    should "update snitch" do
      name = "UPDATED"
      id = Model.Snitch.write(@snitch_updated).id

      id
      |> Model.Snitch.read
      |> Map.put(:name, name)
      |> Model.Snitch.write
      assert Model.Snitch.read(id).name == name
    end

  end

end
