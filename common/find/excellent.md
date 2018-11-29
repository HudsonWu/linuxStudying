find . -type f -name "*.log" | grep -v .do-not-touch | while read fname; do
echo mv $fname ${fname/.log/.LOG/}; done | bash -x

find . -path "./.git" -prune -o -type f ! -name "*.*" -print
