-- Example Analysis: Referee Bias Visualization

select
    referee_name,
    round(home_win_pct * 100, 2) as home_win_percentage,
    round(away_win_pct * 100, 2) as away_win_percentage
from {{ ref('referee_bias') }}
order by home_win_percentage desc;
