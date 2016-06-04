module PageObjects
  module ClimbLogs
    class Index < Base
      def current_gym_name
        find('.gym h2').text
      end

      def next_gym
        find('.gym h2 .fa-caret-right').click
      end

      def next_section
        find('.section .fa-caret-right').click
      end

      def showing_valid_gym_section_and_logs_for?(user)
        showing_climb_logs_for_current_section? user
      end

      private

      def current_gym
        Gym.find_by_name current_gym_name
      end

      def current_section
        Section.find_by_name current_section_name
      end

      def current_section_name
        find('.section h3').text
      end

      def logs_expected_for_section(user, section)
        user.athlete_story.climb_logs.in_section(section)
      end

      def main_element
        find 'main.climb_logs.index'
      end

      def showing_climb_logs_for_current_section?(user)
        return false unless showing_valid_section_name? user
        logs_expected_for_section(user, current_section).all? do |climb_log|
          page.has_selector?(
            ".#{Climb.color_name_for(climb_log.climb.color)}",
            text: climb_log.grade.name
          )
        end
      end

      def showing_valid_gym_name?(user)
        current_gym_name.in? user.athlete_story.gyms.map(&:name)
      end

      def showing_valid_section_name?(user)
        return false unless showing_valid_gym_name?(user)
        current_section_name.in? current_gym.sections.map(&:name)
      end
    end
  end
end
