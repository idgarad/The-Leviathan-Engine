
> **Language Notice:** As of October 2025, Rust is the unified backend language for all simulation, orchestration, and infrastructure code in The Leviathan Engine project. All future code examples and integrations will use Rust.

Here’s a plain text summary of our discussion so far:

---

We explored backend language choices for building an MMO/MUD inspired by EVE Online, with emphasis on large-scale combat simulation, horizontal scaling, and deterministic physics. The debate centered on Rust, Go, and Zig:

- **Rust**: Strongest candidate for CPU-bound simulation. Zero-cost abstractions, memory safety without GC, excellent for ECS and physics-heavy workloads. Borrow checker enforces patterns that enable optimizations. Steeper learning curve but long-term maintainability and performance are superior.  
- **Go**: Great for distributed systems, orchestration, and I/O-heavy workloads. Simple concurrency model (goroutines, channels). Downsides are garbage collection and weaker control over memory layout, which can cause jitter in real-time combat.  
- **Zig**: Offers C-like control and predictable performance, but ecosystem is young and lacks high-level abstractions. Best for specialized modules, not the entire backend.


Final Decision (October 2025):
The Leviathan Engine project will move forward with Rust as the unified backend language for all simulation, orchestration, and infrastructure code. This decision is based on technical, gameplay, and maintainability considerations documented above. All future code examples and integrations will use Rust.

---

**Grid Mechanics:**
- The world is divided into grids (simulation shards) to isolate load.  
- Grids must adapt dynamically: POIs (planets, moons, stations, depots, player-built structures) get envelopes based on maximum manual travel range.  
- If envelopes overlap, POIs must be in the same grid; otherwise, warp transitions are required.  
- With a max ship speed of 20,000 km/hr and 22 hours of available travel, the maximum manual range is 440,000 km. This defines the envelope radius.  
- New POIs can trigger grid merges or expansions. Corridors can be created to allow manual flight between grids without merging them entirely.  
- Hysteresis and cooldowns prevent constant merging/splitting.

---

**Combat Simulation:**
- Inspired by EVE Online, requiring tracking of turrets vs. transversal velocities.  
- Rust’s borrow checker does not hinder optimization; instead, it enables LLVM to optimize more aggressively. ECS with struct-of-arrays layout is cache-friendly and SIMD-optimized.  
- Go’s GC and memory model make it less suited for deterministic, physics-heavy combat.

---

**Time Dilation and Load Management:**
- Grids can slow their tick rate under load to preserve accuracy. This is explained diegetically as “remote command latency.”  
- Each grid is represented in-lore as a **Command Node**.  
- Command Nodes can:  
  - Enforce a maximum ship cap (with faction/fleet exceptions for reinforcements).  
  - Deny or throttle warp-ins when congested.  
  - Enter **time dilation mode** under heavy load, slowing combat but keeping it accurate.  
- Overloading a Command Node becomes a strategic gameplay element (e.g., blockading reinforcements).  
- This turns backend scaling constraints into emergent gameplay mechanics.

---

**Key Takeaways:**
- Rust is the best single-language choice for the backend.  
- Grids are dynamic, sized by reachable POIs, with corridors to preserve manual flight.  
- Combat simulation benefits from Rust’s ECS and SIMD optimizations.  
- Command Nodes provide a diegetic explanation for load management, with caps, throttling, and time dilation as both technical safeguards and strategic gameplay features.

---
