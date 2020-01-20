@extends('layouts.app')

@section('content')
<div class="container auth-page register">
    <section class="header">
        <h1>Quaker</h1>
        <h2>Reset Password</h2>
    </section>

    @if (session('status'))
        <div class="alert alert-success" role="alert">
            {{ session('status') }}
        </div>
    @endif

    <form>
        @csrf
        <div>
            <input id="email" type="email" class="form-control{{ $errors->has('email') ? ' is-invalid' : '' }}" placeholder="E-mail Address" name="email" value="{{ old('email') }}" required>
        </div>
        @if ($errors->has('email'))
            <span class="invalid-feedback" role="alert">
                <strong>{{ $errors->first('email') }}</strong>
            </span>
        @endif

        <button type="submit" class="btn btn-primary">
            <!-- {{ __('Send Password Reset Link') }} -->
            Not functional
        </button>
    </form>
</div>
@endsection
