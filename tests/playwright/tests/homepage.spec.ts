import { test, expect } from '@playwright/test';

// Helper function to navigate to the homepage and click the "continue" button
test.beforeEach(async ({ page }) => {
  await page.goto('/');
  await page.click('button:has-text("Continue")');
});

test('has title', async ({ page }) => {
  // Expect a title "to contain" a substring.
  await expect(page).toHaveTitle(/PetSpotR/);
});

test('get started link', async ({ page }) => {
  // Click the get started link.
  await page.getByRole('button', { name: 'I lost my pet' }).click();
  // Expects the URL to contain intro.
  await expect(page).toHaveURL(/.*lost/);
});

test('fill out and submit lost pet form', async ({ page }) => {
  // Navigate directly to the lost pet page
  await page.goto('/lost');

  // Fill out the form fields
  await page.fill('#petname', 'Buddy');
  await page.selectOption('#type', 'Dog');
  await page.fill('#breed', 'Golden Retriever');
  await page.selectOption('#lostlocation', 'Melbourne');
  await page.fill('#ownername', 'John Doe');
  await page.fill('#owneremail', 'john.doe@example.com');
  await page.setInputFiles('#petimage', 'tests/playwright/fixtures/buddy.jpg');

  // Submit the form
  await page.click('button:has-text("Submit")');

  // Expect a success message or redirection after form submission
  await expect(page).toHaveURL(/.*submit/);
});