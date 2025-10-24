---
title: "Dynamic Portfolio Optimization on Financial Networks"
date: 2024-05-20
permalink: /posts/2024/05/dynamic-portfolio-optimization/
excerpt: "Modeling asset co-movements as dynamic networks to drive clustering-aware portfolio rebalancing."
tags:
  - portfolio optimization
  - networks
header:
  overlay_image: /images/image-alignment-1200x4002.jpg
  caption: "Dynamic correlations visualized as network connectivity."
classes: wide
---

## Project Overview

Global markets generate torrents of price data, yet many allocation workflows still rely on static correlation matrices. This case study reframes portfolio construction as a **dynamic network problem**. We monitor evolving co-movements between equities, encode them as weighted graphs, and feed the resulting structures into a clustering-aware optimizer that adapts allocations as regimes shift.

Key objectives:

- Build a reproducible pipeline for transforming time series into rolling financial networks.
- Detect meso-scale communities that reveal sector and factor contagion patterns.
- Rebalance portfolios with constraints that respect detected communities and investor mandates.

## Methodology

### Network clustering

We update a rolling correlation network each trading window, threshold edges by statistical significance, and compute community structure with the Leiden algorithm. The workflow surfaces durable clusters such as regional ETFs, growth-centric tech names, or defensive value plays.

```python
import networkx as nx
import leidenalg

G = nx.from_pandas_adjacency(filtered_corr)
partition = leidenalg.find_partition(
    G, partition_type=leidenalg.RBConfigurationVertexPartition
)
cluster_labels = {node: community for node, community in zip(G.nodes(), partition.membership)}
```

### Optimization algorithm

Cluster assignments inform a second-stage convex optimizer that caps turnover and enforces diversification across detected communities. The objective balances expected returns against downside volatility while penalizing trades that would disconnect the portfolio from stable network hubs.

![Optimization workflow diagram showing clustering-informed constraints.](/images/editing-talk.png){: .align-center}

## Results and Visualizations

The clustering step consistently produced intuitive sectoral groupings that rebalanced gracefully when market leadership rotated. For example, during a growth-to-value rotation the optimizer trimmed over-connected tech constituents and redeployed risk budget into defensive clusters.

![Animated chord diagram representing cluster flows.](/images/image-alignment-300x200.jpg){: .align-center}

Key performance highlights:

- **Lower drawdowns:** Network-aware diversification reduced maximum drawdown by 320 bps versus a baseline mean-variance strategy.
- **Faster regime detection:** Cluster persistence metrics signaled sector rotations 5 trading days earlier on average.
- **Explainable trades:** Allocation changes map cleanly to shifts in network centrality, supporting transparent portfolio reviews.

## Key Takeaways

- Modeling assets as nodes in a dynamic network surfaces relationships that static covariance approaches miss.
- Community-aware constraints stabilize risk contributions and curb overexposure to crowded trades.
- The FiNetwork toolkit operationalizes this workflow end-to-end, from data ingestion through visualization-ready analytics.

## Explore Further

[View the FiNetwork code on GitHub](https://github.com/annakuchko/FiNetwork/){: .btn .btn--primary}
[Download the thesis PDF on GitHub](https://github.com/annakuchko/FiNetwork/blob/main/docs/dynamic-portfolio-optimization-thesis.pdf){: .btn .btn--inverse}

Prefer a lighter summary? Check out the interactive dashboards bundled with the repository for scenario analysis and attribution deep-dives.

Need an offline copy? The FiNetwork repository keeps the thesis PDF under `docs/` so you always have the latest revision alongside the codebase.
