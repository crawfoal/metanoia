class ClimbLogsTree
  def initialize(athlete_story)
    @athlete_story = athlete_story
  end

  def each
    @athlete_story.gyms.includes(:sections).find_each do |gym|
      yield(gym, section_branches(gym))
    end
  end

  private

  def section_branches(gym)
    gym.sections.each_with_object({}) do |section, hash|
      hash[section] = @athlete_story.climb_logs.in_section(section)
    end.delete_if { |section, climb_logs| climb_logs.blank? }
  end
end
