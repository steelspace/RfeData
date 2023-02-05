

/* tags: 
select * from Tag
*/
insert into Tag (name) values ('human rights')
insert into Tag (name) values ('usa')
insert into Tag (name) values ('war')
insert into Tag (name) values ('climate change')

/* articles: 
delete from Item where discriminator = 'ART'
select * from Item where discriminator = 'ART'
 */
insert into Item (title, description, status, discriminator, text) values
    ('Nad USA se vznášel čínský špionážní balón',
    'Nad USA se vznášel čínský špionážní balón: Bidenovy stíhačky ho sestřelily! „Číhal“ i u jaderných zbraní',
    'D',
    'ART',
    'Řízení letového provozu v sobotu večer českého času uzemnilo letadla na letištích v Jižní a Severní Karolíně, aby měly stíhačky nerušený prostor. Jak ukazují televizní záběry, balon po sestřelu splaskl a šel k zemi, lépe řečeno do Atlantiku. Pak začala operace vyzvedávání trosek.')
insert into Item (title, description, status, discriminator, text) values
    ('Bouřlivé odhalení z emailů',
    'Kreml zřejmě podplácel evropské politiky, aby zaujali vstřícnější postoje vůči Rusku. Činil tak prostřednictvím utajované lobbistické organizace, která byla řízena přímo z ruského parlamentu.',
    'P',
    'ART',
    'OCCRP tvrdí, že uniklé e-maily z organizace Mezinárodní agentura pro současnou politiku ozřejmují fungování skrytého lobbingu Ruska v evropské politice. Podle ní byla řízena přímo zevnitř Státní dumy, dolní komory ruského parlamentu. Uniklá elektronická korespondence patřila parlamentnímu pracovníkovi Sargisi Mirzachanjanovi, který organizaci po ruské anexi ukrajinského poloostrova Krym vedl. S pomocí vybudované sítě analytiků, novinářů a dalších osob pomáhal prosazovat zájmy Kremlu ve věci protiruských sankcí či anexe Krymu.')

/* photos: 
delete from Item where discriminator = 'PHO'
select * from Item where discriminator = 'PHO'
select id, title, resolution_x * resolution_y as mpx from Item where discriminator = 'PHO'
*/
insert into Item (title, description, status, discriminator, file_path, resolution_x, resolution_y, source) values
    ('RFERL photo with 12Mpx',
    '',
    'P',
    'PHO',
    'trash/1.jpg',
    3000, 4000,
    'RFERL')

insert into Item (title, description, status, discriminator, file_path, resolution_x, resolution_y, source) values
    ('RFERL photo with 12Mpx',
    '',
    'P',
    'PHO',
    'trash/1.jpg',
    3000, 4000,
    'RFERL')

insert into Item (title, description, status, discriminator, file_path, resolution_x, resolution_y, source) values
    ('RFERL photo 2 with 12Mpx',
    '',
    'P',
    'PHO',
    'trash/2.jpg',
    3000, 4000,
    'RFERL')

insert into Item (title, description, status, discriminator, file_path, resolution_x, resolution_y, source) values
    ('CRO photo with 12Mpx',
    '',
    'P',
    'PHO',
    'trash/2.jpg',
    3000, 4000,
    'CRO')    

insert into Item (title, description, status, discriminator, file_path, resolution_x, resolution_y, source) values
    ('CRO photo with 3Mpx',
    '',
    'P',
    'PHO',
    'trash/2.jpg',
    2000, 3000,
    'CRO')

/* galleries: 
delete from Item where discriminator = 'PGL'
select * from Item where discriminator = 'PGL'
*/
insert into Item (title, description, status, discriminator) values
    ('Gallery 1',
    '',
    'P',
    'PGL')

insert into Item (title, description, status, discriminator) values
    ('Gallery 2',
    '',
    'P',
    'PGL')

/* bridge photo to gallery: 
delete from Photo_Gallery
select * from Photo_Gallery
*/
insert into Photo_Gallery (photo_id, gallery_id, order_in_gallery) values (3, 8, 1)
insert into Photo_Gallery (photo_id, gallery_id, order_in_gallery) values (4, 8, 2)
insert into Photo_Gallery (photo_id, gallery_id, order_in_gallery) values (5, 8, 3)
insert into Photo_Gallery (photo_id, gallery_id, order_in_gallery) values (6, 8, 4)
insert into Photo_Gallery (photo_id, gallery_id, order_in_gallery) values (7, 8, 5)

/* videos: 
delete from Item where discriminator = 'VID'
select * from Item where discriminator = 'VID'
*/
insert into Item (title, description, status, discriminator, file_path, resolution_x, resolution_y, duration_seconds) values
    ('full HD video, 2h',
    '',
    'P',
    'VID',
    'trash/1.mkv',
    1024, 768,
    2 * 60 * 60)

insert into Item (title, description, status, discriminator, file_path, resolution_x, resolution_y, duration_seconds) values
    ('full HD video, 10m',
    '',
    'P',
    'VID',
    'trash/2.mkv',
    1024, 768,
    10 * 60)

/* audio: 
delete from Item where discriminator = 'AUD'
select * from Item where discriminator = 'AUD'
*/
insert into Item (title, description, status, discriminator, file_path, duration_seconds) values
    ('audio 2.5h',
    '',
    'P',
    'AUD',
    'trash/1.mp3',
    2.5 * 60 * 60)

insert into Item (title, description, status, discriminator, file_path, duration_seconds) values
    ('audio 15m',
    '',
    'P',
    'AUD',
    'trash/2.mp3',
    15 * 60)        

insert into Item (title, description, status, discriminator, file_path, duration_seconds) values
    ('audio 15m not in trash',
    '',
    'P',
    'AUD',
    'somewhere/1.mp3',
    15 * 60)        