# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

user = User.create(
  document: '132465',
  email: 'mandakeru@gmail.com',
  name: 'Jean Silva',
  password: 'qweqwe123'
)
company = Company.create(
  description: 'Uma loja sem igual',
  document: '456789123',
  fantasy_name: 'Mandakeru Store',
  legal_name: 'Mandakeru lojas de cristal',
  phone: '456789456789',
  segment_id: 3,
  user: user
)