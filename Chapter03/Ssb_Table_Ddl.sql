DROP TABLE IF EXISTS lineitem;
DROP TABLE IF EXISTS supplier;
DROP TABLE IF EXISTS part;
DROP TABLE IF EXISTS orders;
DROP TABLE IF EXISTS customer;
DROP TABLE IF EXISTS dwdate;
CREATE TABLE customer
(
  C_CUSTKEY      BIGINT NOT NULL,
  C_NAME         VARCHAR(25),
  C_ADDRESS      VARCHAR(40),
  C_NATIONKEY    BIGINT,
  C_PHONE        VARCHAR(15),
  C_ACCTBAL      DECIMAL(18,4),
  C_MKTSEGMENT   VARCHAR(10),
  C_COMMENT      VARCHAR(117)
)
diststyle ALL;
CREATE TABLE orders
(
  O_ORDERKEY        BIGINT NOT NULL,
  O_CUSTKEY         BIGINT,
  O_ORDERSTATUS     VARCHAR(1),
  O_TOTALPRICE      DECIMAL(18,4),
  O_ORDERDATE       DATE,
  O_ORDERPRIORITY   VARCHAR(15),
  O_CLERK           VARCHAR(15),
  O_SHIPPRIORITY    INTEGER,
  O_COMMENT         VARCHAR(79)
)
distkey (O_ORDERKEY) sortkey (O_ORDERDATE);
CREATE TABLE part
(
  P_PARTKEY       BIGINT NOT NULL,
  P_NAME          VARCHAR(55),
  P_MFGR          VARCHAR(25),
  P_BRAND         VARCHAR(10),
  P_TYPE          VARCHAR(25),
  P_SIZE          INTEGER,
  P_CONTAINER     VARCHAR(10),
  P_RETAILPRICE   DECIMAL(18,4),
  P_COMMENT       VARCHAR(23)
)
diststyle ALL;
CREATE TABLE supplier
(
  S_SUPPKEY     BIGINT NOT NULL,
  S_NAME        VARCHAR(25),
  S_ADDRESS     VARCHAR(40),
  S_NATIONKEY   BIGINT,
  S_PHONE       VARCHAR(15),
  S_ACCTBAL     DECIMAL(18,4),
  S_COMMENT     VARCHAR(101)
)
diststyle ALL;
CREATE TABLE lineitem
(
  L_ORDERKEY        BIGINT NOT NULL,
  L_PARTKEY         BIGINT,
  L_SUPPKEY         BIGINT,
  L_LINENUMBER      INTEGER NOT NULL,
  L_QUANTITY        DECIMAL(18,4),
  L_EXTENDEDPRICE   DECIMAL(18,4),
  L_DISCOUNT        DECIMAL(18,4),
  L_TAX             DECIMAL(18,4),
  L_RETURNFLAG      VARCHAR(1),
  L_LINESTATUS      VARCHAR(1),
  L_SHIPDATE        DATE,
  L_COMMITDATE      DATE,
  L_RECEIPTDATE     DATE,
  L_SHIPINSTRUCT    VARCHAR(25),
  L_SHIPMODE        VARCHAR(10),
  L_COMMENT         VARCHAR(44)
)
distkey (L_ORDERKEY) sortkey (L_RECEIPTDATE);
CREATE TABLE dwdate
(
  d_datekey            INTEGER NOT NULL,
  d_date               VARCHAR(19) NOT NULL,
  d_dayofweek          VARCHAR(10) NOT NULL,
  d_month              VARCHAR(10) NOT NULL,
  d_year               INTEGER NOT NULL,
  d_yearmonthnum       INTEGER NOT NULL,
  d_yearmonth          VARCHAR(8) NOT NULL,
  d_daynuminweek       INTEGER NOT NULL,
  d_daynuminmonth      INTEGER NOT NULL,
  d_daynuminyear       INTEGER NOT NULL,
  d_monthnuminyear     INTEGER NOT NULL,
  d_weeknuminyear      INTEGER NOT NULL,
  d_sellingseason      VARCHAR(13) NOT NULL,
  d_lastdayinweekfl    VARCHAR(1) NOT NULL,
  d_lastdayinmonthfl   VARCHAR(1) NOT NULL,
  d_holidayfl          VARCHAR(1) NOT NULL,
  d_weekdayfl          VARCHAR(1) NOT NULL
