{{ config(materialized='table') }}

with matches as (
    select *
    from {{ ref('stg_matches') }}
),

agg as (
    select
        referee_name,
        count(*) filter (where ft_result = 'H')::float as home_wins,
        count(*) filter (where ft_result = 'A')::float as away_wins,
        count(*) as total_matches
    from matches
    where referee_name is not null
    group by referee_name
)

select
    referee_name,
    home_wins / nullif(total_matches, 0) as home_win_pct,
    away_wins / nullif(total_matches, 0) as away_win_pct,
    total_matches
from agg
