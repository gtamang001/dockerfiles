#! /bin/bash
echo "running exporter for endpoint $ENDPOINT
apache_exporter --scrape_uri="$ENDPOINT"