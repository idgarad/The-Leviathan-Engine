---

# 📘 Final Unified Combat Codex

## 🌌 Lore Layer
- **Wardens**: Remote commanders interfacing via Command Nodes.  
- **Ships**: Fully crewed, but only **bridge officers** are explicitly tracked.  
- **Bridge Crew**: XO, Tactical, Navigation, Engineering, Comms—treated as “meat modules” that provide buffs.  
- **Combat Feel**:  
  - No cockpit view—combat is experienced through sensors, radar, and comms.  
  - Lag and time dilation are diegetically explained as Command Node sync delays.  
  - Anxiety of “no windows in space”: blips on radar, cloaked ships, uncertain locks.  
- **Doctrine**: Combat is about issuing orders (“Approach pattern Zeta, orbit at 30 km, fire bays 3 and 6”), not micromanaging thrusters.  

---

## ⚙️ Design Layer

### 1. Tank Layers
**Damage resolution order:**

1. **Deflector Shield (first layer)**  
   - Exploits angle of attack to deflect shots into glancing blows.  
   - Factors: module quality, officer skill, range, angle of attack.  
   - Successful deflection reduces damage (25–50%).  

2. **Absorption Shields (subsequent layers)**  
   - Convert incoming energy/kinetic into heat.  
   - Phased channels: if weapon matches phase, shield is bypassed.  
   - Cycle modulation creates vulnerability windows.  
   - Layered: 3 (frigates) → 20 (capitals).  
   - Vulnerable to high RoF (phase‑walking) and alpha strikes (thermal overload).  

3. **Exterior Armor**  
   - Absorbs kinetic, disperses energy heat.  
   - Velocity bleed reduces penetration.  

4. **Exterior Hull**  
   - Structural shell; breaches cause secondary effects.  

5. **Laminated Inner Hull (LIH)**  
   - Kevlar‑like weave protecting crew/habitat.  
   - Last line of defense; semi‑flexible to absorb shock.  

---

### 2. Targeting & Hit Chance
\[
P_{\text{hit}} = \frac{T}{T + \left(\frac{V_{\text{trans}}}{R}\right)^\alpha} \cdot S
\]

- \(T\): Weapon tracking speed.  
- \(V_{\text{trans}}\): Target transversal velocity.  
- \(R\): Range.  
- \(\alpha\): Curve shaping constant.  
- \(S\): Sensor lock factor (reduced for small ships).  

**Officer Modifiers**  
- Tactical: Buffs tracking, crit, accuracy.  
- Navigation: Increases evasive transversal.  
- Comms: Improves sensor lock stability.  
- XO: Reduces variance in RNG (crew discipline).  

---

### 3. Maneuvers & Dodge
- **Dodge ability**: Crew executes evasive maneuvers → reduces hit chance temporarily.  
- **Scaling**: Ship agility + Navigation skill + XO + Tactical synergy.  
- **Cooldown**: Prevents spam; costs energy/accuracy.  

---

### 4. Electronic Warfare (EW)
- **Jamming**: Reduces enemy sensor factor \(S\).  
- **Spoofing/Taunt**: Redirects enemy targeting AI.  
  \[
  P_{\text{taunt}} = \frac{E_{\text{jam}} \cdot (1 + B_{\text{crew}})}{E_{\text{jam}} + R_{\text{enemy}}}
  \]  
- **Counter‑ECM**: Enemy Comms Officer and certs resist spoof/jam.  
- **Side effects**: Taunting increases own sensor footprint.  

---

### 5. Officers as Buff Modules
- XO: Order execution speed, reduces lag penalties.  
- Tactical: Accuracy, crit, tracking.  
- Navigation: Dodge, transversal, maneuverability.  
- Engineering: Energy efficiency, repair, heat management.  
- Comms: Sensor lock, EW effectiveness.  

---

### 6. Skills & Certifications
- **Skills**: Rank 1–10; Rank 5 = Mastery; Ranks 6–10 = global bonuses.  
- **Certifications**: All three skills in suite ≥ 5 → unlocks cert.  
- **Enhancement Bonuses**: Certs improve global bonuses of member skills (e.g., +10% global damage, +2% range).  
- **Meta‑Certifications**: Require multiple certs; unlock doctrines, ships, fleet abilities.  
- **Faction Gating**: USO and navies/corporations gate access to skills/certs.  

---

### 7. Rules of Engagement (RoE) & Resolution
- **Ships are not bombs**: Built to fail safe, not explode.  
- **The Emperor’s Kiss (TEK)**: Fragile bridge sensor; if destroyed or thresholds met, triggers surrender.  
- **Distress Surrender Beacon (DSB)**:  
  - Activated automatically.  
  - Warden disconnected; XO issues surrender.  
  - Ship enters custody of **Imperial Recovery Services (IRS)**.  
- **Aggressor Rights**:  
  - Entitled to salvage share.  
  - May ransom crew (via Crew Ransom Insurance payouts).  
  - May forgo ransom and escort crew to station.  
- **IRS Role**:  
  - Processes salvage, crew, and insurance payouts.  
  - Takes a cut of salvage.  
  - Often handles cleanup after battles.  
- **Loot Handling**:  
  - Abstracted: delivered to fleet commander.  
  - IRS batch‑processes salvage asynchronously.  

---

### 8. Critical Strikes & Spoils of War
- **Critical Strikes**: Rare hits disable specific modules (weapons, engines, shields, life support).  
- **Module Thresholds**: If enough modules are destroyed (e.g., 50%), TEK triggers DSB even if hull intact.  
- **Spoils of War**:  
  - Ship surrenders but remains largely intact.  
  - Aggressors may capture ship as a prize.  
  - Creates tactical choice: brute force wreck vs. precision disable.  

---

## 🧑‍💻 Technical Layer

### Damage Resolution Flow
1. Roll for **hit chance** (tracking vs transversal, sensor lock).  
2. If hit → check **Deflector Shield glancing blow**.  
3. If glancing → apply reduced damage, skip deeper layers.  
4. If not glancing → apply to **Absorption Shields** (phase check, heat absorption, blowout risk).  
5. If shields fail → apply to **Armor** (absorption %, velocity bleed).  
6. If armor fails → apply to **Exterior Hull** (structural integrity).  
7. If hull fails → apply to **LIH** (crew/system protection).  
8. Check **critical strike rolls** → disable modules.  
9. If TEK destroyed or thresholds met → trigger **DSB**.  

### Performance Model
- **Local layer** (skills, certs, officers): Cached, recompute only on change.  
- **Fleet layer** (auras, EW, taunts): Per‑tick recompute, optimized with spatial partitioning and delta updates.  
- **Tick layers**:  
  - Physics: 1–10 Hz.  
  - Combat: 5–10 Hz.  
  - Sensors: 1–2 Hz.  
  - Command: event‑driven.  
- **Time dilation**: If server load spikes, slow simulation globally—diegetically explained as Command Node sync delay.  

---

## 📚 Lore Hooks
- **Deflector chatter**: “XO reports we angled the deflector—enemy shot glanced off!”  
- **Shield cycling secrets**: Guarded by navies; espionage targets.  
- **Alpha strikes**: Risk catastrophic shield blowouts → “thermal flash” events.  
- **“Getting under their guns”**: Explained as turrets unable to track fast targets.  
- **“Hard to lock”**: Small ships flicker on sensors.  
- **Crew chatter**: Officers narrate successes/failures of dodges, taunts, locks.  
- **Faction doctrines**: Some emphasize brute force, others EW trickery.  
- **Spoils of war**: Captured ships become valuable prizes, reinforcing salvage/ransom economy.  
- **Warden role**: You’re not flying—you’re commanding.  

---s

