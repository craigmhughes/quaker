<?php

use App\User;
use Illuminate\Support\Str;
use Faker\Generator as Faker;
use App\Question;
use App\Questionnaire;
use App\Response;
use App\Option;
use App\Label;

/*
|--------------------------------------------------------------------------
| Model Factories
|--------------------------------------------------------------------------
|
| This directory should contain each of the model factory definitions for
| your application. Factories provide a convenient way to generate new
| model instances for testing / seeding your application's database.
|
*/

$factory->define(User::class, function (Faker $faker) {
    return [
        'name' => $faker->name,
        'email' => $faker->unique()->safeEmail,
        'email_verified_at' => now(),
        'password' => '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', // password
        'remember_token' => Str::random(10),
    ];
});

$factory->define(Questionnaire::class, function (Faker $faker) {
    return [
        'title' => $faker->sentence,
        'description' => $faker->sentence,
        'user_id' => 1,
        'is_public' => rand(0,1) == 1,
    ];
});

$factory->define(Question::class, function (Faker $faker) {

    // random question type -- true = open, false = closed
    $q_type = rand(0,1)==1;

    return [
        'title' => $faker->sentence,
        'questionnaire_id' => rand(1,5),
        'type' => $q_type ? 'open' : 'closed',
    ];
});

function getClosedQ(){
  $q = Question::all()->where('type', 'closed')->pluck('id');
  return sizeof($q) > 0 ? $q[rand(0, sizeof($q) > 1 ? sizeof($q)-1 : 0)] : getClosedQ();
}

$factory->define(Option::class, function (Faker $faker) {

  $q = Question::find(getClosedQ());

    return [
        'question_id' => $q->id,
        'option' => $faker->word,
        'order_no' => 0,
    ];
});

function getPublicQ(){
  $qs = Questionnaire::all()->where('is_public', 1)->pluck('id');
  $q = Question::all()->where('questionnaire_id', $qs[rand(0, sizeof($qs) > 1 ? sizeof($qs)-1 : 0)])->pluck('id');
  return sizeof($q) > 0 ? $q : getPublicQ();
}

function getOpts(){
  // get question type -- true = open, false = closed
  $q = getPublicQ();
  $q = Question::find($q[rand(0,sizeof($q) > 1 ? sizeof($q)-1 : 0)]);

  if($q->type == "open"){
    return [$q, null];
  }

  $ans = Option::all()->where('question_id', $q->id)->pluck('id');
  return sizeof($ans) > 1 ? [$q,  Option::find($ans[0])->option] : getOpts();
}

$factory->define(Response::class, function (Faker $faker) {
    $data = getOpts();
    $q = $data[0];
    $ans = $data[1];

    return [
        'question_id' => $q->id,
        'type' => $q->type,
        'response' => $q->type == "open" ? $faker->sentence : $ans,
    ];
});
