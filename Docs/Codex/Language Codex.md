**Planning the Linguistic Codex**

I need to create a Linguistic Codex, and it'll include sections on Python, Rust, and C++. I’ll make sure each section is structured, with lists and bold lead-ins. I’ll avoid repeating myself and will handle any issues with profanity or collisions. Oh, I should also think about including translation tables. I'll keep the number of sections reasonable—to under six. And I want to make sure it's personalized to the user's interests, so that part’s important. Let's get started on it.
# Linguistic codex for unified naming

Names exist as structured phrases built from curated word classes, translated directly into each supported language, and validated against collisions and profanity. This engine applies to characters, locations, ships, arrays, and star systems (post-sovereignty), with ISC procedural codes as the baseline for unclaimed space.

---

## Core concepts

- **Canonical native form:** The archival default for every entity. For locations, ISC codes are canonical until sovereignty naming occurs.
- **Direct translation:** Word-for-word mapping across languages with culture-specific phoneme flavor optionally layered after the literal translation.
- **Grammar templates:** Controlled phrase structures that produce poetic, diegetic names while remaining machine-parseable.
- **Collision and profanity safeguards:** Global registry checks and per-language forbidden patterns to keep the archive clean.

---

## Word classes and templates

### Word classes

- **Adverbs:** Motion/intensity modifiers.
  - Examples:
    - **Violence:** Bleeding, Searing, Shattering
    - **Mystique:** Whispering, Veiled, Waking
    - **Temporal:** Endless, Dawning, Waning
- **Adjectives:** Qualities and colors.
  - Examples:
    - **Material:** Iron, Adamant, Glass
    - **Color:** Crimson, Azure, Umbral
    - **Virtue:** Silent, Faithful, Sovereign
- **Nouns:** Entities and symbols.
  - Examples:
    - **Martial:** Blade, Bastion, Phalanx
    - **Industrial:** Forge, Array, Foundry
    - **Cosmic:** Star, Rift, Meridian
- **Accessories:** Function words that bind phrases.
  - Examples:
    - **Articles/particles:** The, A
    - **Relations:** of, from, in
    - **Copula/connectors:** is, that

### Grammar templates

- **Template A:** [The] + [Adjective] + [Noun]
  - Example: The Crimson Forge
- **Template B:** [Adverb] + [Noun] + [of] + [Noun]
  - Example: Bleeding Blade of Hellfire
- **Template C:** [Noun] + [is] + [Adjective]
  - Example: Bastion is Eternal
- **Template D (epithet):** [Adjective] + [Noun] + [from] + [Noun]
  - Example: Silent Star from Gannait
- **Template E (compound):** [The] + [Adjective] + [Noun] + [of] + [Adjective] + [Noun]
  - Example: The Umbral Accord of Iron Meridian

> Tips:
> - Keep 5–8 templates per culture to ensure variety without drift.
> - Allow optional middle epithet segments for characters (e.g., “Uvald, the Silent Blade”).

---

## Translation and culture layers

### Direct translation tables (per language)

- **Structure:** One-to-one mapping for each word class; no freeform translation at this stage.
- **Example (Imperial Standard):**
  - **Adverbs:** Bleeding → Uvald, Whispering → Sileth
  - **Adjectives:** Crimson → Heg, Silent → Vos
  - **Nouns:** Blade → Hegth, Forge → Veynar, Star → Sereth
  - **Accessories:** The → Tha, of → de, is → es, from → ex

- **Example (House dialect):**
  - **Adverbs:** Bleeding → Ouwald, Whispering → Sil’eth
  - **Adjectives:** Crimson → Vosh, Silent → Keth
  - **Nouns:** Blade → Heth, Forge → Zar, Star → Sareth
  - **Accessories:** The → Tha’, of → av, is → esh, from → ven

- **Example (Corporate Trade Tongue):**
  - **Adverbs:** Bleeding → Bleed, Whispering → Wisper
  - **Adjectives:** Crimson → C‑Red, Silent → S‑Quiet
  - **Nouns:** Blade → BladeX, Forge → ForgeCo, Star → StarSys
  - **Accessories:** The → The, of → of, is → is, from → fm

### Phoneme flavoring (optional, post-translation)

- **Imperial:** Latinizing suffixes (‑um, ‑or), vowel smoothing.
- **House:** Aspirates (h, gh), epenthetic vowels (e, a), clan suffixes (‑eth, ‑zar).
- **Corporate:** Compression, alphanumeric stylization, hyphenation.

> Apply phoneme flavoring only after collision/profanity validation on the direct translation, and validate again post-flavor.

---

## Registry, collisions, and profanity

- **Global registry:** Stores canonical native names and normalized keys per language.
  - **Key format:** lowercase, diacritics stripped, spaces → single delimiter.
- **Collision policy:**
  - **Hard collision:** Exact normalized match → regenerate or append diegetic differentiator (Prime, Ascendant, II, of Sector X).
  - **Near collision:** Levenshtein ≤ 2 against popular names → prefer regeneration to avoid confusion.
- **Profanity policy:**
  - **Per-language blacklist:** Exact words and risky substrings.
  - **Cross-language scan:** Check concatenations and syllable boundaries to avoid accidental expletives.
  - **Heuristics:** Disallow sequences that form profanity when hyphenated, compressed, or suffixed.

---

## Code examples

### Python: end-to-end prototype

```python
import random
import re
from typing import Dict, List, Set

# Word banks
ADVERBS = ["Bleeding", "Whispering", "Shattering", "Searing", "Dawning"]
ADJECTIVES = ["Crimson", "Silent", "Iron", "Umbral", "Sovereign"]
NOUNS = ["Blade", "Forge", "Star", "Accord", "Bastion", "Array", "Meridian"]
ACCESSORIES = {"The": "The", "of": "of", "is": "is", "from": "from"}

TEMPLATES = [
    lambda: f"{ACCESSORIES['The']} {random.choice(ADJECTIVES)} {random.choice(NOUNS)}",
    lambda: f"{random.choice(ADVERBS)} {random.choice(NOUNS)} {ACCESSORIES['of']} {random.choice(NOUNS)}",
    lambda: f"{random.choice(NOUNS)} {ACCESSORIES['is']} {random.choice(ADJECTIVES)}",
    lambda: f"{random.choice(ADJECTIVES)} {random.choice(NOUNS)} {ACCESSORIES['from']} {random.choice(NOUNS)}",
    lambda: f"{ACCESSORIES['The']} {random.choice(ADJECTIVES)} {random.choice(NOUNS)} {ACCESSORIES['of']} {random.choice(ADJECTIVES)} {random.choice(NOUNS)}",
]

# Direct translations
TRANSLATIONS: Dict[str, Dict[str, str]] = {
    "Imperial": {
        "Bleeding": "Uvald", "Whispering": "Sileth", "Shattering": "Droskh", "Searing": "Serakh", "Dawning": "Aurith",
        "Crimson": "Heg", "Silent": "Vos", "Iron": "Ferum", "Umbral": "Umbra", "Sovereign": "Domin",
        "Blade": "Hegth", "Forge": "Veynar", "Star": "Sereth", "Accord": "Pactum", "Bastion": "Bastio", "Array": "Ordin", "Meridian": "Meridia",
        "The": "Tha", "of": "de", "is": "es", "from": "ex"
    },
    "House": {
        "Bleeding": "Ouwald", "Whispering": "Sil’eth", "Shattering": "Drosh", "Searing": "Se’rak", "Dawning": "Aneth",
        "Crimson": "Vosh", "Silent": "Keth", "Iron": "Ir’n", "Umbral": "Um’ral", "Sovereign": "Sov’eth",
        "Blade": "Heth", "Forge": "Zar", "Star": "Sareth", "Accord": "Akord", "Bastion": "Bas’ten", "Array": "Ar’rai", "Meridian": "Mer’eth",
        "The": "Tha’", "of": "av", "is": "esh", "from": "ven"
    },
    "Corporate": {
        "Bleeding": "Bleed", "Whispering": "Wisper", "Shattering": "Shard", "Searing": "Burn", "Dawning": "Start",
        "Crimson": "C-Red", "Silent": "S-Quiet", "Iron": "Fe", "Umbral": "Dark", "Sovereign": "Core",
        "Blade": "BladeX", "Forge": "ForgeCo", "Star": "StarSys", "Accord": "Accord™", "Bastion": "BastionInc", "Array": "ArrayNet", "Meridian": "MeridX",
        "The": "The", "of": "of", "is": "is", "from": "fm"
    }
}

BLACKLIST: Dict[str, Set[str]] = {
    # Substrings lowercased; add per language as needed
    "global": {"badword", "curse"},
    "Imperial": {"obscenity1"},
    "House": {"obscenity2"},
    "Corporate": {"obscenity3"},
}

USED_NAMES: Set[str] = set()

def normalize(s: str) -> str:
    s = s.lower()
    s = re.sub(r"[^a-z0-9]+", "-", s)
    return re.sub(r"-+", "-", s).strip("-")

def violates_profanity(name: str, lang: str = "global") -> bool:
    key = normalize(name)
    pools = BLACKLIST.get("global", set()).union(BLACKLIST.get(lang, set()))
    return any(b in key for b in pools)

def collision(name: str) -> bool:
    return normalize(name) in USED_NAMES

def register(name: str):
    USED_NAMES.add(normalize(name))

def translate_direct(name: str, culture: str) -> str:
    words = name.split()
    tmap = TRANSLATIONS.get(culture, {})
    return " ".join(tmap.get(w, w) for w in words)

def flavor_phoneme(name: str, culture: str) -> str:
    # Optional post-translation flavoring
    if culture == "Imperial":
        return re.sub(r"\b(\w+)\b", lambda m: (m.group(1) + "um") if m.group(1) in {"Pactum", "Bastio"} else m.group(1), name)
    if culture == "House":
        return name.replace("th", "’th")
    if culture == "Corporate":
        return name.replace(" ", "-")
    return name

def generate_unique(culture_native: str = "Imperial", max_attempts: int = 50) -> Dict[str, str]:
    for _ in range(max_attempts):
        raw = random.choice(TEMPLATES)()
        if violates_profanity(raw) or collision(raw):
            continue
        # Register canonical native form
        register(raw)
        # Produce translations
        output = {}
        for culture in TRANSLATIONS.keys():
            direct = translate_direct(raw, culture)
            flavored = flavor_phoneme(direct, culture)
            # Validate post-flavor too
            if violates_profanity(flavored, culture):
                continue
            output[culture] = flavored
        # Canonical native form (archival default)
        output["Native"] = translate_direct(raw, culture_native)
        output["CanonicalRaw"] = raw
        return output
    raise RuntimeError("Failed to generate a unique, clean name")

if __name__ == "__main__":
    result = generate_unique()
    for k, v in result.items():
        print(f"{k}: {v}")
```

---

### Rust: modular engine skeleton

```rust
use rand::seq::SliceRandom;
use rand::thread_rng;
use regex::Regex;
use std::collections::{HashMap, HashSet};

#[derive(Clone)]
struct Lexicon {
    adverbs: Vec<&'static str>,
    adjectives: Vec<&'static str>,
    nouns: Vec<&'static str>,
    accessories: HashMap<&'static str, &'static str>,
}

#[derive(Clone)]
struct Translations {
    map: HashMap<&'static str, HashMap<&'static str, &'static str>>,
}

struct Registry {
    used: HashSet<String>,
    blacklist_global: HashSet<String>,
    blacklist_lang: HashMap<&'static str, HashSet<String>>,
}

impl Registry {
    fn new() -> Self {
        let mut blacklist_global = HashSet::new();
        blacklist_global.insert("badword".into());
        blacklist_global.insert("curse".into());
        Registry { used: HashSet::new(), blacklist_global, blacklist_lang: HashMap::new() }
    }
    fn normalize(&self, s: &str) -> String {
        let re = Regex::new(r"[^a-z0-9]+").unwrap();
        let lower = s.to_lowercase();
        let mut r = re.replace_all(&lower, "-").to_string();
        let re2 = Regex::new(r"-+").unwrap();
        r = re2.replace_all(&r, "-").to_string();
        r.trim_matches('-').to_string()
    }
    fn collision(&self, s: &str) -> bool {
        self.used.contains(&self.normalize(s))
    }
    fn register(&mut self, s: &str) {
        self.used.insert(self.normalize(s));
    }
    fn violates(&self, s: &str, lang: &str) -> bool {
        let key = self.normalize(s);
        if self.blacklist_global.iter().any(|b| key.contains(b)) { return true; }
        if let Some(set) = self.blacklist_lang.get(lang) {
            if set.iter().any(|b| key.contains(b)) { return true; }
        }
        false
    }
}

fn templates(lex: &Lexicon) -> Vec<Box<dyn Fn() -> String>> {
    vec![
        Box::new({
            let lex = lex.clone();
            move || format!("{} {} {}", lex.accessories["The"], choice(&lex.adjectives), choice(&lex.nouns))
        }),
        Box::new({
            let lex = lex.clone();
            move || format!("{} {} {} {}", choice(&lex.adverbs), choice(&lex.nouns), lex.accessories["of"], choice(&lex.nouns))
        }),
        Box::new({
            let lex = lex.clone();
            move || format!("{} {} {}", choice(&lex.nouns), lex.accessories["is"], choice(&lex.adjectives))
        }),
        Box::new({
            let lex = lex.clone();
            move || format!("{} {} {} {}", choice(&lex.adjectives), choice(&lex.nouns), lex.accessories["from"], choice(&lex.nouns))
        }),
    ]
}

fn choice(list: &Vec<&'static str>) -> &'static str {
    let mut rng = thread_rng();
    list.choose(&mut rng).unwrap()
}

fn translate_direct(name: &str, culture: &str, trans: &Translations) -> String {
    let tmap = trans.map.get(culture).unwrap_or(&HashMap::new());
    name.split_whitespace()
        .map(|w| tmap.get(w).cloned().unwrap_or(w))
        .collect::<Vec<_>>()
        .join(" ")
}

fn flavor(name: &str, culture: &str) -> String {
    match culture {
        "Imperial" => name.replace("um", "um"),
        "House" => name.replace("th", "’th"),
        "Corporate" => name.replace(" ", "-"),
        _ => name.to_string(),
    }
}

fn generate_unique(lex: &Lexicon, trans: &Translations, reg: &mut Registry, native_culture: &str, max_attempts: usize) -> HashMap<String, String> {
    let t = templates(lex);
    for _ in 0..max_attempts {
        let raw = t.choose(&mut thread_rng()).unwrap()();
        if reg.violates(&raw, "global") || reg.collision(&raw) { continue; }
        reg.register(&raw);
        let mut out: HashMap<String, String> = HashMap::new();
        for culture in trans.map.keys() {
            let direct = translate_direct(&raw, culture, trans);
            let flavored = flavor(&direct, culture);
            if reg.violates(&flavored, culture) { continue; }
            out.insert(culture.to_string(), flavored);
        }
        let native = translate_direct(&raw, native_culture, trans);
        out.insert("Native".into(), native);
        out.insert("CanonicalRaw".into(), raw);
        return out;
    }
    panic!("Failed to generate a unique, clean name");
}

fn main() {
    let lex = Lexicon {
        adverbs: vec!["Bleeding", "Whispering", "Shattering", "Searing", "Dawning"],
        adjectives: vec!["Crimson", "Silent", "Iron", "Umbral", "Sovereign"],
        nouns: vec!["Blade", "Forge", "Star", "Accord", "Bastion", "Array", "Meridian"],
        accessories: HashMap::from([("The", "The"), ("of", "of"), ("is", "is"), ("from", "from")]),
    };

    let mut imp = HashMap::new();
    imp.insert("Bleeding", "Uvald"); imp.insert("Whispering", "Sileth"); imp.insert("Shattering", "Droskh"); imp.insert("Searing", "Serakh"); imp.insert("Dawning", "Aurith");
    imp.insert("Crimson", "Heg"); imp.insert("Silent", "Vos"); imp.insert("Iron", "Ferum"); imp.insert("Umbral", "Umbra"); imp.insert("Sovereign", "Domin");
    imp.insert("Blade", "Hegth"); imp.insert("Forge", "Veynar"); imp.insert("Star", "Sereth"); imp.insert("Accord", "Pactum"); imp.insert("Bastion", "Bastio"); imp.insert("Array", "Ordin"); imp.insert("Meridian", "Meridia");
    imp.insert("The", "Tha"); imp.insert("of", "de"); imp.insert("is", "es"); imp.insert("from", "ex");

    let mut house = HashMap::new();
    house.insert("Bleeding", "Ouwald"); house.insert("Whispering", "Sil’eth"); house.insert("Shattering", "Drosh"); house.insert("Searing", "Se’rak"); house.insert("Dawning", "Aneth");
    house.insert("Crimson", "Vosh"); house.insert("Silent", "Keth"); house.insert("Iron", "Ir’n"); house.insert("Umbral", "Um’ral"); house.insert("Sovereign", "Sov’eth");
    house.insert("Blade", "Heth"); house.insert("Forge", "Zar"); house.insert("Star", "Sareth"); house.insert("Accord", "Akord"); house.insert("Bastion", "Bas’ten"); house.insert("Array", "Ar’rai"); house.insert("Meridian", "Mer’eth");
    house.insert("The", "Tha’"); house.insert("of", "av"); house.insert("is", "esh"); house.insert("from", "ven");

    let mut corp = HashMap::new();
    corp.insert("Bleeding", "Bleed"); corp.insert("Whispering", "Wisper"); corp.insert("Shattering", "Shard"); corp.insert("Searing", "Burn"); corp.insert("Dawning", "Start");
    corp.insert("Crimson", "C-Red"); corp.insert("Silent", "S-Quiet"); corp.insert("Iron", "Fe"); corp.insert("Umbral", "Dark"); corp.insert("Sovereign", "Core");
    corp.insert("Blade", "BladeX"); corp.insert("Forge", "ForgeCo"); corp.insert("Star", "StarSys"); corp.insert("Accord", "Accord™"); corp.insert("Bastion", "BastionInc"); corp.insert("Array", "ArrayNet"); corp.insert("Meridian", "MeridX");
    corp.insert("The", "The"); corp.insert("of", "of"); corp.insert("is", "is"); corp.insert("from", "fm");

    let trans = Translations { map: HashMap::from([("Imperial", imp), ("House", house), ("Corporate", corp)]) };

    let mut reg = Registry::new();
    let out = generate_unique(&lex, &trans, &mut reg, "Imperial", 100);
    for (k, v) in out {
        println!("{}: {}", k, v);
    }
}
```

---

### C++: practical, header-only style

```cpp
#include <algorithm>
#include <iostream>
#include <random>
#include <regex>
#include <string>
#include <unordered_map>
#include <unordered_set>
#include <vector>

struct Lexicon {
    std::vector<std::string> adverbs = {"Bleeding", "Whispering", "Shattering", "Searing", "Dawning"};
    std::vector<std::string> adjectives = {"Crimson", "Silent", "Iron", "Umbral", "Sovereign"};
    std::vector<std::string> nouns = {"Blade", "Forge", "Star", "Accord", "Bastion", "Array", "Meridian"};
    std::unordered_map<std::string, std::string> accessories = {{"The","The"},{"of","of"},{"is","is"},{"from","from"}};
};

struct Registry {
    std::unordered_set<std::string> used;
    std::unordered_set<std::string> blacklist_global = {"badword", "curse"};
    std::unordered_map<std::string, std::unordered_set<std::string>> blacklist_lang;
    std::string normalize(const std::string& s) const {
        std::string lower = s;
        std::transform(lower.begin(), lower.end(), lower.begin(), ::tolower);
        std::regex re("[^a-z0-9]+");
        std::string r = std::regex_replace(lower, re, "-");
        std::regex re2("-+");
        r = std::regex_replace(r, re2, "-");
        if (!r.empty() && r.front()=='-') r.erase(r.begin());
        if (!r.empty() && r.back()=='-') r.pop_back();
        return r;
    }
    bool collision(const std::string& s) const {
        return used.count(normalize(s)) > 0;
    }
    void register_name(const std::string& s) {
        used.insert(normalize(s));
    }
    bool violates(const std::string& s, const std::string& lang) const {
        std::string key = normalize(s);
        for (const auto& b : blacklist_global) { if (key.find(b) != std::string::npos) return true; }
        auto it = blacklist_lang.find(lang);
        if (it != blacklist_lang.end()) {
            for (const auto& b : it->second) { if (key.find(b) != std::string::npos) return true; }
        }
        return false;
    }
};

using TMap = std::unordered_map<std::string, std::string>;
struct Translations {
    std::unordered_map<std::string, TMap> map;
};

std::mt19937& rng() {
    static std::random_device rd;
    static std::mt19937 gen(rd());
    return gen;
}

template<typename T>
const T& choice(const std::vector<T>& v) {
    std::uniform_int_distribution<size_t> dist(0, v.size()-1);
    return v[dist(rng())];
}

std::vector<std::function<std::string()>> templates(const Lexicon& lex) {
    return {
        [&]() { return lex.accessories.at("The") + " " + choice(lex.adjectives) + " " + choice(lex.nouns); },
        [&]() { return choice(lex.adverbs) + " " + choice(lex.nouns) + " " + lex.accessories.at("of") + " " + choice(lex.nouns); },
        [&]() { return choice(lex.nouns) + " " + lex.accessories.at("is") + " " + choice(lex.adjectives); },
        [&]() { return choice(lex.adjectives) + " " + choice(lex.nouns) + " " + lex.accessories.at("from") + " " + choice(lex.nouns); },
    };
}

std::string translate_direct(const std::string& name, const std::string& culture, const Translations& trans) {
    auto it = trans.map.find(culture);
    const TMap* tmap = (it != trans.map.end()) ? &it->second : nullptr;
    std::string out;
    std::string word;
    for (size_t i = 0; i <= name.size(); ++i) {
        if (i == name.size() || name[i] == ' ') {
            if (!word.empty()) {
                std::string t = word;
                if (tmap) {
                    auto jt = tmap->find(word);
                    if (jt != tmap->end()) t = jt->second;
                }
                if (!out.empty()) out.push_back(' ');
                out += t;
                word.clear();
            }
        } else {
            word.push_back(name[i]);
        }
    }
    return out;
}

std::string flavor(const std::string& name, const std::string& culture) {
    if (culture == "Imperial") return name; // placeholder
    if (culture == "House") {
        std::string out = name;
        size_t pos = 0;
        while ((pos = out.find("th", pos)) != std::string::npos) { out.replace(pos, 2, "’th"); pos += 3; }
        return out;
    }
    if (culture == "Corporate") {
        std::string out = name;
        std::replace(out.begin(), out.end(), ' ', '-');
        return out;
    }
    return name;
}

std::unordered_map<std::string, std::string> generate_unique(const Lexicon& lex, const Translations& trans, Registry& reg, const std::string& native_culture, int max_attempts = 100) {
    auto t = templates(lex);
    for (int i = 0; i < max_attempts; ++i) {
        std::string raw = t[std::uniform_int_distribution<int>(0, (int)t.size()-1)(rng())]();
        if (reg.violates(raw, "global") || reg.collision(raw)) continue;
        reg.register_name(raw);
        std::unordered_map<std::string, std::string> out;
        for (const auto& kv : trans.map) {
            const std::string& culture = kv.first;
            std::string direct = translate_direct(raw, culture, trans);
            std::string flavored = flavor(direct, culture);
            if (reg.violates(flavored, culture)) continue;
            out[culture] = flavored;
        }
        out["Native"] = translate_direct(raw, native_culture, trans);
        out["CanonicalRaw"] = raw;
        return out;
    }
    throw std::runtime_error("Failed to generate a unique, clean name");
}

int main() {
    Lexicon lex;

    Translations trans;
    trans.map["Imperial"] = {
        {"Bleeding","Uvald"},{"Whispering","Sileth"},{"Shattering","Droskh"},{"Searing","Serakh"},{"Dawning","Aurith"},
        {"Crimson","Heg"},{"Silent","Vos"},{"Iron","Ferum"},{"Umbral","Umbra"},{"Sovereign","Domin"},
        {"Blade","Hegth"},{"Forge","Veynar"},{"Star","Sereth"},{"Accord","Pactum"},{"Bastion","Bastio"},{"Array","Ordin"},{"Meridian","Meridia"},
        {"The","Tha"},{"of","de"},{"is","es"},{"from","ex"}
    };
    trans.map["House"] = {
        {"Bleeding","Ouwald"},{"Whispering","Sil’eth"},{"Shattering","Drosh"},{"Searing","Se’rak"},{"Dawning","Aneth"},
        {"Crimson","Vosh"},{"Silent","Keth"},{"Iron","Ir’n"},{"Umbral","Um’ral"},{"Sovereign","Sov’eth"},
        {"Blade","Heth"},{"Forge","Zar"},{"Star","Sareth"},{"Accord","Akord"},{"Bastion","Bas’ten"},{"Array","Ar’rai"},{"Meridian","Mer’eth"},
        {"The","Tha’"},{"of","av"},{"is","esh"},{"from","ven"}
    };
    trans.map["Corporate"] = {
        {"Bleeding","Bleed"},{"Whispering","Wisper"},{"Shattering","Shard"},{"Searing","Burn"},{"Dawning","Start"},
        {"Crimson","C-Red"},{"Silent","S-Quiet"},{"Iron","Fe"},{"Umbral","Dark"},{"Sovereign","Core"},
        {"Blade","BladeX"},{"Forge","ForgeCo"},{"Star","StarSys"},{"Accord","Accord™"},{"Bastion","BastionInc"},{"Array","ArrayNet"},{"Meridian","MeridX"},
        {"The","The"},{"of","of"},{"is","is"},{"from","fm"}
    };

    Registry reg;
    auto out = generate_unique(lex, trans, reg, "Imperial");
    for (const auto& kv : out) {
        std::cout << kv.first << ": " << kv.second << "\n";
    }
    return 0;
}
```

---

## Integration with sovereignty, characters, and archives

- **Characters:** Generate at creation using templates; store full extended identity.
  - **Format:** [First] [Middle/Epithet] [Last] of [Homeworld] of [Affiliation]
  - **Example:** Uvald Hegthezar of Gannait VI of Clan Sergeth
- **Locations:** Default to ISC code; on sovereignty naming, run engine and register canonical native, plus translations.
  - **Record:** ISC X004V‑09A → Native: Droskh Veynar → Translations per culture
- **Archives and UI:**
  - **Default display:** Canonical native form; toggle to culture-specific or ISC code per context.
  - **Validation:** Always pass names through collision and profanity checks pre- and post-translation/flavor.

---

