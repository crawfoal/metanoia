module ClimbHelper
  def data_for_color_options
    Climb.colors.map { |hex, _id| [Climb.color_name_for(hex), hex] }
  end

  def button_to_log_climb(climb, options = {})
    merged_options = {
      class: [climb.color_name, 'climb'],
      remote: true,
      method: :post,
      params: { 'climb_log[climb_id]': climb.id }
    }
    merged_options[:class] += Array(options.delete(:class))
    merged_options = merged_options.merge(options)
    button_to climb.grade.name,
              athletes_climb_logs_path,
              merged_options
  end
end
