-- models/analytics/team_win_probability.sql
with matches as (
    select *
    from {{ ref('stg_matches') }}
),

home as (
    select
        season_str as season,
        home_team as team,
        count(*) filter (where ft_result = 'H')::float / nullif(count(*), 0) as home_win_prob
    from matches
    group by season_str, home_team
),

away as (
    select
        season_str as season,
        away_team as team,
        count(*) filter (where ft_result = 'A')::float / nullif(count(*), 0) as away_win_prob
    from matches
    group by season_str, away_team
)

select
    coalesce(h.season, a.season) as season,
    coalesce(h.team, a.team) as team,
    coalesce(h.home_win_prob, 0) as home_win_prob,
    coalesce(a.away_win_prob, 0) as away_win_prob
from home h
full outer join away a
    on h.season = a.season and h.team = a.team;
