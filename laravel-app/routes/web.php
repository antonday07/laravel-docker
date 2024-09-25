<?php

use App\Models\User;
use Illuminate\Support\Facades\Route;

Route::get('/', function () {
    return view('welcome');
});

Route::get('/users', function () {  
    return response()->json([
        'data' => User::paginate(100),
    ]);
});
