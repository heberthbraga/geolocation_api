User.find_or_create_by(email: 'admin@example.com') do |admin|
  p 'Seeding admin user'

  admin.first_name = 'Super'
  admin.last_name = 'Admin'
  admin.password = 'Test1234!'
  admin.add_role(:admin)
end

User.find_or_create_by(email: 'api@example.com') do |registered|
  p 'Seeding api user'

  registered.first_name = 'Api'
  registered.last_name = 'User'
  registered.password = 'Test1234!'
  registered.add_role(:api)
end