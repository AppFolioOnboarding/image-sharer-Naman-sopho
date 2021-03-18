# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

seed_image_links = [
  'https://i.imgur.com/6nVLIw5.jpeg',
  'https://i.imgur.com/or6GffH.jpeg',
  'https://i.imgur.com/4y5fo3T.jpeg',
  'https://i.imgur.com/ISr48OB.jpeg',
  'https://i.imgur.com/fV7I4Mz.jpeg',
  'https://i.imgur.com/0E03MEg.jpeg',
  'https://i.imgur.com/Bj4LeOD.jpeg',
  'https://i.imgur.com/Re7XDWL.jpeg',
  'https://i.imgur.com/0L8llya.jpeg',
  'https://i.imgur.com/VBa75cL.jpg',
  'https://i.imgur.com/zBEWILX.png',
  'https://i.imgur.com/kO1YU1C.jpeg',
  'https://i.imgur.com/bApQAna.jpg',
  'https://i.imgur.com/TB2QCta.jpg',
  'https://i.imgur.com/CM6TpAm.jpeg',
  'https://i.imgur.com/2vjFOAP.jpeg',
  'https://i.imgur.com/H2EOPU2.jpeg',
  'https://i.imgur.com/WRDp4lm.png',
  'https://i.imgur.com/mtOO9er.png',
  'https://i.imgur.com/SCMXF0b.jpeg',
  'https://i.imgur.com/19Pi6tt.png'
]

seed_image_links.each do |seed_image_link|
  Image.create(link: seed_image_link)
end
