class Route < Climb
  # Once data has been entered in a production environment, special care needs
  # to be taken when adding new options to a Rails enum definition. Either you
  # can only add values to the end of the array, or the production data needs to
  # be migrated.
  enum grade: (5..9).map { |num| "5.#{num}" } +
              ((10..15).map do |num|
                ('a'..'d').map { |letter| "5.#{num}#{letter}" }
              end).flatten[0..-2]
end
