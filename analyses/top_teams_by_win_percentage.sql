-- Example Analysis: Top Performing Teams by Win Percentage

with team_performance as (
    select
        team,
        season,
        (wins::float / nullif((wins + draws + losses), 0)) as win_pct
    from {{ ref('team_season_results') }}
)

select
    team,
    season,
    round(win_pct * 100, 2) as win_percentage
from team_performance
order by win_percentage desc, season desc
limit 10;
