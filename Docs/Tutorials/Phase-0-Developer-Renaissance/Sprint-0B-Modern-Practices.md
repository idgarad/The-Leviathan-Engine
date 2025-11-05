# Sprint 0B: Modern Development Practices & Git Workflows

> **Week 2** | **Estimated Time: 10-15 hours** | **Learning Focus: Professional Development Habits**

---

## 🎯 Learning Objectives

1. **Testing Mindset**: Understand why and how to write tests from day one
2. **Git Workflows**: Modern version control practices for solo and team development
3. **Documentation Culture**: Writing code that others (including future you) can understand
4. **Debugging Skills**: Using modern Rust debugging tools effectively

---

## 🚫 Scope Boundaries (What We're NOT Doing)

- ❌ **No CI/CD pipelines yet** - Local development focus (Sprint 7A material)
- ❌ **No advanced Git features** - Branching, rebasing come later
- ❌ **No performance profiling** - Focus on correctness first (Sprint 3B material)
- ❌ **No external dependencies** - Standard library only

---

## 📚 Learning Resources for This Sprint

### Books
- **"The Rust Programming Language"** (The Rust Team)
  - ISBN: 978-1718500440
  - **Focus**: Chapter 11 (Writing Automated Tests)
  - Free online: https://doc.rust-lang.org/book/ch11-00-testing.html

- **"Effective Debugging"** (Diomidis Spinellis)
  - ISBN: 978-0134394794
  - **Focus**: Chapters 1-3 (Debugging mindset and tools)

### Online Resources
- **Git Handbook** (GitHub)
  - Link: https://guides.github.com/introduction/git-handbook/
  - **Focus**: Basic commands and workflow

- **Rustdoc Book**
  - Link: https://doc.rust-lang.org/rustdoc/
  - **Focus**: Writing documentation comments

### Academic Papers
- **"Why Do Software Developers Use Static Analysis Tools?"** (Christakis & Bird, 2016)
  - Available: https://www.microsoft.com/en-us/research/publication/why-do-software-developers-use-static-analysis-tools/
  - **Relevance**: Understanding the value of automated code quality tools

---

## 🧪 Project: Basic Calculator with Comprehensive Testing

### The Challenge
Build a calculator that teaches fundamental Rust concepts while establishing professional development practices.

### Step 1: Project Setup with Git
```bash
# Create new project
cargo new rust-calculator
cd rust-calculator

# Initialize Git repository
git init
git add .
git commit -m "Initial commit: calculator project setup"

# Create .gitignore (Cargo creates this, but let's understand it)
echo "target/" >> .gitignore
echo "Cargo.lock" >> .gitignore  # Only for applications, not libraries
git add .gitignore
git commit -m "Add .gitignore for Rust project"
```

### Step 2: Basic Calculator Structure
**File: `src/main.rs`**
```rust
//! # Rust Calculator
//! 
//! A simple calculator demonstrating Rust fundamentals and testing practices.
//! 
//! ## Learning Objectives
//! - Error handling with Result types
//! - Pattern matching
//! - Unit testing
//! - Documentation

use std::io;

/// Represents the mathematical operations our calculator supports
#[derive(Debug, PartialEq)]
enum Operation {
    Add,
    Subtract,
    Multiply,
    Divide,
}

/// Custom error type for calculator operations
#[derive(Debug, PartialEq)]
enum CalcError {
    DivisionByZero,
    InvalidOperation,
    ParseError,
}

/// Parse a string into an Operation
/// 
/// # Examples
/// 
/// ```
/// let op = parse_operation("+").unwrap();
/// assert_eq!(op, Operation::Add);
/// ```
fn parse_operation(input: &str) -> Result<Operation, CalcError> {
    match input.trim() {
        "+" => Ok(Operation::Add),
        "-" => Ok(Operation::Subtract),
        "*" => Ok(Operation::Multiply),
        "/" => Ok(Operation::Divide),
        _ => Err(CalcError::InvalidOperation),
    }
}

/// Perform a mathematical operation on two numbers
/// 
/// # Arguments
/// 
/// * `left` - The left operand
/// * `op` - The operation to perform
/// * `right` - The right operand
/// 
/// # Returns
/// 
/// Returns `Ok(result)` on success, or `Err(CalcError)` on failure
/// 
/// # Examples
/// 
/// ```
/// let result = calculate(10.0, Operation::Add, 5.0).unwrap();
/// assert_eq!(result, 15.0);
/// ```
fn calculate(left: f64, op: Operation, right: f64) -> Result<f64, CalcError> {
    match op {
        Operation::Add => Ok(left + right),
        Operation::Subtract => Ok(left - right),
        Operation::Multiply => Ok(left * right),
        Operation::Divide => {
            if right == 0.0 {
                Err(CalcError::DivisionByZero)
            } else {
                Ok(left / right)
            }
        }
    }
}

/// Parse user input into numbers and operation
fn parse_input(input: &str) -> Result<(f64, Operation, f64), CalcError> {
    let parts: Vec<&str> = input.split_whitespace().collect();
    
    if parts.len() != 3 {
        return Err(CalcError::ParseError);
    }
    
    let left = parts[0].parse::<f64>().map_err(|_| CalcError::ParseError)?;
    let op = parse_operation(parts[1])?;
    let right = parts[2].parse::<f64>().map_err(|_| CalcError::ParseError)?;
    
    Ok((left, op, right))
}

fn main() {
    println!("Rust Calculator v0.1.0");
    println!("Enter calculations in the format: number operator number");
    println!("Example: 10 + 5");
    println!("Type 'quit' to exit");
    
    loop {
        print!("calc> ");
        io::Write::flush(&mut io::stdout()).unwrap(); // Ensure prompt shows
        
        let mut input = String::new();
        match io::stdin().read_line(&mut input) {
            Ok(_) => {
                let input = input.trim();
                
                if input == "quit" {
                    println!("Goodbye!");
                    break;
                }
                
                match parse_input(input) {
                    Ok((left, op, right)) => {
                        match calculate(left, op, right) {
                            Ok(result) => println!("Result: {}", result),
                            Err(CalcError::DivisionByZero) => {
                                println!("Error: Cannot divide by zero!");
                            },
                            Err(e) => println!("Error: {:?}", e),
                        }
                    },
                    Err(CalcError::ParseError) => {
                        println!("Error: Invalid input format. Use: number operator number");
                    },
                    Err(e) => println!("Error: {:?}", e),
                }
            },
            Err(error) => println!("Error reading input: {}", error),
        }
    }
}

#[cfg(test)]
mod tests {
    use super::*;
    
    #[test]
    fn test_parse_operation_valid() {
        assert_eq!(parse_operation("+"), Ok(Operation::Add));
        assert_eq!(parse_operation("-"), Ok(Operation::Subtract));
        assert_eq!(parse_operation("*"), Ok(Operation::Multiply));
        assert_eq!(parse_operation("/"), Ok(Operation::Divide));
    }
    
    #[test]
    fn test_parse_operation_invalid() {
        assert_eq!(parse_operation("^"), Err(CalcError::InvalidOperation));
        assert_eq!(parse_operation("add"), Err(CalcError::InvalidOperation));
    }
    
    #[test]
    fn test_calculate_addition() {
        let result = calculate(10.0, Operation::Add, 5.0).unwrap();
        assert_eq!(result, 15.0);
    }
    
    #[test]
    fn test_calculate_division_by_zero() {
        let result = calculate(10.0, Operation::Divide, 0.0);
        assert_eq!(result, Err(CalcError::DivisionByZero));
    }
    
    #[test]
    fn test_parse_input_valid() {
        let (left, op, right) = parse_input("10 + 5").unwrap();
        assert_eq!(left, 10.0);
        assert_eq!(op, Operation::Add);
        assert_eq!(right, 5.0);
    }
    
    #[test]
    fn test_parse_input_invalid() {
        assert_eq!(parse_input("10 +"), Err(CalcError::ParseError));
        assert_eq!(parse_input("not a number"), Err(CalcError::ParseError));
    }
}
```

### Step 3: Testing and Documentation
```bash
# Run tests
cargo test

# Run tests with output
cargo test -- --nocapture

# Generate documentation
cargo doc --open

# Check code with clippy (Rust linter)
cargo clippy

# Format code
cargo fmt
```

---

## 🔧 Debugging Workflow

### Setting Up Debug Environment
1. **VS Code**: Set breakpoints by clicking line numbers
2. **Terminal Debugging**: Use `cargo run` with `println!` for now
3. **Test Debugging**: Use `cargo test -- --nocapture` to see print output

### Common Debugging Scenarios
```rust
// Example: Debug print for understanding flow
fn calculate(left: f64, op: Operation, right: f64) -> Result<f64, CalcError> {
    eprintln!("DEBUG: Calculating {} {:?} {}", left, op, right); // stderr output
    
    match op {
        // ... rest of function
    }
}
```

---

## 📝 Git Workflow Practice

### Daily Development Cycle
```bash
# Start new feature
git checkout -b feature/error-handling-improvements

# Make changes, test frequently
cargo test
git add .
git commit -m "Add comprehensive error handling for division"

# Merge back (for solo development)
git checkout main
git merge feature/error-handling-improvements
git branch -d feature/error-handling-improvements
```

### Good Commit Message Practices
- **Format**: `type: brief description`
- **Types**: feat, fix, docs, test, refactor
- **Examples**:
  - `feat: add support for floating-point operations`
  - `fix: handle division by zero gracefully`
  - `test: add comprehensive input parsing tests`
  - `docs: add usage examples to README`

---

## ✅ Success Criteria

### Must Complete Before Moving to Phase 1:
- [ ] Calculator compiles and runs without errors
- [ ] All tests pass (`cargo test` succeeds)
- [ ] Code passes linting (`cargo clippy` with no warnings)
- [ ] Documentation generates successfully (`cargo doc`)
- [ ] At least 5 meaningful Git commits demonstrating workflow

### Understanding Check:
- [ ] Can explain what `Result<T, E>` is and why it's used
- [ ] Understand the difference between `#[test]` and regular functions
- [ ] Can write a simple `match` expression
- [ ] Comfortable with basic Git commands (add, commit, status)

### Code Quality Check:
- [ ] Functions have documentation comments with examples
- [ ] Error cases are handled explicitly (no `unwrap()` in main logic)
- [ ] Tests cover both success and failure cases
- [ ] Variable names are descriptive

---

## 🚨 Common Temptations to Avoid

### Scope Creep Warnings:
- **"Let's add a GUI interface"** → Phase 3 material
- **"I should support complex expressions like (2+3)*4"** → Future enhancement
- **"Let me implement a proper parser with regex"** → Over-engineering for learning goals
- **"I need to handle all possible floating-point edge cases"** → Perfect is the enemy of good enough

### Time Management:
- **Expected Time**: 10-15 hours over 1 week
- **Warning Signs**: 
  - Spending >3 hours on any single function
  - Writing tests for extremely obscure edge cases
  - Trying to make the UI "perfect"

---

## 🎯 Key Learning Insights

### Mental Model Reinforcements:
1. **Ownership**: Notice how strings are borrowed with `&str` vs owned with `String`
2. **Error Handling**: See how `Result` forces you to handle failures explicitly
3. **Pattern Matching**: Experience how `match` is more powerful than if/else chains
4. **Testing**: Understand how tests document expected behavior

### Professional Habits Established:
- Write tests alongside code, not after
- Use descriptive error types instead of strings
- Document public functions with examples
- Commit frequently with meaningful messages

---

## 📝 Sprint Completion Notes

### What Worked Well:
[To be filled in during sprint]

### Challenges Encountered:
[To be filled in during sprint]

### Adjustments for Future Learners:
[To be filled in during sprint]

---

**Next Phase**: [Phase 1: Config & Data Tools](../Phase-1-Config-Data-Tools/)

*Remember: We're learning Rust by building practical tools. The calculator isn't the goal - understanding Rust fundamentals through a meaningful project is the goal.*