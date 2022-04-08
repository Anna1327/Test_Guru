# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

users = User.create!(
  [{ first_name: 'Anna', last_name: 'Rubinova', role: 'admin', email: 'aoi.yatsu@ya.ru', password: 'secretus' },
  { first_name: 'Andrey', last_name: 'Ivanov', role: 'user', email: 'aoi.yatsu@mail.ru', password: 'secretus' },
  { first_name: 'Kristina', last_name: 'Smirnova', role: 'user', email: 'test@test.ru', password: 'secretus'}]
)

categories = Category.create!(
  [{ title: 'Backend' },
  { title: 'Frontend' }]
)
  
tests = Test.create!(
  [{ title: 'Ruby', level: 1, category: categories.first, author_id: users.first.id },
  { title: 'Ruby on Rails', level: 3, category: categories.first, author_id: users.last.id },
  { title: 'Python', level: 1, category: categories.first, author_id: users.first.id },
  { title: 'HTML', level: 3, category: categories.last, author_id: users.last.id },
  { title: 'JavaScript', level: 3, category: categories.last, author_id: users.last.id }]
)
  
questions = Question.create!(
  [{ body: 'Кто создал язык Ruby?', test_id: tests.first.id },
  { body: 'Назовите 3 основных принципа ООП', test_id: tests.first.id },
  { body: 'Как расшифровывается MVC?', test_id: tests[1].id },
  { body: 'Что такое миграция?', test_id: tests[1].id },
  { body: 'К какому типу языка относится Python?', test_id: tests[2].id },
  { body: 'Что такое лямбда-функция?', test_id: tests[2].id },
  { body: 'Что такое DOM?', test_id: tests[3].id },
  { body: 'Что такое CORS?', test_id: tests[3].id },
  { body: 'Что такое замыкание в JavaScript?', test_id: tests[4].id },
  { body: 'В чем разница между == и ===?', test_id: tests[4].id }]
)
Answer.create!(body: 'Хайяо Миядзаки', correct: false, question_id: questions.first.id)
Answer.create!(body: 'Йо Асакура', correct: false, question_id: questions.first.id)
Answer.create!(body: 'Юкихиро Мацумото', question_id: questions.first.id)
Answer.create!(body: 'Ямашита Томохиса', correct: false, question_id: questions.first.id)

Answer.create!(body: 'инкапсуляция, наследование, полиморфизм', question_id: questions[1].id)
Answer.create!(body: 'ингибиция, фасилитация, аберрация', correct: false, question_id: questions[1].id)
Answer.create!(body: 'брадикинезия, трепанация, кампиметрия', correct: false, question_id: questions[1].id)
Answer.create!(body: 'пролиферация, резекция, манипуляция', correct: false, question_id: questions[1].id)

Answer.create!(body: 'метод переопределение кластер', correct: false, question_id: questions[2].id)
Answer.create!(body: 'миграция представление константа', correct: false, question_id: questions[2].id)
Answer.create!(body: 'модель пролиферация контроллер', correct: false, question_id: questions[2].id)
Answer.create!(body: 'модель представление контроллер', question_id: questions[2].id)

Answer.create!(body: 'переход от одной структуры БД к другой без потери косистентности', question_id: questions[3].id)
Answer.create!(body: 'переселение людей из одного региона в другой', correct: false, question_id: questions[3].id)
Answer.create!(body: 'бегство грызунов в природе', correct: false, question_id: questions[3].id)
Answer.create!(body: 'перемещение всей базы данных в новое место, например с локальных офисных компьютеров в облачную среду', correct: false, question_id: questions[3].id)

Answer.create!(body: 'индексируемый', correct: false, question_id: questions[4].id)
Answer.create!(body: 'интерпретируемый', question_id: questions[4].id)
Answer.create!(body: 'иррациональный', correct: false, question_id: questions[4].id)
Answer.create!(body: 'исследовательский', correct: false, question_id: questions[4].id)

Answer.create!(body: 'многоразовая функция', correct: false, question_id: questions[5].id)
Answer.create!(body: 'локальная функция', correct: false, question_id: questions[5].id)
Answer.create!(body: 'анонимная функция', question_id: questions[5].id)
Answer.create!(body: 'глобальная функция', correct: false, question_id: questions[5].id)

Answer.create!(body: 'место жительства', correct: false, question_id: questions[6].id)
Answer.create!(body: 'объектная модель документа', question_id: questions[6].id)
Answer.create!(body: 'собственность', correct: false, question_id: questions[6].id)
Answer.create!(body: 'сокращение от домофон', correct: false, question_id: questions[6].id)

Answer.create!(body: 'совместное использование ресурсов между разными источниками', question_id: questions[7].id)
Answer.create!(body: 'содружество независимых государств', correct: false, question_id: questions[7].id)
Answer.create!(body: 'зашифрованное использование ресурсов', correct: false, question_id: questions[7].id)
Answer.create!(body: 'рациональное использование природных ресурсов', correct: false, question_id: questions[7].id)

Answer.create!(body: 'наследование', correct: false, question_id: questions[8].id)
Answer.create!(body: 'комбинация функции и лексического окружения, в котором она была определена', question_id: questions[8].id)
Answer.create!(body: 'цикл повторяющихся действий', correct: false, question_id: questions[8].id)
Answer.create!(body: 'глубокое клонирование', correct: false, question_id: questions[8].id)

Answer.create!(body: 'Оператор строгого равенства производит приведение типов, оператор двойного равенства - нет', correct: false, question_id: questions[9].id)
Answer.create!(body: 'оператор двойного равенства производит приведение типов, оператор строгого равенства - нет', question_id: questions[9].id)