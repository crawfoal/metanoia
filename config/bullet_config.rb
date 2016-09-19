module BulletConfig
  def self.whitelist_false_positives
    # Legitimate false positives
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

    # Actual unoptimized queries, but not ready to fix yet
    Bullet.add_whitelist(
      type: :counter_cache,
      class_name: 'User',
      association: :roles
    )
    Bullet.add_whitelist(
      type: :counter_cache,
      class_name: 'AthleteStory',
      association: :memberships
    )
    Bullet.add_whitelist(
      type: :n_plus_one_query,
      class_name: 'User',
      association: :roles
    )
    Bullet.add_whitelist(
      type: :n_plus_one_query,
      class_name: 'User',
      association: :manager_story
    )
    Bullet.add_whitelist(
      type: :n_plus_one_query,
      class_name: 'User',
      association: :setter_story
    )
  end
end
