<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class Option extends Model
{
  /**
   * The attributes that are mass assignable.
   *
   * @var array
   */
  protected $fillable = [
      'question_id', 'option', 'order_no', 'created_at', 
  ];

  public function question()
  {
      return $this->belongsTo('App\Question','question_id');
  }
}
