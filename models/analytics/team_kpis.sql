{{ config(materialized='table') }}

with matches as (
    select *
    from {{ ref('stg_matches') }}
),

home as (
    select
        season_str as season,
        home_team as team,
        avg(fth_goals) as avg_goals_for,
        avg(fta_goals) as avg_goals_against,
        avg(h_sot) as avg_shots_on_target,
        avg(h_yellow) as avg_yellow_cards,
        avg(h_red) as avg_red_cards,
        avg(h_fouls) as avg_fouls
    from matches
    group by season_str, home_team
),

away as (
    select
        season_str as season,
        away_team as team,
        avg(fta_goals) as avg_goals_for,
        avg(fth_goals) as avg_goals_against,
        avg(a_sot) as avg_shots_on_target,
        avg(a_yellow) as avg_yellow_cards,
        avg(a_red) as avg_red_cards,
        avg(a_fouls) as avg_fouls
    from matches
    group by season_str, away_team
)

select
    coalesce(h.season, a.season) as season,
    coalesce(h.team, a.team) as team,
    coalesce(h.avg_goals_for, 0) + coalesce(a.avg_goals_for, 0) as avg_goals_for,
    coalesce(h.avg_goals_against, 0) + coalesce(a.avg_goals_against, 0) as avg_goals_against,
    coalesce(h.avg_shots_on_target, 0) + coalesce(a.avg_shots_on_target, 0) as avg_shots_on_target,
    coalesce(h.avg_yellow_cards, 0) + coalesce(a.avg_yellow_cards, 0) as avg_yellow_cards,
    coalesce(h.avg_red_cards, 0) + coalesce(a.avg_red_cards, 0) as avg_red_cards,
    coalesce(h.avg_fouls, 0) + coalesce(a.avg_fouls, 0) as avg_fouls
from home h
full outer join away a
    on h.season = a.season and h.team = a.team
