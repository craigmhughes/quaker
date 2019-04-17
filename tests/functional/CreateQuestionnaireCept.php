<?php
$I = new FunctionalTester($scenario);

$I->am('researcher');
$I->wantTo('create a new questionnaire');


// log in
Auth::loginUsingId(1);

// Add db test data
$I->haveRecord('questionnaires', [
    'id' => '9000',
    'title' => 'Qre 1',
    'user_id' => 1,
    'is_public' => false,
]);



// When
$I->amOnPage('/home');
$I->see('Questionnaires', 'h1');
$I->see('Qre 1');
$I->dontSee('Qre 2');
// And
$I->click('Create Questionnaire');

// Then
$I->seeCurrentUrlEquals('/questionnaires/create');
// And
$I->see('New Questionnaire', 'h3');

// Submit only required fields and see if app handles rest.
$I->submitForm('#questionnaire-form', [
    'title' => 'Qre 2',

    'questions[0][title]' => 'Test Question 1',
    'questions[0][type]' => 'open',

    'questions[1][title]' => 'Test Question 2',
    'questions[1][type]' => 'closed',
    'questions[1][options][0][title]' => 'one',
]);

// Then
$I->seeCurrentUrlEquals('/home');
$I->see('Questionnaires', 'h1');
$I->see('Qre 1');
$I->see('Qre 2');

$I->seeRecord('questionnaires', ['title' => 'Qre 2']);
