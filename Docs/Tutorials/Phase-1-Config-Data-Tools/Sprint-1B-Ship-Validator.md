# Sprint 1B: Ship Design Validator

> **Week 4** | **Estimated Time: 12-16 hours** | **Learning Focus: Error Handling, Pattern Matching, Validation Logic**

---

## 🎯 Learning Objectives

1. **Advanced Error Handling**: Custom error types, error propagation, and meaningful error messages
2. **Pattern Matching Mastery**: Complex `match` expressions and exhaustive pattern coverage
3. **Validation Patterns**: Building robust validation logic for complex data structures
4. **File Processing**: Reading multiple files, batch processing, and reporting
5. **Professional Error Reporting**: User-friendly error messages with context

---

## 🚫 Scope Boundaries (What We're NOT Doing)

- ❌ **No GUI validation interface** - CLI tool only (Sprint 6A material)
- ❌ **No network validation** - Local file processing only
- ❌ **No performance optimization** - Focus on correctness (Sprint 3B material)  
- ❌ **No complex physics simulation** - Rule-based validation only

---

## 📚 Learning Resources for This Sprint

### Books
- **"The Rust Programming Language"** (The Rust Team)
  - ISBN: 978-1718500440
  - **Focus**: Chapter 9 (Error Handling), Chapter 6 (Pattern Matching)
  - Free online: https://doc.rust-lang.org/book/ch09-00-error-handling.html

- **"Effective Rust"** (David Drysdale)
  - ISBN: 978-1718503229
  - **Focus**: Items on error handling and pattern matching

### Online Resources
- **Rust Error Handling**: thiserror and anyhow crates
  - Link: https://docs.rs/thiserror/latest/thiserror/
  - Link: https://docs.rs/anyhow/latest/anyhow/
  - **Focus**: Creating custom error types vs. using dynamic errors

### Academic Papers
- **"A Few Billion Lines of Code Later: Using Static Analysis to Find Bugs in the Real World"** (Bessey et al., 2010)
  - Available: https://cacm.acm.org/magazines/2010/2/69354-a-few-billion-lines-of-code-later/fulltext
  - **Relevance**: Understanding validation and static analysis principles

---

## 🚀 Project: Ship Design Validator

### The Challenge
Build a validator that checks ship configuration files against design rules. This teaches advanced error handling, complex validation logic, and batch file processing while creating a tool that ensures ship designs are balanced and legal within the game's rules.

### Step 1: Project Setup
```bash
# Create new project
cargo new ship-validator
cd ship-validator
```

**File: `Cargo.toml`**
```toml
[package]
name = "ship-validator"
version = "0.1.0"
edition = "2021"

[dependencies]
serde = { version = "1.0", features = ["derive"] }
toml = "0.8"
clap = { version = "4.0", features = ["derive"] }
thiserror = "1.0"  # For custom error types
anyhow = "1.0"     # For error context
walkdir = "2.4"    # For recursive file searching
colored = "2.0"    # For colored terminal output

[dev-dependencies]
tempfile = "3.0"
```

### Step 2: Define Ship Data Structures

**File: `src/ship.rs`**
```rust
//! Ship configuration data structures and validation logic

use serde::{Deserialize, Serialize};
use std::collections::HashMap;

/// Represents different ship size classes
#[derive(Debug, Clone, PartialEq, Serialize, Deserialize)]
#[serde(rename_all = "snake_case")]
pub enum ShipClass {
    Frigate,
    Destroyer,
    Cruiser,
    Battlecruiser,
    Battleship,
    Dreadnought,
}

impl ShipClass {
    /// Get the base power grid for this ship class
    pub fn base_power_grid(&self) -> u32 {
        match self {
            ShipClass::Frigate => 100,
            ShipClass::Destroyer => 200,
            ShipClass::Cruiser => 400,
            ShipClass::Battlecruiser => 600,
            ShipClass::Battleship => 800,
            ShipClass::Dreadnought => 1000,
        }
    }
    
    /// Get the base CPU capacity for this ship class
    pub fn base_cpu_capacity(&self) -> u32 {
        match self {
            ShipClass::Frigate => 50,
            ShipClass::Destroyer => 100,
            ShipClass::Cruiser => 200,
            ShipClass::Battlecruiser => 300,
            ShipClass::Battleship => 400,
            ShipClass::Dreadnought => 500,
        }
    }
    
    /// Get maximum module slots for this ship class
    pub fn max_module_slots(&self) -> usize {
        match self {
            ShipClass::Frigate => 8,
            ShipClass::Destroyer => 12,
            ShipClass::Cruiser => 16,
            ShipClass::Battlecruiser => 20,
            ShipClass::Battleship => 24,
            ShipClass::Dreadnought => 32,
        }
    }
}

/// Represents different types of ship modules
#[derive(Debug, Clone, PartialEq, Serialize, Deserialize)]
#[serde(rename_all = "snake_case")]
pub enum ModuleType {
    Weapon,
    Defense,
    Engineering,
    Navigation,
    Command,
    Cargo,
}

/// Represents a ship module/component
#[derive(Debug, Clone, PartialEq, Serialize, Deserialize)]
pub struct ShipModule {
    /// Unique identifier for this module
    pub id: String,
    
    /// Display name
    pub name: String,
    
    /// Module category
    pub module_type: ModuleType,
    
    /// Power grid consumption
    pub power_consumption: u32,
    
    /// CPU usage
    pub cpu_usage: u32,
    
    /// Optional size/slot requirements
    pub slot_size: Option<u8>,
    
    /// Module-specific attributes
    pub attributes: HashMap<String, f64>,
}

/// Complete ship configuration
#[derive(Debug, Clone, PartialEq, Serialize, Deserialize)]
pub struct ShipConfig {
    /// Unique ship identifier
    pub id: String,
    
    /// Display name
    pub name: String,
    
    /// Ship class/size
    pub ship_class: ShipClass,
    
    /// Installed modules
    pub modules: Vec<ShipModule>,
    
    /// Configuration metadata
    pub metadata: ShipMetadata,
}

/// Ship configuration metadata
#[derive(Debug, Clone, PartialEq, Serialize, Deserialize)]
pub struct ShipMetadata {
    pub created_at: String,
    pub designer: Option<String>,
    pub version: String,
    pub notes: Option<String>,
}

impl ShipConfig {
    /// Calculate total power consumption of all modules
    pub fn total_power_consumption(&self) -> u32 {
        self.modules.iter().map(|m| m.power_consumption).sum()
    }
    
    /// Calculate total CPU usage of all modules
    pub fn total_cpu_usage(&self) -> u32 {
        self.modules.iter().map(|m| m.cpu_usage).sum()
    }
    
    /// Count modules by type
    pub fn module_count_by_type(&self, module_type: &ModuleType) -> usize {
        self.modules.iter()
            .filter(|m| &m.module_type == module_type)
            .count()
    }
}

#[cfg(test)]
mod tests {
    use super::*;
    
    #[test]
    fn test_ship_class_power_grid() {
        assert_eq!(ShipClass::Frigate.base_power_grid(), 100);
        assert_eq!(ShipClass::Dreadnought.base_power_grid(), 1000);
    }
    
    #[test]
    fn test_power_consumption_calculation() {
        let modules = vec![
            ShipModule {
                id: "module1".to_string(),
                name: "Test Module 1".to_string(),
                module_type: ModuleType::Weapon,
                power_consumption: 50,
                cpu_usage: 10,
                slot_size: Some(1),
                attributes: HashMap::new(),
            },
            ShipModule {
                id: "module2".to_string(),
                name: "Test Module 2".to_string(),
                module_type: ModuleType::Defense,
                power_consumption: 30,
                cpu_usage: 15,
                slot_size: Some(1),
                attributes: HashMap::new(),
            },
        ];
        
        let ship = ShipConfig {
            id: "test_ship".to_string(),
            name: "Test Ship".to_string(),
            ship_class: ShipClass::Frigate,
            modules,
            metadata: ShipMetadata {
                created_at: "2025-01-01T00:00:00Z".to_string(),
                designer: None,
                version: "0.1.0".to_string(),
                notes: None,
            },
        };
        
        assert_eq!(ship.total_power_consumption(), 80);
        assert_eq!(ship.total_cpu_usage(), 25);
    }
}
```

### Step 3: Create Custom Error Types

**File: `src/validation.rs`**
```rust
//! Ship validation logic and error types

use crate::ship::{ShipConfig, ShipClass, ModuleType};
use thiserror::Error;
use std::fmt;

/// Validation errors that can occur when checking ship designs
#[derive(Error, Debug, Clone)]
pub enum ValidationError {
    #[error("Power consumption ({actual}) exceeds grid capacity ({max}) by {overflow}")]
    PowerOverflow {
        actual: u32,
        max: u32,
        overflow: u32,
    },
    
    #[error("CPU usage ({actual}) exceeds capacity ({max}) by {overflow}")]
    CpuOverflow {
        actual: u32,
        max: u32,
        overflow: u32,
    },
    
    #[error("Too many modules: {actual} installed, maximum {max} allowed for {ship_class:?}")]
    TooManyModules {
        actual: usize,
        max: usize,
        ship_class: ShipClass,
    },
    
    #[error("Invalid module configuration: {module_id} - {reason}")]
    InvalidModule {
        module_id: String,
        reason: String,
    },
    
    #[error("Ship design rule violation: {rule}")]
    DesignRuleViolation {
        rule: String,
    },
    
    #[error("Missing required module type: {module_type:?}")]
    MissingRequiredModule {
        module_type: ModuleType,
    },
}

/// Result type for validation operations
pub type ValidationResult<T> = Result<T, ValidationError>;

/// Comprehensive validation report
#[derive(Debug, Clone)]
pub struct ValidationReport {
    pub ship_id: String,
    pub is_valid: bool,
    pub errors: Vec<ValidationError>,
    pub warnings: Vec<String>,
    pub info: Vec<String>,
}

impl ValidationReport {
    pub fn new(ship_id: String) -> Self {
        Self {
            ship_id,
            is_valid: true,
            errors: Vec::new(),
            warnings: Vec::new(),
            info: Vec::new(),
        }
    }
    
    pub fn add_error(&mut self, error: ValidationError) {
        self.is_valid = false;
        self.errors.push(error);
    }
    
    pub fn add_warning(&mut self, warning: String) {
        self.warnings.push(warning);
    }
    
    pub fn add_info(&mut self, info: String) {
        self.info.push(info);
    }
}

impl fmt::Display for ValidationReport {
    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
        writeln!(f, "Validation Report for: {}", self.ship_id)?;
        writeln!(f, "Status: {}", if self.is_valid { "✅ VALID" } else { "❌ INVALID" })?;
        
        if !self.errors.is_empty() {
            writeln!(f, "\nErrors:")?;
            for error in &self.errors {
                writeln!(f, "  • {}", error)?;
            }
        }
        
        if !self.warnings.is_empty() {
            writeln!(f, "\nWarnings:")?;
            for warning in &self.warnings {
                writeln!(f, "  ⚠ {}", warning)?;
            }
        }
        
        if !self.info.is_empty() {
            writeln!(f, "\nInfo:")?;
            for info in &self.info {
                writeln!(f, "  ℹ {}", info)?;
            }
        }
        
        Ok(())
    }
}

/// Ship design validator
pub struct ShipValidator {
    /// Whether to perform strict validation
    strict_mode: bool,
}

impl ShipValidator {
    pub fn new(strict_mode: bool) -> Self {
        Self { strict_mode }
    }
    
    /// Validate a complete ship configuration
    pub fn validate(&self, ship: &ShipConfig) -> ValidationReport {
        let mut report = ValidationReport::new(ship.id.clone());
        
        // Basic resource validation
        self.validate_power_consumption(ship, &mut report);
        self.validate_cpu_usage(ship, &mut report);
        self.validate_module_count(ship, &mut report);
        
        // Design rule validation
        self.validate_design_rules(ship, &mut report);
        
        // Add informational statistics
        self.add_ship_statistics(ship, &mut report);
        
        report
    }
    
    fn validate_power_consumption(&self, ship: &ShipConfig, report: &mut ValidationReport) {
        let total_power = ship.total_power_consumption();
        let max_power = ship.ship_class.base_power_grid();
        
        if total_power > max_power {
            report.add_error(ValidationError::PowerOverflow {
                actual: total_power,
                max: max_power,
                overflow: total_power - max_power,
            });
        } else if total_power > (max_power * 90 / 100) {
            report.add_warning(format!(
                "High power usage: {}% of capacity ({}/{})",
                (total_power * 100 / max_power),
                total_power,
                max_power
            ));
        }
    }
    
    fn validate_cpu_usage(&self, ship: &ShipConfig, report: &mut ValidationReport) {
        let total_cpu = ship.total_cpu_usage();
        let max_cpu = ship.ship_class.base_cpu_capacity();
        
        if total_cpu > max_cpu {
            report.add_error(ValidationError::CpuOverflow {
                actual: total_cpu,
                max: max_cpu,
                overflow: total_cpu - max_cpu,
            });
        } else if total_cpu > (max_cpu * 90 / 100) {
            report.add_warning(format!(
                "High CPU usage: {}% of capacity ({}/{})",
                (total_cpu * 100 / max_cpu),
                total_cpu,
                max_cpu
            ));
        }
    }
    
    fn validate_module_count(&self, ship: &ShipConfig, report: &mut ValidationReport) {
        let module_count = ship.modules.len();
        let max_modules = ship.ship_class.max_module_slots();
        
        if module_count > max_modules {
            report.add_error(ValidationError::TooManyModules {
                actual: module_count,
                max: max_modules,
                ship_class: ship.ship_class.clone(),
            });
        }
    }
    
    fn validate_design_rules(&self, ship: &ShipConfig, report: &mut ValidationReport) {
        // Rule: All ships must have at least one weapon
        if ship.module_count_by_type(&ModuleType::Weapon) == 0 {
            if self.strict_mode {
                report.add_error(ValidationError::MissingRequiredModule {
                    module_type: ModuleType::Command,
                });
            } else {
                report.add_warning("Ship has no weapons installed".to_string());
            }
        }
        
        // Rule: Large ships should have command modules
        match ship.ship_class {
            ShipClass::Battlecruiser | ShipClass::Battleship | ShipClass::Dreadnought => {
                if ship.module_count_by_type(&ModuleType::Command) == 0 {
                    report.add_warning("Large ship without command module".to_string());
                }
            }
            _ => {}
        }
        
        // Rule: Check for duplicate module IDs
        let mut seen_ids = std::collections::HashSet::new();
        for module in &ship.modules {
            if !seen_ids.insert(&module.id) {
                report.add_error(ValidationError::InvalidModule {
                    module_id: module.id.clone(),
                    reason: "Duplicate module ID".to_string(),
                });
            }
        }
    }
    
    fn add_ship_statistics(&self, ship: &ShipConfig, report: &mut ValidationReport) {
        let power_usage = ship.total_power_consumption();
        let cpu_usage = ship.total_cpu_usage();
        let max_power = ship.ship_class.base_power_grid();
        let max_cpu = ship.ship_class.base_cpu_capacity();
        
        report.add_info(format!(
            "Power efficiency: {}% ({}/{})",
            (power_usage * 100 / max_power),
            power_usage,
            max_power
        ));
        
        report.add_info(format!(
            "CPU efficiency: {}% ({}/{})",
            (cpu_usage * 100 / max_cpu),
            cpu_usage,
            max_cpu
        ));
        
        report.add_info(format!(
            "Module slots used: {}/{}",
            ship.modules.len(),
            ship.ship_class.max_module_slots()
        ));
    }
}

#[cfg(test)]
mod tests {
    use super::*;
    use crate::ship::*;
    use std::collections::HashMap;
    
    fn create_test_ship() -> ShipConfig {
        ShipConfig {
            id: "test_ship".to_string(),
            name: "Test Ship".to_string(),
            ship_class: ShipClass::Frigate,
            modules: vec![
                ShipModule {
                    id: "weapon_1".to_string(),
                    name: "Test Weapon".to_string(),
                    module_type: ModuleType::Weapon,
                    power_consumption: 50,
                    cpu_usage: 25,
                    slot_size: Some(1),
                    attributes: HashMap::new(),
                },
            ],
            metadata: ShipMetadata {
                created_at: "2025-01-01T00:00:00Z".to_string(),
                designer: Some("Test Designer".to_string()),
                version: "0.1.0".to_string(),
                notes: None,
            },
        }
    }
    
    #[test]
    fn test_valid_ship() {
        let ship = create_test_ship();
        let validator = ShipValidator::new(false);
        let report = validator.validate(&ship);
        
        assert!(report.is_valid);
        assert!(report.errors.is_empty());
    }
    
    #[test]
    fn test_power_overflow() {
        let mut ship = create_test_ship();
        ship.modules[0].power_consumption = 150; // Exceeds frigate capacity of 100
        
        let validator = ShipValidator::new(false);
        let report = validator.validate(&ship);
        
        assert!(!report.is_valid);
        assert_eq!(report.errors.len(), 1);
        
        match &report.errors[0] {
            ValidationError::PowerOverflow { actual, max, overflow } => {
                assert_eq!(*actual, 150);
                assert_eq!(*max, 100);
                assert_eq!(*overflow, 50);
            }
            _ => panic!("Expected PowerOverflow error"),
        }
    }
}
```

---

## ✅ Success Criteria

### Must Complete Before Moving to Sprint 2A:
- [ ] Ship validator compiles and runs without errors
- [ ] Can validate individual ship files and report specific errors
- [ ] Can batch-process directories of ship configuration files
- [ ] All tests pass with comprehensive error case coverage
- [ ] Error messages are helpful and actionable for ship designers

### Understanding Check:
- [ ] Can create custom error types using `thiserror`
- [ ] Understand when to use `Result<T, E>` vs `Option<T>`
- [ ] Can write complex `match` expressions with multiple patterns
- [ ] Comfortable with error propagation using `?` operator

### Code Quality Check:
- [ ] Error messages include context and suggested fixes
- [ ] Validation logic is modular and testable
- [ ] Tests cover both valid and invalid configurations
- [ ] CLI output is clear and user-friendly

---

## 🚨 Common Temptations to Avoid

### Scope Creep Warnings:
- **"Let's add a ship designer GUI"** → CLI tool focus for now
- **"I should validate against a complex physics engine"** → Rule-based validation sufficient
- **"Let me add network validation of ship loadouts"** → Local file processing only
- **"I need to handle every possible edge case"** → Cover common cases well

Remember: We're learning advanced Rust error handling and validation patterns. The goal is mastering these concepts, not building the perfect ship validator.

---

**Next Sprint**: [Sprint 2A: NPC Behavior Simulator](./Sprint-2A-NPC-Simulator.md)

*This sprint solidifies your understanding of Rust's error handling philosophy and pattern matching power. These skills are essential for building robust systems.*