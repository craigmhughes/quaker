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
      <table class="table">
        <thead class="thead-light">
          <tr>
            <th scope="col">Title</th>
            <th scope="col">Creation Date</th>
            <th scope="col">Status</th>
            <th scope="col">Responses</th>
          </tr>
        </thead>
        <tbody>
          @foreach ($questionnaires as $questionnaire)
            <tr>
              <th scope="row" name="{{$questionnaire->title}}" onclick="location.href='{{"/questionnaires/edit/" . $questionnaire->id}}'">{{$questionnaire->title}}</th>
              <td>{{date('jS F Y', strtotime($questionnaire->created_at))}}</td>
              <td><i class="fas fa-circle {{$questionnaire->is_public ? 'public' : 'private'}}"></i>{{$questionnaire->is_public ? 'Public' : 'Private'}}</td>
              <td onclick="location.href='{{"/responses/" . $questionnaire->id}}'">
                <?php $resp_val = 0; ?>
                @foreach ($questionnaire->questions as $question)
                  <?php
                    $resp_val += sizeof($question->responses);
                  ?>
                @endforeach
                {{ $resp_val }}
              </td>
            </tr>
          @endforeach
        </tbody>
      </table>

    @else
      <p>No Questionnaires to show</p>
    @endif
  </div>
@endsection
