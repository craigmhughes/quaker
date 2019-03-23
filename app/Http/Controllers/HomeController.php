<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Questionnaire;
use App\Question;
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

      return view('home', [
        'questionnaires' => $qres,
      ]);
    }
}
