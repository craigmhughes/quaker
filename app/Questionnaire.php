<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class Questionnaire extends Model
{

  /**
   * The attributes that are mass assignable.
   *
   * @var array
   */
  protected $fillable = [
      'title', 'description', 'is_public', 'user_id',
  ];

  /**
     * Get the comments for the blog post.
     */
    public function questions()
    {
        return $this->hasMany('App\Question');
    }
}
