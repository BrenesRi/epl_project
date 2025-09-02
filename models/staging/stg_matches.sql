with raw as (

    select
        match_date::date as match_date,
        season_str,
        trim(home_team) as home_team,
        trim(away_team) as away_team,
        fth_goals,
        fta_goals,
        upper(ft_result) as ft_result,
        hth_goals,
        hta_goals,
        upper(ht_result) as ht_result,
        trim(referee_name) as referee_name,
        h_shots,
        a_shots,
        h_sot,
        a_sot,
        h_fouls,
        a_fouls,
        h_corners,
        a_corners,
        h_yellow,
        a_yellow,
        h_red,
        a_red,
        display_order,
        trim(league_name) as league_name
    from {{ source('premier_league', 'raw_matches') }}

)

select * from raw