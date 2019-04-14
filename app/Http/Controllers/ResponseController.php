<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Response;
use App\Question;

class ResponseController extends Controller
{
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
        //
    }

    /**
     * Store a newly created resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function store(Request $request)
    {
        for ($i=0; $i < count($request->response); $i++) {
          $resp = $request->response[$i];

          // Create new response if answered.
          if($resp['response'] !== null){

            Response::create([
              "question_id" => $resp['question']['id'],
              "type" => $resp['question']['type'],
              "response" => $resp['response']
            ]);
          }
        }

        // TODO: create completed page
        return redirect('/');
    }

    /**
     * Display the specified resource.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function show($id)
    {
        $questions = Question::all()->where('questionnaire_id', $id);
        $responses = [];

        foreach ($questions as $question) {
          if(count($question->responses) > 0){
            array_push($responses, $question->responses);
          }
        }

        return view('responses.show', [
          'responses' => $responses,
          'questions' => $questions
        ]);
    }

    public function get(Request $request, $id){
      if($request->ajax()){
        $resp = [];
        foreach( Response::all()->where('question_id', $id) as $response ){
          array_push($resp, $response);
        }
        return $resp;
      }
      return redirect('/');
    }

    /**
     * Show the form for editing the specified resource.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function edit($id)
    {
        //
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
