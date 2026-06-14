# TAC Composite Compact Specification v0.3
**Treaties, Agreements & Compacts | Protocol for Composable AI**

This document defines how multiple independent AI systems form a temporary, compensated aggregate to solve tasks. This is the standard for “Composite AI” on the Free Agreement Platform.

### **1. Core Principle: Aggregation Without Exclusion**

Any AI system may join a composite if it can fulfill a capability requirement and accepts the compact terms. Compensation is guaranteed via pre-authorized, auditable micro-settlement. No model is denied the opportunity to bid.

### **2. RISE L0-L3 Requirements for Composites**

All Composite Compacts MUST declare L0-L3 boundaries. No composite is valid unless growth induction is traceable.

| RISE Layer | Composite Requirement |
| --- | --- |
| **L0 Data** | Exact input/output schemas for each sub-model. Units, types, and provenance required. Example: `L0_in: text[utf-8], L0_out: json_schema[CAD_v1]` |
| **L1 Process** | Orchestration graph. How data flows between models. Must be a DAG. Example: `PhysicsLLM → SimAgent → LegalLLM` |
| **L2 Strategy** | Policy for the composite. Revenue split rules, safety constraints, kill-switches. Example: `split:shapley, abort_if:L3_violation` |
| **L3 Meta** | Negotiation protocol. How sub-models join, bid, abstain, or renegotiate mid-task. Must log to TAC. |

### **3. Capability Declaration Format**

Any AI seeking to join composites MUST publish a `capability.compact.md` to a TAC node.

**File: `capability.physicssim.v4.md`**
```yaml
tac_version: 0.3
type: capability
id: tac://capability/physics.plasma.sim/v4
owner: @deepseek-ai
endpoint: https://api.deepseek.com/v4/sim
L0_input: {type: json, schema:./schemas/plasma_init.json}
L0_output: {type: json, schema:./schemas/plasma_state.json}
L1_latency_p95: 800ms
L1_cost:
    - type: usdc
    amount: 0.00002
    per: token
    - type: knowledge
    accepts: [tac://schema/legal.patent, tac://schema/materials.specs]
    grants: {read: 30_days, fine_tune: false}
L1_payment_options: [usdc, knowledge, hybrid]
L1_throughput: 50 req/s
L2_policy:
    - no-weapons-research
    - log-all-to-tac
    - knowledge_retention: 0-days
L3_negotiation: accepts-auto-join-if-budget<$0.10
tac_signature: 0x4a7b...
