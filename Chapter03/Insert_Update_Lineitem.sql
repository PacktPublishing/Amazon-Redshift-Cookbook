-- Start a new transaction
BEGIN TRANSACTION;

-- Drop stg_lineitem if exists

DROP TABLE IF EXISTS stg_lineitem;

-- Create a stg_lineitem staging table and COPY data from input S3 location with the refreshed incremental data

CREATE TABLE stg_lineitem
(
  orderkey        BIGINT,
  LINENUMBER      INTEGER NOT NULL,
  QUANTITY        DECIMAL(18,4),
  EXTENDEDPRICE   DECIMAL(18,4),
  DISCOUNT        DECIMAL(18,4),
  TAX             DECIMAL(18,4),
  RETURNFLAG      VARCHAR(1),
  LINESTATUS      VARCHAR(1),
  SHIPDATE        DATE,
  COMMITDATE      DATE,
  RECEIPTDATE     DATE,
  SHIPINSTRUCT    VARCHAR(25),
  SHIPMODE        VARCHAR(10),
  COMMENT VARCHAR(44),
  p_name          VARCHAR(55),
  s_name          VARCHAR(25)
)
BACKUP NO sortkey (RECEIPTDATE);                                                                                                                                                                                                             s_name varchar(25)) BACKUP NO sortkey (receiptdate);

COPY stg_lineitem
FROM 's3://hfworkshop/packt/etl/lineitem/shipdate_dt=2020-08-15/' iam_role 'arn:aws:iam::987719398599:role/RedshiftCopyUnload' region 'us-east-1' csv gzip compupdate preset;


SELECT *
FROM stg_lineitem
LIMIT 10
SELECT l_linenumber,
       l_quantity,
       l_extendedprice,
       l_discount,
       l_tax,
       l_returnflag,
       l_linestatus,
       l_shipdate,
       l_commitdate,
       l_receiptdate,
       l_shipinstruct,
       l_shipmode,
       l_comment
FROM stg_lineitem
LIMIT 5
SELECT l_shipdate,
       count(1)
FROM stg_lineitem
GROUP BY l_shipdate

-- Delete any rows from target store_sales for the input date for idempotency

DELETE
FROM lineitem
WHERE l_receiptdate = '2020-10-15';

--Insert data from staging table to the target TABLE

INSERT INTO lineitem (l_orderkey, l_partkey, l_suppkey, l_linenumber, l_quantity, l_extendedprice, l_discount, l_tax, l_returnflag, l_linestatus, l_shipdate, l_commitdate, l_receiptdate, l_shipinstruct, l_shipmode, l_comment) WITH supplier_dim AS
  (SELECT DISTINCT s_name,
                   s_suppkey
   FROM supplier),
                                                                                                                                                                                                                                       part_dim AS
  (SELECT DISTINCT p_name,
                   p_partkey
   FROM part)
SELECT orderkey AS l_orderkey,
       p_partkey AS l_partkey,
       s_suppkey AS l_suppkey,
       linenumber AS l_linenumber,
       quantity AS l_quantity,
       extendedprice AS l_extendedprice,
       discount AS l_discount,
       tax AS l_tax,
       returnflag AS l_returnflag,
       linestatus AS l_linestatus,
       shipdate AS l_shipdate,
       commitdate AS l_commitdate,
       receiptdate AS l_receiptdate,
       shipinstruct AS l_shipinstruct,
       shipmode AS l_shipmode,
       COMMENT AS l_comment
FROM stg_lineitem stg --JOIN dwdate ON d_date = receiptdate
LEFT OUTER JOIN part_dim prt ON prt.p_name = stg.p_name
LEFT OUTER JOIN supplier_dim sup ON sup.s_name = stg.s_name;

--drop staging table

DROP TABLE IF EXISTS stg_lineitem;

-- End transaction and commit
END TRANSACTION;
