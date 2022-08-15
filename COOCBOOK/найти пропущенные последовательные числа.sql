SELECT id+1 as start_interval, next_id-1 as finish_interval
FROM(
  SELECT id, LEAD(id)OVER(ORDER BY id)as next_id
  FROM mia_h2_cl_global
)T
WHERE id+1 <> next_id

-- дополнить генерацией последовательностей
--fff

