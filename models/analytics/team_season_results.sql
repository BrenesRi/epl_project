-- models/analytics/team_season_results.sql
with matches as (
    select *
    from {{ ref('stg_matches') }}
),

results as (
    select
        home_team as team,
        season_str as season,
        sum(case when ft_result = 'H' then 1 else 0 end) as wins,
        sum(case when ft_result = 'D' then 1 else 0 end) as draws,
        sum(case when ft_result = 'A' then 1 else 0 end) as losses
    from matches
    group by home_team, season_str

    union all

    select
        away_team as team,
        season_str as season,
        sum(case when ft_result = 'A' then 1 else 0 end) as wins,
        sum(case when ft_result = 'D' then 1 else 0 end) as draws,
        sum(case when ft_result = 'H' then 1 else 0 end) as losses
    from matches
    group by away_team, season_str
)

select
    team,
    season,
    sum(wins) as wins,
    sum(draws) as draws,
    sum(losses) as losses
from results
group by team, season
