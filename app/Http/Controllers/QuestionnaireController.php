<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Questionnaire;
use Auth;

class QuestionnaireController extends Controller
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
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
        //
    }

    /**
     * Show the form for creating a new resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function create()
    {

        return view('questionnaire.edit-form');
    }

    /**
     * Store a newly created resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function store(Request $request)
    {

        // dd($request);

        $is_public = isset($request['is_public']) ? 1 : 0;

        $this->validate($request,[
          'title' => 'required',
          'description' => 'nullable',
          'questions' => 'required',
          'is_public' => 'nullable',
        ]);

        $questionnaire = Questionnaire::create([
          'title' => $request['title'],
          'description' => $request['description'],
          'user_id' => Auth::id(),
          'is_public' => $is_public
        ]);

        // dd($request['questions']);

        foreach($request['questions'] as $question){

          $new_question = $questionnaire->questions()->create([
            'title' => $question['title'],
            'type' => $question['type'],
            'questionnaire_id' => $questionnaire['id'],
          ]);

          if($question['type'] == "closed"){
            foreach($question['options'] as $option){

              $new_question->options()->create([
                'question_id' => $new_question['id'],
                'option' => $option,
                'order_no' => 0,
              ]);


            }
          }
        }



        return redirect('home');
    }

    /**
     * Display the specified resource.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function show($id)
    {
        //
    }

    /**
     * Show the form for editing the specified resource.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function edit($id)
    {
      $edit = Questionnaire::find($id);

      /* Disable other users from editing questionnaires
      not belonging to them */
      if($edit->user_id !== Auth::id()){
        return redirect('/home');
      }

      // $data['questions'] = $data['questionnaire']->questions;
      // $data['options'] = [];
      //
      // for($i = 0; $i < sizeof($data['questions']); $i++){
      //   if($data['questions'][$i]->type == "closed"){
      //     $data['options'][$i] = $data['questions'][$i]->options;
      //   }
      // }

      // dd($data);

      return view('questionnaire.edit-form', ['edit' => $edit]);
    }

    /**
     * Update the specified resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function update(Request $request, $id)
    {
        //
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function destroy($id)
    {
        //
    }
}
