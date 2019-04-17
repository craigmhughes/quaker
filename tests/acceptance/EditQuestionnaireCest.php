<?php

class EditQuestionnaireCest
{
    public function _before(AcceptanceTester $I)
    {
      $I->amOnPage("/home");

      $I->fillField("email", "test@mail.com");
      $I->fillField("password", "password");
      $I->click("button[type=submit]");

      $I->see("Questionnaires", "h1");
    }


    public function editQuestion(AcceptanceTester $I)
    {
      $I->see("Questionnaire 1");
      $I->click("th[name='Questionnaire 1']");

      $I->see("Edit Questionnaire");

      // Start Delete Question.
        // See question 1
        $I->seeElement("textarea[name='questions[0][title]']");
        // Remove Question 1
        $I->click(".question:nth-child(1) .remove-question");
        // See that question 2 has become question 1
        $I->seeElement("textarea[name='questions[0][title]']");
      // End Delete Question

      // Start Change Question
        $I->click(".question:nth-child(1) .q-select");
        $I->click(".question:nth-child(1) .q-select option[value=closed]");
        $I->fillField("questions[0][title]", "Edited Open to Closed Question");

        $I->fillField("questions[0][options][0][title]", "Sample Option 1");
        $I->click(".question:nth-child(1) .add-option");
        $I->fillField("questions[0][options][1][title]", "Sample Option 2");
      // End Change Question

      // Add Question
        $I->click("Add Question");

      // Question 2 = Open Question
        $I->fillField("questions[1][title]", "Sample Open Question");


      $I->click("Save");
      $I->seeCurrentURLEquals("/home");

    }
}
