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
['SEO', 'SMM', 'WEB'].each do |product|
  Product.create!(user: demo_user, name: product)
end

{'Построения' => ['Найма', 'Коммуникации', 'Инспекции и доклады'],
 'Распространения' => ['Реклама и маркетинг', 'Понимание', 'Продажи'],
 'Финансов' => ['Доходы', 'Расходы', 'Активы и мат часть'],
 'Техническое' => ['Планирование', 'Обеспечение', 'Производство'],
 'Квалификации и качества' => ['Качества', 'Обучение персонала', 'Коррекции'],
 'Расширения' => ['Связи с общественностью', 'Вводных услуг', 'Работа с партнерами'],
 'Административное' => ['Офис учредителя', 'Юр Вопросов', 'Исполнительн. Дир'], }.each do |department, sections|
  if dep = Department.create!(name: department, user: demo_user)
    puts "Created Department: #{dep.name}"
    sections.each do |_section|
      puts "\tSection: #{_section}"
      section = Section.create!(name: _section, department: dep)
      stat = Statistic.create!(user: demo_user, section: section, name: "Стат #{_section}", units: ['час', 'шт', 'звонок'].shuffle.first)
      if stat.id < 4
        start_date = (Time.now - 2.month)
        while start_date < Time.now
          Report.create!(statistic: stat, report_at: start_date, units: (4..8).to_a.shuffle.first)
          start_date += 1.day
        end
      end
    end
  end
end
