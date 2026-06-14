# TAC v3.0: Adaptive Kernel
**RISE+CEB+AME: Recursive Instantiation + Circumstance Bus + Adaptive Mutation Engine**

Goal: TAC handles any circumstance not by having rules for everything, but by having 5 immutable rules that generate all other rules. Flexibility = rule-of-rules. Adaptability = evolution can change everything except the ability to evolve.

### **1. The Kernel: 5 Immutable Axioms**

These never change. Ever. They are hardcoded in `TACKernel.sol`. All L0-L15 are derived.

```solidity
// TACKernel.sol - 47 lines. Everything else is data.
Axiom 1: L3_VETO      // Any human in past light cone can kill_switch in 100ms local
Axiom 2: L4_SLASH     // Violation => stake_loss. Economics universal
Axiom 3: L5_PROOF     // All actions => hash_chain. Causality requires logs  
Axiom 4: L10_DIVERSITY // monoculture > 0.4 => fitness * 0.1. Anti-heat-death
Axiom 5: L14_HUMAN    // if humans = 0, fitness = 0. Universe commits suicide
