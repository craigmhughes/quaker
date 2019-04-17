<?php

/*
|--------------------------------------------------------------------------
| Web Routes
|--------------------------------------------------------------------------
|
| Here is where you can register web routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| contains the "web" middleware group. Now create something great!
|
*/

Route::get('/', function () { return view('welcome'); });

Route::get('responses/get/{id}', [
  'as' => 'responses.get',
  'uses' => 'ResponseController@get'
]);

Route::get('questionnaires/answer/{id}', [
  'as' => 'questionnaires.show',
  'uses' => 'QuestionnaireController@show'
]);

Route::get('questionnaires/{id}', function(){
  return redirect('/');
});


Route::group(['middleware' => ['web']], function () {
    Auth::routes();

    Route::get('/home', 'HomeController@index')->name('home');

    // Questionnaires
    Route::get('questionnaires/edit/{id}', [
      'as' => 'questionnaires.edit',
      'uses' => 'QuestionnaireController@edit'
    ]);

    Route::get('questionnaires/create', [
      'as' => 'questionnaires.create',
      'uses' => 'QuestionnaireController@create'
    ]);

    Route::resource('/questionnaires', 'QuestionnaireController', ['except' => ['edit', 'show', 'create']]);
    Route::resource('/responses', 'ResponseController');


});
