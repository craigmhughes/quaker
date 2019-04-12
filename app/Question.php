<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class Question extends Model
{
  /**
   * The attributes that are mass assignable.
   *
   * @var array
   */
  protected $fillable = [
      'title', 'questionnaire_id', 'type', 'options', 'labels',
  ];

  public function questionnaire()
  {
      return $this->belongsTo('App\Questionnaire','questionnaire_id');
  }

  public function options()
  {
      return $this->hasMany('App\Option');
  }

  public function responses()
  {
      return $this->hasMany('App\Response');
  }
}
