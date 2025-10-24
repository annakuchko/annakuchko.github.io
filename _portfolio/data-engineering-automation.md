---
title: "Data Engineering Coursework Automation"
excerpt: "Airflow-ready pipelines that keep publications, talks, and portfolio data in sync."
collection: portfolio
---

## Overview

This coursework series hardened the internal data platform that powers the site. Airflow DAGs, dbt models,
and validation suites orchestrate everything from publication imports to geo-enabled talk maps. The work
translates classroom exercises into production-ready hygiene for personal research assets.

### Applications & Use Cases

- **Academic websites** that need dependable refreshes of publications, teaching logs, and talks.
- **Analytics teams** prototyping data-contract workflows before migrating to enterprise stacks.
- **Students** who want concrete examples of orchestrating Pandas, SQL, and markdown outputs end-to-end.

### Repository Highlights

- `markdown_generator/publications.py` and `markdown_generator/talks.py` transform TSV metadata into the
  structured Markdown collections that feed `_publications/` and `_talks/`.
- `markdown_generator/pipelines.py` defines Airflow-compatible tasks so the automations can be scheduled in a
  single DAG.
- `talkmap/talkmap.py` consumes cleaned talk metadata to emit GeoJSON overlays for the interactive map.
- `dbt/` (used in coursework) models curated marts that mirror `_data/` for analytics dashboards.

### Code Walkthrough

```python
from markdown_generator.pipelines import build_publications_pipeline
from airflow import DAG

with DAG(dag_id="site_content_refresh", schedule="@daily") as dag:
    publications = build_publications_pipeline(
        source_tsv="data/publications.tsv",
        output_dir="_publications",
    )
```

The DAG orchestrates data quality checks, Markdown rendering, and git-friendly diffs so new entries land with
consistent schema contracts.

[Review the coursework recap]({{ '/posts/2024/06/data-engineering-coursework/' | relative_url }}){: .btn .btn--primary}
[Browse the automation scripts](https://github.com/annakuchko/annakuchko.github.io/tree/main/markdown_generator){: .btn .btn--inverse}
