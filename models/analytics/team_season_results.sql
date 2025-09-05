{{ config(materialized='table') }}

with matches as (
    select *
    from {{ ref('stg_matches') }}
),

results as (
    -- Home matches
    select
        home_team as team,
        season_str as season,
        sum(case when ft_result = 'H' then 1 else 0 end) as wins,
        sum(case when ft_result = 'D' then 1 else 0 end) as draws,
        sum(case when ft_result = 'A' then 1 else 0 end) as losses
    from matches
    group by home_team, season_str

    union all

    -- Away matches
    select
        away_team as team,
        season_str as season,
        sum(case when ft_result = 'A' then 1 else 0 end) as wins,
        sum(case when ft_result = 'D' then 1 else 0 end) as draws,
        sum(case when ft_result = 'H' then 1 else 0 end) as losses
    from matches
    group by away_team, season_str
),

aggregated as (
    select
        team,
        season,
        sum(wins) as wins,
        sum(draws) as draws,
        sum(losses) as losses
    from results
    group by team, season
)

select
    team,
    season,
    -- numeric year to allow proper sorting in Power BI
    cast(left(season, 4) as int) as season_start_year,
    season as season_display,
    wins,
    draws,
    losses
from aggregated
