-- models/analytics/team_fouls_results.sql
with matches as (
    select *
    from {{ ref('stg_matches') }}
),

home as (
    select
        season_str as season,
        home_team as team,
        case
            when ft_result = 'H' then 'Win'
            when ft_result = 'D' then 'Draw'
            else 'Loss'
        end as result,
        avg(h_fouls) as avg_fouls
    from matches
    group by season_str, home_team, ft_result
),

away as (
    select
        season_str as season,
        away_team as team,
        case
            when ft_result = 'A' then 'Win'
            when ft_result = 'D' then 'Draw'
            else 'Loss'
        end as result,
        avg(a_fouls) as avg_fouls
    from matches
    group by season_str, away_team, ft_result
)

select * from home
union all
select * from away;
