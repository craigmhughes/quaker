@extends('layouts.app')

@section('title')
  Responses
@endsection

@section('include-scripts')
  <script src="{{asset('js/Chart.min.js')}}"></script>
  <script src="{{asset('js/response-chart.js')}}" defer></script>
@endsection

@section('content')
  @if (!isset($responses) || count($responses) < 1)
    <script>window.location = "/home";</script>
  @else

    {{---------------- GATHER DATA FOR USE IN CHART ELEMENTS -----------------}}

    <?php
    // Init chart data array (Holds groups of responses)
    $chart_data = [];
    $question_data = [];

    // Re-read object to get numeric index to match when collecting response.
    foreach ($questions as $question) {
      array_push($question_data, $question);
    }

     // Split by Question group
    foreach($responses as $response_group){

        // 0 = Labels, 1 = Frequency, 2 = Question Type
        $resp_data = [[],[],[]];


      //  Individual Responses
      foreach($response_group as $response){

          // Base chart style on question type.
          if($resp_data[2] == null){
            $resp_data[2] = $response['type'];
          }

          // Check against existing responses and add to frequency array if found,
          // else, make new label with a frequency value of 1
          if(count($resp_data[0]) > 0){
            for($i = 0; $i < count($resp_data[0]); $i++){
              if($response['response'] == $resp_data[0][$i]){
                $resp_data[1][$i] += 1;
              } else {
                array_push($resp_data[0], $response['response']);
                array_push($resp_data[1], 1);
              }
            }
          } else {
            array_push($resp_data[0], $response['response']);
            array_push($resp_data[1], 1);
          }
      }

       array_push($chart_data, $resp_data);

    }
    ?>

    {{--------------------------- RENDER CHARTS ------------------------------}}


    <?php for($i = 0; $i < count($chart_data); $i++){ ?>
      <div class="response">
        <h1>{{$question_data[$i]->title}}</h1>
        <input type="hidden" value="{{$question_data[$i]->id}}" class="question-id">
        <p>{{count($question_data[$i]->responses)}} Responses</p>
        <canvas class="chart-element"></canvas>
      </div>
    <?php };?>
  @endif
@endsection
