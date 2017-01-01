# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
#user = CreateAdminService.new.call
#puts 'CREATED ADMIN USER: ' << user.email
demo_user = User.create!(email: 'demo@admin.com',
                        name: 'Demo User',
                        password: 'passwd',
                        password_confirmation: 'passwd')
puts demo_user.inspect
{'Построения' => ['Найма', 'Коммуникации', 'Инспекции и доклады'],
 'Распространения' => ['Реклама и маркетинг', 'Понимание', 'Продажи'],
 'Финансов' => ['Доходы', 'Расходы', 'Активы и мат часть'],
 'Техническое' => ['Планирование', 'Обеспечение', 'Производство'],
 'Квалификации и качества' => ['Качества', 'Обучение персонала', 'Коррекции'],
 'Расширения' => ['Связи с общественностью', 'Вводных услуг', 'Работа с партнерами'],
 'Административное' => ['Офис учредителя', 'Юр Вопросов', 'Исполнительн. Дир'], }.each do |department, sections|
  if dep = Department.create(name: department, user: demo_user)
    puts "Created Department: #{dep.name}"
    sections.each do |section|
      puts "\tSection: #{section}"
      Section.create(name: section, department: dep)
    end
  end
end