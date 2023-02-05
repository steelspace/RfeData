/* All published photogalleries that have at least 3 published photos.
Returns all properties of the photogalley + count of published photos */
select pg.id, pg.title, pg.description, pg.status, pg.date_created, pg.publication_date, published_photo_count from Item as pg
join
(select pg.gallery_id, count(ph.id) as published_photo_count from Photo_Gallery pg 
    join Item ph on ph.discriminator = 'PHO'
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
    as total_trash_media_duration_hrs
from Item it 
where it.discriminator IN ('VID', 'AUD')
    and it.file_path LIKE 'trash/%'

/* All photos with more than 10 megapixels which have source "RFERL" or tag "Citizen Journalism" */
select ph.id, ph.source, ph.resolution_x * ph.resolution_y as resolution from Item ph
where ph.discriminator = 'PHO'
    and ph.resolution_x * ph.resolution_y > 10000000
    and (source = 'RFERL' or exists (
        select it.item_id from Item_Tag it
        join Tag tg on tg.id = it.tag_id
        where it.item_id = ph.id and tg.name = 'citizen journalism'
    ))
