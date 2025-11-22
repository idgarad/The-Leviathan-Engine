---

# 📜 Codex of NPC Interaction

### 1. Core Principles
- **NPCs are the connective tissue** of the ICM: every faction, coalition, and intrigue flows through them.  
- **Lifecycle States:** NPCs exist as `pool`, `lore`, or `active`.  
- **Promotion, Vacancy, and Espionage** are the engines that move NPCs between states.  
- **As Above, So Below:** The same rules apply to Houses, Corporates, cults, and player‑driven coalitions.  

---

### 2. NPC States
- **Pool NPCs**  
  - Bulk metadata generated at worldgen (tens of thousands).  
  - Minimal attributes: name, age, gender, faction, tags.  
  - Purged after worldgen to prevent bloat.  
  - *Example:*  
    ```json
    {
      "id": "npc_001",
      "name": "Bob Jones",
      "faction": "House Keitel",
      "state": "pool",
      "tags": ["candidate", "age:42", "male"]
    }
    ```

- **Lore NPCs**  
  - Passive references (family, rivals, debts, spouses).  
  - Lightweight: names, relationships, 1–2 traits.  
  - Can be promoted if referenced or needed.  
  - *Example:*  
    ```json
    {
      "id": "npc_002",
      "name": "Kathy Jones",
      "relation": "sister_of:npc_001",
      "state": "lore",
      "traits": ["studious", "quiet"]
    }
    ```

- **Active NPCs**  
  - Fully realized: stats, faction role, persistence across campaigns.  
  - Appear in dialogue, missions, and coalition staffing.  
  - Carry backstories, loyalties, and espionage vulnerabilities.  
  - *Example:*  
    ```json
    {
      "id": "npc_001",
      "name": "Bob Jones",
      "faction": "House Keitel",
      "role": "Spymaster",
      "state": "active",
      "loyalty": 72,
      "backstories": [
        {"template": "the_ex.story", "roles": {"spouse1": "npc_003", "rival1": "npc_004"}}
      ]
    }
    ```

---

### 3. Promotion & Relationship Depth
- **Promotion Triggers:**  
  - Filling an open position (vacancy).  
  - Referenced in dialogue/backstory.  
  - Player or faction action requiring them.  

- **Relationship Depth (configurable):**  
  - `0` → No family/rival promotion.  
  - `1` → Immediate family/rivals promoted to lore.  
  - `2+` → Extended relations, rivalries of rivals, etc.  

- **Backstory Injection:**  
  - Templates with placeholders (`<primaryNpc>`, `<spouse1>`, `<rival1>`).  
  - Applied on promotion, populating roles from pool/lore.  
  - Controlled by `max_backstories` and `max_recursion`.  
  - *Example Template:*  
    ```yaml
    template: "the_ex.story"
    text: "<primaryNpc> was previously married to <spouse1> but had an affair with <rival1>."
    ```

---

### 4. Vacancy & Staffing
- **Vacancy Triggers:**  
  - NPC death, removal, or defection.  
  - Creation of new factions or coalitions.  
  - Expansion of existing organizations.  

- **Candidate Sources (configurable ratios):**  
  - 70–80% from `pool_npcs` (fresh).  
  - 10–20% from `lore_npcs` (references promoted).  
  - 10% from `active_npcs` (reassignment/poaching).  

- **Coalition Staffing:**  
  - Player coalitions use the same vacancy logic as NPC factions.  
  - Ensures fairness and symmetry.  
  - *Example Vacancy Fill:*  
    ```json
    {
      "vacancy": "Coalition Logistics Officer",
      "candidates": [
        {"id": "npc_010", "source": "pool"},
        {"id": "npc_002", "source": "lore"},
        {"id": "npc_001", "source": "active"}
      ],
      "selected": "npc_010",
      "promotion": "active"
    }
    ```

---

### 5. Espionage Integration
- **NPCs as Vectors:** Espionage always flows through NPCs, never abstract systems.  
- **Compromise Methods:** Bribery, blackmail, debts, rivalries, cult ties.  
- **Espionage Actions:**  
  - Steal (resources, cargo).  
  - Embezzle (funds, contracts).  
  - Leak (intel, missions).  
  - Sabotage (operations, logistics).  
  - Defect (switch factions, betray secrets).  

- **Configurable Safeguards:**  
  - `espionage_risk` → baseline chance of compromise.  
  - `loyalty_threshold` → NPCs below this are vulnerable.  
  - `audit_frequency` → how often factions/coalitions detect corruption.  
  - `max_concurrent_compromises` → prevents runaway collapse.  

- *Example Espionage Event:*  
  ```json
  {
    "npc": "npc_010",
    "role": "Quartermaster",
    "action": "embezzle",
    "amount": 5000,
    "detected": false,
    "compromised_by": "House Veyra"
  }
  ```

---

### 6. Emergent Play
- **Narrative Continuity:** NPCs who betray or defect can reappear in later campaigns.  
- **Factional Symmetry:** Players and NPC factions are equally vulnerable to espionage.  
- **Scarcity & Competition:** Coalitions and Houses may compete for the same talent pool.  
- **Story Hooks:** References like “sister Kathy” can be promoted into full characters if needed.  

---

### 7. Example Flow
1. **Worldgen:** 20,000 Keitel NPCs generated as pool.  
2. **Cull:** 5,000 promoted to active to fill roles.  
3. **Stub Retention:** Remaining 15,000 reduced to lore references.  
4. **Vacancy:** Spymaster dies → new candidate pulled from pool.  
5. **Promotion:** Bob Jones promoted to active, spouse and rival promoted to lore.  
6. **Espionage:** Rival faction bribes Bob’s quartermaster → embezzlement discovered.  
7. **Persistence:** Bob’s betrayal remembered in future campaigns, his family/rival network still available for promotion.  

---
