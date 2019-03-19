<?php

use App\User;
use Illuminate\Support\Str;
use Faker\Generator as Faker;
use App\Question;
use App\Questionnaire;
use App\Response;

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
        'user_id' => 1,
    ];
});

$factory->define(Question::class, function (Faker $faker) {

    // random question type -- true = open, false = closed
    $q_type = rand(0,1)==1;

    return [
        'title' => $faker->sentence,
        'questionnaire_id' => rand(1,5),
        'type' => $q_type ? 'open' : 'closed',
        'options' => $q_type ? '' : '["' . $faker->word . '", "' . $faker->word . '", "' . $faker->word . '"]',
        'labels' => $q_type ? '' : '["' . $faker->word . '", "' . $faker->word . '", "' . $faker->word . '"]',
    ];
});

$factory->define(Response::class, function (Faker $faker) {

    // get question type -- true = open, false = closed
    $q = Question::find(rand(1,10));
    $r_type = $q->type == 'open';
    $ans = str_replace(['[','"',']'], '', explode(',', $q->options)[0]);

    return [
        'question_id' => $q->id,
        'type' => $r_type ? 'open' : 'closed',
        'response' => $r_type ? $faker->sentence : $ans,
    ];
});
