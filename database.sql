CREATE TABLE Category (
    id INT IDENTITY(1,1) NOT NULL,
    name VARCHAR(255) NOT NULL,
    status INT NOT NULL,
    CONSTRAINT PK_Category PRIMARY KEY CLUSTERED (id)
);

CREATE TABLE Item (
    id INT IDENTITY(1,1) NOT NULL,
    title NVARCHAR(128) NOT NULL,
    description NVARCHAR(255) NOT NULL,
    status VARCHAR(1) NOT NULL,
    date_created DATETIME2 DEFAULT GETDATE() NOT NULL,
    publication_date DATETIME2 NULL,
    discriminator NVARCHAR(3) NOT NULL,
    text NTEXT NULL,
    duration_seconds NUMERIC(8,1) NULL,
    file_path NVARCHAR(255) NULL,
    resolution_x INT NULL,
    resolution_y INT NULL,
    source VARCHAR(20) NULL,
    CONSTRAINT check_discriminator CHECK (discriminator IN ('ART', 'VID', 'AUD', 'PGL', 'PHO')),
    CONSTRAINT check_status CHECK (status IN ('D', 'P', 'A')),
    CONSTRAINT PK_Item PRIMARY KEY CLUSTERED (id)
);

CREATE NONCLUSTERED INDEX idx_file_path ON Item(file_path) WHERE file_path IS NOT NULL

CREATE TABLE Tag (
    id INT IDENTITY(1,1) NOT NULL,
    name NVARCHAR(100) NOT NULL,
    CONSTRAINT PK_Tag PRIMARY KEY CLUSTERED (id)
);

/* bridge tables */

CREATE TABLE Photo_Gallery (
    photo_id INT NOT NULL,
    gallery_id INT NOT NULL,
    order_in_gallery INT NOT NULL,
    CONSTRAINT PK_Photo_Gallery PRIMARY KEY CLUSTERED (photo_id, gallery_id, order_in_gallery),
    CONSTRAINT FK_pg_photo FOREIGN KEY (photo_id) REFERENCES Item (id),
    CONSTRAINT FK_pg_gallery FOREIGN KEY (gallery_id) REFERENCES Item (id)
)

CREATE TABLE Item_Category (
    item_id INT NOT NULL,
    category_id INT NOT NULL,
    CONSTRAINT PK_Item_Category PRIMARY KEY CLUSTERED (item_id, category_id),
    CONSTRAINT FK_ct_item FOREIGN KEY (item_id) REFERENCES Item (id),
    CONSTRAINT FK_ct_category FOREIGN KEY (category_id) REFERENCES Category (id)
)

CREATE TABLE Item_Tag (
    item_id INT NOT NULL,
    tag_id INT NOT NULL,
    CONSTRAINT PK_Item_Tag PRIMARY KEY CLUSTERED (item_id, tag_id),
    CONSTRAINT FK_it_item FOREIGN KEY (item_id) REFERENCES Item (id),
    CONSTRAINT FK_it_tag FOREIGN KEY (tag_id) REFERENCES Tag (id)
)

/*
drop table Photo_Gallery
drop table Item_Category
drop table Item_Tag
drop table Category 
drop table Item
drop table Tag
*/

