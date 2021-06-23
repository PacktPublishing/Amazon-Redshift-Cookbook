import os
import json
import psycopg2
import redis
import hashlib

class DB:
    def __init__(self, **params):
       # params.setdefault("charset", "utf8mb4")
        #params.setdefault("cursorclass", pyredshift.cursors.DictCursor)

        self.redshiftsql = psycopg2.connect(**params)

    def query(self, sql):
        with self.redshiftsql.cursor() as cursor:
            cursor.execute(sql)
            return cursor.fetchall()

    def record(self, sql):
        with self.redshiftsql.cursor() as cursor:
            cursor.execute(sql)
            return cursor.fetchone()

    def closecur(self):
        self.redshiftsql.close()

# Time to live for cached data
TTL = 180

# Read the Redis credentials from the REDIS_URL environment variable.
REDIS_URL = os.environ.get('REDIS_URL')

# Read the DB credentials from the DB_* environment variables.
DB_HOST = os.environ.get('DB_HOST')
DB_USER = os.environ.get('DB_USER')
DB_PASS = os.environ.get('DB_PASS')
DB_NAME = os.environ.get('DB_NAME')
DB_PORT = os.environ.get('DB_PORT')

# Initialize the database
Database = DB(host=DB_HOST, user=DB_USER, password=DB_PASS, dbname=DB_NAME,port=DB_PORT )

# Initialize the cache
Cache = redis.Redis.from_url(REDIS_URL)


def fetch(sql):
    """Retrieve records from the cache, or else from the database."""
    key =  hashlib.sha224(sql).hexdigest()
    res = Cache.get(key)

    print(key)
    if res:
        print('returning from cache')
        return json.loads(res)

    res = Database.query(sql)
    print('setting key in the cache')
    Cache.setex(key, TTL, json.dumps(res))
    Database.closecur()
    print('testing the existence of key in cache')
    test(key)
    return res

def test(key):
    print(' ')
    print('--------------------from cache-------------')
    return (Cache.get(key))

##Display the result of some queries
print(fetch("SELECT product_title,SUM(total_votes) FROM product_reviews WHERE product_category = 'Apparel' GROUP BY product_title ORDER BY SUM(total_votes) DESC LIMIT 10;"))
print(fetch("SELECT product_title,SUM(total_votes) FROM product_reviews WHERE product_category = 'Apparel' GROUP BY product_title ORDER BY SUM(total_votes) DESC LIMIT 10;"))
Cache.flushall()
