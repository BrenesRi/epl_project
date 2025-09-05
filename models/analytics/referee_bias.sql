{{ config(materialized='table') }}

with matches as (
    select *
    from {{ ref('stg_matches') }}
)

select
    referee_name,
    count(*) filter (where ft_result = 'H')::float / nullif(count(*), 0) as home_win_pct,
    count(*) filter (where ft_result = 'A')::float / nullif(count(*), 0) as away_win_pct
from matches
group by referee_name
