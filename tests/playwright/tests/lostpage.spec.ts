// Create playwright tests for LostPet.razor
// import dependencies
import { test, expect } from '@playwright/test';

// test that h2 element with the words "Step 1: Tell us about your pet and how to contact you" renders
test('h2 element with the words "Step 1: Tell us about your pet and how to contact you" renders', async ({ page }) => {
    await page.goto('https://localhost:5001/LostPet');
    await expect(page).toHaveText('h2', 'Step 1: Tell us about your pet and how to contact you');
})

// test that h2 element with the words "Step 2: Tell us where your pet was last seen" renders
test('h2 element with the words "Step 2: Tell us where your pet was last seen" renders', async ({ page }) => {
    await page.goto('https://localhost:5001/LostPet');
    await expect(page).toHaveText('h2', 'Step 2: Tell us where your pet was last seen');
})

// test that h2 element with the words "Step 3: Tell us about your pet's appearance" renders
test(`h2 element with the words "Step 3: Tell us about your pet's appearance" renders`, async ({ page }) => {
    await page.goto('https://localhost:5001/LostPet');
    await expect(page).toHaveText('h2', `Step 3: Tell us about your pet's appearance`);
})

// test that dropdown menu renders
test('dropdown menu renders', async ({ page }) => {
    await page.goto('https://localhost:5001/LostPet');
    await expect(page).toHaveSelector('select');
})