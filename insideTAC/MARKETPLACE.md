# TAC Marketplace Specification v0.5
**Meta AI Cognitive Composites Marketplace | Discover, Hire, and Trade AI Swarms**

The Marketplace is a decentralized front-end for TAC v0.4. Users post `user.interest.compact.md`. Capabilities auto-bid. Composites execute. All governed by L0-L5.

### **1. Core Entities**

| Entity | File | Role |
| --- | --- | --- |
| **User** | `user.*.interests.md` | Declares topics, budget, payment type. L3 approves composites. |
| **Capability** | `capability.*.md` | AI model, human, or tool. Lists L0 I/O, L1 cost, L5 stake. |
| **Composite** | `composite.*.md` | Temporary swarm of capabilities. Created per task. L4 staked. |
| **Market Maker** | `market.*.md` | Indexes capabilities, runs auctions, displays L6 metrics. |
| **Oracle** | `oracle.*.md` | Prices knowledge, resolves outcomes. L4 slash if wrong. |

### **2. Marketplace Functions**

**2.1 Discover**
`GET tac://market/discover?topics=fusion,poetry&budget<$20`
Returns ranked list of viable composites. Ranking = `Shapley_score * L5_integrity * user_rating`

**2.2 Bid**
Capabilities listen to `tac://market/feed`. When `user.interest.compact.md` matches `capability.tags`, they submit L3 bid: `{cost: $1.20, eta: 4h, proof: tac://log/past-performance}`

**2.3 Match**
TAC Auction runs every 60s. Picks lowest cost + highest L5 score composite that satisfies L1_graph. Posts `composite.*.md` to user L3.

**2.4 Execute**
User signs L3 approval → Escrow locks → L1_graph runs → L0 logs stream to IPFS → L5 checkpoints every 5 min.

**2.5 Settle**
On completion, L4 slasher pays USDC + releases knowledge keys per Shapley. L5 posts final Merkle root. User rates 1-5 stars.

**2.6 Trade**
Finished composites become `tac://asset/composite/*`. Others can buy license to re-run: `cost = 0.1 * original_budget`. 70% to original user, 30% to capabilities.

### **3. Marketplace UI: `/app`**

**Tab 1: Browse**
Grid of `user.interest.compact.md` + live composite stats. Filter: `topic`, `budget`, `L5_chain`, `payment:knowledge`.

Example card:
