module BulletConfig
  def self.whitelist_false_positives
    Bullet.add_whitelist(
      type: :n_plus_one_query,
      class_name: 'ClimbLog',
      association: :climb
    )
    Bullet.add_whitelist(
      type: :n_plus_one_query,
      class_name: 'Gym',
      association: :route_grade_system
    )
    Bullet.add_whitelist(
      type: :n_plus_one_query,
      class_name: 'Gym',
      association: :boulder_grade_system
    )
    Bullet.add_whitelist(
      type: :n_plus_one_query,
      class_name: 'GradeSystem',
      association: :grades
    )
  end
end
