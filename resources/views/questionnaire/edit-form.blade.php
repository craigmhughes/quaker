@extends('layouts.app')

@section('include-scripts')
  <script src="{{ asset('js/questionnaire.js') }}" defer></script>
@endsection

@section('content')
  <div id="questionnaire-container">

    {!! Form::open(array('action' => isset($edit) ?
      ["QuestionnaireController@update", $edit->id] : "QuestionnaireController@store", 'id' => 'questionnaire-form')) !!}
        {{ csrf_field() }}
        @isset($edit)
          <input type="hidden" name="_method" value="put" />
        @endisset
        <div class="row row-head d-flex">
          <h3 class="title">New Questionnaire</h3>
          <div class="ml-auto right">
            <p class=" ml-auto">Make Public</p>
            <div class="pretty p-switch p-fill">
                <input type="checkbox" name="is_public" {{isset($edit) && $edit->is_public == 1 ? 'checked' : ''}}/>
                <div class="state p-success">
                    <label> </label>
                </div>
            </div>
            {!! Form::submit('Save', ['class' => 'btn btn-primary ml-auto']) !!}
          </div>
          {{-- <button  class="btn btn-primary ml-auto"><a href="{{ route('questionnaire/') }}">Save</a></button> --}}
        </div>

        {!! Form::textarea('title',  isset($edit) ? $edit->title : null, [
          'class' => 'large-8 columns title',
          'id' => 'questionnaire-title',
          'placeholder' => 'Questionnaire Title',
          'autocomplete' => 'off',
          'maxlength' => '100',
          'data-autoresize' => '',
          'rows' => '1',
          ]) !!}

        {!! Form::textarea('description', isset($edit) ? $edit->description : null, [
          'class' => 'large-8 columns desc',
          'placeholder' => 'Enter Description Here',
          'maxlength' => '150',
          'data-autoresize' => '',
          'rows' => '1',
          ]) !!}

        <div id="question-section">
          @isset($edit)
            <?php
              for($i = 0; $i < count($edit->questions); $i++){
                $question = $edit->questions[$i];

                echo '
                <div class="question">
                  <div class="row">

                    <textarea type="text" data-autoresize rows="1"  class="title" name="questions[' . $i . '][title]" autocomplete="off" placeholder="Untitled Open Question">' . $question->title . '</textarea>

                    <div class="question-select ml-auto">
                      <select class="q-select">';

                      if($question->type == "open"){
                        echo '
                        <option value="open" selected>Open</option>
                        <option value="closed" >Closed</option>
                        ';
                      } else {
                        echo '
                        <option value="open">Open</option>
                        <option value="closed" selected>Closed</option>
                        ';
                      }

                      echo '
                      </select>
                      <i class="fas fa-chevron-down"></i>
                    </div>

                  </div>

                  <input type="hidden" class="q-type" name="questions[' . $i . '][type]" value="open"/>
                  <div class="question-inputs">';

                  if($question->type == "open"){
                    echo '<input class="open-input noselect" type="text" placeholder="Enter Answer Here..."/>';
                  } else {
                    for($j = 0; $j < count($question->options); $j++){
                    $option = $question->options[$j];
                     echo '
                     <div class="closed-option">
                       <div class="pretty p-curve p-pulse p-icon">
                         <input type="checkbox" />
                         <div class="state p-success">
                             <i class="icon fas fa-check"></i>
                             <label></label>
                         </div>
                       </div>
                       <input value="'.$option->option.'" class="closed-value title"  autocomplete="off" name="questions['.$i.'][options]['.$j.']" placeholder="Option">
                       <i class="fas fa-minus remove-option"></i>
                     </div>
                     ';
                    }
                  }



                  echo '</div>
                  <button class="remove-question" type="button"><i class="fas fa-trash"></i> Remove Question</button>
                </div>';
              }
            ?>
          @endisset
        </div>

        <button id="add-q" type="button"><i class="fas fa-plus"></i> Add Question</button>


    {!! Form::close() !!}
  </div>
@endsection
