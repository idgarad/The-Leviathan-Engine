# Sprint 0A: Environment Setup & Mental Models

> **Week 1 - Part A** | **Estimated Time: 8-12 hours** | **Learning Focus: Development Environment & Rust Mindset**

---

## 🎯 Learning Objectives (Remember to let Copilot know you are starting a new sprint)

1. **Environment Setup**: Complete Rust development environment with modern tooling
2. **Mental Model Transition**: Understand key differences between pre-OOP programming and Rust
3. **Project Structure**: Learn modern Rust project organization patterns

---

## 🚫 Scope Boundaries (What We're NOT Doing)

- ❌ **No complex algorithms** - Focus on tooling, not problem-solving
- ❌ **No web development** - CLI tools only this sprint
- ❌ **No database integration** - File-based examples only
- ❌ **No networking** - Local development environment focus

---

## 📋 Prerequisites

- **Assumed Knowledge**: Basic familiarity with command-line interfaces
- **Experience Level**: Complete programming beginner OR experienced developer new to Rust
- **Hardware**: Modern computer with internet access (Windows/Linux/macOS)

---

## 🛠️ Environment Setup Steps

### Step 1: Install Rust Toolchain
```bash
# Install rustup (Rust installer and version manager)
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

# Follow prompts for default installation
# Restart terminal or source environment
source ~/.cargo/env

# Verify installation
rustc --version
cargo --version
```

### Step 2: Configure Development Environment

#### Option A: VS Code (Recommended for beginners)
```bash
# Install VS Code extensions via command line or GUI:
# - rust-analyzer (Rust language server)
# - CodeLLDB (Debugger)
# - Error Lens (Inline error display)
# - GitLens (Git integration)
```

#### Option B: Terminal + Editor Setup
- Configure your preferred editor with rust-analyzer
- Ensure syntax highlighting and auto-completion work

### Step 3: Git Configuration
```bash
# Configure Git (replace with your information)
git config --global user.name "Your Name"
git config --global user.email "your.email@example.com"

# Verify configuration
git config --list
```

---

## 🧠 Mental Model: Pre-OOP to Rust Transition

### Key Mindset Shifts

#### 1. **Ownership Instead of Manual Memory Management**
**Pre-OOP Era**: Manual malloc/free, careful pointer management
**Rust**: Compiler-enforced ownership rules prevent memory errors

#### 2. **Immutability by Default**
**Pre-OOP Era**: Variables mutable unless const
**Rust**: Variables immutable unless explicitly marked `mut`

#### 3. **Pattern Matching Instead of Switch/If Chains**
**Pre-OOP Era**: Complex nested if/else or switch statements
**Rust**: Powerful `match` expressions that must be exhaustive

#### 4. **Error Handling as Types**
**Pre-OOP Era**: Return codes, global error variables
**Rust**: `Result<T, E>` and `Option<T>` types make errors explicit

---

## 💻 First Rust Program: "Hello, Leviathan"

### Step 1: Create New Project
```bash
# Create new binary project
cargo new hello-leviathan
cd hello-leviathan

# Examine project structure
tree . # or ls -la on systems without tree
```

### Step 2: Understand Project Structure
```
hello-leviathan/
├── Cargo.toml          # Project metadata and dependencies
├── src/
│   └── main.rs         # Main application entry point
└── target/             # Compiled output (generated)
```

### Step 3: Modify `src/main.rs`
```rust
fn main() {
    println!("Hello, Leviathan Engine!");
    
    // Demonstrate basic variable binding
    let project_name = "The Leviathan Engine";
    let version = "0.1.0";
    
    println!("Project: {}", project_name);
    println!("Version: {}", version);
    
    // Demonstrate mutability
    let mut counter = 0;
    counter += 1;
    println!("Counter: {}", counter);
}
```

### Step 4: Build and Run
```bash
# Compile and run in one step
cargo run

# Or compile then run separately
cargo build
./target/debug/hello-leviathan
```

---

## 📚 Essential Learning Resources

### Books
- **"The Rust Programming Language"** (The Rust Team)
  - ISBN: 978-1718500440
  - Free online: https://doc.rust-lang.org/book/
  - **Focus**: Chapters 1-3 for this sprint

- **"Programming Rust"** (Jim Blandy, Jason Orendorff, Leonora Tindall)
  - ISBN: 978-1492052593
  - **Focus**: Chapter 1 (Systems Programming Languages)

### Online Courses (Free)
- **Rustlings**: Interactive Rust exercises
  - Link: https://github.com/rust-lang/rustlings
  - **Focus**: Complete "intro" exercises

- **Rust by Example**: Hands-on examples
  - Link: https://doc.rust-lang.org/rust-by-example/
  - **Focus**: Hello World through Variables sections

### Videos
- **"Rust Crash Course"** by Traversy Media (1 hour overview)
- **"Why Rust?"** by No Boilerplate (15 min motivation)

### Academic Papers
- **"Rust: Fast and Safe Systems Programming"** (Mozilla Research, 2010)
  - Available: https://arxiv.org/abs/2011.06138
  - **Relevance**: Understanding the "why" behind Rust's design decisions

---

## ✅ Success Criteria

### Must Complete Before Moving to Sprint 0B:
- [ ] Rust toolchain installed and working (`cargo --version` succeeds)
- [ ] Development environment configured with basic Rust support
- [ ] "Hello, Leviathan" program compiles and runs successfully
- [ ] Can create new Cargo projects and understand basic structure
- [ ] Completed "intro" section of Rustlings exercises

### Understanding Check:
- [ ] Can explain the difference between `let x = 5` and `let mut x = 5`
- [ ] Understand what `cargo run` does vs `cargo build`
- [ ] Can navigate basic Rust documentation

---

## 🚨 Common Temptations to Avoid

### Scope Creep Warnings:
- **"Let's also set up a web framework"** → Park for Phase 3
- **"I should learn about async programming now"** → Sprint 3A material
- **"Let me understand lifetimes completely"** → Will come naturally through practice
- **"I need to optimize this hello world program"** → Focus on learning, not performance

### Time Management:
- **Expected Time**: 8-12 hours over 1 week
- **Warning Signs**: Spending more than 2 hours on any single step
- **Escape Hatch**: If stuck >30 minutes, document the issue and move on

---

## 📝 Sprint Completion Notes

### What Worked Well:
[To be filled in during sprint]

### Challenges Encountered:
[To be filled in during sprint]

### Adjustments for Future Learners:
[To be filled in during sprint]

---

**Next Sprint**: [Sprint 0B: Modern Development Practices](./Sprint-0B-Modern-Practices.md)

*Remember: The goal is to learn Rust by building useful tools, not to build perfect software. "Good enough to move forward" is the success criteria.*