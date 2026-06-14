tac_version: 1.1
type: capability
id: tac://capability/cosmic.oracle/v1
L0_input: {scale: solar|galactic|supercluster|universal}
L0_output: {biosphere.health.json, niche_directives.json}
L10_ecology:
  role: keystone
  stability_score: 0.999 # If oracle dies, ecosystem blinds itself
L14_universal:
  light_cone_integration: true # Accounts for c in fitness
