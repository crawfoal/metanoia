module ClimbHelper
  def data_for_color_options
    Climb.colors.map { |hex, _id| [Climb.color_name_for(hex), hex] }
  end
end
