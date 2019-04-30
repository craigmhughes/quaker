<?php

class DeleteQuestionnaireCest
{

  public function deleteQuestion(AcceptanceTester $I)
  {
    $I->amOnPage("/home");

    $I->fillField("email", "test@mail.com");
    $I->fillField("password", "password");
    $I->click("button[type=submit]");

    $I->see("Questionnaires", "h1");

    $I->see("Edited Questionnaire 1");
    $I->click("th[name='Edited Questionnaire 1']");

    $I->see("Edit Questionnaire");

    $I->click("#delete-questionnaire");

    // Wait for modal animation to complete.
    $I->wait(1);

    // Confirm deletion
    $I->seeElement("#delete-modal");
    $I->click("#delete-modal button.primary-btn");

    $I->see("Questionnaires", "h1");
    $I->dontSeeElement("th[name='Edited Questionnaire 1']");

  }
}
