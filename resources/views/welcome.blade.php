@extends('layouts.app')

@section('include-styles')
  <link href="{{ asset('css/home.css') }}" rel="stylesheet">
@endsection

@section('content')
  <section id="landing-page">
    @isset($resp)
      <h1>Thank you for your time.</h1>
    @endisset
    <div id="intro-message">
      <h1>Welcome to <b>QMaker</b></h1>
      <br/>
      <p>Create & Answer Questionnaires. Results rendered using ChartJS.</p>
    </div>
  </section>
@endsection
