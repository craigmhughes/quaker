@extends('layouts.app')

@section('content')
  <section id="landing-page">
    @isset($resp)
      <h1>Thank you for your time.</h1>
    @endisset
    <div id="intro-message">
      <h1>Welcome Message.</h1>
      <br/>
      <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.</p>
    </div>
  </section>
@endsection
