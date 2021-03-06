<?php

class AnswerQuestionnaireCest
{
    public function _before(AcceptanceTester $I)
    {
      // NOTE: Make sure questionnaire with ID of 6 is set to public.
      $I->amOnPage('/questionnaires/answer/6');
    }

    // tests
    public function tryToTest(AcceptanceTester $I)
    {
      /*   Only answer first in list. There will always be one question.
       *   Build answer form to create a response entry based on total answers given.
       */
      $I->fillField('response[1][response]', 'Lorem Ipsum');

      $I->click('Save');
      $I->seeCurrentURLEquals('/');
    }
}
