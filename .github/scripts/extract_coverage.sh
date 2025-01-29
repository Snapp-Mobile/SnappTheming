#!/bin/bash

CODECOV_PATH=$(swift test --enable-code-coverage --show-codecov-path)

COVERAGE_FUNCTIONS_COVERED=$(jq '.data[0].totals.functions.covered' "$CODECOV_PATH")
COVERAGE_FUNCTIONS_TOTAL=$(jq '.data[0].totals.functions.count' "$CODECOV_PATH")
COVERAGE_FUNCTIONS_PERCENT=$(jq -r '.data[0].totals.functions.percent | (.*100 | floor / 100) | tostring' "$CODECOV_PATH")

COVERAGE_INSTANTIATIONS_COVERED=$(jq '.data[0].totals.instantiations.covered' "$CODECOV_PATH")
COVERAGE_INSTANTIATIONS_TOTAL=$(jq '.data[0].totals.instantiations.count' "$CODECOV_PATH")
COVERAGE_INSTANTIATIONS_PERCENT=$(jq -r '.data[0].totals.instantiations.percent | (.*100 | floor / 100) | tostring' "$CODECOV_PATH")

COVERAGE_LINES_COVERED=$(jq '.data[0].totals.lines.covered' "$CODECOV_PATH")
COVERAGE_LINES_TOTAL=$(jq '.data[0].totals.lines.count' "$CODECOV_PATH")
COVERAGE_LINES_PERCENT=$(jq -r '.data[0].totals.lines.percent | (.*100 | floor / 100) | tostring' "$CODECOV_PATH")

COVERAGE_REGIONS_COVERED=$(jq '.data[0].totals.regions.covered' "$CODECOV_PATH")
COVERAGE_REGIONS_TOTAL=$(jq '.data[0].totals.regions.count' "$CODECOV_PATH")
COVERAGE_REGIONS_PERCENT=$(jq -r '.data[0].totals.regions.percent | (.*100 | floor / 100) | tostring' "$CODECOV_PATH")

# Export variables to GitHub Actions
{
  echo "COVERAGE_FUNCTIONS_COVERED=$COVERAGE_FUNCTIONS_COVERED"
  echo "COVERAGE_FUNCTIONS_TOTAL=$COVERAGE_FUNCTIONS_TOTAL"
  echo "COVERAGE_FUNCTIONS_PERCENT=$COVERAGE_FUNCTIONS_PERCENT"
  echo "COVERAGE_INSTANTIATIONS_COVERED=$COVERAGE_INSTANTIATIONS_COVERED"
  echo "COVERAGE_INSTANTIATIONS_TOTAL=$COVERAGE_INSTANTIATIONS_TOTAL"
  echo "COVERAGE_INSTANTIATIONS_PERCENT=$COVERAGE_INSTANTIATIONS_PERCENT"
  echo "COVERAGE_LINES_COVERED=$COVERAGE_LINES_COVERED"
  echo "COVERAGE_LINES_TOTAL=$COVERAGE_LINES_TOTAL"
  echo "COVERAGE_LINES_PERCENT=$COVERAGE_LINES_PERCENT"
  echo "COVERAGE_REGIONS_COVERED=$COVERAGE_REGIONS_COVERED"
  echo "COVERAGE_REGIONS_TOTAL=$COVERAGE_REGIONS_TOTAL"
  echo "COVERAGE_REGIONS_PERCENT=$COVERAGE_REGIONS_PERCENT"
} >> "$GITHUB_ENV"

# Save to pr_coverage_summary.txt
cat <<EOF > pr_coverage_summary.txt
| Metric           | Covered | Total | Coverage (%) |
|-----------------|---------|-------|--------------|
| **Functions**    | $COVERAGE_FUNCTIONS_COVERED  | $COVERAGE_FUNCTIONS_TOTAL  | $COVERAGE_FUNCTIONS_PERCENT%  |
| **Instantiations** | $COVERAGE_INSTANTIATIONS_COVERED  | $COVERAGE_INSTANTIATIONS_TOTAL  | $COVERAGE_INSTANTIATIONS_PERCENT%  |
| **Lines**        | $COVERAGE_LINES_COVERED  | $COVERAGE_LINES_TOTAL  | $COVERAGE_LINES_PERCENT%  |
| **Regions**      | $COVERAGE_REGIONS_COVERED  | $COVERAGE_REGIONS_TOTAL  | $COVERAGE_REGIONS_PERCENT%  |
EOF
