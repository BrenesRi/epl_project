{{ config(materialized='table') }}

with matches as (
    select *
    from {{ ref('stg_matches') }}
)

select
    referee_name,
    avg(h_yellow + a_yellow) as avg_yellow_cards,
    avg(h_red + a_red)       as avg_red_cards,
    count(*)                 as total_matches
from matches
where referee_name is not null
group by referee_name
