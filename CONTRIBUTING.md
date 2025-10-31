# Contributing to The Leviathan Engine
> **Language Notice:** As of October 2025, Rust is the unified backend language for all simulation, orchestration, and infrastructure code in The Leviathan Engine project. All future code examples and integrations will use Rust.

Thank you for your interest in contributing to The Leviathan Engine! This project operates with a dual-repository approach that balances development efficiency with community collaboration.

## 🏗️ Development Architecture

### GitLab (Primary Development)
- **Purpose**: Full CI/CD pipeline, private development workflows
- **Access**: Internal development team and infrastructure
- **Features**: Automated testing, deployment pipelines, infrastructure management

### GitHub (Public Mirror) 
- **Purpose**: Community access, code visibility, public collaboration
- **Access**: Open to everyone for review, issues, and discussions
- **Sync**: Automatic mirror from GitLab main branch (excluding sensitive files)

## 🤝 How to Contribute

### 1. Community Contributions
**GitHub Repository (this one)**
- 🐛 **Bug Reports**: File issues with detailed reproduction steps
- 💡 **Feature Requests**: Suggest enhancements and gameplay ideas
- 📚 **Documentation**: Improve tutorials, examples, and guides
- 🗣️ **Discussions**: Participate in architecture and design conversations

### 2. Code Contributions
**Process Overview:**
1. **Propose Changes**: Start with a GitHub issue to discuss your idea
2. **Development**: Fork this repository and create a feature branch
3. **Testing**: Ensure your changes include comprehensive tests
4. **Pull Request**: Submit PR with clear description and rationale
5. **Review**: Community and maintainer review process
6. **Integration**: Approved changes merged to GitLab and synced back

### 3. Documentation Contributions
**High Priority Areas:**
- Tutorial improvements and new examples
- API documentation and code samples  
- Performance optimization guides
- Game design pattern explanations
- Infrastructure setup documentation

## 🎯 Contribution Guidelines

### Code Quality Standards
```go
// All contributions must follow the established patterns:
// 1. Comprehensive documentation with examples
// 2. Educational value for learning Go and MUD development
// 3. Performance awareness and monitoring integration
// 4. ICM three-tier design compliance where applicable

// Example: Well-documented contribution
// CommandProcessor handles player input with comprehensive monitoring.
// This serves as a reference implementation for MUD command processing
// patterns, demonstrating proper error handling, performance tracking,
// and the ICM three-tier interaction framework.
type CommandProcessor struct {
    // metrics provides real-time command performance monitoring
    // Following the BTOP-inspired philosophy of comprehensive metrics
    metrics *CommandMetrics
    
    // handlers contains registered command implementations
    // Each command must support all applicable ICM tiers
    handlers map[string]CommandHandler
}
```

### Documentation Standards
- **Self-Documenting Code**: Every function and struct needs complete documentation
- **Educational Context**: Explain WHY decisions were made, not just what they do
- **Tutorial Integration**: Consider how your contribution teaches MUD development
- **Performance Notes**: Include performance implications and monitoring points

### Testing Requirements
- **Unit Tests**: 90%+ code coverage with meaningful assertions
- **Integration Tests**: End-to-end scenarios with real data flows
- **Performance Tests**: Baseline measurements for regression detection
- **Educational Tests**: Tests that serve as usage examples

## 🧪 Development Environment

### Local Setup
```bash
# 1. Fork and clone this repository
git clone https://github.com/YOUR_USERNAME/The-Leviathan-Engine.git
cd The-Leviathan-Engine

# 2. Start development environment
docker-compose up -d

# 3. Install Go dependencies
go mod tidy

# 4. Run tests
go test ./...

# 5. Start development server
go run cmd/server/main.go
```

### Code Style
- Follow standard Go conventions (`gofmt`, `golint`, `go vet`)
- Use meaningful variable and function names
- Include comprehensive comments for complex logic
All gameplay features must consider the three-tier interaction model:

**Tier 1 - Individual Content**
- Personal skill development and progression
- Solo gameplay mechanics and challenges
- Individual resource management

**Tier 2 - Group Content**
- Small team cooperation (2-10 players)
- Shared objectives requiring coordination
- Enhanced capabilities through teamwork

**Tier 3 - Faction Content**
- Large-scale organizational activities
- Political and economic influence systems
- Territory control and resource management

### Content Scaling Philosophy
- **Dynamic Adaptation**: Content scales to player count, not vice versa
- **Meaningful Challenge**: Maintains engagement at all participation levels
- **Proportional Rewards**: Benefits scale appropriately with group size
- **Lore Consistency**: Scaling feels natural within the game world

## 🔍 Review Process

### Community Review

## Coding Standards

- Rust for backend and infrastructure
4. **Performance Impact**: Assess implications for scalability targets

4. **GitHub Sync**: Changes mirrored back to public repository

## 🏆 Recognition

### Contributor Recognition
- **Contributors List**: Maintained in repository documentation
- **Educational Impact**: Highlight contributions that improve learning resources
- **Community Awards**: Recognition for outstanding community engagement
- **Tutorial Attribution**: Credit for significant documentation improvements

### Types of Contributions Valued
- **Educational Excellence**: Contributions that teach MUD development concepts
- **Performance Innovation**: Optimizations and monitoring improvements
- **Community Building**: Documentation, examples, and mentoring
- **Game Design**: ICM-compliant gameplay features and mechanics

## 🚀 Getting Started

### First Contribution Ideas
- **Documentation Improvements**: Fix typos, clarify explanations, add examples
- **Test Coverage**: Add tests for existing code to improve reliability
- **Performance Monitoring**: Add metrics and monitoring to existing systems
- **Tutorial Development**: Create step-by-step guides for specific features

### Advanced Contributions
- **New Commands**: Implement MUD commands following established patterns
- **Gameplay Systems**: Add ICM-compliant game mechanics and features
- **Infrastructure Tools**: Improve deployment and monitoring automation
- **Performance Optimization**: Enhance scalability and response times

## 📞 Communication

### Community Channels
- **GitHub Issues**: Bug reports, feature requests, technical discussions
- **GitHub Discussions**: General questions, design conversations, help requests
- **Pull Request Comments**: Code-specific feedback and technical review

### Maintainer Contact
- **GitHub Issues**: Primary communication method for development topics
- **Direct Contact**: Available for complex architectural discussions

---

**Thank you for helping build the future of MUD development education! 🎮✨**

Every contribution, no matter how small, helps create a better learning resource for the entire MUD development community.