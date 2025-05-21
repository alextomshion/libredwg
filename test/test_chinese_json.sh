#!/bin/sh

DWGREAD_PATH="../../programs/dwgread"
INPUT_DXF="../test/test-data/test_chinese.dxf"
OUTPUT_JSON="test_chinese.output.json"
EXPECTED_STRING="你好世界"

# Run dwgread to convert DXF to JSON
"$DWGREAD_PATH" -O json -o "$OUTPUT_JSON" "$INPUT_DXF"

# Check if dwgread was successful
if [ $? -ne 0 ]; then
  echo "Test FAILED: dwgread command failed to execute or returned an error."
  rm -f "$OUTPUT_JSON" # Clean up
  exit 1
fi

# Verify the content of the JSON output
if grep -q "$EXPECTED_STRING" "$OUTPUT_JSON"; then
  echo "Test PASSED"
  rm -f "$OUTPUT_JSON" # Clean up
  exit 0
else
  echo "Test FAILED: Chinese string not found or incorrect in JSON output."
  cat "$OUTPUT_JSON" # Print output for debugging
  rm -f "$OUTPUT_JSON" # Clean up
  exit 1
fi
