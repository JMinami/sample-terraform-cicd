#!/bin/bash

if [ $# -ne 2 ]; then
  echo "Usage: $0 <directory1> <directory2>"
  exit 1
fi

dir1="$1"
dir2="$2"

if [ ! -d "$dir1" ] || [ ! -d "$dir2" ]; then
  echo "Both arguments must be directories."
  exit 1
fi

# ファイル名の差分を出力
echo "Comparing filenames:"
diff -rq "$dir1" "$dir2"

# ファイルの中身の差分を出力 (改行の差分を無視)
echo
echo "Comparing file contents:"
for file1 in "$dir1"/*; do
  file2="${file1/$dir1/$dir2}"
  if [ -f "$file1" ] && [ -f "$file2" ]; then
    diff --strip-trailing-cr -q "$file1" "$file2" || diff --strip-trailing-cr "$file1" "$file2"
  fi
done

echo "Comparison done."
