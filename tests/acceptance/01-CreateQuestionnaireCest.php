<?php

class CreateQuestionnaireCest
{

  public function _before(AcceptanceTester $I)
  {
    $I->amOnPage("/home");

    $I->fillField("email", "test@mail.com");
    $I->fillField("password", "password");
    $I->click("button[type=submit]");

    $I->see("Questionnaires", "h1");
  }

  public function createQuestionnaire(AcceptanceTester $I)
  {



    // Start Create Questionnaire
      $I->click("Create Questionnaire");

      $I->fillField("title", "Questionnaire 1");
      $I->fillField("description", "lorem ipsum dolor sit amet.");
      $I->click("input[name=is_public]");

      // Question 1 = Closed question
        $I->click(".question:nth-child(1) .q-select");
        $I->click(".question:nth-child(1) .q-select option[value=closed]");
        $I->fillField("questions[0][title]", "Sample Closed Question");

        $I->fillField("questions[0][options][0][title]", "Sample Option 1");
        $I->click(".question:nth-child(1) .add-option");
        $I->fillField("questions[0][options][1][title]", "Sample Option 2");

      $I->click("Add Question");

      // Question 2 = Open Question
        $I->fillField("questions[1][title]", "Sample Open Question");

      $I->click("Save");

      $I->seeCurrentURLEquals("/home");

  }

}
