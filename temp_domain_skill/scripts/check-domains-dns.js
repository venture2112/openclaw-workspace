#!/usr/bin/env node

/**
 * Domain availability checker using DNS lookups
 * No API keys required - works instantly!
 * 
 * Usage:
 *   node check-domains-dns.js <domain1> <domain2> ...
 * 
 * Example:
 *   node check-domains-dns.js example.com test.net demo.org
 */

const dns = require('dns').promises;

async function checkDomain(domain) {
  try {
    // Try to resolve the domain - if it resolves, it's registered
    await dns.resolve(domain, 'A');
    return { domain, available: false, status: 'taken' };
  } catch (error) {
    // ENOTFOUND = domain doesn't exist (likely available)
    // ENODATA = domain exists but no A records (still registered)
    if (error.code === 'ENOTFOUND') {
      return { domain, available: true, status: 'available' };
    } else if (error.code === 'ENODATA') {
      return { domain, available: false, status: 'registered' };
    }
    return { domain, available: false, status: 'unknown', error: error.code };
  }
}

async function checkDomainsBatch(domains, concurrency = 10) {
  const results = [];
  
  for (let i = 0; i < domains.length; i += concurrency) {
    const batch = domains.slice(i, i + concurrency);
    const batchResults = await Promise.all(batch.map(checkDomain));
    results.push(...batchResults);
    
    // Small delay between batches to be respectful
    if (i + concurrency < domains.length) {
      await new Promise(r => setTimeout(r, 100));
    }
  }
  
  return results;
}

async function main() {
  const domains = process.argv.slice(2);
  
  if (domains.length === 0) {
    console.error('Usage: node check-domains-dns.js <domain1> <domain2> ...');
    console.error('Example: node check-domains-dns.js example.com test.net');
    process.exit(1);
  }
  
  const results = await checkDomainsBatch(domains);
  
  const available = results.filter(r => r.available).map(r => r.domain);
  const unavailable = results.filter(r => !r.available && r.status !== 'unknown').map(r => r.domain);
  const unknown = results.filter(r => r.status === 'unknown').map(r => r.domain);
  
  // Output JSON for easy parsing
  const output = {
    checked: domains.length,
    available: available,
    unavailable: unavailable,
    unknown: unknown,
    summary: {
      available: available.length,
      unavailable: unavailable.length,
      unknown: unknown.length
    }
  };
  
  console.log(JSON.stringify(output, null, 2));
}

main().catch(err => {
  console.error('Error:', err.message);
  process.exit(1);
});
