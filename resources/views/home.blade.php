@extends('layouts.app')

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
          @foreach ($questionnaires as $key => $value)
            <tr>
              <th scope="row">{{$value->title}}</th>
              <td>{{date('jS F Y', strtotime($value->created_at))}}</td>
              <td><i class="fas fa-circle {{$value->is_public ? 'public' : 'private'}}"></i>{{$value->is_public ? 'Public' : 'Private'}}</td>
              <td>
                <?php $resp_val = 0; ?>
                @foreach (App\Question::all()->where('questionnaire_id', $value->id) as $key => $val)
                  <?php $resp_val += sizeof(App\Response::all()->where('question_id', $val->id)) ?>
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
