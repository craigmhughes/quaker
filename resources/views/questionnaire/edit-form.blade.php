@extends('layouts.app')

@section('title')
  <?php echo isset($edit) ? 'Edit Questionnaire' : 'Create Questionnaire' ?>
@endsection

@section('include-scripts')
  <script src="{{ asset('js/questionnaire.js') }}" defer></script>
  <script src="{{ asset('js/delete-questionnaire.js') }}" defer></script>
@endsection

@if($errors->any())
  @section('err')
    <div class="error-nav">
      <div class="container">
        <p>{{$errors->first()}}</p>
      </div>
    </div>
  @endsection
@endif

@section('app-class')
edit-form
@endsection

@section('content')
  {{-- Confirmation overlay --}}
  @isset($edit)
    <div id="overlay" class="hidden">
      <div id="delete-modal">
        <p>Are you sure you want to delete this questionnaire?</p>
        <button type="button" class="primary btn">Yes</button>
        <button type="button" class="btn secondary">No</button>
      </div>
    </div>
  @endisset

  <div id="save-bar">
    <div class="left">
      <a href="/home"><i class="fas fa-chevron-left"></i> Back</a>
    </div>
    <div class="right">
      @isset($edit)
        <button id="delete-questionnaire" class="btn secondary" type="button"><i class="fas fa-trash"></i></button>
      @endisset
      {!! Form::button('<i class="fas fa-save"></i> Save', ['type' => 'submit', 'form' => 'questionnaire-form', 'class' => 'btn btn primary ml-auto']) !!}
    <div>
  </div>
</div></div>

  {{-- Questionnaire form --}}
  <div id="questionnaire-container">
    <p id="answer-link">Save changes & share this link: <span></span> <span class="copy">Copied</span></p>

    {!! Form::open(array('action' => isset($edit) ?
      ["QuestionnaireController@update", $edit->id] : "QuestionnaireController@store", 'id' => 'questionnaire-form')) !!}
        {{ csrf_field() }}
        @isset($edit)
          <input type="hidden" id="form-method" name="_method" value="put" />
        @endisset
        <div class="row row-head d-flex">
          <h3 class="title">{{isset($edit) ? 'Edit' : 'New'}} Questionnaire</h3>

          {!! Form::textarea('title',  isset($edit) ? $edit->title : null, [
          'class' => 'large-8 columns title',
          'id' => 'questionnaire-title',
          'placeholder' => 'Questionnaire Title',
          'autocomplete' => 'off',
          'maxlength' => '100',
          'data-autoresize' => '',
          'rows' => '1',
          'required' => '',
          ]) !!}

          {!! Form::textarea('description', isset($edit) ? $edit->description : null, [
          'class' => 'large-8 columns desc',
          'placeholder' => 'Enter Description Here',
          'maxlength' => '150',
          'data-autoresize' => '',
          'rows' => '1',
          ]) !!}

          <div class="public-bar">
            <p>Make Public</p>
            <div class="pretty p-switch p-fill">
                <input type="checkbox" name="is_public" id="is-public-switch" {{isset($edit) && $edit->is_public == 1 ? 'checked' : ''}}/>
                <div class="state p-success">
                    <label> </label>
                </div>
            </div>
          </div>
          {{-- <button  class="btn btn-primary ml-auto"><a href="{{ route('questionnaire/') }}">Save</a></button> --}}
        </div>
        @isset($edit)
          <input type="hidden" name="id" value="{{$edit->id}}"/>
        @endisset

        <div id="question-section">
          @isset($edit)
            <?php
              for($i = 0; $i < count($edit->questions); $i++){
                $question = $edit->questions[$i];

                echo '
                <div class="question" value="'. $i .'">
                  <div class="row">

                    <textarea required type="text" data-autoresize rows="1"  class="title" name="questions[' . $i . '][title]" autocomplete="off" placeholder="Untitled Open Question">' . $question->title . '</textarea>

                    <div class="question-select ml-auto">
                      Question Type: 
                      <select class="q-select btn secondary">';

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
                    </div>

                  </div>

                  <input type="hidden" class="q-type" name="questions[' . $i . '][type]" value="'. $question->type .'"/>
                  <input type="hidden" class="q-id" name="questions[' . $i . '][id]" value="'. $question->id .'"/>
                  <div class="question-inputs">';

                  if($question->type == "open"){
                    echo '<input class="open-input noselect" type="text" placeholder="Enter Answer Here..."/></div>';
                  } else {
                    for($j = 0; $j < count($question->options); $j++){
                    $option = $question->options[$j];
                     echo '
                     <div class="closed-option">
                      <div class="pretty p-curve p-pulse p-icon">
                        <input type="checkbox"/>
                         <div class="state p-success">
                             <i class="icon fas fa-check"></i>
                             <label></label>
                         </div>
                       </div>
                       <input required value="'.$option->option.'" class="closed-value title"  autocomplete="off" name="questions['.$i.'][options]['.$j.'][title]" placeholder="Option">
                       <input type="hidden" value="'.$option->id.'" class="closed-value option-id" name="questions['.$i.'][options]['.$j.'][id]" >
                       <i class="fas fa-minus remove-option"></i>
                     </div>
                     ';
                    }

                    echo '</div>
                    <button class="add-option btn primary" type="button"><i class="fas fa-plus"></i> Add Option</button>';
                  }

                  echo '
                  <button class="remove-question btn secondary" type="button"><i class="fas fa-trash"></i> Remove Question</button>
                </div>';
              }
            ?>
          @endisset
        </div>

        <button id="add-q" class="btn primary" type="button"><i class="fas fa-plus"></i> Add Question</button>


    {!! Form::close() !!}
  </div>
@endsection
