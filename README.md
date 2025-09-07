# Premier League Transformations Project

## Overview

This project analyzes and transforms English Premier League (EPL) football data using [dbt (data build tool)](https://www.getdbt.com/). It provides a robust analytics layer for match results, team performance, referee statistics, and more, enabling advanced reporting and visualization (e.g., in Power BI).

## What Does This Project Do?

- **Transforms raw EPL match data** into clean, analytics-ready tables.
- **Calculates key metrics**: team KPIs, win probabilities, card/foul stats, referee bias, goal distributions, and more.
- **Implements rigorous data testing** to ensure data quality and reliability.
- **Supports downstream analytics and BI tools** for deep football insights.

## Project Structure

- `models/analytics/`: Core analytical models (SQL) for team, match, and referee analysis.
- `models/staging/`: Staging models that clean and standardize raw data sources.
- `models/analytics/schema.yml`: Documentation and tests for each analytical model.
- `macros/`: Custom dbt macros for reusable logic and tests.
- `seeds/`, `snapshots/`, `analyses/`: Additional dbt features for data management.
- `dbt_project.yml`: Main dbt configuration file.

## What is dbt?

**dbt (data build tool)** is an open-source framework for transforming data in your warehouse using SQL. It enables analytics engineers to:

- **Write modular SQL models** that build on each other.
- **Test data quality** with built-in and custom tests.
- **Document data models** for transparency and collaboration.
- **Version control transformations** using Git.
- **Automate and orchestrate pipelines** with simple commands.

### Key Advantages of dbt

- **Modularity**: Build complex logic from simple, reusable models.
- **Testing**: Catch data issues early with schema and data tests (e.g., uniqueness, accepted ranges).
- **Documentation**: Auto-generate docs from YAML and SQL files.
- **Lineage Tracking**: Visualize how data flows from source to final tables.
- **Collaboration**: Integrates with Git for team workflows.
- **Materializations**: Choose how models are built (views, tables, incremental, ephemeral).

## How dbt is Used in This Project

- **Sources**: Defined in `models/staging/sources.yml` to connect to raw EPL match data.
- **Staging Models**: Clean and standardize raw data (`stg_matches.sql`).
- **Analytics Models**: Calculate advanced metrics (e.g., team KPIs, win probabilities, referee bias) in `models/analytics/`.
- **Schema & Data Tests**: YAML files (e.g., `schema.yml`) specify tests for uniqueness, accepted ranges, not-null, and more, using [dbt-utils](https://github.com/dbt-labs/dbt-utils).
- **Materializations**: Models are built as tables or views for performance and flexibility.

## Example Analytical Models

- **Team KPIs**: Average goals, cards, fouls per team/season.
- **Win Probability**: Home/away win rates for each team.
- **Referee Bias**: Home/away win percentages by referee.
- **Goal Distribution**: Categorizes matches by total goals scored.
- **Team Cards/Fouls**: Aggregates disciplinary stats by team and result.

## How to Run

1. Install dbt and dependencies (see dbt docs).
2. Configure your profile and connection in `dbt_project.yml` and `profiles.yml`.
3. Run transformations:
   - `dbt run` — Build models.
   - `dbt test` — Run data tests.
   - `dbt docs generate && dbt docs serve` — View documentation.

## Learn More

- [dbt Documentation](https://docs.getdbt.com/docs/introduction)
- [dbt Discourse](https://discourse.getdbt.com/)
- [dbt Community Slack](https://community.getdbt.com/)
- [dbt Events](https://events.getdbt.com)
- [dbt Blog](https://blog.getdbt.com/)

---

*This project enables deep, reliable analysis of Premier League football data using modern analytics engineering best practices with dbt.*
