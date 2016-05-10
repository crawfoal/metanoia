# encoding: UTF-8
# This file is auto-generated from the current content of the database. Instead
# of editing this file, please use the migrations feature of Seed Migration to
# incrementally modify your database, and then regenerate this seed file.
#
# If you need to create the database on another system, you should be using
# db:seed, not running all the migrations from scratch. The latter is a flawed
# and unsustainable approach (the more migrations you'll amass, the slower
# it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Base.transaction do

  GradeSystem.create({"created_at"=>"2016-05-10T02:33:27.993Z", "id"=>3, "name"=>"Hueco Scale", "updated_at"=>"2016-05-10T02:33:27.993Z"})

  GradeSystem.create({"created_at"=>"2016-05-10T02:33:28.028Z", "id"=>4, "name"=>"YDS", "updated_at"=>"2016-05-10T02:33:28.028Z"})

  GradeSystem.create({"created_at"=>"2016-05-10T03:03:54.593Z", "id"=>5, "name"=>"Hueco Scale", "updated_at"=>"2016-05-10T03:03:54.593Z"})

  GradeSystem.create({"created_at"=>"2016-05-10T03:03:54.628Z", "id"=>6, "name"=>"YDS", "updated_at"=>"2016-05-10T03:03:54.628Z"})
  ActiveRecord::Base.connection.reset_pk_sequence!('grade_systems')

  Grade.create({"created_at"=>"2016-05-10T02:33:28.003Z", "grade_system_id"=>3, "id"=>47, "name"=>"VB", "order"=>0, "updated_at"=>"2016-05-10T02:33:28.003Z"})

  Grade.create({"created_at"=>"2016-05-10T02:33:28.006Z", "grade_system_id"=>3, "id"=>48, "name"=>"V0", "order"=>1, "updated_at"=>"2016-05-10T02:33:28.006Z"})

  Grade.create({"created_at"=>"2016-05-10T02:33:28.007Z", "grade_system_id"=>3, "id"=>49, "name"=>"V1", "order"=>2, "updated_at"=>"2016-05-10T02:33:28.007Z"})

  Grade.create({"created_at"=>"2016-05-10T02:33:28.008Z", "grade_system_id"=>3, "id"=>50, "name"=>"V2", "order"=>3, "updated_at"=>"2016-05-10T02:33:28.008Z"})

  Grade.create({"created_at"=>"2016-05-10T02:33:28.009Z", "grade_system_id"=>3, "id"=>51, "name"=>"V3", "order"=>4, "updated_at"=>"2016-05-10T02:33:28.009Z"})

  Grade.create({"created_at"=>"2016-05-10T02:33:28.010Z", "grade_system_id"=>3, "id"=>52, "name"=>"V4", "order"=>5, "updated_at"=>"2016-05-10T02:33:28.010Z"})

  Grade.create({"created_at"=>"2016-05-10T02:33:28.011Z", "grade_system_id"=>3, "id"=>53, "name"=>"V5", "order"=>6, "updated_at"=>"2016-05-10T02:33:28.011Z"})

  Grade.create({"created_at"=>"2016-05-10T02:33:28.014Z", "grade_system_id"=>3, "id"=>54, "name"=>"V6", "order"=>7, "updated_at"=>"2016-05-10T02:33:28.014Z"})

  Grade.create({"created_at"=>"2016-05-10T02:33:28.016Z", "grade_system_id"=>3, "id"=>55, "name"=>"V7", "order"=>8, "updated_at"=>"2016-05-10T02:33:28.016Z"})

  Grade.create({"created_at"=>"2016-05-10T02:33:28.017Z", "grade_system_id"=>3, "id"=>56, "name"=>"V8", "order"=>9, "updated_at"=>"2016-05-10T02:33:28.017Z"})

  Grade.create({"created_at"=>"2016-05-10T02:33:28.018Z", "grade_system_id"=>3, "id"=>57, "name"=>"V9", "order"=>10, "updated_at"=>"2016-05-10T02:33:28.018Z"})

  Grade.create({"created_at"=>"2016-05-10T02:33:28.020Z", "grade_system_id"=>3, "id"=>58, "name"=>"V10", "order"=>11, "updated_at"=>"2016-05-10T02:33:28.020Z"})

  Grade.create({"created_at"=>"2016-05-10T02:33:28.021Z", "grade_system_id"=>3, "id"=>59, "name"=>"V11", "order"=>12, "updated_at"=>"2016-05-10T02:33:28.021Z"})

  Grade.create({"created_at"=>"2016-05-10T02:33:28.023Z", "grade_system_id"=>3, "id"=>60, "name"=>"V12", "order"=>13, "updated_at"=>"2016-05-10T02:33:28.023Z"})

  Grade.create({"created_at"=>"2016-05-10T02:33:28.024Z", "grade_system_id"=>3, "id"=>61, "name"=>"V13", "order"=>14, "updated_at"=>"2016-05-10T02:33:28.024Z"})

  Grade.create({"created_at"=>"2016-05-10T02:33:28.025Z", "grade_system_id"=>3, "id"=>62, "name"=>"V14", "order"=>15, "updated_at"=>"2016-05-10T02:33:28.025Z"})

  Grade.create({"created_at"=>"2016-05-10T02:33:28.026Z", "grade_system_id"=>3, "id"=>63, "name"=>"V15", "order"=>16, "updated_at"=>"2016-05-10T02:33:28.026Z"})

  Grade.create({"created_at"=>"2016-05-10T02:33:28.027Z", "grade_system_id"=>3, "id"=>64, "name"=>"V16", "order"=>17, "updated_at"=>"2016-05-10T02:33:28.027Z"})

  Grade.create({"created_at"=>"2016-05-10T02:33:28.029Z", "grade_system_id"=>4, "id"=>65, "name"=>"5.5", "order"=>0, "updated_at"=>"2016-05-10T02:33:28.029Z"})

  Grade.create({"created_at"=>"2016-05-10T02:33:28.030Z", "grade_system_id"=>4, "id"=>66, "name"=>"5.6", "order"=>1, "updated_at"=>"2016-05-10T02:33:28.030Z"})

  Grade.create({"created_at"=>"2016-05-10T02:33:28.031Z", "grade_system_id"=>4, "id"=>67, "name"=>"5.7", "order"=>2, "updated_at"=>"2016-05-10T02:33:28.031Z"})

  Grade.create({"created_at"=>"2016-05-10T02:33:28.032Z", "grade_system_id"=>4, "id"=>68, "name"=>"5.8", "order"=>3, "updated_at"=>"2016-05-10T02:33:28.032Z"})

  Grade.create({"created_at"=>"2016-05-10T02:33:28.033Z", "grade_system_id"=>4, "id"=>69, "name"=>"5.9", "order"=>4, "updated_at"=>"2016-05-10T02:33:28.033Z"})

  Grade.create({"created_at"=>"2016-05-10T02:33:28.034Z", "grade_system_id"=>4, "id"=>70, "name"=>"5.10a", "order"=>5, "updated_at"=>"2016-05-10T02:33:28.034Z"})

  Grade.create({"created_at"=>"2016-05-10T02:33:28.036Z", "grade_system_id"=>4, "id"=>71, "name"=>"5.10b", "order"=>6, "updated_at"=>"2016-05-10T02:33:28.036Z"})

  Grade.create({"created_at"=>"2016-05-10T02:33:28.038Z", "grade_system_id"=>4, "id"=>72, "name"=>"5.10c", "order"=>7, "updated_at"=>"2016-05-10T02:33:28.038Z"})

  Grade.create({"created_at"=>"2016-05-10T02:33:28.039Z", "grade_system_id"=>4, "id"=>73, "name"=>"5.10d", "order"=>8, "updated_at"=>"2016-05-10T02:33:28.039Z"})

  Grade.create({"created_at"=>"2016-05-10T02:33:28.041Z", "grade_system_id"=>4, "id"=>74, "name"=>"5.11a", "order"=>9, "updated_at"=>"2016-05-10T02:33:28.041Z"})

  Grade.create({"created_at"=>"2016-05-10T02:33:28.042Z", "grade_system_id"=>4, "id"=>75, "name"=>"5.11b", "order"=>10, "updated_at"=>"2016-05-10T02:33:28.042Z"})

  Grade.create({"created_at"=>"2016-05-10T02:33:28.044Z", "grade_system_id"=>4, "id"=>76, "name"=>"5.11c", "order"=>11, "updated_at"=>"2016-05-10T02:33:28.044Z"})

  Grade.create({"created_at"=>"2016-05-10T02:33:28.047Z", "grade_system_id"=>4, "id"=>77, "name"=>"5.11d", "order"=>12, "updated_at"=>"2016-05-10T02:33:28.047Z"})

  Grade.create({"created_at"=>"2016-05-10T02:33:28.048Z", "grade_system_id"=>4, "id"=>78, "name"=>"5.12a", "order"=>13, "updated_at"=>"2016-05-10T02:33:28.048Z"})

  Grade.create({"created_at"=>"2016-05-10T02:33:28.049Z", "grade_system_id"=>4, "id"=>79, "name"=>"5.12b", "order"=>14, "updated_at"=>"2016-05-10T02:33:28.049Z"})

  Grade.create({"created_at"=>"2016-05-10T02:33:28.050Z", "grade_system_id"=>4, "id"=>80, "name"=>"5.12c", "order"=>15, "updated_at"=>"2016-05-10T02:33:28.050Z"})

  Grade.create({"created_at"=>"2016-05-10T02:33:28.051Z", "grade_system_id"=>4, "id"=>81, "name"=>"5.12d", "order"=>16, "updated_at"=>"2016-05-10T02:33:28.051Z"})

  Grade.create({"created_at"=>"2016-05-10T02:33:28.052Z", "grade_system_id"=>4, "id"=>82, "name"=>"5.13a", "order"=>17, "updated_at"=>"2016-05-10T02:33:28.052Z"})

  Grade.create({"created_at"=>"2016-05-10T02:33:28.053Z", "grade_system_id"=>4, "id"=>83, "name"=>"5.13b", "order"=>18, "updated_at"=>"2016-05-10T02:33:28.053Z"})

  Grade.create({"created_at"=>"2016-05-10T02:33:28.055Z", "grade_system_id"=>4, "id"=>84, "name"=>"5.13c", "order"=>19, "updated_at"=>"2016-05-10T02:33:28.055Z"})

  Grade.create({"created_at"=>"2016-05-10T02:33:28.056Z", "grade_system_id"=>4, "id"=>85, "name"=>"5.13d", "order"=>20, "updated_at"=>"2016-05-10T02:33:28.056Z"})

  Grade.create({"created_at"=>"2016-05-10T02:33:28.057Z", "grade_system_id"=>4, "id"=>86, "name"=>"5.14a", "order"=>21, "updated_at"=>"2016-05-10T02:33:28.057Z"})

  Grade.create({"created_at"=>"2016-05-10T02:33:28.058Z", "grade_system_id"=>4, "id"=>87, "name"=>"5.14b", "order"=>22, "updated_at"=>"2016-05-10T02:33:28.058Z"})

  Grade.create({"created_at"=>"2016-05-10T02:33:28.059Z", "grade_system_id"=>4, "id"=>88, "name"=>"5.14c", "order"=>23, "updated_at"=>"2016-05-10T02:33:28.059Z"})

  Grade.create({"created_at"=>"2016-05-10T02:33:28.060Z", "grade_system_id"=>4, "id"=>89, "name"=>"5.14d", "order"=>24, "updated_at"=>"2016-05-10T02:33:28.060Z"})

  Grade.create({"created_at"=>"2016-05-10T02:33:28.061Z", "grade_system_id"=>4, "id"=>90, "name"=>"5.15a", "order"=>25, "updated_at"=>"2016-05-10T02:33:28.061Z"})

  Grade.create({"created_at"=>"2016-05-10T02:33:28.062Z", "grade_system_id"=>4, "id"=>91, "name"=>"5.15b", "order"=>26, "updated_at"=>"2016-05-10T02:33:28.062Z"})

  Grade.create({"created_at"=>"2016-05-10T02:33:28.063Z", "grade_system_id"=>4, "id"=>92, "name"=>"5.15c", "order"=>27, "updated_at"=>"2016-05-10T02:33:28.063Z"})

  Grade.create({"created_at"=>"2016-05-10T03:03:54.602Z", "grade_system_id"=>5, "id"=>93, "name"=>"VB", "order"=>0, "updated_at"=>"2016-05-10T03:03:54.602Z"})

  Grade.create({"created_at"=>"2016-05-10T03:03:54.605Z", "grade_system_id"=>5, "id"=>94, "name"=>"V0", "order"=>1, "updated_at"=>"2016-05-10T03:03:54.605Z"})

  Grade.create({"created_at"=>"2016-05-10T03:03:54.606Z", "grade_system_id"=>5, "id"=>95, "name"=>"V1", "order"=>2, "updated_at"=>"2016-05-10T03:03:54.606Z"})

  Grade.create({"created_at"=>"2016-05-10T03:03:54.607Z", "grade_system_id"=>5, "id"=>96, "name"=>"V2", "order"=>3, "updated_at"=>"2016-05-10T03:03:54.607Z"})

  Grade.create({"created_at"=>"2016-05-10T03:03:54.609Z", "grade_system_id"=>5, "id"=>97, "name"=>"V3", "order"=>4, "updated_at"=>"2016-05-10T03:03:54.609Z"})

  Grade.create({"created_at"=>"2016-05-10T03:03:54.610Z", "grade_system_id"=>5, "id"=>98, "name"=>"V4", "order"=>5, "updated_at"=>"2016-05-10T03:03:54.610Z"})

  Grade.create({"created_at"=>"2016-05-10T03:03:54.611Z", "grade_system_id"=>5, "id"=>99, "name"=>"V5", "order"=>6, "updated_at"=>"2016-05-10T03:03:54.611Z"})

  Grade.create({"created_at"=>"2016-05-10T03:03:54.612Z", "grade_system_id"=>5, "id"=>100, "name"=>"V6", "order"=>7, "updated_at"=>"2016-05-10T03:03:54.612Z"})

  Grade.create({"created_at"=>"2016-05-10T03:03:54.615Z", "grade_system_id"=>5, "id"=>101, "name"=>"V7", "order"=>8, "updated_at"=>"2016-05-10T03:03:54.615Z"})

  Grade.create({"created_at"=>"2016-05-10T03:03:54.617Z", "grade_system_id"=>5, "id"=>102, "name"=>"V8", "order"=>9, "updated_at"=>"2016-05-10T03:03:54.617Z"})

  Grade.create({"created_at"=>"2016-05-10T03:03:54.618Z", "grade_system_id"=>5, "id"=>103, "name"=>"V9", "order"=>10, "updated_at"=>"2016-05-10T03:03:54.618Z"})

  Grade.create({"created_at"=>"2016-05-10T03:03:54.619Z", "grade_system_id"=>5, "id"=>104, "name"=>"V10", "order"=>11, "updated_at"=>"2016-05-10T03:03:54.619Z"})

  Grade.create({"created_at"=>"2016-05-10T03:03:54.621Z", "grade_system_id"=>5, "id"=>105, "name"=>"V11", "order"=>12, "updated_at"=>"2016-05-10T03:03:54.621Z"})

  Grade.create({"created_at"=>"2016-05-10T03:03:54.623Z", "grade_system_id"=>5, "id"=>106, "name"=>"V12", "order"=>13, "updated_at"=>"2016-05-10T03:03:54.623Z"})

  Grade.create({"created_at"=>"2016-05-10T03:03:54.624Z", "grade_system_id"=>5, "id"=>107, "name"=>"V13", "order"=>14, "updated_at"=>"2016-05-10T03:03:54.624Z"})

  Grade.create({"created_at"=>"2016-05-10T03:03:54.625Z", "grade_system_id"=>5, "id"=>108, "name"=>"V14", "order"=>15, "updated_at"=>"2016-05-10T03:03:54.625Z"})

  Grade.create({"created_at"=>"2016-05-10T03:03:54.626Z", "grade_system_id"=>5, "id"=>109, "name"=>"V15", "order"=>16, "updated_at"=>"2016-05-10T03:03:54.626Z"})

  Grade.create({"created_at"=>"2016-05-10T03:03:54.627Z", "grade_system_id"=>5, "id"=>110, "name"=>"V16", "order"=>17, "updated_at"=>"2016-05-10T03:03:54.627Z"})

  Grade.create({"created_at"=>"2016-05-10T03:03:54.629Z", "grade_system_id"=>6, "id"=>111, "name"=>"5.5", "order"=>0, "updated_at"=>"2016-05-10T03:03:54.629Z"})

  Grade.create({"created_at"=>"2016-05-10T03:03:54.630Z", "grade_system_id"=>6, "id"=>112, "name"=>"5.6", "order"=>1, "updated_at"=>"2016-05-10T03:03:54.630Z"})

  Grade.create({"created_at"=>"2016-05-10T03:03:54.631Z", "grade_system_id"=>6, "id"=>113, "name"=>"5.7", "order"=>2, "updated_at"=>"2016-05-10T03:03:54.631Z"})

  Grade.create({"created_at"=>"2016-05-10T03:03:54.632Z", "grade_system_id"=>6, "id"=>114, "name"=>"5.8", "order"=>3, "updated_at"=>"2016-05-10T03:03:54.632Z"})

  Grade.create({"created_at"=>"2016-05-10T03:03:54.633Z", "grade_system_id"=>6, "id"=>115, "name"=>"5.9", "order"=>4, "updated_at"=>"2016-05-10T03:03:54.633Z"})

  Grade.create({"created_at"=>"2016-05-10T03:03:54.634Z", "grade_system_id"=>6, "id"=>116, "name"=>"5.10a", "order"=>5, "updated_at"=>"2016-05-10T03:03:54.634Z"})

  Grade.create({"created_at"=>"2016-05-10T03:03:54.635Z", "grade_system_id"=>6, "id"=>117, "name"=>"5.10b", "order"=>6, "updated_at"=>"2016-05-10T03:03:54.635Z"})

  Grade.create({"created_at"=>"2016-05-10T03:03:54.637Z", "grade_system_id"=>6, "id"=>118, "name"=>"5.10c", "order"=>7, "updated_at"=>"2016-05-10T03:03:54.637Z"})

  Grade.create({"created_at"=>"2016-05-10T03:03:54.638Z", "grade_system_id"=>6, "id"=>119, "name"=>"5.10d", "order"=>8, "updated_at"=>"2016-05-10T03:03:54.638Z"})

  Grade.create({"created_at"=>"2016-05-10T03:03:54.641Z", "grade_system_id"=>6, "id"=>120, "name"=>"5.11a", "order"=>9, "updated_at"=>"2016-05-10T03:03:54.641Z"})

  Grade.create({"created_at"=>"2016-05-10T03:03:54.642Z", "grade_system_id"=>6, "id"=>121, "name"=>"5.11b", "order"=>10, "updated_at"=>"2016-05-10T03:03:54.642Z"})

  Grade.create({"created_at"=>"2016-05-10T03:03:54.644Z", "grade_system_id"=>6, "id"=>122, "name"=>"5.11c", "order"=>11, "updated_at"=>"2016-05-10T03:03:54.644Z"})

  Grade.create({"created_at"=>"2016-05-10T03:03:54.645Z", "grade_system_id"=>6, "id"=>123, "name"=>"5.11d", "order"=>12, "updated_at"=>"2016-05-10T03:03:54.645Z"})

  Grade.create({"created_at"=>"2016-05-10T03:03:54.647Z", "grade_system_id"=>6, "id"=>124, "name"=>"5.12a", "order"=>13, "updated_at"=>"2016-05-10T03:03:54.647Z"})

  Grade.create({"created_at"=>"2016-05-10T03:03:54.649Z", "grade_system_id"=>6, "id"=>125, "name"=>"5.12b", "order"=>14, "updated_at"=>"2016-05-10T03:03:54.649Z"})

  Grade.create({"created_at"=>"2016-05-10T03:03:54.651Z", "grade_system_id"=>6, "id"=>126, "name"=>"5.12c", "order"=>15, "updated_at"=>"2016-05-10T03:03:54.651Z"})

  Grade.create({"created_at"=>"2016-05-10T03:03:54.652Z", "grade_system_id"=>6, "id"=>127, "name"=>"5.12d", "order"=>16, "updated_at"=>"2016-05-10T03:03:54.652Z"})

  Grade.create({"created_at"=>"2016-05-10T03:03:54.653Z", "grade_system_id"=>6, "id"=>128, "name"=>"5.13a", "order"=>17, "updated_at"=>"2016-05-10T03:03:54.653Z"})

  Grade.create({"created_at"=>"2016-05-10T03:03:54.655Z", "grade_system_id"=>6, "id"=>129, "name"=>"5.13b", "order"=>18, "updated_at"=>"2016-05-10T03:03:54.655Z"})

  Grade.create({"created_at"=>"2016-05-10T03:03:54.656Z", "grade_system_id"=>6, "id"=>130, "name"=>"5.13c", "order"=>19, "updated_at"=>"2016-05-10T03:03:54.656Z"})

  Grade.create({"created_at"=>"2016-05-10T03:03:54.657Z", "grade_system_id"=>6, "id"=>131, "name"=>"5.13d", "order"=>20, "updated_at"=>"2016-05-10T03:03:54.657Z"})

  Grade.create({"created_at"=>"2016-05-10T03:03:54.659Z", "grade_system_id"=>6, "id"=>132, "name"=>"5.14a", "order"=>21, "updated_at"=>"2016-05-10T03:03:54.659Z"})

  Grade.create({"created_at"=>"2016-05-10T03:03:54.660Z", "grade_system_id"=>6, "id"=>133, "name"=>"5.14b", "order"=>22, "updated_at"=>"2016-05-10T03:03:54.660Z"})

  Grade.create({"created_at"=>"2016-05-10T03:03:54.661Z", "grade_system_id"=>6, "id"=>134, "name"=>"5.14c", "order"=>23, "updated_at"=>"2016-05-10T03:03:54.661Z"})

  Grade.create({"created_at"=>"2016-05-10T03:03:54.662Z", "grade_system_id"=>6, "id"=>135, "name"=>"5.14d", "order"=>24, "updated_at"=>"2016-05-10T03:03:54.662Z"})

  Grade.create({"created_at"=>"2016-05-10T03:03:54.663Z", "grade_system_id"=>6, "id"=>136, "name"=>"5.15a", "order"=>25, "updated_at"=>"2016-05-10T03:03:54.663Z"})

  Grade.create({"created_at"=>"2016-05-10T03:03:54.664Z", "grade_system_id"=>6, "id"=>137, "name"=>"5.15b", "order"=>26, "updated_at"=>"2016-05-10T03:03:54.664Z"})

  Grade.create({"created_at"=>"2016-05-10T03:03:54.665Z", "grade_system_id"=>6, "id"=>138, "name"=>"5.15c", "order"=>27, "updated_at"=>"2016-05-10T03:03:54.665Z"})
  ActiveRecord::Base.connection.reset_pk_sequence!('grades')
end

SeedMigration::Migrator.bootstrap(20160510014750)
