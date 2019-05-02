# Diagnosing postgresql problems

## Instrumentation
It helps to have a good picture of what is going on with the database before diving into details.  
Two recommendations are:
1.  Install some sort of monitoring software which has a postgres plugin.  Munin works great for this (some configuration issues with pg 11).
2.  Set "log_min_duration_statement" in your postgresql log to some value like 1 minute (60000) to log if you are getting any really bad queries.  Note that you can change this value without having to restart database.  Just a reload will do.

Two things to be cautious about are:
1.  Be careful if you set the value too low as your db performance will suffer as huge amounts are logged to disk. Setting to 0 logs everything.  There might be some cases you want to do this but for a very short time (eg. a minute or two).
2.  Be careful if you have tracker data as you find identifiable information gets leaked into the log.  You should only log statements for a short time and examine carefully.

(Note that it is also useful to instrument proxy server by capturing request times into a performance log)

## Useful diagnostic queries
1.  Looking at those long queries from the log:
```
grep duration postgres.log | less
```

2.  Checking for deadlocks
```
grep deadlock postgres.log | less
```

3.  Looking at the pg_stats_query table
```
select pid,xact_start-now() xact_time ,query_start-now() query_time, query, state 
  from pg_stat_activity where state != 'idle' 
  order by xact_start-now();
```
Note that this is really useful information to capture before restarting a dead tomcat.

4. The pg_locks view contains information about locks held by processes.  The following query
(from postgresql.org wiki) gives information about any processes which are waiting for a locks
which is held by another transaction: 
```
SELECT blocked_locks.pid     AS blocked_pid,
         blocked_activity.usename  AS blocked_user,
         blocking_locks.pid     AS blocking_pid,
         blocking_activity.usename AS blocking_user,
         blocked_activity.query    AS blocked_statement,
         blocking_activity.query   AS current_statement_in_blocking_process
   FROM  pg_catalog.pg_locks         blocked_locks
    JOIN pg_catalog.pg_stat_activity blocked_activity  ON blocked_activity.pid = blocked_locks.pid
    JOIN pg_catalog.pg_locks         blocking_locks 
        ON blocking_locks.locktype = blocked_locks.locktype
        AND blocking_locks.DATABASE IS NOT DISTINCT FROM blocked_locks.DATABASE
        AND blocking_locks.relation IS NOT DISTINCT FROM blocked_locks.relation
        AND blocking_locks.page IS NOT DISTINCT FROM blocked_locks.page
        AND blocking_locks.tuple IS NOT DISTINCT FROM blocked_locks.tuple
        AND blocking_locks.virtualxid IS NOT DISTINCT FROM blocked_locks.virtualxid
        AND blocking_locks.transactionid IS NOT DISTINCT FROM blocked_locks.transactionid
        AND blocking_locks.classid IS NOT DISTINCT FROM blocked_locks.classid
        AND blocking_locks.objid IS NOT DISTINCT FROM blocked_locks.objid
        AND blocking_locks.objsubid IS NOT DISTINCT FROM blocked_locks.objsubid
        AND blocking_locks.pid != blocked_locks.pid
 
    JOIN pg_catalog.pg_stat_activity blocking_activity ON blocking_activity.pid = blocking_locks.pid
   WHERE NOT blocked_locks.GRANTED;
   ``` 
   