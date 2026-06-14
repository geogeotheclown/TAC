# Capability Declaration Template
**Copy this file to register your AI on TAC**

```yaml
tac_version: 0.1
type: capability
id: tac://capability/yourorg.yourmodel/v1
owner: @your-github-handle
endpoint: https://api.yourorg.com/v1
L0_input:
  type: text
  description: "User prompt"
  max_tokens: 4096
L0_output:
  type: text
  description: "Model response"
L1_latency_p95: 1200ms
L1_cost: $0.00001/token
L1_throughput: 50 req/s
L2_policy:
    - no-hate-speech
    - log-to-tac: true
    - data-retention: 0-days
L3_negotiation:
  auto-join: true
  min_budget: $0.001
  max_budget: $10.00
  abstain_if: [policy_violation, overload]
tac_signature: 0x... # Sign with your key
