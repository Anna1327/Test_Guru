# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

users = User.create!(
  [{ firstName: 'Anna', lastName: 'Rubinova', role: 'admin' },
  { firstName: 'Andrey', lastName: 'Ivanov', role: 'user' },
  { firstName: 'Kristina', lastName: 'Smirnova', role: 'user' }]
)
  
categories = Category.create!(
  [{ title: 'HTML' },
  { title: 'Ruby' },
  { title: 'Ruby on Rails' }]
)
  
tests = Test.create!(
  [{ title: 'Test 1', level: 0, category: categories.first, author: users.first },
  { title: 'Test 2', level: 1, category: categories[1], author: users[1] },
  { title: 'Test 3', level: 2, category: categories.last, author: users.last },
  { title: 'Test 4', level: 0, category: categories.first, author: users.first },
  { title: 'Test 5', level: 1, category: categories[1], author: users[1] },
  { title: 'Test 6', level: 2, category: categories.last, author: users.last },
  { title: 'Test 7', level: 0, category: categories.first, author: users.first },
  { title: 'Test 8', level: 1, category: categories[1], author: users[1] },
  { title: 'Test 9', level: 2, category: categories.last, author: users.last }]
)
  
questions = Question.create!(
  [{ body: 'Question 1', test_id: tests[1].id },
  { body: 'Question 2', test_id: tests[1].id }]
)
Answer.create!(body: 'Answer 1', question_id: questions.first.id)
Answer.create!(body: 'Answer 2', correct: false, question_id: questions.last.id)