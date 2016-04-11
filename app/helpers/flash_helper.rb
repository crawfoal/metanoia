module FlashHelper
  def render_flash
    rendered_flashes = []
    types_to_display.each do |type|
      next if flash[type].blank?
      rendered_flashes << render(
        partial: 'layouts/flash',
        locals: { type: type, message: flash[type] }
      )
    end
    rendered_flashes.join('').html_safe
  end

  private

  def types_to_display
    [:notice, :alert, :warning]
  end
end
