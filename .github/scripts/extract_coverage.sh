#!/bin/bash

CODECOV_PATH=$(swift test --enable-code-coverage --show-codecov-path)

echo "📄 Full Code Coverage JSON Output:"
#jq '.' "$CODECOV_PATH"

# Extract all line coverage data for files containing 'SnappTheming/Sources'
FILES_LINE_COUNTS=$(jq -r '.data[0].files[] | select(.filename | contains("SnappTheming/Sources")) | .summary.lines' "$CODECOV_PATH")

# Initialize variables for total lines, covered lines, and count
total_lines=0
covered_lines=0
count=0

# Loop through each file's line count data
for lines_data in $FILES_LINE_COUNTS; do
  # Extract total and covered lines for each file
  total=$(echo "$lines_data" | jq '.count')
  covered=$(echo "$lines_data" | jq '.covered')

  # Add to the total lines and covered lines
  total_lines=$((total_lines + total))
  covered_lines=$((covered_lines + covered))
  count=$((count + 1))  # Increment the count of files
done

# Calculate the average line coverage percentage
if [ $total_lines -gt 0 ]; then
  average_coverage=$(echo "scale=6; $covered_lines * 100 / $total_lines" | bc)  # Keep 6 decimal places
else
  average_coverage=0
fi

# Generate coverage badge URL
average_coverage_rounded=$(echo "$average_coverage" | awk '{print int($1 * 100 + 0.5) / 100}')

# Save to pr_coverage_summary.txt
cat <<EOF > pr_coverage_summary.txt
| ID | Name | Source Files | Lines | Coverage |
|----|------|--------------|-------|----------|
| 0 | SnappTheming | $count | ($covered_lines/$total_lines) | $badge_url |
EOF
