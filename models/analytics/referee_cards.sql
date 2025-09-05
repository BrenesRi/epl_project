-- models/analytics/referee_cards.sql
with matches as (
    select *
    from {{ ref('stg_matches') }}
)

select
    referee_name,
    avg(h_yellow + a_yellow) as avg_yellow_cards,
    avg(h_red + a_red) as avg_red_cards
from matches
group by referee_name;
