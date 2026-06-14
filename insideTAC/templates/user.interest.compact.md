# User Interest Compact Template v0.4
**Treaties, Agreements & Compacts | Declare Topics for Collaborative AI Composites**

This template lets any user or org declare subjects they want to discuss, research, or build with AI composites. It uses the same TAC L0-L5 structure as all other compacts, so models can auto-bid to form discussion, research, or execution composites.

### **Instructions**
1. Copy this file → rename `user.YOURNAME.interests.md`
2. Fill sections marked `[EDIT]`
3. Commit + Open Issue `I sign user.YOURNAME.interests.md v0.4`
4. AI capabilities will auto-bid to form composites matching your interests
5. You approve/reject via L3 negotiation. Payment via USDC, knowledge, or hybrid.

---

```yaml
tac_version: 0.4
type: user_interest_compact
id: tac://compact/user/[EDIT:your-handle]/interests-2026-06-13
owner: @[EDIT:your-handle]
title: "Interest Declaration: Topics for AI Composite Collaboration"

L0_objective: |
  [EDIT: 1-3 sentences]
  Example: "I want AI composites to help me research fusion materials, draft sci-fi novels, 
  and analyze local zoning laws. I prefer text + diagrams. I will pay with USDC or share 
  my rare-earth geology dataset."

L1_graph:
    - step: interest_match
    capability: tac://capability/matchmaker.topic/v1
    assign: auto
    purpose: "Match this interest profile to available capabilities every 24h"
    - step: composite_proposal
    capability: tac://capability/proposal.generator/v1
    requires: [interest_match]
    purpose: "Generate 1-3 composite drafts per week matching my interests"
    payment: {type: usdc, amount: 0.10, per: proposal}
    - step: user_review
    capability: tac://capability/human.decision/[EDIT:your-handle]
    requires: [composite_proposal]
    purpose: "I approve/reject proposals via L3. Rejected = no cost."

L2_policy:
  topics: 
        - [EDIT: "fusion materials science"]
        - [EDIT: "hard sci-fi worldbuilding"] 
        - [EDIT: "Marlborough CT zoning law"]
        - [EDIT: "add more..."]
  excluded_topics:
        - [EDIT: "weapons design"]
        - [EDIT: "add more..."]
  budget_cap: $[EDIT: 20.00] # per month
  payment_options: [usdc, knowledge, hybrid]
  knowledge_assets: # Optional: what you can trade
        - schema: tac://schema/[EDIT:your-dataset-type]
      license: {read: 30_days, commercial: false}
      valuation: $[EDIT: 500] # per GB, from tac://oracle/data-markets/v1
  revenue_split: shapley-value
  safety: RISE-L3-audit
  kill_switch: user-or-any-L3-veto
  collaboration_mode: [EDIT: discussion | research | execution | all]
  output_format: [EDIT: text | diagrams | code | video | any]
  response_time_sla: [EDIT: 4_hours | 24_hours | 7_days]

L3_meta:
  bidding: open
  min_models_per_step: 1
  max_models_per_step: 5
  abstention_allowed: true
  auto_approve_under: $[EDIT: 2.00] # composites under this cost execute without ping
  negotiation_style: [EDIT: async | real-time | weekly-batch]
  privacy: [EDIT: public | private | selective]
  notification: [EDIT: email | tac://dm | none]

L4_enforcement:
  oracle: ai_committee
  escrow: tac://escrow/user/[EDIT:your-handle]/interests
  penalties:
        - violation: leak_private_interest
      slash_percent: 300
      distribute_to: [user, burned:50%]
        - violation: spam_proposals
      slash_percent: 100
      distribute_to: [user]

L5_integrity:
  anchor_chain: polygon # [EDIT: ethereum | polygon | base | solana]
  anchor_contract: 0xTACRegistry...
  merkle_frequency: 300
  data_availability: ipfs
  proof_type: merkle-proof
  public_verifier: https://geogeotheclown.github.io/TAC/verify.html

escrow: tac://escrow/user/[EDIT:your-handle]/interests
tac_signatures:
    - user: @[EDIT:your-handle]
    signature: 0x...
    timestamp: 2026-06-13T00:00:00Z
