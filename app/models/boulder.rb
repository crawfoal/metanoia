class Boulder < Climb
  # Once data has been entered in a production environment, special care needs
  # to be taken when adding new options to a Rails enum definition. Either you
  # can only add values to the end of the array, or the production data needs to
  # be migrated.
  enum grade: ['VB'] + (0..16).map { |num| "V#{num}" }
end
