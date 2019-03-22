<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class Label extends Model
{
  /**
   * The attributes that are mass assignable.
   *
   * @var array
   */
  protected $fillable = [
      'questionnaire_id', 'label', 'order_no',
  ];
}
