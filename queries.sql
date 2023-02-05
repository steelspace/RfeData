/* All published photogalleries that have at least 3 published photos.
Returns all properties of the photogalley + count of published photos */

select pg.id, pg.title, pg.description, pg.status, pg.date_created, pg.publication_date, published_photo_count from Item as pg
join
(select pg.gallery_id, count(ph.id) as published_photo_count from Photo_Gallery as pg 
    join Item as ph on ph.discriminator = 'PHO'
        and pg.photo_id = ph.id and ph.status = 'P'
    group by pg.gallery_id
    having count(ph.id) > 3) 
        as relevant_photo on pg.id = relevant_photo.gallery_id
where pg.status = 'P'


/* All Videos, Audios and Photos stored in trash folder (meaning that file path starts with trash/).
Returns all common properties of Item + FilePath */
select it.id, it.title, it.description, it.status, it.date_created, it.publication_date, it.file_path
from Item it 
where it.discriminator IN ('VID', 'AUD')
    and it.file_path LIKE 'trash/%'

/* Total length of audios and videos in trash folder. */
select ISNULL(sum(it.duration_seconds) / 60.0 / 60.0, 0.0)
    as total_duration_hrs
from Item it 
where it.discriminator IN ('VID', 'AUD')
    and it.file_path LIKE 'trash/%'

/*
select ga.title, ph.title, ph.resolution_x * ph.resolution_y as mpx from Item as ga
join Photo_Gallery as pg on pg.gallery_id = ga.id 
join Item as ph on ph.discriminator = 'PHO' and pg.photo_id = ph.id
    where ga.discriminator = 'PGL'
*/