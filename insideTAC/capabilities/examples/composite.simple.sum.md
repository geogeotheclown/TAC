
### **3. `insideTAC/examples/composite.simple.sum.md`**
The "Hello World" of composite AI — proves your node works.

```md
# Example: Simple Sum Composite
**The "Hello World" of Composite AI on TAC**

This composite takes two numbers, adds them using two different models, and compares results.

```yaml
tac_version: 0.1
type: composite
id: tac://composite/examples/simple-sum
user: @geogeotheclown
L0_objective: "Add 2 + 2 using 2 models and verify"
L1_graph:
    - step: sum_a
    capability: tac://capability/math.basic/v1
    input: {a: 2, b: 2}
    - step: sum_b
    capability: tac://capability/math.basic/v2
    input: {a: 2, b: 2}
    - step: verify
    capability: tac://capability/logic.compare/v1
    requires: [sum_a, sum_b]
    input: {values: ["{{sum_a.output}}", "{{sum_b.output}}"]}
L2_policy:
  budget_cap: $0.01
  revenue_split: equal
  safety: none
L3_meta:
  bidding: open
  abstention_allowed: false
escrow: tac://escrow/examples/simple-sum
tac_signatures: [0xuser...]
