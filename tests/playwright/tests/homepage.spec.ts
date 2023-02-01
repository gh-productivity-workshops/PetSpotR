import { test, expect } from '@playwright/test';

test('has title', async ({ page }) => {
  await page.goto('http://app.9e5524d3a2474ae58276.westus3.aksapp.io/');

  // Expect a title "to contain" a substring.
  await expect(page).toHaveTitle(/PetSpotR/);
});

test('get started link', async ({ page }) => {
  await page.goto('http://app.9e5524d3a2474ae58276.westus3.aksapp.io/');

  // Click the get started link.
  await page.getByRole('button', { name: 'I lost my pet' }).click();

  // Expects the URL to contain intro.
  await expect(page).toHaveURL(/.*lost/);
});
