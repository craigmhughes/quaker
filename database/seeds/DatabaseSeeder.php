<?php

 use Illuminate\Database\Seeder;
 use Illuminate\Database\Eloquent\Model;
 use App\User;
 use App\Questionnaire;
 use App\Question;
 use App\Response;
 use App\Option;

 class DatabaseSeeder extends Seeder
 {
     /**
      * Run the database seeds.
      *
      * @return void
      */
     public function run()
     {
         //disable foreign key check for this connection before running seeders
         DB::statement('SET FOREIGN_KEY_CHECKS=0;');
         Model::unguard();

         // truncate category before adding in data with ids that are set.
         // Category::truncate();
         // $this->call(CategoriesTableSeeder::class);

         // User::truncate();
         Questionnaire::truncate();
         Question::truncate();
         Response::truncate();
         Option::truncate();

         // factory(User::class, 50)->create();
         factory(Questionnaire::class, 5)->create();
         factory(Question::class, 10)->create();
         factory(Option::class, 10)->create();
         factory(Response::class, 20)->create();

         //re-enable foreign key check for this connection
         DB::statement('SET FOREIGN_KEY_CHECKS=1;');
         Model::reguard();





     }
 }
