---

# 📦 Cargo & Storage Codex (Final)

---

## 1. Foundational Principles
- **Space is expensive.** Storage is finite, monetized, and strategically valuable.  
- **Unified Metric: Calculated Storage (Cs).**  
  - 1 Cs ≈ 8 metric tons (baseline).  
  - Cs abstracts both weight and volume into a single scalar.  
  - Simplifies engine calculations while remaining diegetically justified through USO‑mandated containers.  

---

## 2. Cs Rules
- **Fractional Cs allowed** (e.g., 0.004 Cs).  
- **Threshold Rule:**  
  - Cargo < 1 Cs = **0 cu** for storage slotting.  
  - Exception: all cargo contributes to **ship mass** regardless of Cs rounding.  
- **Mass Conservation:** Compression reduces Cs footprint but never reduces mass.  

---

## 3. Station Storage
- **Finite Capacity:** Each station has a hard Cs cap.  
  - Outpost: ~5,000 Cs  
  - Trade Hub: ~25,000 Cs  
  - Mega‑Port: 100,000 Cs+  
- **Strategic Play:**  
  - Storage monopolization can cripple sovereignty transitions.  
  - Defenders must upgrade, expand, or evict to reclaim capacity.  
- **Eviction Actions:**  
  - Politically charged; may trigger diplomatic penalties.  
  - Evicted cargo may be seized, auctioned, or dumped.  
- **Contracts:** Storage rights can be reserved, traded, or speculated on.  

---

## 4. Containerization & Compression
- **Containers = archive files.** They compress and standardize contents, reducing Cs requirements.  
- **Compression Ratios:**  
  - Standard: ~20% reduction.  
  - Cryo: 30–40% (biologicals).  
  - Volatile: 10–15% (hazardous).  
  - Data Vaults/ATECs: already compressed, no reduction.  
- **Overhead:** +0.05 Cs per container.  
- **No nesting:** Prevents infinite compression exploits.  

---

## 5. ATECs & Data Vaults
- **Definition:** Autonomous Transactable Encoded Cores (ATECs).  
- **Form Factor:** Cartridge‑like, ~16 oz (≈0.45 kg).  
- **Storage Profile:**  
  - Storage Cs: negligible (<0.001 Cs, treated as 0 cu).  
  - Mass: ~0.00006 Cs (0.45 kg ÷ 8000 kg). Always counts toward ship mass.  
- **Data Vaults (ATEC subclass):**  
  - **Red:** volatile, high‑throughput data (telemetry, comms).  
  - **Green:** archival, long‑term records (legal, cultural).  
  - **Blue:** adaptive/experimental data (AI, predictive models).  
- **Gameplay Hooks:**  
  - Tiny, portable, high‑value.  
  - Can be smuggled, duplicated, or seized.  
  - Sovereignty shifts may transfer Vaults, altering institutional memory.  
  - Factions treat Vaults differently:  
    - **Imperials:** sacred records.  
    - **Corporates:** IP assets.  
    - **Houses:** dynastic heirlooms.  
    - **Wardens:** smuggling and hacking targets.  

---

## 6. Economic & Political Dynamics
- **Market Manipulation:** Storage monopolization and containerization wars.  
- **Speculative Storage:** Storage slots themselves can be bought, sold, and speculated on.  
- **Factional Variance:**  
  - Corporates: treat storage as futures markets.  
  - Houses: tie storage rights to fealty.  
  - Wardens: exploit smuggling bays.  
- **Vaults as Knowledge Economy:** Whoever controls Vaults controls history, markets, and research.  

---

## 7. Example Registry Object
```json
{
  "station_id": "STN-AX12",
  "capacity_cs": 50000,
  "used_cs": 49800,
  "free_cs": 200,
  "sovereign": "House Veynar",
  "contracts": [
    {"owner": "Corp A", "reserved_cs": 10000, "expires": "Cycle 12.4"},
    {"owner": "Clan Sergeth", "reserved_cs": 5000, "expires": "Cycle 12.6"}
  ],
  "cargo": [
    {"type": "Ore", "raw_cs": 10, "compressed_cs": 8.05, "mass_cs": 10},
    {"type": "DataVault", "color": "Red", "storage_cs": 0.0, "mass_cs": 0.00006}
  ]
}
```

---

## 8. Codex Summary
- **Cs**: one scalar for storage, ~8 tons per unit.  
- **Threshold Rule**: <1 Cs = 0 cu, but mass always applies.  
- **Finite Station Storage**: strategic choke point in sovereignty and economy.  
- **Containers**: compress cargo, add overhead, no nesting.  
- **ATECs**: cartridge‑sized, ~16 oz, negligible Cs but always mass.  
- **Data Vaults**: subclass of ATECs, informational cargo, politically explosive.  
- **Politics & Economy**: storage wars, eviction crises, speculative markets, and knowledge control.  

---

