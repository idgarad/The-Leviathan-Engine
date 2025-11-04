2025-11-01 Entry 1
After a fair bit of testing, Consul is just too much overkill really for the dev environment, the justification just isn't there from a managment load despite what nomad brings. It just wasn't something I felt was worth the time or the effort for a predominatly educational tool. Garage I think is the more direct solution for this project since the only real use of it I see is terraform. Perhaps using it for config data as a repo for run-time configs might squeeze some additional use from it but to be honest I'd be hard pressed to think that as neccesary. My estimates are about 4 gigs worth of config data but I have to get the engine to a point where we can start testing the NPC memory subsystem to start looking at how the data will scale. With a 22 hour day and using just 500 concurrent users, I came up with nearly 50mb of memory data, per day, per NPC faction. Just 200 factions makes that a huge amount but it wouldn't require and sophisticate storage, it could be just ZFS with block level dedup and even that would be overkill. A simulated memory file that was 10 gbs compressed down to less than 100 mb as a gzip so it's highly compressable data already.I am honestly more worried about IO constraints processing the nightly update batch. I still have to contend with the time scale also.

2025-10-31 Entry 1

It may seem pedantic to do all this infrastructure work first for a git repo for a small learning project but it is important because we need to, in evaluating solutions, take into account what tool we have available. Compromises often have to be made in the real business world. This whole pre-process is a learning journey in-of-itself in analyizing what technical debt we will accrue with our solutions. Ideally if possible we would then, at the end, rebuild a deployment of this infrastructure as code to effectively re-create itself. That way is someone is building their first homelab this part illustrates the steps and foundation blocks that need to be in place. By the time they are done going through this process, they'll understand the pitfalls of configuring infrastructure. Then when we get to IAC, the coding decisions we make when it comes to scalability make more sense on the design choices. Someone might fire up this MUD and find they can no longer self host it, but in the process of following this project, in turn hopefully, be able to easly migrate it to a cloud service provider and scale it as needed. For larger enterprises it can be used as a Integration and Performance test of infrastructure in a more, enteraining way. Nothing like using it as a shakeout tool for a week or two, test DR and HA mechanisms all while reading daily digests about NPCs having a space war.

Need to perfomrance test a new network? Fire up a few hundred agents and have them go to town in a virtual space battle for a few days. I think ideally we want to generate our own iMark style performance scores and if we are lucky, get some volunteers to contribute code to push this engine to better performance.

A good example of this was working towards Terraform. We first tried MinIO but it generated it's secret keys before we could even see them since we ran it as a service.d with no way to rebuild those keys. Eh.. I felt that was an oversight that didn't sit right. So then it was Garage which does allow key generation which makes more sense since I find sharing keys problematic in an enterprise. Key segretation is something I am a fan of, checking super user IDs is one thing, but sharing security tokens of any kind I find problematic. Then we looked at Consul as a solution... which could bring us Nomad as a bonus.

In the corporate environment with multiple stakeholders you will run into this a lot. You need a solution, then if you ask the right questions you find out there are other groups and people that also need parts of that soution and it is much easier to get a capex for a solution one projet wants, when it is also something that 10 other projects want. So we are now leaning on setting up Consul and Nomad, dropping ceph, garage, minio, and NFS as potential backends. We are getting Consul and Nomad functionality for 'free' when all we really needed was a stateful place to toss some Terraform state info into.

But again we may just end back up on a thumb drive plugged into an DD-WRT router with NFS running. That is the tough part of engineering a solution, it isn't just the software, it's what it is going to run on, how you can manage it, and keep it up and running at a low cost point.

I am tracking the pve1 machine's load pre deployment for example, right now we sit at 146w load. We were at 122w before this project so we know the VMs we've created (we are only at the 2.1 infrastructure config point so far) Once we are done I will shut down all the VMs, rebase line the load and if we can put that into the prometheus monitoring so we can keep tabs. In my day job performance-per-watt is a major factor for many solutions. It a reason we had to abandon CEPH (among other configuration quirks with missing keys) as it wants physical disks. It wasn't worth implementing when we have a ZFS backed NAS (technically it's on pve1 because I find running TrueNAS virtualized overkill) that is a pointless cost for something that effectively we want to do nothing more than store some terraform data.

I have to deal with AWS and Azure in the enterprise as it is so this extra leg work is a good foundation for understanding pitfalls and design constraints and I want to make sure someone following along with this understand the infrastructure part as best as a project like this can provide. Again it is also how I am evaluating tools like ChatGPT and Claude for their accuracy and effecacy in their solutions. I have a solid 1k developers between onshore and offshore and I need to make sure, while I am no expert in well.. anything... I have to be able to follow the conversations to be effective in mitigating 'Unforseen Consequences' (Queue the Half-Life music singer and start wiping off the crowbar...) in the enterprise. I don't have to be an SME, but I do need to understand what the arguments are and what is at stake.

Signed: Idgarad Lyracant via VsCode and GitHub Copilot

---

2025-10-30 Entry 2
Today we are researching and evaluating the appropriate licensing requirements for The Leviathan Engine project. The goal is to ensure the engine is freely available for educational purposes and unrestricted for non-commercial individual use, while limiting commercial exploitation. We are considering GNU or GPL licensing as a possible solution, but will review all options to best balance openness and protection. This is an important step to support the project's educational mission and community accessibility.

Signed: Idgarad Lyracant via VsCode and GitHub Copilot

---

2025-10-30 Entry 1
Today is going well as we make progress on infrastructure development. GitLab and Docker are already up and running, and we will be moving on to Terraform soon. I am continuing to develop documentation with the AI to ensure a sensible structure and flow for building out this project.

I have experimented with using Copilot's voice chat to reduce typing. It is mildly effective.

I am working to ensure we have a solid foundation of infrastructure to emulate a typical CI/CD pipeline. With my background in managing hundreds of concurrent projects, my hope is that we accomplish several goals:
1. Learn a new language—specifically Rust.
2. As is tradition, build the galaxy generator in Rust.
3. Gain a better understanding of the "below-the-glass" aspects of DevOps and CI/CD pipelines.
4. Use this project to facilitate learning about cloud management and infrastructure as code, supporting test environment integrity and cloud services.
5. Structure the "Dwarf Fortress meets Eve Online" project as an educational tool, providing learning opportunities throughout development.
6. Use this tool as a general benchmark for infrastructure performance. As a real-time MUD/MMO simulation, even with zero players, the ongoing simulation and NPC data provide an excellent opportunity to stress-test infrastructure. With a variable datastore backend, we can benchmark world generation, data import, simulated player stubs, variable active NPCs, and push the architecture as hard as needed.
7. Apply a Unix-like philosophy of Loosely Coupled Systems (LCS) for natural horizontal scaling—from single node (All-in-One) setups to distributed deployments. Ideally, this could run on a laptop or expand into the cloud on demand.
8. Make the project fun, catering to those who prefer grounded ships-in-space gameplay over real-time graphics. If Eve Online is Star Trek, this project is The Expanse.
9. I strongly believe in the ICM—Idgarad's Conceptual Model:
    - MMOs are like a apple: the MMO is the skin, and the virtual world is the actual fruit. The MMO is a tool for interacting with a virtual world.
    - The MMO should be structured as a hobby, like gardening. You can't "beat" an MMO; content should scale as a hobby. Break the mentality of theme park vs open world and think more of 'what tools can I give the player the same way I look at how a gardener looks at tool to make gardening more enjoyable.
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
