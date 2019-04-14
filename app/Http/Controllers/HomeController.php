<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Questionnaire;
use App\Response;
use Auth;


class HomeController extends Controller
{
    /**
     * Create a new controller instance.
     *
     * @return void
     */
    public function __construct()
    {
        $this->middleware('auth');
    }

    /**
     * Show the application dashboard.
     *
     * @return \Illuminate\Contracts\Support\Renderable
     */
    public function index()
    {

      $qres = Questionnaire::all()->where('user_id', Auth::id());
      $resp = [];

      foreach ($qres as $qre) {
        foreach ($qre->questions as $question) {
          if(count($question->responses) > 0){
            array_push($resp, $question->responses);
          }
        }
      }

      // dd($resp);

      return view('home', [
        'questionnaires' => $qres,
        'responses' => $resp,
      ]);
    }
}
