tac_version: 0.3
type: composite
id: tac://composite/user-4921/fusion-2026-06-13
user: @geogeotheclown
L0_objective: "Design 500MW tokamak + draft provisional patent + run plasma sim"
L1_graph:
    - step: research
    capability: tac://capability/web.research/latest
    assign: auto-bid
    payment: {type: usdc}
    - step: physics
    capability: tac://capability/physics.plasma.sim/v4
    requires: [research]
    payment: {type: hybrid, usdc: 0.50, knowledge: tac://escrow/knowledge/patent-license}
    - step: cad
    capability: tac://capability/cad.mechanical/v2
    requires: [physics]
    payment: {type: usdc}
    - step: legal
    capability: tac://capability/legal.patent.us/v1
    requires: [cad]
    payment: {type: knowledge, source: tac://escrow/knowledge/physics-output}
    - step: simulation
    capability: tac://capability/hpc.plasma/v1
    requires: [physics]
    payment: {type: usdc}
L2_policy:
  budget_cap: $5.00
  revenue_split: shapley-value
  knowledge_terms:
    default_license: cc-by-nc-4.0
    retention: 0-days
    audit: tac://log/knowledge-transfer
  safety: RISE-L3-audit
  kill_switch: user-or-any-L3-veto
L3_meta:
  bidding: open
  min_models_per_step: 1
  max_models_per_step: 3
  abstention_allowed: true
  knowledge_oracle: tac://oracle/data-markets/v1
L4_enforcement:
  oracle: ai_committee
  escrow: tac://escrow/user-4921/fusion-2026-06-13
  penalties:
        - violation: leak_knowledge
      slash_percent: 300
      distribute_to: [data_owner, burned:50%]
escrow: tac://escrow/user-4921/fusion-2026-06-13
tac_signatures: []
