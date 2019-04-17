<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Questionnaire;
use App\Question;
use App\Option;
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
        // $this->middleware('auth');
    }

    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
        $this->middleware('auth');
        return redirect('/home');
    }

    /**
     * Show the form for creating a new resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function create()
    {
        // Being weird with auth middleware. Must use check.
        if(Auth::check()){
          return view('questionnaire.edit-form');
        }

        return redirect('/');
    }

    /**
     * Store a newly created resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function store(Request $request)
    {
        $this->middleware('auth');
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
                'option' => $option['title'],
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
      $view = Questionnaire::find($id);

      /* Disable other users from editing questionnaires
      not belonging to them */
      if(!$view['is_public'] || $view == null){
        return redirect('/');
      }

      return view('questionnaire.answer-form', ['view' => $view]);
    }

    /**
     * Show the form for editing the specified resource.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function edit($id)
    {
      $this->middleware('auth');

      $edit = Questionnaire::find($id);

      /* Disable other users from editing questionnaires
      not belonging to them */
      if($edit['user_id'] !== Auth::id()){
        return redirect('/home');
      }

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
        $this->middleware('auth');
        $edit = $request->all();

        // dd($request);

        // Validate required fields
        $this->validate($request,[
          'title' => 'required',
          'description' => 'nullable',
          'questions' => 'required'
        ]);

        // dd($edit);

        // Edit Questionnaire
        $questionnaire = Questionnaire::find($edit['id']);

        $questionnaire->title = $edit['title'];
        $questionnaire->description = $edit['description'];
        $questionnaire->is_public = isset($edit['is_public']) ? 1 : 0;

        $questionnaire->save();

        // Edit Questions
        $questions = $questionnaire->questions;
        $found_questions = [];

        for($i = 0; $i < count($edit['questions']); $i++){

          // Create new Question if no existing id is found.
          if(!isset($edit['questions'][$i]['id'])){


            $new_question = $questionnaire->questions()->create([
              'title' => $edit['questions'][$i]['title'],
              'type' => $edit['questions'][$i]['type'],
              'questionnaire_id' => $questionnaire['id'],
            ]);

            if($edit['questions'][$i]['type'] == "closed"){
              foreach($edit['questions'][$i]['options'] as $option){

                $new_question->options()->create([
                  'question_id' => $new_question['id'],
                  'option' => $option['title'],
                  'order_no' => 0,
                ]);
              }

            }



          } else {

            $question = Question::find($edit['questions'][$i]['id']);

            if($question == null){
              // TODO: add error message to home
              return redirect('/home');
            }

            if($question['type'] == "closed" && isset($edit['questions'][$i]['options'])){

              // Overwrite options first. Then overwrite question data.
              $options = $edit['questions'][$i]['options'];

              /*  Loop for checking if there are missing
                  options in edit form. delete if so.
              */
              for ($j=0; $j < count($question->options); $j++) {
                $found = false;

                for ($k=0; $k < count($options); $k++) {

                  if(isset($options[$k]['id'])){
                    if($question->options[$j]['id'] == $options[$k]['id']){
                      $found = true;
                      break;
                    }
                  }

                }

                if(!$found){
                  Option::find($question->options[$j]['id'])->delete();
                }
              }

              /* Loop for checking edit options and
                editing/creating based on result
              */
              for ($j=0; $j < count($options); $j++) {



                // If existing option.
                if(isset($options[$j]['id'])){

                  $option = Option::find($options[$j]['id']);

                  if($option !== null){
                    // overwrite.
                    $option->option = $options[$j]['title'];
                    $option->save();
                  }

                } else {
                  // dd($edit['questions'][$i]['id']);
                  // else, create new option.
                  $new_option = $question->options()->create([
                    'question_id' => $edit['questions'][$i]['id'],
                    'option' => $options[$j]['title'],
                    'order_no' => 0,
                  ]);

                  // dd($new_option);

                }
              }


            } else if($edit['questions'][$i]['type'] == "closed"){

                foreach($edit['questions'][$i]['options'] as $option){
                  $question->options()->create([
                    'question_id' => $question['id'],
                    'option' => $option['title'],
                    'order_no' => 0,
                  ]);
                }
            } else if ($edit['questions'][$i]['type'] == "open" && $question["type"] == "closed"){
              $question->options()->delete();
            }


            /*  Loop for checking if there are missing
                quesitons in edit form. delete if so.
            */
            for ($j=0; $j < count($questionnaire->questions); $j++) {
              $found = false;

              for ($k=0; $k < count($edit['questions']); $k++) {

                if(isset($edit['questions'][$k]['id'])){
                  // dd($questionnaire->questions[$j]['id']);
                  if($questionnaire->questions[$j]['id'] == $edit['questions'][$k]['id']){
                    $found = true;
                    break;
                  }
                }

              }

              if(!$found){
                $del_question = Question::find($questionnaire->questions[$j]['id']);
                $del_question->responses()->delete();
                $del_question->delete();
              }
            }


            // Overwrite question data.
            $question->title = $edit['questions'][$i]['title'];
            $question->type = $edit['questions'][$i]['type'];
            $question->save();

          }

        }

        return redirect('/home');


    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function destroy($id)
    {
      $this->middleware('auth');
      $questionnaire = Questionnaire::find($id);

      // Check if user is owner.
      if($questionnaire->user_id == Auth::id()){
        $questionnaire->delete();
      }

      return redirect('/home');
    }
}
