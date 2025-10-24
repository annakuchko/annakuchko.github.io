---
title: "Dynamic Portfolio Optimization"
excerpt: "Financial network analytics powering adaptive rebalancing."
collection: portfolio
---

## Overview

Dynamic correlations make static covariance matrices obsolete. This project rebuilds asset allocation as a
graph-driven workflow that learns community structure on the fly and injects it into the trading rules. The
resulting pipeline pairs statistical rigor with explainability so investment committees can see *why* the
portfolio rotates, not just the trades it recommends.

![Network-informed rebalancing workflow illustration.](/images/editing-talk.png)

### Applications & Use Cases

- **Multi-asset allocators** seeking regime-aware diversification across equities, commodities, and rates.
- **Risk desks** that need early warning signals when clusters of securities start moving in lockstep.
- **Thematic funds** that want to sanity-check conviction trades against evolving network centrality metrics.

### Repository Highlights

The [FiNetwork repository](https://github.com/annakuchko/FiNetwork/) combines PyTorch Geometric, NetworkX,
and CVXPy to ship an end-to-end research stack:

- `finetwork/data` handles ingestion, rolling-window feature engineering, and correlation filtering.
- `finetwork/clustering.py` wraps Leiden community detection with reproducible seeds and persistence metrics.
- `finetwork/optimizers/cluster_constrained.py` exposes the convex program that balances return, risk, and
  cluster-aware turnover penalties.
- `dashboards/` contains Plotly Dash apps for animated network diagnostics and cluster attribution reviews.

### Code Walkthrough

```python
from finetwork.optimizers import ClusterAwareRebalancer

rebalance = ClusterAwareRebalancer(
    target_vol=0.12,
    max_turnover=0.08,
    cluster_diversity_floor=0.15,
)

trade_list = rebalance.generate_trades(
    expected_returns, covariance_matrix, cluster_labels
)
```

The optimizer ingests the latest network-derived clusters, injects them into allocation constraints, and
produces a trade list that respects both volatility budgets and diversification floors. Attribution reports
map every trade back to the network motifs that triggered it.

[Read the research summary]({{ '/posts/2024/05/dynamic-portfolio-optimization/' | relative_url }}){: .btn .btn--primary}
[Browse the FiNetwork codebase](https://github.com/annakuchko/FiNetwork/){: .btn .btn--inverse}
