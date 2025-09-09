-- models/analytics/team_fouls_vs_winrate.sql
{{ config(materialized='table') }}

with matches as (
    select *
    from {{ ref('stg_matches') }}
),

-- Poner cada partido desde la perspectiva del equipo
team_match as (
    -- perspectiva local
    select
        season_str as season,
        home_team   as team,
        h_fouls     as fouls,
        case when ft_result = 'H' then 1 else 0 end as is_win
    from matches

    union all

    -- perspectiva visitante
    select
        season_str as season,
        away_team   as team,
        a_fouls     as fouls,
        case when ft_result = 'A' then 1 else 0 end as is_win
    from matches
),

agg as (
    select
        season,
        team,
        count(*)                         as matches_played,
        avg(fouls)                       as avg_fouls,
        sum(is_win)                      as wins
    from team_match
    group by season, team
)

select
    season,
    team,
    matches_played,
    avg_fouls,
    wins,
    (wins::float / nullif(matches_played, 0)) as win_rate
from agg
