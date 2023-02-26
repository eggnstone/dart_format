echo Fixing path separators ...
for f in $(find lib/src/kotlin -name '*.dt.g.dart')
do
  echo "$f"
  # Multiple calls because global doesn't seem to work

  sed -i 's/\\\([a-z][a-z]\)/\/\1/g' "$f"

  #sed -i 's/\\\([a-z][a-z\.]\+\?\)/\/\1/g' "$f"
  #sed -i 's/\\\([a-z][a-z\.]\+\?\)/\/\1/g' "$f"
done
