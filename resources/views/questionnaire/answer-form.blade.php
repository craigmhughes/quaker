@extends('layouts.app')

@section('title')
  Answer Questionnaire
@endsection

@section('include-scripts')
  <script src="{{ asset('js/response.js') }}" defer></script>
@endsection

@section('content')
  <!-- TODO: Change input values to be readable for the ResponseController -->
  <div id="questionnaire-container" class="view">

    {!! Form::open(array('action' => "ResponseController@store", 'id' => 'questionnaire-form')) !!}
        {{ csrf_field() }}
        <div class="row row-head d-flex">
          <h3 class="title">Answer Questionnaire</h3>
          <div class="ml-auto right">
            {!! Form::submit('Save', ['class' => 'btn btn-primary ml-auto']) !!}
          </div>
        </div>

        <h1 class="title">{{$view->title}}</h1>
        <p class="desc">{{$view->description}}</p>

        <div id="question-section">
            <?php
              for($i = 0; $i < count($view->questions); $i++){
                $question = $view->questions[$i];

                echo '
                <div class="question">
                  <div class="row">

                    <h3 class="title">' . $question->title . '</h3>

                  </div>

                  <input type="hidden" class="q-type" name="response[' . $i . '][question][type]" value="'. $question->type .'"/>
                  <input type="hidden" class="q-id" name="response[' . $i . '][question][id]" value="'. $question->id .'"/>
                  <div class="question-inputs">';

                  if($question->type == "open"){
                    echo '<input class="open-input" type="text" name="response[' . $i . '][response]" placeholder="Enter Answer Here..."/></div>';
                  } else {
                    echo '<input type="hidden" value="" class="response-ans" name="response[' . $i . '][response]">';
                    for($j = 0; $j < count($question->options); $j++){
                    $option = $question->options[$j];
                     echo '
                     <div class="closed-option">
                       <div class="pretty p-curve p-pulse p-icon">
                         <input type="checkbox" class="input-option"/>
                         <div class="state p-success">
                             <i class="icon fas fa-check"></i>
                             <label></label>
                         </div>
                       </div>
                       <p class="closed-value title">'. $option->option .'</p>
                     </div>
                     ';
                    }
                    echo "</div>";
                  }

                  echo "</div>";
              }
            ?>
        </div>

    {!! Form::close() !!}
  </div>
@endsection
