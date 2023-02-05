/*
Delete all 2-word (space-separated) tags for which 2-word (dash-separated) counterpart exists. 
Make sure that in case an item used the space- separated version, 
    it will now use the dash-separated version. 
Write selects to run before and after your changes,
    to verity that the operation has been successful.
I.e. if there is tag "human rights" and there's also tag "human-rights" all items 
    having tag "human rights" will now have tag "human-rights" and tag "human rights" will be deleted.
*/

select item.id, item.title, spaced.tspace_name, spaced.tdash_name from Item item
inner join Item_Tag it on it.item_id = item.id
inner join (
    select tspace.id as tspace_id, tdash.id as tdash_id,
        tspace.name as tspace_name, tdash.name as tdash_name from Tag tspace
    join Tag tdash on REPLACE(tdash.name, '-', ' ') = tspace.name
    where len(tdash.name) - len(replace(tdash.name, '-', '')) = 1) spaced
    on spaced.tspace_id = it.tag_id

begin transaction

update it
set it.tag_id = 2
from Item_Tag it 
select * from Tag tspace
join Tag tdash on REPLACE(tdash.name, '-', ' ') = tspace.name
where len(tdash.name) - len(replace(tdash.name, '-', '')) = 1

rollback