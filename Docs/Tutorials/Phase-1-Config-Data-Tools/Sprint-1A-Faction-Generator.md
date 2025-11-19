# Sprint 1A: Faction Config Generator

> **Week 3** | **Estimated Time: 12-16 hours** | **Learning Focus: Structs, Enums, File I/O, CLI Arguments**

---

## 🎯 Learning Objectives

1. **Struct Design**: Model real-world data with Rust structs and derive macros
2. **Enum Usage**: Use enums for type-safe categorization and pattern matching
3. **Serialization**: Convert Rust data to/from TOML configuration files
4. **CLI Interface**: Build command-line tools with argument parsing
5. **File Operations**: Read, write, and validate configuration files

---

## 🚫 Scope Boundaries (What We're NOT Doing)

- ❌ **No database storage** - File-based configs only (Sprint 2B material)
- ❌ **No web interface** - CLI tool only (Sprint 6A material)
- ❌ **No complex validation rules** - Basic validation only
- ❌ **No interactive prompts** - Command-line arguments only

---

## 📚 Learning Resources for This Sprint

### Books
- **"The Rust Programming Language"** (The Rust Team)
  - ISBN: 978-1718500440
  - **Focus**: Chapter 5 (Structs), Chapter 6 (Enums and Pattern Matching)
  - Free online: https://doc.rust-lang.org/book/ch05-00-structs.html

- **"Command-Line Rust"** (Ken Youens-Clark)
  - ISBN: 978-1098109417
  - **Focus**: Chapters 1-3 (CLI basics and argument parsing)

### Online Resources
- **Serde Documentation**: Serialization library
  - Link: https://serde.rs/
  - **Focus**: Derive macros and TOML format

- **Clap Documentation**: Command-line argument parser
  - Link: https://docs.rs/clap/latest/clap/
  - **Focus**: Basic usage and derive API

### Academic Papers
- **"Configuration Management: A Survey"** (Delaet et al., 2010)
  - Available: https://doi.org/10.1145/1880022.1880025
  - **Relevance**: Understanding configuration file design principles

---

## 🏗️ Project: Faction Configuration Generator

### The Challenge
Build a CLI tool that generates TOML configuration files for game factions. This teaches struct design, serialization, and file operations while creating something immediately useful for our eventual game engine.

### Step 1: Project Setup and Dependencies
```bash
# Create new project
cargo new faction-generator
cd faction-generator

# Add dependencies to Cargo.toml
```

**File: `Cargo.toml`**
```toml
[package]
name = "faction-generator"
version = "0.1.0"
edition = "2021"

[dependencies]
serde = { version = "1.0", features = ["derive"] }
toml = "0.8"
clap = { version = "4.0", features = ["derive"] }
anyhow = "1.0"  # For easy error handling

[dev-dependencies]
tempfile = "3.0"  # For testing with temporary files
```

### Step 2: Define Core Data Structures

**File: `src/faction.rs`**
```rust
//! Faction data structures for The Leviathan Engine
//! 
//! This module defines the core data types used to represent
//! political entities in the game world.

use serde::{Deserialize, Serialize};
use std::collections::HashMap;

/// Represents different types of political entities
#[derive(Debug, Clone, PartialEq, Serialize, Deserialize)]
#[serde(rename_all = "snake_case")]
pub enum FactionType {
    /// Major noble houses with territorial claims
    House,
    /// Commercial entities focused on trade and manufacturing
    Corporation,
    /// Military organizations serving the Empire
    WardenClan,
    /// Temporary alliances between smaller entities
    Coalition,
}

/// Represents the economic focus of a faction
#[derive(Debug, Clone, PartialEq, Serialize, Deserialize)]
#[serde(rename_all = "snake_case")]
pub enum EconomicFocus {
    /// Emphasis on resource extraction and raw materials
    Mining,
    /// Focus on manufacturing and value-added production
    Manufacturing,
    /// Specialization in trade and logistics
    Commerce,
    /// Military contracting and security services
    Military,
    /// Balanced approach across all economic sectors
    Diversified,
}

/// Represents the territorial scope of a faction's influence
#[derive(Debug, Clone, PartialEq, Serialize, Deserialize)]
#[serde(rename_all = "snake_case")]
pub enum TerritorialScope {
    /// Single system or station
    Local,
    /// Multiple systems within an array
    Regional,
    /// Entire arrays or multiple arrays
    Sector,
    /// Cross-sector influence
    Imperial,
}

/// Core faction configuration
/// 
/// This struct represents all the data needed to configure
/// a faction in The Leviathan Engine.
#[derive(Debug, Clone, PartialEq, Serialize, Deserialize)]
pub struct FactionConfig {
    /// Unique identifier for this faction
    pub id: String,
    
    /// Display name for the faction
    pub name: String,
    
    /// Optional short description or motto
    pub description: Option<String>,
    
    /// Type of political entity this faction represents
    pub faction_type: FactionType,
    
    /// Economic specialization
    pub economic_focus: EconomicFocus,
    
    /// Scope of territorial influence
    pub territorial_scope: TerritorialScope,
    
    /// Starting military strength (0-100 scale)
    pub military_strength: u8,
    
    /// Starting economic power (0-100 scale)
    pub economic_power: u8,
    
    /// Starting political influence (0-100 scale)
    pub political_influence: u8,
    
    /// Key-value pairs for custom attributes
    pub custom_attributes: HashMap<String, String>,
    
    /// Configuration metadata
    pub metadata: FactionMetadata,
}

/// Metadata about the faction configuration
#[derive(Debug, Clone, PartialEq, Serialize, Deserialize)]
pub struct FactionMetadata {
    /// When this configuration was created
    pub created_at: String,
    
    /// Tool version that created this config
    pub generator_version: String,
    
    /// Optional notes about this configuration
    pub notes: Option<String>,
}

impl FactionConfig {
    /// Create a new faction configuration with default values
    /// 
    /// # Arguments
    /// 
    /// * `id` - Unique identifier for the faction
    /// * `name` - Display name for the faction
    /// 
    /// # Returns
    /// 
    /// A new `FactionConfig` with reasonable default values
    /// 
    /// # Examples
    /// 
    /// ```
    /// use faction_generator::faction::FactionConfig;
    /// 
    /// let faction = FactionConfig::new("house_bakken".to_string(), "House Bakken".to_string());
    /// assert_eq!(faction.id, "house_bakken");
    /// assert_eq!(faction.name, "House Bakken");
    /// ```
    pub fn new(id: String, name: String) -> Self {
        Self {
            id,
            name,
            description: None,
            faction_type: FactionType::House,
            economic_focus: EconomicFocus::Diversified,
            territorial_scope: TerritorialScope::Regional,
            military_strength: 50,
            economic_power: 50,
            political_influence: 50,
            custom_attributes: HashMap::new(),
            metadata: FactionMetadata {
                created_at: chrono::Utc::now().to_rfc3339(),
                generator_version: env!("CARGO_PKG_VERSION").to_string(),
                notes: None,
            },
        }
    }
    
    /// Validate that the faction configuration is reasonable
    /// 
    /// # Returns
    /// 
    /// `Ok(())` if valid, `Err` with description if invalid
    pub fn validate(&self) -> anyhow::Result<()> {
        if self.id.is_empty() {
            return Err(anyhow::anyhow!("Faction ID cannot be empty"));
        }
        
        if self.name.is_empty() {
            return Err(anyhow::anyhow!("Faction name cannot be empty"));
        }
        
        if self.military_strength > 100 {
            return Err(anyhow::anyhow!("Military strength must be 0-100"));
        }
        
        if self.economic_power > 100 {
            return Err(anyhow::anyhow!("Economic power must be 0-100"));
        }
        
        if self.political_influence > 100 {
            return Err(anyhow::anyhow!("Political influence must be 0-100"));
        }
        
        Ok(())
    }
}

#[cfg(test)]
mod tests {
    use super::*;
    
    #[test]
    fn test_faction_creation() {
        let faction = FactionConfig::new(
            "test_faction".to_string(),
            "Test Faction".to_string(),
        );
        
        assert_eq!(faction.id, "test_faction");
        assert_eq!(faction.name, "Test Faction");
        assert_eq!(faction.faction_type, FactionType::House);
        assert_eq!(faction.military_strength, 50);
    }
    
    #[test]
    fn test_faction_validation_valid() {
        let faction = FactionConfig::new(
            "valid_faction".to_string(),
            "Valid Faction".to_string(),
        );
        
        assert!(faction.validate().is_ok());
    }
    
    #[test]
    fn test_faction_validation_empty_id() {
        let mut faction = FactionConfig::new(
            "".to_string(),
            "Valid Name".to_string(),
        );
        
        assert!(faction.validate().is_err());
    }
    
    #[test]
    fn test_faction_validation_invalid_strength() {
        let mut faction = FactionConfig::new(
            "test".to_string(),
            "Test".to_string(),
        );
        faction.military_strength = 101;
        
        assert!(faction.validate().is_err());
    }
    
    #[test]
    fn test_serialization_roundtrip() {
        let original = FactionConfig::new(
            "serialization_test".to_string(),
            "Serialization Test".to_string(),
        );
        
        // Convert to TOML
        let toml_string = toml::to_string(&original).unwrap();
        
        // Parse back from TOML
        let deserialized: FactionConfig = toml::from_str(&toml_string).unwrap();
        
        assert_eq!(original.id, deserialized.id);
        assert_eq!(original.name, deserialized.name);
        assert_eq!(original.faction_type, deserialized.faction_type);
    }
}
```

---

## ✅ Success Criteria

### Must Complete Before Moving to Sprint 1B:
- [ ] Faction generator compiles and runs without errors
- [ ] Can generate valid TOML files from command-line arguments
- [ ] All tests pass (`cargo test` succeeds)
- [ ] Tool validates configuration files and reports errors clearly
- [ ] Documentation is complete with examples

### Understanding Check:
- [ ] Can explain the difference between `struct` and `enum`
- [ ] Understand what `#[derive(Serialize, Deserialize)]` does
- [ ] Can add new fields to structs and update tests
- [ ] Comfortable with `Result<T, E>` error handling patterns

---

## 🚨 Common Temptations to Avoid

### Scope Creep Warnings:
- **"Let's add a database backend"** → Sprint 2B material
- **"I should make this interactive with prompts"** → CLI arguments are sufficient
- **"Let me add complex faction relationship modeling"** → Future enhancement
- **"I need to handle all possible TOML edge cases"** → Basic serialization is enough

Remember: We're learning Rust fundamentals by building useful tools. Perfect faction modeling isn't the goal - understanding structs, enums, and file I/O is the goal.

---

**Next Sprint**: [Sprint 1B: Ship Design Validator](./Sprint-1B-Ship-Validator.md)

*This sprint establishes the foundation for all future configuration management tools. Focus on getting comfortable with Rust's type system and serialization patterns.*