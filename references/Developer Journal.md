

2025-10-30 Entry 1
Today is going well as we make progress on infrastructure development. GitLab and Docker are already up and running, and we will be moving on to Terraform soon. I am continuing to develop documentation with the AI to ensure a sensible structure and flow for building out this project.

I have experimented with using Copilot's voice chat to reduce typing. It is mildly effective.

I am working to ensure we have a solid foundation of infrastructure to emulate a typical CI/CD pipeline. With my background in managing hundreds of concurrent projects, my hope is that we accomplish several goals:
1. Learn a new language—specifically Go.
2. As is tradition, build the galaxy generator in Go.
3. Gain a better understanding of the "below-the-glass" aspects of DevOps and CI/CD pipelines.
4. Use this project to facilitate learning about cloud management and infrastructure as code, supporting test environment integrity and cloud services.
5. Structure the "Dwarf Fortress meets Eve Online" project as an educational tool, providing learning opportunities throughout development.
6. Use this tool as a general benchmark for infrastructure performance. As a real-time MUD/MMO simulation, even with zero players, the ongoing simulation and NPC data provide an excellent opportunity to stress-test infrastructure. With a variable datastore backend, we can benchmark world generation, data import, simulated player stubs, variable active NPCs, and push the architecture as hard as needed.
7. Apply a Unix-like philosophy of Loosely Coupled Systems (LCS) for natural horizontal scaling—from single node (All-in-One) setups to distributed deployments. Ideally, this could run on a laptop or expand into the cloud on demand.
8. Make the project fun, catering to those who prefer grounded ships-in-space gameplay over real-time graphics. If Eve Online is Star Trek, this project is The Expanse.
9. I strongly believe in the ICM—Idgarad's Conceptual Model:
    - MMOs are like a peach: the MMO is the fruit, and the virtual world is the pit. The MMO is a tool for interacting with a virtual world.
    - The MMO should be structured as a hobby, like gardening. You can't "beat" an MMO; content should scale as a hobby.
    - Content should be structured, when possible, in a Three Tier Approach:
        - Tier 1: The Single Player experience. Tier 1 quests or missions should be achievable by a single player (e.g., a typical "fetch" quest). Tier 1 content should be completable in a reasonable amount of time—about 30 minutes, including travel. Tier content should scale with reasonable expectations.
        - Tier 2: The Group and Guide experience. This is collaborative content for two or more people (e.g., dungeons in fantasy MMOs). Expected completion time might be an hour.
        - Tier 3: Faction or realm content. This is raid-level content for groups of groups (e.g., large fleets in a sci-fi setting).
    - This relationship forces content to ask: "What does X look like at Tier 1, Tier 2, and Tier 3?"
        - These are guidelines, not hard rules. For example, consider the gameplay feature: Fishing.
            - Tier 1 Fishing: Solo fishing at a lake or river, using basic equipment (rod, bait). The player can catch common fish, improve personal fishing skill, and enjoy a relaxing, self-paced experience. Rewards are personal and limited to what one player can carry or cook.
            - Tier 2 Fishing: Group fishing expeditions, such as chartering a boat with friends or joining a small fishing crew. Players coordinate roles (captain, net handler, spotter), use advanced gear, and target larger or rarer fish. Shared rewards, teamwork, and access to special fishing locations (deep sea, remote islands).
            - Tier 3 Fishing: Faction or organization-level fishing operations. Large fleets or guilds manage commercial fishing, control maritime territory, and compete for market dominance. Activities include resource management, trade negotiations, and defending fishing rights against rival groups. Rewards scale to the organization, with economic and political impact on the game world.
10. "As Above, As Below"
    1.  We want the NPCs to have to utilize the same information and tools as a player. If the NPC needs 500 ships, those should be built the same way a player would build 100 ships. It also means they have to deal with lag and downtime just like a player would. We in turn should make sure players have full access to the same mechanics as the NPCs and various factions.
11. "What happens in the game, stays in the game."
    1.  We want to ensure that players have all the tools to enact thier gameplay options. We do not want them engaging in spying outside of the game for example (a source of a lot of drama in games like EVE Online) rather ensure they have in-game mechanics to achieve that.
    2.  Informally known as the Vegas Rule.

I believe this project can achieve these points. Additionally, I am evaluating AI development tools to learn their quirks and nuances, as I am often the one who must herd all those metaphorical "cats" into the barn called production.
Signed: Idgarad Lyracant via VsCode and GitHub Copilot
