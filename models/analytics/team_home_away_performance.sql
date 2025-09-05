{{ config(materialized='table') }}

with matches as (
    select *
    from {{ ref('stg_matches') }}

),

home_results as (

    select
        season_str,
        home_team as team,
        count(*) filter (where fth_goals > fta_goals) as home_wins,
        count(*) filter (where fth_goals = fta_goals) as home_draws,
        count(*) filter (where fth_goals < fta_goals) as home_losses,
        count(*) as total_home_matches
    from matches
    group by season_str, home_team

),

away_results as (

    select
        season_str,
        away_team as team,
        count(*) filter (where fta_goals > fth_goals) as away_wins,
        count(*) filter (where fta_goals = fth_goals) as away_draws,
        count(*) filter (where fta_goals < fth_goals) as away_losses,
        count(*) as total_away_matches
    from matches
    group by season_str, away_team

),

combined as (

    select
        coalesce(h.season_str, a.season_str) as season_str,
        coalesce(h.team, a.team) as team,
        coalesce(h.home_wins, 0) as home_wins,
        coalesce(h.home_draws, 0) as home_draws,
        coalesce(h.home_losses, 0) as home_losses,
        coalesce(h.total_home_matches, 0) as total_home_matches,
        coalesce(a.away_wins, 0) as away_wins,
        coalesce(a.away_draws, 0) as away_draws,
        coalesce(a.away_losses, 0) as away_losses,
        coalesce(a.total_away_matches, 0) as total_away_matches
    from home_results h
    full outer join away_results a
        on h.season_str = a.season_str
       and h.team = a.team

)

select
    season_str,
    team,
    coalesce(home_wins, 0) as home_wins,
    coalesce(home_draws, 0) as home_draws,
    coalesce(home_losses, 0) as home_losses,
    coalesce(total_home_matches, 0) as total_home_matches,
    coalesce(away_wins, 0) as away_wins,
    coalesce(away_draws, 0) as away_draws,
    coalesce(away_losses, 0) as away_losses,
    coalesce(total_away_matches, 0) as total_away_matches,
    coalesce(home_wins::float / nullif(total_home_matches, 0), 0) as home_win_pct,
    coalesce(away_wins::float / nullif(total_away_matches, 0), 0) as away_win_pct
from combined
