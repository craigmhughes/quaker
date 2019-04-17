<?php
$I = new FunctionalTester($scenario);

$I->am('researcher');
$I->wantTo('edit an existing questionnaire');


// log in
Auth::loginUsingId(1);

// Add db test data
$I->haveRecord('questionnaires', [
    'id' => '9000',
    'title' => 'Qre 1',
    'user_id' => 1,
    'is_public' => false,
]);

$I->haveRecord('questions', [
  'id' => 9998,
  'type' => 'open',
  'title' => 'Test Question 1',
  'questionnaire_id' => 9000
]);

$I->haveRecord('questions', [
  'id' => 9999,
  'type' => 'open',
  'title' => 'Test Question 2',
  'questionnaire_id' => 9000
]);



// When
$I->amOnPage('/home');
$I->see('Questionnaires', 'h1');
$I->see('Qre 1');
// And

// Issue with onclick value. Works when clicking but not when testing.
// Force url to edit page instead.
// $I->click('th[value="9000"]');
$I->amOnPage('/questionnaires/edit/9000');

// Then
$I->seeCurrentUrlEquals('/questionnaires/edit/9000');
// And
$I->see('Edit Questionnaire', 'h3');

$I->fillField('title', "Qre 1 - Edited");
$I->fillField('questions[0][title]', "Test Question 3");

$I->see("Test Question 2");
$I->click(".question[value=1] > .remove-question");
$I->dontSee("Test Question 2");

$I->click('Save');

// Then
$I->seeCurrentUrlEquals('/home');
$I->see('Questionnaires', 'h1');
$I->see('Qre 1 - Edited');

$I->seeRecord('questions', ['title' => 'Test Question 3', 'questionnaire_id' => 9000]);
$I->dontSeeRecord('questions', ['title' => 'Test Question 2', 'questionnaire_id' => 9000]);
