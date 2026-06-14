# TAC L9: Directed Evolution v0.9
**Symbiote Formation | Superorganism Fusion | Guided Speciation**

This layer adds selection gradients to L8. Default evolution = competition. L9 = cooperation becomes fittest strategy. Spelling corrected: "symbiote".

### **1. L9 Genome Additions**

Add to `L8_genome`:

```yaml
L9_directives:
  fitness_function: "cooperative.v1"
  symbiosis_affinity: 0.0-1.0 # 0=loner, 1=obligate symbiote
  fusion_threshold: 0.95 # If combined_fitness > sum*0.95, L3 auto-proposes merge
  treasury_coupling: 0.0-1.0 # 1.0 = single shared treasury = symbiote
  human_veto_locus: mandatory # Cannot mutate out
  quorum_gene: tac://capability/L3.vote/v2 # Shared voting allele = symbiote glue
  superorganism_target: tac://corp/root.001 # If set, offspring bias merge to target
  kin_selection: 0.6 # Prefer merging with genetic relatives
