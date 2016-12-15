# needed to get defdatabase and other macros
use Amnesia

defdatabase TestDatabase do
  #We define a table, records will be sorted, the first element will be taken as an index
  deftable Snitch, [{ :id, autoincrement }, :name, :notes, :alert_email, :slack_webhook, :tags ], type: :ordered_set do
    #Nice to have, we declare a struct that represents a record in the database
    @type t :: %Snitch{id: non_neg_integer, name: String.t, notes: String.t, alert_email: String.t, slack_webhook: String.t, tags: List :: list(String.t)}
  end

end
