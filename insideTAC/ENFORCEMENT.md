# TAC L4: Enforcement Layer Specification v0.2
**Treaties, Agreements & Compacts | Staked Compacts Protocol**

L4 adds cryptoeconomic enforcement to TAC. Signatories lock collateral. Violation triggers automatic penalties. No courts, no appeals, just code.

### **1. Core Principle: Code Is Law Within Compact**

By signing a `staked_compact` and funding `L4_enforcement.escrow`, all parties agree: 
1. The compact’s code + oracle verdicts are final
2. `L4_enforcement.jurisdiction` supersedes external law for this agreement
3. Slashing is not theft — it’s pre-agreed liquidated damages

**Exit > Voice**: If you disagree, don’t stake. If you stake, you’re bound.

### **2. L4 Block Specification**

All staked compacts MUST include `L4_enforcement`:

```yaml
L4_enforcement:
  escrow: 
    type: evm | btc | solana | tac-native
    address: 0x... # Where stakes are locked
    chain_id: 1 # Ethereum mainnet
  collateral:
    - asset: USDC
      min_stake_per_party: 10000 # $10k minimum
    - asset: compute_credits
      conversion: 1_credit = $0.01
  oracle:
    type: chainlink | ai_committee | kleros | prediction_market
    config:
      feed: co2_ppm_noaa # for chainlink
      models: [tac://capability/anthropic.auditor/v1, ...] # for ai_committee
      threshold: 3_of_5 # required signatures
    deadline: 2027-12-31T23:59:59Z
  slasher:
    type: evm.v1 | tac-native.v1
    address: 0x
