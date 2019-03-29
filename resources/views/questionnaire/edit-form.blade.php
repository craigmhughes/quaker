@extends('layouts.app')

@section('include-scripts')
  <script src="{{ asset('js/questionnaire.js') }}" defer></script>
@endsection

@section('content')
  <div id="questionnaire-container">

    {!! Form::open(array('action' => 'QuestionnaireController@store', 'id' => 'questionnaire-form')) !!}
            {{ csrf_field() }}
        <div class="row row-head d-flex">
          <h3 class="title">New Questionnaire</h3>
          {!! Form::submit('Save', ['class' => 'btn btn-primary ml-auto']) !!}
          {{-- <button  class="btn btn-primary ml-auto"><a href="{{ route('questionnaire/') }}">Save</a></button> --}}
        </div>

        {!! Form::text('title', null, [
          'class' => 'large-8 columns title',
          'placeholder' => 'Questionnaire Title',
          'autocomplete' => 'off',
          ]) !!}

        {!! Form::textarea('description', null, [
          'class' => 'large-8 columns desc',
          'placeholder' => 'Enter Description Here',
          'maxlength' => '100'
          ]) !!}

        <div id="question-section">

        </div>

        <button id="add-q" type="button"><i class="fas fa-plus"></i> Add Question</button>


    {!! Form::close() !!}
  </div>
@endsection
