#!/bin/bash
# Test CNAME Records dari 2 klien berbeda

echo "=== Testing CNAME Records ==="
echo ""

echo "Testing from $(hostname):"
echo ""

echo "1. Testing www.K11.com → sirion.K11.com:"
dig www.K11.com +short
echo ""

echo "2. Testing static.K11.com → lindon.K11.com:"
dig static.K11.com +short
echo ""

echo "3. Testing app.K11.com → vingilot.K11.com:"
dig app.K11.com +short
echo ""

echo "4. Verifying A records:"
echo "   sirion.K11.com:"
dig sirion.K11.com +short
echo "   lindon.K11.com:"
dig lindon.K11.com +short
echo "   vingilot.K11.com:"
dig vingilot.K11.com +short

echo ""
echo "5. Testing with nslookup:"
nslookup www.K11.com
nslookup static.K11.com
nslookup app.K11.com