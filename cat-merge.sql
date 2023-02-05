/*
Write a script which will merge Categories "User Content" and "User Upload" into a new category "Citizen Journalism" 
(i.e. all items from "User Content" 
    and "User Upload" categories will go to category "Citizen Journalism"
    and than the categories "User Content" and "User Upload" will be deleted.
*/

/* check current state */
select it.title, ca.name from Item it
join Item_Category ic on ic.item_id = it.id
join Category ca on ca.id = ic.category_id
where ca.name in ('User Content', 'User Upload', 'Citizen Journalism')

select id, name, status from Category

/* determine cat. ids */
declare @user_content_id INT
select @user_content_id = id from Category
where name = 'User Content'

declare @user_upload_id INT
select @user_upload_id = id from Category
where name = 'User Upload'

declare @user_cjournalism_id INT
select @user_cjournalism_id = id from Category
where name = 'Citizen Journalism'

begin transaction

/* >>>> SOLUION START */

/* replace categories */
update Item_Category
set category_id = @user_cjournalism_id
where category_id IN (@user_content_id, @user_upload_id)

/* don't delete, deactivate */
update Category
set status = 0
where id in (@user_upload_id, @user_content_id)

/* >>>> SOLUION END */

/* check state after update */
select it.title, ca.name from Item it
join Item_Category ic on ic.item_id = it.id
join Category ca on ca.id = ic.category_id
where ca.name in ('User Content', 'User Upload', 'Citizen Journalism')

/* outdated cats deactivated */
select id, name, status from Category

/* to be able to repeat the script for testing */
rollback
