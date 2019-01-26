# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

garage = Garage.create!(name: 'LA Garage')
garage2 = Garage.create!(name: 'NYC Garage')

first_floor = Floor.create!(number_of_spaces: 2, garage: garage, name: 'First floor')
second_floor = Floor.create!(number_of_spaces: 2, garage: garage, name: 'Second floor')

floor = Floor.create!(number_of_spaces: 2, garage: garage2, name: 'First floor')

ParkingTransaction.create!(floor: first_floor)
ParkingTransaction.create!(floor: second_floor)
ParkingTransaction.create!(floor: floor)