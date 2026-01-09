#!/bin/bash

# Step 1: Build scanner
echo "Building scanner..."
flex lexical.l
gcc -std=c99 main.c lex.yy.c -o scanner
if [ $? -ne 0 ]; then
  echo "Scanner Build Failed."
  exit 1
fi

# Step 2: Run scanner
echo "Running scanner..."
./scanner
if [ $? -ne 0 ]; then
  echo "Scanner Execution Failed."
  exit 1
fi

# Step 3: Compare outputs
echo "Comparing outputs..."
echo "-------------------------"

total_tests=45
passed=0

for i in $(seq 1 $total_tests); do
  actual="my-output/${i}.out"
  expected="test/out/${i}.out"

  if [ ! -f "$actual" ]; then
    echo "Test $i: Missing output file $actual"
    continue
  fi

  if diff -q "$actual" "$expected" > /dev/null; then
    echo "Test $i: Passed"
    passed=$((passed + 1))
  else
    echo "Test $i: Failed"
    echo "Diff:"
    diff "$actual" "$expected"
    echo "-------------------------"
  fi
done

grade=$((passed * 2))  # 0.2 per test = 2 points per 10 tests
echo "========================="
echo "Passed: $passed / $total_tests"
echo "Grade: $grade / 10"
echo "========================="

if [ "$passed" -ne "$total_tests" ]; then
  exit 1
fi
