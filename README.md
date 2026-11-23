# Workshop Capacity and Utilization

**SQL · PostgreSQL · Relational Modeling**

A small workshop registration model and reports on capacity usage, empty sessions and workshops awaiting scheduling. The model uses six related tables. The composite registration key prevents double registration and foreign keys enforce valid relationships.

```sh
createdb workshops_demo
psql -X -v ON_ERROR_STOP=1 -d workshops_demo -f sql/setup.sql
psql -X -v ON_ERROR_STOP=1 -d workshops_demo -f sql/analytics.sql
```

The demo uses fictional records. Expected occupancy for sessions 1, 2 and 3 is full, available and empty, respectively.

Adapted from database coursework at Kyiv School of Economics.
