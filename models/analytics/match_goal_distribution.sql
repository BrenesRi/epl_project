-- models/analytics/match_goal_distribution.sql
with matches as (
    select *
    from {{ ref('stg_matches') }}
)

select
    match_date,
    season_str as season,
    home_team,
    away_team,
    (fth_goals + fta_goals) as total_goals,
    case
        when (fth_goals + fta_goals) = 0 then '0'
        when (fth_goals + fta_goals) = 1 then '1'
        when (fth_goals + fta_goals) = 2 then '2'
        else '3+'
    end as goal_category
from matches;
