const { chromium } = require('playwright');

const TOKEN = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI2OWQ4MDc5ZGRkOTFkNmFkNTkwNGVlMjciLCJrZXkiOiI5YzY5NWU1MDUzMWJjNTZmNGI4MjEzYzYwZjkzMmI2MyIsImlkIjoiNjlkOWQxZGQ4MjE5ZmI1ZmVkYzZjZDgzIiwiaWF0IjoxNzc1ODgyNzE3LCJleHAiOjE4MDc0MTg3MTd9.aBvKNl1xebDDiKIBvvFz4D5t613VH1X9pZMpNLobVwQ';
const STORAGE_ID = '6a00019fa166af267ed2cf05';

const features = [
  { title: 'Local Events', description: 'Stay up-to-date on the latest and soon to be happenings in the North Valley area.' },
  { title: 'Hidden Gems', description: 'Discover secret spots, local favorites, and under-the-radar places that make North Valley special.' },
  { title: 'Food & Drink', description: 'From craft breweries to family-owned eateries, explore the best culinary experiences across Vista, San Marcos, and Escondido.' },
  { title: 'Outdoor Adventures', description: 'Hiking trails, parks, beaches, and outdoor activities for every skill level in North County San Diego.' },
  { title: 'Community Stories', description: 'Meet local heroes, small business owners, and neighbors making a difference in our community.' },
  { title: 'Weekend Picks', description: 'Curated recommendations for the best things to do, see, and experience every weekend.' }
];

(async () => {
  const browser = await chromium.launch({ headless: true });
  const context = await browser.newContext();
  
  // Set the auth token
  await context.addInitScript((token) => {
    localStorage.setItem('letterman_token', token);
  }, TOKEN);
  
  const page = await context.newPage();
  
  try {
    // Navigate to the publication settings
    await page.goto(`https://app.letterman.ai/newsletters-storage/${STORAGE_ID}/settings`, { waitUntil: 'networkidle' });
    
    console.log('Page loaded, looking for feature inputs...');
    
    // Wait for the page to fully load
    await page.waitForTimeout(3000);
    
    // Take a screenshot to see what's on the page
    await page.screenshot({ path: '/root/.openclaw/workspace/letterman-page.png', fullPage: true });
    console.log('Screenshot saved');
    
    // Try to find and update feature sections
    // The features are likely in a section labeled "Features" or "Sign-up Page"
    
    // Look for feature title inputs (Feature Title 2, 3, 4, 5, 6)
    for (let i = 1; i < features.length; i++) {
      const featureNum = i + 1; // 2, 3, 4, 5, 6
      const feature = features[i];
      
      // Try to find the title input for this feature
      const titleSelector = `input[placeholder*="Feature Title ${featureNum}"], input[value*="Feature Title ${featureNum}"], textarea[placeholder*="Feature Title ${featureNum}"]`;
      const descSelector = `input[placeholder*="Feature Description ${featureNum}"], textarea[placeholder*="Feature Description ${featureNum}"]`;
      
      // More generic approach - look for inputs in the features section
      const titleInput = await page.locator(`text=Feature Title ${featureNum} >> xpath=../../input, text=Feature Title ${featureNum} >> xpath=../input, text=Feature Title ${featureNum} >> xpath=../textarea`).first();
      
      if (await titleInput.isVisible().catch(() => false)) {
        await titleInput.fill(feature.title);
        console.log(`Updated Feature ${featureNum} title: ${feature.title}`);
      } else {
        // Try alternative selectors
        const allInputs = await page.locator('input[type="text"], textarea').all();
        console.log(`Found ${allInputs.length} input elements`);
        
        for (let j = 0; j < allInputs.length; j++) {
          const placeholder = await allInputs[j].getAttribute('placeholder').catch(() => '');
          const value = await allInputs[j].inputValue().catch(() => '');
          console.log(`Input ${j}: placeholder="${placeholder}", value="${value}"`);
        }
      }
    }
    
    // Look for save button
    const saveButton = await page.locator('button:has-text("Save"), button:has-text("Update"), button[type="submit"]').first();
    if (await saveButton.isVisible().catch(() => false)) {
      await saveButton.click();
      console.log('Clicked save button');
      await page.waitForTimeout(2000);
    }
    
    console.log('Done!');
    
  } catch (error) {
    console.error('Error:', error);
    await page.screenshot({ path: '/root/.openclaw/workspace/letterman-error.png', fullPage: true });
  }
  
  await browser.close();
})();
