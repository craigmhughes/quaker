@extends('layouts.app')

{{-- Extra Styles --}}
@section('include-styles')
  <link href="{{ asset('css/home.css') }}" rel="stylesheet">
@endsection

{{-- Success Message --}}
@if (session()->has('success'))
  @section('err')
    <div class="success-nav">
      <div class="container">
        <p>{{session()->get('success')}}</p>
      </div>
    </div>
  @endsection
@endif

{{-- Content --}}
@section('content')
  <section id="landing-page">
    <div class="intro-message">
      <div>
        <h1>Quaker</h1>
        <p>The Questionnaire Maker</p>
        <p class="highlight">Sample Project by Craig Hughes</p>
      </div>
    </div>
    <div class="footer-links">
      <a href='/login' class="btn secondary">Log in</a>
      <a href='/register'>Don't have an account?</a>
    </div>
  </section>
@endsection

@section('app-class')
  home
@endsection
