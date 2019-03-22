<?php
$I = new FunctionalTester($scenario);

$I->am('admin');
$I->wantTo('create a new questionnaire');


// log in as your admin user
// This should be id of 1 if you created your manual login for a known user first.
Auth::loginUsingId(1);
// Add db test data

// add a test article to check that content can be seen in list at start

$I->haveRecord('questionnaires', [
    'id' => '9000',
    'title' => 'Qre 1',
    'user_id' => 1
]);


// tests /////////////////////////////////////////////

// create an article linked to one category
// When
$I->amOnPage('/dashboard');
$I->see('Questionnaires', 'h1');
$I->see('Qre 1');
$I->dontSee('Qre 2');
// And
$I->click('Create Questionnaire');

// Then
$I->amOnPage('/questionnaires/create');
// And
$I->see('Create Questionnaire', 'h1');

$I->submitForm('#createqre', [
    'title' => 'Qre 2',
    'questions' => array(
      [
        'title' => 'Test Question 1',
        'type' => 'open',
        'options' => null,
        'labels' => null,
      ],
      [
        'title' => 'Test Question 2',
        'type' => 'closed',
        'options' => 'one||two||three',
        'labels' => 'onel||twol||threel',
      ]
    )
]);

// Then
$I->seeCurrentUrlEquals('/dashboard');
$I->see('Questionnaires', 'h1');
$I->see('Qre 1');
$I->see('Qre 2');

$I->click('Qre 2'); // the title is a link to the detail page


// Check that the url has a similar path to this.. the last part is a regular expression to allow for a digit or more to be returned as an id.
$I->seeCurrentUrlMatches('~/questionnaires/(\d+)~');
$I->see('Qre 2', 'h1');
