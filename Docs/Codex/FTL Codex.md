---

# 📘 FTL Codex: Intrinsic Field Dynamics & Modular Jump Architecture

## 1. 🎯 Goals

- Provide a **mathematically sound framework** for FTL mechanics.  
- Define **ratings‑based components** (drives, stabilizers, mitigators, QTAs).  
- Ensure **tunability** for balancing gameplay and lore.  
- Support **scalable simulation** in code (Rust, Python, C++).  
- Address **performance considerations** for real‑time or tick‑based engines.  

---

## 2. 🌌 Core Paradigm

- The **Intrinsic Field (IF)** is the true traveler in Hyper‑Space.  
- The **ship remains inert** in C‑Space until the IF re‑anchors.  
- **Spin‑Up** = crew waiting while the IF transits.  
- **Cooldown** = IF stabilization before next projection.  
- **Interdiction** = external force pulling IF out of transit.  
- **Conservation Principle**: Momentum, velocity, and angular momentum are preserved across jumps. The ship “teleports” to the IF’s new anchor point but retains its physics state.

---

## 3. 📐 Mathematical Model

### 3.1 Effective Jump Rating
\[
R = JR \cdot \left( \frac{M}{1000} \right)^{\alpha}
\]

### 3.2 Quantum Tunneling Boost
\[
\theta_{\text{eff}} = \theta_{\text{rated}} \cdot \left( \frac{M}{M_{\text{ref}}} \right)^{\gamma}
\]
\[
D_{\text{boosted}} = R \cdot (1 + \theta_{\text{eff}})
\]

### 3.3 Intrinsic Field Burn
\[
B = \beta \cdot (1 - \sigma) \cdot M \cdot f \cdot D
\]

### 3.4 Heat Accumulation
\[
H = k \cdot (1 - \tau) \cdot M \cdot (f \cdot D)^2
\]

### 3.5 Energy Budget
\[
E_{\text{required}} = \epsilon \cdot JR \cdot M
\quad
E_{\text{available}} = M
\]

### 3.6 Spin‑Up Time
\[
T_{\text{spin}} = T_0 \cdot \left( \frac{M_{\text{ref}}}{M} \right)^{\delta}
\]

### 3.7 Cooldown Time
\[
T_{\text{cool}} = C_0 \cdot \left( \frac{M}{M_{\text{ref}}} \right)^{\zeta}
\]

### 3.8 Forced Jump During Cooldown
\[
IF_{\text{fraction}}(t) = \min\left(1, \frac{t}{T_{\text{cool}}} \right)
\quad
D_{\text{forced}} = D_{\text{max}} \cdot IF_{\text{fraction}}(t)
\]

### 3.9 Conservation of Momentum
\[
\vec{v}_{\text{exit}} = \vec{v}_{\text{entry}}
\]

---

## 4. 🛡️ Interdiction Mechanics

- **Active Interdiction**: Disrupts IF during spin‑up. At 0%: jump prevented. At X%: ship emerges at X% of intended distance.  
- **Interdiction Points (Bubbles)**: If IF path intersects bubble, ship emerges at bubble coordinates. Always a valid anchor—no partial failures.  

---

## 5. ⚙️ Tunables & Balancing Knobs

| Parameter | Effect | Gameplay Impact |
|-----------|--------|-----------------|
| \( JR \) | Base drive rating | Defines engine tiers |
| \( \alpha \) | Mass scaling exponent | Controls advantage of large ships |
| \( \theta_{\text{rated}} \) | QTA rating | Defines interstellar capability |
| \( \gamma \) | QTA scaling exponent | Controls cutoff for small ships |
| \( \beta \) | IF burn coefficient | Balances stabilizer value |
| \( \sigma \) | Stabilizer rating | Reduces IF burn |
| \( k \) | Heat coefficient | Balances mitigator value |
| \( \tau \) | Mitigator rating | Reduces heat |
| \( \epsilon \) | Drive efficiency | Energy cost scaling |
| \( T_0 \) | Reference spin‑up | Sets baseline jump delay |
| \( \delta \) | Spin‑up scaling | Small vs large ship timing |
| \( C_0 \) | Reference cooldown | Sets baseline recovery |
| \( \zeta \) | Cooldown scaling | Large ship penalty |

---

## 6. 🚀 Example Ships

| Ship Name               | Mass (tons)     | JR   | QTA Rating | Boosted Range (Mm) | Light Years | Spin‑Up (s) | Cooldown (s) |
|--------------------------|-----------------|------|-------------|---------------------|-------------|--------------|---------------|
| **Star Destroyer**       | 62,000,000      | 6000 | 7725        | 4.73 × 10¹⁴         | 50.0        | 10.0         | 30.0          |
| **Executor SSD**         | 150,000,000     | 6000 | 7725        | 5.54 × 10¹⁵         | 585.6       | 6.4          | 59.3          |
| **Enterprise‑D**         | 4,500,000       | 6000 | 7725        | 51.1M               | 0.0054      | 127.0        | 1.9           |
| **Cassidy Mark II**      | 387,000         | 8500 | 7725        | 59.3M               | 0.0063      | 127.0        | 1.9           |
| **Reaper Capital Ship**  | 18,000,000      | 6000 | 7725        | 2.36B               | 0.25        | 19.0         | 13.6          |

---

## 7. 🧑‍💻 Coding Examples

### Python

```python
def effective_jump_rating(mass, jr=6000, alpha=0.85):
    return jr * (mass / 1000.0) ** alpha

def quantum_tunneling_boost(mass, rated_theta=7725, ref_mass=62000000, gamma=2.0):
    return rated_theta * (mass / ref_mass) ** gamma

def boosted_range(mass, jr=6000, rated_theta=7725):
    r = effective_jump_rating(mass, jr)
    theta_eff = quantum_tunneling_boost(mass, rated_theta)
    return r * (1 + theta_eff)

def spin_up_time(mass, t0=10.0, ref_mass=62000000, delta=0.5):
    return t0 * (ref_mass / mass) ** delta

def cooldown_time(mass, c0=30.0, ref_mass=62000000, zeta=0.75):
    return c0 * (mass / ref_mass) ** zeta

def if_fraction(t, cooldown_time):
    return min(1.0, t / cooldown_time)

def forced_jump_range(full_range, t, cooldown_time):
    return full_range * if_fraction(t, cooldown_time)
```

### Rust

```rust
pub fn effective_jump_rating(mass: f64, jr: f64, alpha: f64) -> f64 {
    jr * (mass / 1000.0).powf(alpha)
}

pub fn quantum_tunneling_boost(mass: f64, rated_theta: f64, ref_mass: f64, gamma: f64) -> f64 {
    rated_theta * (mass / ref_mass).powf(gamma)
}

pub fn boosted_range(mass: f64, jr: f64, rated_theta: f64, ref_mass: f64, alpha: f64, gamma: f64) -> f64 {
    let r = effective_jump_rating(mass, jr, alpha);
    let theta_eff = quantum_tunneling_boost(mass, rated_theta, ref_mass, gamma);
    r * (1.0 + theta_eff)
}

pub fn spin_up_time(mass: f64, t0: f64, ref_mass: f64, delta: f64) -> f64 {
    t0 * (ref_mass / mass).powf(delta)
}

pub fn cooldown_time(mass: f64, c0: f64, ref_mass: f64, zeta: f64) -> f64 {
    c0 * (mass / ref_mass).powf(zeta)
}

pub fn if_fraction(t: f64, cooldown_time: f64) -> f64 {
    (t.min(cooldown_time)) / cooldown_time
}

pub fn forced_jump_range(full_range: f64, t: f64, cooldown_time: f64) -> f64 {
    full_range * if_fraction
