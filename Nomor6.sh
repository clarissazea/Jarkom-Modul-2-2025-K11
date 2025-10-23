#!/bin/bash
# Tirion - Check Zone Transfer

echo "=== Checking Zone Transfer Status ==="
echo ""

# Cek serial number di Tirion (Master)
echo "Serial number at Tirion (ns1):"
dig @localhost K11.com SOA +short

echo ""
echo "Serial number at Valmar (ns2):"
dig @10.69.3.4 K11.com SOA +short

echo ""
echo "Testing record resolution from both nameservers:"
echo "ns1 (Tirion):"
dig @10.69.3.3 earendil.K11.com +short

echo "ns2 (Valmar):"
dig @10.69.3.4 earendil.K11.com +short


#!/bin/bash
# Valmar - Verify Zone Transfer

echo "=== Verifying Zone Transfer at Valmar ==="
echo ""

echo ""
echo "Serial number at Valmar:"
dig @localhost K11.com SOA +short

echo ""
echo "Testing resolution:"
dig @localhost earendil.K11.com +short
dig @localhost www.K11.com +short