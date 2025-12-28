<?php

namespace App\Http\Middleware\Lifers;

use Closure;
use Illuminate\Support\Facades\Auth;

class ProtectDF {
    public function handle($request, Closure $next) {
        if (Auth::check() && Auth::id() !== 1) {
            return response()->view('lifers.protect', [], 403);
        }
        return $next($request);
    }
}
