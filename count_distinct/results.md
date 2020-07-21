## Count and distinct

Count(distinct) is much slower than subquery with distinct and then count.
Because count(distinct) always sort, rather that using a hash, to do its work.

On my PC count with subquery performs 8 times better.

```
INSERT 0 1000000

  SELECT COUNT(DISTINCT name)
  FROM tasks

                                                      QUERY PLAN                                                       
-----------------------------------------------------------------------------------------------------------------------
 Aggregate  (cost=50775.00..50775.01 rows=1 width=8) (actual time=1744.752..1744.752 rows=1 loops=1)
   ->  Seq Scan on tasks  (cost=0.00..43275.00 rows=3000000 width=4) (actual time=0.010..186.042 rows=3000000 loops=1)
 Planning Time: 0.195 ms
 Execution Time: 1744.824 ms
 (4 rows)


  WITH agg AS (
    SELECT DISTINCT name
    FROM tasks
    GROUP BY name
  )
  SELECT COUNT(*)
  FROM agg

                                                                          QUERY PLAN                                                                           
---------------------------------------------------------------------------------------------------------------------------------------------------------------
 Aggregate  (cost=29900.87..29900.88 rows=1 width=8) (actual time=206.032..206.032 rows=1 loops=1)
   CTE agg
     ->  Unique  (cost=29900.08..29900.80 rows=3 width=4) (actual time=206.022..206.027 rows=3 loops=1)
           ->  Group  (cost=29900.08..29900.79 rows=3 width=4) (actual time=206.022..206.026 rows=3 loops=1)
                 Group Key: tasks.name
                 ->  Gather Merge  (cost=29900.08..29900.78 rows=6 width=4) (actual time=206.021..208.786 rows=9 loops=1)
                       Workers Planned: 2
                       Workers Launched: 2
                       ->  Sort  (cost=28900.05..28900.06 rows=3 width=4) (actual time=204.659..204.660 rows=3 loops=3)
                             Sort Key: tasks.name
                             Sort Method: quicksort  Memory: 25kB
                             Worker 0:  Sort Method: quicksort  Memory: 25kB
                             Worker 1:  Sort Method: quicksort  Memory: 25kB
                             ->  Partial HashAggregate  (cost=28900.00..28900.03 rows=3 width=4) (actual time=204.644..204.645 rows=3 loops=3)
                                   Group Key: tasks.name
                                   ->  Parallel Seq Scan on tasks  (cost=0.00..25775.00 rows=1250000 width=4) (actual time=0.007..61.419 rows=1000000 loops=3)
   ->  CTE Scan on agg  (cost=0.00..0.06 rows=3 width=0) (actual time=206.023..206.029 rows=3 loops=1)
 Planning Time: 0.209 ms
 Execution Time: 208.882 ms
(19 rows)


```


## Links

https://www.postgresql.org/message-id/CAMkU%3D1wFdvb76NWVw%3DzLKF3H6-tn%3D%2Bz9o_Nv2oioWfy6Z8Xo0A%40mail.gmail.com
