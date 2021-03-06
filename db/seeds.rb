# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

garage = Garage.new(name: 'LA Garage')
garage2 = Garage.new(name: 'NYC Garage')

garage.floors << Floor.new(number_of_spaces: 2, garage: garage, name: 'First floor')
garage.floors << Floor.new(number_of_spaces: 2, garage: garage, name: 'Second floor')

garage.save!

garage2.floors << Floor.new(number_of_spaces: 2, garage: garage2, name: 'First floor')
garage2.save!

ParkingTransaction.create!(floor: garage.floors.first)
ParkingTransaction.create!(floor: garage.floors.first)
ParkingTransaction.create!(floor: garage2.floors.first)