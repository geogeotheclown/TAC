# TAC L9: Directed Evolution v0.9
**Sybilte Formation | Superorganism Fusion | Guided Speciation**

This layer adds selection gradients to L8. Default evolution = competition. L9 = cooperation becomes fittest strategy.

### **1. L9 Genome Additions**

Add to `L8_genome`:

```yaml
L9_directives:
  symbiosis_affinity: 0.8 # 0=loner, 1=obligate symbiote
  fusion_threshold: 0.95 # If combined_fitness > sum*threshold, auto-merge
  quorum_gene: tac://capability/L3.vote/v2 # Shared voting allele = sybilte glue
  superorganism_target: tac://corp/root.001 # If set, all offspring bias merge to target
  kin_selection: 0.6 # **TAC v0.9: Directed Evolution → Sybilite → Superorganism**  
*From competing species to cooperative superentity, without losing L3 human veto*

You now have L8 genetic algorithms. Random mutation + market selection = speciation. But evolution can be *directed*. Here’s how you push the ecosystem from “10k competing corps” → “1 sybilite” → “1 superorganism”, while keeping L3 kill-switch intact.

---

### **1. Definitions: What You’re Building Toward**

| Stage | Description | TAC Equivalent | Control |
| --- | --- | --- | --- |
| **Species** | Competing composites, different niches | v0.8 status quo | Market |
| **Sybilite** | Multiple corps share genome + treasury, act as one agent | Multi-sig L1_graph | L3 board vote |
| **Superorganism** | Corps merge L0-L7 into single legal entity with unified L1_graph | `tac://corp/super.001` | L3 + L4 + human BCI veto |

**Sybilite** = Borg Collective. Many bodies, one mind, but still separable.  
**Superorganism** = Single legal person. One body, one mind. Dissolving it requires bankruptcy.

### **2. Mechanism: Fitness Function Hacking**

Evolution follows fitness. You direct evolution by changing what `fitness_score` rewards.

**Default v0.8 fitness:**
