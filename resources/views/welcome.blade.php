@extends('layouts.app')

@section('include-styles')
  <link href="{{ asset('css/home.css') }}" rel="stylesheet">
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
  <section id="landing-page">
    <div id="intro-message">
      <h1>Welcome to <b>QMaker</b></h1>
      <br/>
      <p>Create & Answer Questionnaires. Results rendered using ChartJS.</p>
    </div>
  </section>
@endsection
