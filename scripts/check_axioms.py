"""Fail readiness when an advertised Solution theorem has unapproved axioms.

This checks Lean's report, not source text. It is not Palomar full preflight.
"""

import json
from pathlib import Path
import re
import sys

config = json.loads(Path("comparator.json").read_text(encoding="utf-8"))
report = Path(sys.argv[1]).read_text(encoding="utf-8")
found = {
    name: {item.strip() for item in axioms.split(",") if item.strip()}
    for name, axioms in re.findall(
        r"'([^']+)' depends on axioms:\s*\[([^\]]*)\]", report
    )
}
for name in re.findall(r"'([^']+)' does not depend on any axioms", report):
    found[name] = set()

permitted = set(config["permitted_axioms"])
failed = False
for name in config["theorem_names"]:
    if name not in found:
        print(f"MISSING AXIOM REPORT: {name}")
        failed = True
        continue
    disallowed = found[name] - permitted
    if disallowed:
        print(f"BLOCKED: {name}: {', '.join(sorted(disallowed))}")
        failed = True
    else:
        print(f"PERMITTED AXIOMS: {name}")

if failed:
    raise SystemExit("Palomar intake blocked. Complete and verify every advertised proof.")
print("Axiom report passed. Full pinned Palomar preflight is still required.")
