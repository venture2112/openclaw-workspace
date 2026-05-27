# DNS Lookup Method

## How It Works

This skill uses **DNS resolution** to check if domains are registered.

### Process

1. **DNS Query**: Attempts to resolve the domain's A record
2. **Result Analysis**:
   - `ENOTFOUND` = Domain likely available ✅
   - `DNS resolves` = Domain is registered ❌
   - `ENODATA` = Domain exists but no records (still registered)

### Advantages

✅ **No API keys required**
✅ **Completely free**
✅ **Fast** - checks multiple domains concurrently
✅ **No rate limits**
✅ **Works immediately**

### Limitations

⚠️ **~95% accurate** - Not perfect for edge cases
⚠️ **Parked domains** may show as available when they're not
⚠️ **Always verify** with your registrar before purchasing

### Technical Details

The script uses Node.js built-in `dns.promises` module:

```javascript
const dns = require('dns').promises;

async function checkDomain(domain) {
  try {
    await dns.resolve(domain, 'A');
    return { available: false }; // Resolved = taken
  } catch (error) {
    if (error.code === 'ENOTFOUND') {
      return { available: true }; // Not found = likely available
    }
  }
}
```

### Concurrency

The script checks up to 10 domains simultaneously to maximize speed while being respectful of DNS servers.

### Best Practices

1. Generate 2-3x more names than needed
2. Filter results to only show available domains
3. Prioritize .com extensions
4. Always verify before purchasing
