--Execute the entire process as one transaction
--Create staging table with BACKUP NO
-- Start a new transaction
BEGIN TRANSACTION;

/* Create a staging table to hold the input data. Staging table is created with BACKUP NO option for faster inserts and also data temporary */
DROP TABLE IF EXISTS stg_part;

CREATE TABLE stg_part
(
  NAME          VARCHAR(55),
  MFGR          VARCHAR(25),
  BRAND         VARCHAR(10),
  TYPE          VARCHAR(25),
  SIZE          INTEGER,
  CONTAINER     VARCHAR(10),
  RETAILPRICE   DECIMAL(18,4),
  COMMENT       VARCHAR(23)
)
BACKUP NO
;

COPY stg_part
FROM 's3://hfworkshop/packt/etl/part/dt=2020-08-15/' iam_role 'arn:aws:iam::987719398599:role/RedshiftCopyUnload' region 'us-east-1' csv gzip compupdate preset;

--Update all attributes for the existing parts

UPDATE part
SET p_mfgr = mfgr,
    p_brand = brand,
    p_type = TYPE,
    p_size = SIZE,
    p_container = container,
    p_retailprice = retailprice,
    p_comment = COMMENT
FROM stg_part
WHERE part.p_name = stg_part.name;


-- Insert new parts, by auto-generating the p_partkey

INSERT INTO part (p_partkey, p_name, p_mfgr, p_brand, p_type, p_size, p_container, p_retailprice, p_comment)
WITH max_partkey AS
  (SELECT max(p_partkey) max_partkey
   FROM part)
SELECT row_number() OVER (
                          ORDER BY stg_part.name) + max_partkey AS p_partkey,
                         name,
                         mfgr,
                         brand,
                         TYPE,
                         SIZE,
                         container,
                         retailprice,
                         COMMENT
FROM stg_part
LEFT JOIN part ON (stg_part.name = part.p_name)
JOIN max_partkey ON (1=1)
WHERE part.p_name IS NULL ;

--  commit and End transaction

END TRANSACTION;
