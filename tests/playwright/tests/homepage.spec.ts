import { test, expect } from '@playwright/test';

test('has title', async ({ page }) => {
  await page.goto('/');
  // Expect a title "to contain" a substring.
  await expect(page).toHaveTitle(/PetSpotR/);
});

test('get started link', async ({ page }) => {
  await page.goto('/');
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
  await page.setInputFiles('#petimage', 'fixtures/buddy.jpg');

  // Submit the form
  await page.click('button:has-text("Submit")');

  // Expect a success message or redirection after form submission
  await expect(page).toHaveURL(/.*submit/);
});
