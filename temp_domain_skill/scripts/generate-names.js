#!/usr/bin/env node

/**
 * Domain name generator
 * 
 * Usage:
 *   node generate-names.js "topic" [count]
 * 
 * Example:
 *   node generate-names.js "Growing Giant Zucchinis" 50
 */

function generateDomainNames(topic, count = 30) {
  const words = topic.toLowerCase().split(/\s+/);
  const names = new Set();
  
  // Extract key words (filter out common words)
  const stopWords = ['a', 'an', 'the', 'for', 'with', 'and', 'or'];
  const keywords = words.filter(w => !stopWords.includes(w) && w.length > 2);
  
  // Strategy 1: Direct combinations
  keywords.forEach(word => {
    names.add(word);
    names.add(word + 'hub');
    names.add(word + 'pro');
    names.add('get' + word);
    names.add('my' + word);
  });
  
  // Strategy 2: Two-word combinations
  for (let i = 0; i < keywords.length; i++) {
    for (let j = 0; j < keywords.length; j++) {
      if (i !== j) {
        names.add(keywords[i] + keywords[j]);
      }
    }
  }
  
  // Strategy 3: Prefixes
  const prefixes = ['grow', 'mega', 'epic', 'super', 'pro', 'best', 'top', 'smart'];
  keywords.forEach(word => {
    prefixes.forEach(prefix => {
      names.add(prefix + word);
    });
  });
  
  // Strategy 4: Suffixes
  const suffixes = ['hub', 'pro', 'hq', 'zone', 'spot', 'place', 'world', 'king', 'kingdom', 'magic', 'master'];
  keywords.forEach(word => {
    suffixes.forEach(suffix => {
      names.add(word + suffix);
    });
  });
  
  // Strategy 5: Combined keywords
  if (keywords.length >= 2) {
    names.add(keywords.join(''));
    names.add(keywords.slice(0, 2).join(''));
  }
  
  // Convert to array and limit to requested count
  const nameArray = Array.from(names)
    .filter(name => name.length >= 4 && name.length <= 25)
    .slice(0, count);
  
  return nameArray;
}

function main() {
  const topic = process.argv[2];
  const count = parseInt(process.argv[3]) || 30;
  
  if (!topic) {
    console.error('Usage: node generate-names.js "topic" [count]');
    console.error('Example: node generate-names.js "Growing Giant Zucchinis" 50');
    process.exit(1);
  }
  
  const names = generateDomainNames(topic, count);
  
  // Generate with extensions
  const extensions = ['com', 'net', 'org'];
  const domains = [];
  
  names.forEach(name => {
    extensions.forEach(ext => {
      domains.push(`${name}.${ext}`);
    });
  });
  
  console.log(JSON.stringify({
    topic,
    baseNames: names,
    domains: domains,
    count: domains.length
  }, null, 2));
}

main();
