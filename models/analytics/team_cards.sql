-- models/analytics/team_cards.sql
with matches as (
    select *
    from {{ ref('stg_matches') }}
),

home_cards as (
    select
        season_str as season,
        home_team as team,
        sum(h_yellow) as yellow_cards,
        sum(h_red) as red_cards
    from matches
    group by season_str, home_team
),

away_cards as (
    select
        season_str as season,
        away_team as team,
        sum(a_yellow) as yellow_cards,
        sum(a_red) as red_cards
    from matches
    group by season_str, away_team
)

select
    coalesce(h.season, a.season) as season,
    coalesce(h.team, a.team) as team,
    coalesce(h.yellow_cards, 0) + coalesce(a.yellow_cards, 0) as yellow_cards,
    coalesce(h.red_cards, 0) + coalesce(a.red_cards, 0) as red_cards
from home_cards h
full outer join away_cards a
    on h.season = a.season
   and h.team = a.team;
