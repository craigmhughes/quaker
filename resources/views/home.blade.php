@extends('layouts.app')

@section('content')
  <div class="row justify-content-start">
    <div class="row-head">
      <h1 class="title">Questionnaires</h1>
      <button type="button" class="btn btn-primary ml-auto">Create Questionnaire</button>
    </div>

      @if (isset($questionnaires) && sizeof($questionnaires) > 0)
        <table class="table">
          <thead class="thead-dark">
            <tr>
              <th scope="col">Questionnaire</th>
              <th scope="col">Creation Date</th>
              <th scope="col">Status</th>
              <th scope="col">Responses</th>
            </tr>
          </thead>
          <tbody>
            @foreach ($questionnaires as $key => $value)
              <tr>
                <th scope="row">{{$value->title}}</th>
                <td>{{$value->created_at}}</td>
                <td>Otto</td>
                <td>@mdo</td>
              </tr>
            @endforeach
          </tbody>
        </table>
      @else
        <p>No Questionnaires to show</p>
      @endif
  </div>
@endsection
