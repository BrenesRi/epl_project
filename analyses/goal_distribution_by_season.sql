-- Example Analysis: Goal Distribution by Season

select
    season,
    goal_category,
    count(*) as matches_count
from {{ ref('match_goal_distribution') }}
group by season, goal_category
order by season desc, goal_category;
