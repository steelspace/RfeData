/*
Delete all 2-word (space-separated) tags for which 2-word (dash-separated) counterpart exists. 
Make sure that in case an item used the space- separated version, 
    it will now use the dash-separated version. 
Write selects to run before and after your changes,
    to verity that the operation has been successful.
I.e. if there is tag "human rights" and there's also tag "human-rights" all items 
    having tag "human rights" will now have tag "human-rights" and tag "human rights" will be deleted.
*/

drop table IF EXISTS #replaced_tags

/* map of replacement */ 
select item.id, item.title, 
    spaced.tspace_id, spaced.tspace_name,
    spaced.tdash_id, spaced.tdash_name
into #replaced_tags
    from Item item
inner join Item_Tag it on it.item_id = item.id
inner join (
    select tspace.id as tspace_id, tdash.id as tdash_id,
        tspace.name as tspace_name, tdash.name as tdash_name from Tag tspace
    join Tag tdash on REPLACE(tdash.name, '-', ' ') = tspace.name
    where LEN(tdash.name) - LEN(REPLACE(tdash.name, '-', '')) = 1) spaced
    on spaced.tspace_id = it.tag_id

/* current state */ 
select id, title, tspace_name from #replaced_tags
select name from Tag

begin transaction

update it
set it.tag_id = dashed.tdash_id
from Item_Tag it 
inner join 
(
    select spaced.tspace_id, spaced.tdash_id from Item item
        inner join Item_Tag it on it.item_id = item.id
        inner join (
        select tspace.id as tspace_id, tdash.id as tdash_id,
            tspace.name as tspace_name, tdash.name as tdash_name from Tag tspace
        join Tag tdash on REPLACE(tdash.name, '-', ' ') = tspace.name
    where LEN(tdash.name) - LEN(REPLACE(tdash.name, '-', '')) = 1) spaced
    on spaced.tspace_id = it.tag_id
) dashed 
    on dashed.tspace_id = it.tag_id

/* new state with replaced tags */
select item.id, item.title, tg.name
from #replaced_tags ri
inner join Item item on item.id = ri.id
inner join Item_Tag it on it.item_id = item.id
inner join Tag tg on tg.id = it.tag_id and tg.id = ri.tdash_id

delete from Tag
    where exists (select tspace_id from #replaced_tags where tspace_id = Tag.id)

/* tags without deleted ones */
select name from Tag

rollback