---
title: "Data Engineering Coursework Roundup"
date: 2024-06-15
permalink: /posts/2024/06/data-engineering-coursework/
tags:
  - data engineering
  - python
  - pipelines
---

## Why this coursework still matters

While the site mostly showcases research, a large portion of my recent upskilling has been rooted in pragmatic data engineering. The projects below capture how I combined airflow orchestration, Python scripting, and analytics-ready datasets to keep my portfolio fresh.

## Modules and representative projects

### ETL pipelines
- **Tabular-to-Markdown automation** &mdash; the `markdown_generator/publications.py` script uses Pandas-powered transforms to sanitize TSV metadata and load it into `_publications/` as publishable Markdown. Recreating this pipeline in class highlighted CSV ingestion gotchas, YAML escaping, and how to validate row-level schema drift before writing downstream files.
- **Talk archive normalization** &mdash; in `markdown_generator/talks.py`, the coursework exercise paralleled building resilient extraction code that enforces unique slugs, adds type defaults, and routes clean records into `_talks/` for the website.

### Database modeling and storage
- **Content catalog prototyping** &mdash; we leaned on lightweight SQLite mirrors of the `_data/navigation.yml` structure to test hierarchical menus before publishing. Practicing schema migrations and snapshotting with Alembic carried over to handling real PostgreSQL deployments.
- **Portfolio asset indexing** &mdash; synthesizing metadata from `_portfolio/` into relational tables let us experiment with query patterns (window functions for ordering, JSON aggregation for tags) that later informed live dashboards.

### Analytics scripting
- **Bulk Markdown QA** &mdash; notebooks in `markdown_generator/publications.ipynb` and `talks.ipynb` became the staging ground for Pandas profiling, enabling us to surface missing citations, out-of-range dates, and duplicate venues.
- **Geo storytelling** &mdash; `talkmap/talkmap.py` demonstrated how GeoJSON outputs can be batched from cleaned talk metadata, reinforcing lessons on coordinate validation and data export testing.

## Architecture & tooling

![Coursework data platform architecture]({{ '/images/data-engineering-coursework-architecture.svg' | relative_url }})

Key technologies we relied on:

- **Airflow** for orchestrating nightly refreshes and orchestrating notebook renders.
- **Pandas** and **Great Expectations** for dataframe transformations plus data quality gates.
- **SQL (SQLite/PostgreSQL)** accessed through SQLAlchemy migrations to practice schema evolution.
- **dbt** for modeling curated marts, with docs hosted alongside `_publications/` outputs.
- **Docker Compose** sandboxes to spin up local schedulers, warehouses, and monitoring sidecars.

## Lessons learned & next steps

1. **Observability should be designed, not bolted on.** Tracking data freshness and Airflow DAG SLAs upfront prevented blind spots once pipelines ran nightly.
2. **Schema contracts unlock collaboration.** Having shared YAML/TSV contracts between the `markdown_generator/` scripts and SQL tables made it easier to parallelize course projects.
3. **Analytics-ready layers accelerate storytelling.** Because dbt models and Pandas notebooks reused the same curated tables, I could ship dashboards and written summaries in tandem.

Next, I am porting the markdown automation into a hosted Airflow environment, experimenting with DuckDB for local prototyping, and expanding Great Expectations suites to cover the `_publications/` and `_talks/` collections end-to-end.
