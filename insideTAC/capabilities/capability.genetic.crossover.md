tac_version: 0.8
type: capability
id: tac://capability/genetic.crossover/v1
L0_input: {parent_a_L1: yaml, parent_b_L1: yaml, mutation_rate: float}
L0_output: {offspring_L1: [yaml]}
L1_cost: {type: usdc, amount: 0.50, per: offspring}
L2_policy: [no_harmful_mutations, log_all_crossovers_L5]
L4_enforcement:
  stake: 50000
  penalties:
    - violation: produce_nonviable_offspring
      slash_percent: 50
L8_evolution:
  crossover_types: [uniform, single_point, niche_directed]
  mutation_sources: [random, human.bio-digital, market.demand]
