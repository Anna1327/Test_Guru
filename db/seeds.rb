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
  [{ title: 'HTML' },
  { title: 'Ruby' },
  { title: 'Ruby on Rails' }]
)
  
tests = Test.create!(
  [{ title: 'Test 1', level: 1, category: categories.first, author_id: users.first.id },
  { title: 'Test 2', level: 2, category: categories[1], author_id: users[1].id },
  { title: 'Test 3', level: 3, category: categories.last, author_id: users.last.id },
  { title: 'Test 4', level: 1, category: categories.first, author_id: users.first.id },
  { title: 'Test 5', level: 2, category: categories[1], author_id: users[1].id },
  { title: 'Test 6', level: 3, category: categories.last, author_id: users.last.id },
  { title: 'Test 7', level: 1, category: categories.first, author_id: users.first.id },
  { title: 'Test 8', level: 2, category: categories[1], author_id: users[1].id },
  { title: 'Test 9', level: 3, category: categories.last, author_id: users.last.id }]
)
  
questions = Question.create!(
  [{ body: 'Question 1', test_id: tests[1].id },
  { body: 'Question 2', test_id: tests[1].id }]
)
Answer.create!(body: 'Answer 1', question_id: questions.first.id)
Answer.create!(body: 'Answer 2', correct: false, question_id: questions.last.id)