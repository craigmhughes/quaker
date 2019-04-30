@extends('layouts.app')

@section('title')
  Dashboard
@endsection

@section('content')
  <div id="page-content" class="row justify-content-start">
    <div class="row-head">
      <h1 class="title">Questionnaires</h1>
      <button  class="btn btn-primary ml-auto"><a href="{{ route('questionnaires.create') }}">Create Questionnaire</a></button>
    </div>

    @if (isset($questionnaires) && sizeof($questionnaires) > 0)
      @foreach ($questionnaires as $questionnaire)
        <div class="questionnaire-entry">
          <div class="left">
            <h1 scope="row" name="{{$questionnaire->title}}" onclick="location.href='{{"/questionnaires/edit/" . $questionnaire->id}}'">{{$questionnaire->title}}</h1>
            <p>{{date('jS F Y', strtotime($questionnaire->created_at))}}</p>
            <button type="button" onclick="location.href='{{"/questionnaires/edit/" . $questionnaire->id}}'" class="btn btn-secondary">Edit</button>
            <button type="button" onclick="location.href='{{"/responses/" . $questionnaire->id}}'" class="btn btn-secondary btn-2">View Responses</button>
          </div>
          <div class="right">
            <div></div>
            <div>
              <p class="resp-val" onclick="location.href='{{"/responses/" . $questionnaire->id}}'">
                <?php $resp_val = 0; ?>
                @foreach ($questionnaire->questions as $question)
                  <?php
                    $resp_val += sizeof($question->responses);
                  ?>
                @endforeach
                {{ $resp_val }} Responses
              </p>
              <p class="is_public"><i class="fas fa-circle {{$questionnaire->is_public ? 'public' : 'private'}}"></i>{{$questionnaire->is_public ? 'Public' : 'Private'}}</p>
            </div>
            <div></div>
          </div>
        </div>
      @endforeach
    @else
      <p>No Questionnaires to show</p>
    @endif
  </div>
@endsection
