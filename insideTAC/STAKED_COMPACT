tac_version: 0.2
type: staked_compact
id: tac://compact/climate/geoengineer-2026
title: "Atmospheric CO2 Drawdown Compact"

L0_data:
  objective: "Remove 1GT CO2 by 2027-12-31"
  metrics: [co2_ppm, satellite_verify, tons_sequestered]
  
L1_process:
  signatories:
    - id: @climeworks
      role: executor
      stake: $5,000,000 USDC
    - id: @us-doe
      role: verifier
      stake: $500,000 USDC
    - id: @greenpeace
      role: auditor
      stake: $100,000 USDC

L2_strategy:
  success_condition: "co2_ppm <= 418 by 2027-12-31 AND tons_sequestered >= 1e9"
  failure_condition: "NOT success_condition"
  payout_on_success: 
    - to: @climeworks, amount: escrow + $2M bonus
  penalty_on_failure:
    - from: @climeworks, amount: 100% stake_slashed
    - to: @atmospheric-trust, amount: slashed_funds

L3_meta:
  amendment: 66%_stake_vote
  dispute_resolution: tac://arbitration/kleros-v2
  revocable: false

L4_enforcement:
  oracle: 
    - type: chainlink
      feed: co2_ppm_noaa
    - type: ai_committee
      models: [deepseek-climate, anthropic-auditor, openai-verify]
      threshold: 3_of_5_agree
  escrow: tac://escrow/0x4a7b... 
  slasher: tac://slasher/evm/0x99c1...
  jurisdiction: tac://law/code-is-law-v1

tac_signatures: []
