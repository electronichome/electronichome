IFS=',' read -ra ADDR <<< "$SURGE_URLS"
for i in "${ADDR[@]}"; do
  curl -XPUT --data-binary "@public.tar.gz" -H "Content-Type: application/octet-stream" -H "Authorization: Basic ${SURGE_BASIC_AUTH}" "https://surge.surge.sh/${i}"
done
