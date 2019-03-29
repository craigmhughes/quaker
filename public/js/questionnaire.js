
var q_sec = document.getElementById('question-section');
var question_selects, select_vals;
var question_count = 0;


// Select Question Type Menu
var select_div = `
  <div class="question-select ml-auto">
    <select class="q-select">
      <option value="open">Open</option>
      <option value="closed">Closed</option>
    </select>
    <i class="fas fa-chevron-down"></i>
  </div>`;

// Question HTML
var question_div = `
  <div class="question">
    <div class="row">
      <input type="text" class="title" name="questions[${question_count}][title]" autocomplete="off" placeholder="Untitled Open Question"/>
      ${select_div}
    </div>
    <input type="hidden" class="q-type" name="questions[${question_count}][type]" value="open"/>
    <div class="question-inputs"></div>
  </div>`;

/**
  *   Read Question Select Values
  */
function get_selects(callback){
  // Get Question Select Elements
  question_selects = document.getElementsByClassName('q-select');
  select_vals = [];

  // Get Question Select Values
  for (let i = 0; i < question_selects.length; i++) {
    select_vals[i] = question_selects[i].value;
  }

  console.log(select_vals);

  build_inputs();
  if (typeof callback !== 'undefined'){
      callback();
  }
}

/**
  * Create inputs based on type. Open = text input. Closed = checkboxes.
  */
function build_inputs() {
  let inputs = document.getElementsByClassName('question-inputs');
  let input_count = 0;

  let open_element = `<input class="open-input noselect" type="text" placeholder="Enter Answer Here..."/>`;

  let closed_element = `
    <div class="closed-option">
      <input type="checkbox" class="checkbox">
      <input class="closed-value title" autocomplete="off" name="questions[${question_count}][options][${input_count}]" placeholder="Option">
    </div>
  `;

  for (let i = 0; i < inputs.length; i++) {
    option_count(inputs[i]);
    inputs[i].innerHTML = select_vals[i] === "open" ? open_element : closed_element;
  }
}

/**
  * Get total num of questions and assign to question_count.
  */
function update_question_count(){
  question_count = document.getElementsByClassName('question').length - 1;
  console.log(question_count);
}

function option_count(el){
  return el.getElementsByClassName('closed-option').length;
}

/**
  * Adds question to quesiton section.
  */
function create_question(){

  q_sec.innerHTML += question_div;

  get_selects();
  update_question_count();
}

function create_option(el){

  let q_inputs = el.getElementsByClassName('question-inputs')[0];
  let input_count = option_count(q_inputs);

  let closed_element = `
    <div class="closed-option">
      <input type="checkbox" class="checkbox">
      <input class="closed-value title" autocomplete="off" name="questions[${question_count}][options][${input_count}]" placeholder="Option">
    </div>
  `;

  let titles = q_inputs.getElementsByClassName('title');
  let current_input_vals = [];
  let found_null = false;

  // Remember values
  for(let i = 0; i < titles.length; i++){
    current_input_vals[i] = titles[i].value;

    // Change to true if null value found. Acts as block.
    found_null = titles[i].value.length > 0 && titles[i].value !== ' ' ? found_null : true;
  }

  if(!found_null){
    q_inputs.innerHTML = q_inputs.innerHTML + closed_element;
  }

  // Re-assign remembered values.
  for(let i = 0; i < titles.length-1; i++){
     titles[i].value = current_input_vals[i];
  }

}


/**
  *   Add Click Listener on Type inputs.
  */
document.getElementById('question-section').addEventListener('click', function(e){
  // Event to execute on question type dropdown.
  if (e.target.tagName === "SELECT"){

    for(let i = 0; i < question_selects.length; i++){

      // Detect change and re-read selects.
      if(e.target === question_selects[i] && e.target.value !== select_vals[i]){

        let parent = e.target.parentNode.parentNode.parentNode;
        let question_type = select_vals[i] === "open" ? "closed" : "open";

        // Change Title
        parent.querySelector('input.title').placeholder = `Untitled ${question_type} Question`;
        // Change Question Type
        parent.querySelector('input.q-type').value = question_type;

        get_selects();

        // Add or remove 'add option' based on question type
        if(question_type === "closed" && parent.getElementsByClassName('add-option').length === 0){
          parent.innerHTML += `<button class="add-option" type="button"><i class="fas fa-plus"></i> Add Option</button>`;

        } else if (question_type === "open" && parent.getElementsByClassName('add-option').length > 0){
          parent.removeChild(parent.getElementsByClassName('add-option')[0]);
        }

        // Force value change
        parent.getElementsByClassName('q-select')[0].value = select_vals[i];

      }
    }
  } else if (e.target.className === "add-option") {
    create_option(e.target.parentNode);
  }


});


/**
  *   Prevent Clicking on question inputs.
  */
document.getElementById('question-section').addEventListener('mousedown', (e)=>{
  if (e.target.tagName === "INPUT" && e.target.className.includes("open-input")){
    e.preventDefault();
  }
});



// Run Here

create_question();
