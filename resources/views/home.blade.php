@extends('layouts.app')

@section('title')
  Dashboard
@endsection

@section('app-class')
  dashboard
@endsection

@if (session()->has('success'))
  @section('err')
    <div class="success-nav">
      <div class="container">
        <p>{{session()->get('success')}}</p>
      </div>
    </div>
  @endsection
@endif

@section('content')
  <div id="page-content" class="row">
    <h1 class="title">Welcome, {{auth()->user()->name}}.</h1>
    <button  class="btn btn-primary ml-auto fixed-button" onclick="location.href='/questionnaires/create/new'"><a href="{{ route('questionnaires.create') }}">Create New</a></button>

    <h2 class="subtitle">My Questionnaires</h2>
    @if (isset($questionnaires) && sizeof($questionnaires) > 0)
      @foreach ($questionnaires as $questionnaire)
        <div class="questionnaire-entry">
          <div class="left">
            <h3 scope="row" name="{{$questionnaire->title}}" onclick="location.href='{{"/questionnaires/edit/" . $questionnaire->id}}'">{{$questionnaire->title}}</h3>
            <p>{{date('jS F Y', strtotime($questionnaire->created_at))}}</p>
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
          <div class="right">
              <button type="button" onclick="location.href='{{"/responses/" . $questionnaire->id}}'" class="btn btn-primary">View Responses</button>
              <button type="button" onclick="location.href='{{"/questionnaires/edit/" . $questionnaire->id}}'" class="btn secondary">Edit</button>
          </div>
        </div>
      @endforeach
    @else
      <p>No Questionnaires to show</p>
    @endif
  </div>
@endsection
