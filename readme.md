# Articles Database

## Decision Process
As the specification suggests, there is a certain degree of inheritance between items. There are 4 ways to implement such structure:
1. Single table inheritance
2. Concrete table inheritance
3. Class table inheritance
4. Entity-Attribute-Value

Because 4 is considered an antipattern with many disadvantages, I decided to go with 1.
There is only one table holding all kinds of items divided by discriminator value and most of columns are shared with all types of items.

Pros:
- Simple schema
- Good performance
- Simple queries
- All in all it is [KISS](https://en.wikipedia.org/wiki/KISS_principle) and [DRY](https://en.wikipedia.org/wiki/Don%27t_repeat_yourself) :)

Cons:
- NOT NULL constrains are not available for uncommon columns
- Adding new item types is problematic

## Considerations
- I did not provide premature optimization, execution plan analysis will be provided with bigger data seed
- queries can be improved in script but I understood a task so that it should be a single query
- physical deletion of any data (such as categories) is questionable - category has state, so I deactivated them instead

## How it works
The scripts are tested on MS SQL Azure with compatibility level 16.
It is written as generically as possible.

1. `database.sql` - creates schema (tables, constraints)
2. `seed.sql` - creates data for testing. It can be run only once and only on top of an empty tables because reference IDs are hardcoded.
3. `queries.sql` - task with querying
4. `cat-merge.sql` - category merging task
5. `tags.sql` - tags consolidation task

## Possible Improvements
### Localization / globalozation
- multi-language -> all texts/media can have multiple language versions
- categories in mulptiple languages
- tags in mulptiple languages
- consider timezone, local time, UTC?

### Logical
- order of photos should be unique?
- video should have source too?
- set unique constraints on tag and category names -> depends on use cases

### Performance
- partition data using created date to offload old articles
- prepare views based on discriminator for different types of articles
- for /trash folder it makes sense to calculate field on insert/update if this is common use case
- with more types of items coming, using some document database should be considered instead of the relational one
