climb_params_string = JSON.stringify(
  { climb_log: { climb_id: <%= @climb.id %> } }
)
$("#climbs a[data-params='#{climb_params_string}'").fadeOut ->
  $(this).remove()
