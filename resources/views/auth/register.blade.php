@extends('layouts.app')

{{-- Extra Styles --}}
@section('include-styles')
  <link href="{{ asset('css/home.css') }}" rel="stylesheet">
@endsection

@section('content')
<section id="landing-page" class="auth-page register">
    <section class="header">
        <h1>Quaker</h1>
    </section>
    <form method="POST" action="{{ route('register') }}">
        @csrf
        <div>
            <input id="name" type="text" placeholder="Full Name" class="form-control{{ $errors->has('name') ? ' is-invalid' : '' }}" name="name" value="{{ old('name') }}" required autofocus>

            @if ($errors->has('name'))
                <span class="invalid-feedback" role="alert">
                    <strong>{{ $errors->first('name') }}</strong>
                </span>
            @endif

            <input id="email" type="email" placeholder="E-mail Address" class="form-control{{ $errors->has('email') ? ' is-invalid' : '' }}" name="email" value="{{ old('email') }}" required>

            @if ($errors->has('email'))
                <span class="invalid-feedback" role="alert">
                    <strong>{{ $errors->first('email') }}</strong>
                </span>
            @endif

            <input id="password" type="password" placeholder="Password" class="form-control{{ $errors->has('password') ? ' is-invalid' : '' }}" name="password" required>

            @if ($errors->has('password'))
                <span class="invalid-feedback" role="alert">
                    <strong>{{ $errors->first('password') }}</strong>
                </span>
            @endif

            <input id="password-confirm" placeholder="Password Confirm" type="password" class="form-control" name="password_confirmation" required>
        </div>
        <div class="form-footer">
            <button type="submit" class="btn">
                {{ __('Register') }}
            </button>
        </div>
    </form>
</section>
@endsection