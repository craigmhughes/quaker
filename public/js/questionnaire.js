
var q_sec = document.getElementById('question-section');
var question_selects, select_vals;
var question_count = 0;

var get_question_count = ()=>{
  update_question_count();
  return question_count;
}


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
var get_question_div = ()=>{
  return `
  <div class="question">
    <div class="row">
      <textarea maxlength="80" data-autoresize rows="1" class="title" name="questions[${question_count}][title]" autocomplete="off" placeholder="Untitled Open Question"></textarea>
      ${select_div}
    </div>
    <input type="hidden" class="q-type" name="questions[${question_count}][type]" value="open"/>
    <div class="question-inputs"></div>
    <button class="remove-question" type="button"><i class="fas fa-trash"></i> Remove Question</button>

  </div>`};

  // <i class="fas fa-minus-circle remove-question"></i>

var get_closed_element = (input_count, el)=>{
  return `
  <div class="closed-option">
    <div class="pretty p-curve p-pulse p-icon">
      <input type="checkbox" />
      <div class="state p-success">
          <i class="icon fas fa-check"></i>
          <label></label>
      </div>
    </div>
    <input class="closed-value title" autocomplete="off" name="questions[${typeof el === 'undefined' ? get_question_count()-1 : el}][options][${input_count}][title]" placeholder="Option">
    <i class="fas fa-minus remove-option"></i>
  </div>
`};

/**
  *   Read Question Select Values.
  *
  *   @param edit_el = Element that needs to be edited. Needs to be passed to build_inputs.
  */
function get_selects(edit_el, click){
  // Get Question Select Elements
  question_selects = document.getElementsByClassName('q-select');
  select_vals = select_vals !== undefined ? question_selects.length < select_vals.length ? [] : select_vals : [] ;

  // Get Question Select Values
  if (typeof edit_el === 'undefined') {

    for(let i = 0; i < question_selects.length; i++){
      select_vals[i] = question_selects[i].value;
    }

  } else {
    select_vals[edit_el] = question_selects[edit_el].value;
  }

  if(click || window.location.href.indexOf('create') > 0){
    build_inputs(edit_el);
  }
}

/**
  * Create inputs based on type. Open = text input. Closed = multiple choice.
  */
function build_inputs(edit_el) {
  let inputs = document.getElementsByClassName('question-inputs');
  let input_count = 0;

  let open_element = `<input class="open-input noselect" type="text" placeholder="Enter Answer Here..."/>`;

  if (typeof edit_el === 'undefined') {
    option_count(inputs[inputs.length-1]);
    inputs[inputs.length-1].innerHTML = select_vals[inputs.length-1] === "open" ? open_element : get_closed_element(input_count);
  } else {
    option_count(inputs[edit_el]);
    inputs[edit_el].innerHTML = select_vals[edit_el] === "open" ? open_element : get_closed_element(input_count, edit_el);
  }
}

/**
  * Get total num of questions and assign to question_count.
  */
function update_question_count(){
  question_count = document.getElementsByClassName('question').length;

}

function option_count(el){
  return el.getElementsByClassName('closed-option').length;
}

/**
  * Adds question to quesiton section.
  */
function create_question(){

  q_sec.insertAdjacentHTML('beforeend', get_question_div());

  get_selects(undefined, true);
  update_question_count();
}


function remove_question(el){
  let el_question;
  let parent_index = 0;

  el_question = el.parentNode;

  let questions = document.getElementsByClassName('question');

  for(let i = 0; i < questions.length; i++){
    if(el_question === questions[i]){
      parent_index = i;
      break;
    }
  }

  if(questions.length > 1){
    el_question.parentNode.removeChild(el_question);

    questions = document.getElementsByClassName('question');

    update_question_count();

    for (let i = 0; i < questions.length; i++){
        // Re-reads index. Assigns new index to inputs.
        questions[i].getElementsByClassName('title')[0].setAttribute('name', `questions[${i}][title]`);
        questions[i].getElementsByClassName('q-type')[0].setAttribute('name', `questions[${i}][type]`);
        questions[i].getElementsByClassName('q-id')[0].setAttribute('name', `questions[${i}][id]`);

        let closed_ops = questions[i].getElementsByClassName('closed-value');

        if(closed_ops.length > 0){
          for(let j = 0; j < closed_ops.length; j++){
            closed_ops[j].setAttribute('name', closed_ops[j].getAttribute('name').replace(/questions\[\d+\]/g, `questions[${i}]`));

          }
        }
    }
  }
}

function create_option(el){

  let q_inputs = el.getElementsByClassName('question-inputs')[0];
  let input_count = option_count(q_inputs);
  let q_index = 0;

  // Get Quesiton index by comparing elements.
  let all_inputs = document.getElementsByClassName('question-inputs');
  for(let i = 0; i < all_inputs.length; i++){
    if(q_inputs === all_inputs[i]){
      q_index = i;
      break;
    }
  }



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
    q_inputs.innerHTML = q_inputs.innerHTML + get_closed_element(input_count, q_index);
  }

  // Re-assign remembered values.
  for(let i = 0; i < titles.length-1; i++){
     titles[i].value = current_input_vals[i];
  }

}

function remove_option(el){
  let el_option = el.parentNode;
  let parent_index = 0;

  let questions = document.getElementsByClassName('question');

  for(let i = 0; i < questions.length; i++){
    if(el_option.parentNode.parentNode === questions[i]){
      parent_index = i;
      break;
    }
  }


  let child_options = el_option.parentNode.getElementsByClassName('closed-option');

  if(child_options.length > 1){
    el_option.parentNode.removeChild(el_option);

    for (let i = 0; i < child_options.length; i++){
      child_options[i].getElementsByClassName('title')[0].setAttribute('name', `questions[${parent_index}][options][${i}][title]`);
      if (child_options[i].getElementsByClassName('option-id')[0] !== undefined){
        child_options[i].getElementsByClassName('option-id')[0].setAttribute('name', `questions[${parent_index}][options][${i}][id]`);
      }
    }
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
        parent.querySelector('textarea.title').placeholder = `Untitled ${question_type} Question`;
        // Change Question Type
        parent.querySelector('input.q-type').value = question_type;

        get_selects(i, true);

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

  } else if (e.target.className.includes("remove-option")) {
    remove_option(e.target);

  } else if (e.target.className.includes("remove-question")) {
    remove_question(e.target);
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


document.getElementById('add-q').addEventListener('click', ()=>{
  create_question();
});

let overlay = document.getElementById('overlay');

let switchOverlay = ()=>{
  overlay.className = overlay.className == "hidden" ? "" : "hidden";
  document.querySelector("nav.navbar").style.filter = overlay.className == "hidden" ? "" : "blur(4px)";
  document.getElementById('questionnaire-container').style.filter = overlay.className == "hidden" ? "" : "blur(4px)";
};

overlay.addEventListener('click', (e)=>{
  if(e.target.getAttribute('id') == "overlay"){
    switchOverlay();
    return;

  } else if(e.target.tagName == "BUTTON"){

    if(e.target.getAttribute('class') == "primary-btn"){
      document.getElementById('form-method').value = "delete";
      document.getElementById('questionnaire-form').submit();

    } else {
      switchOverlay();
      return;
      
    }

  }
});

document.getElementById('delete-questionnaire').addEventListener('click', ()=>{

  switchOverlay();


  // document.getElementsByTagName("body")[0].className = "blur";

});


// Prevent creating new question if in edit mode.
if(window.location.href.indexOf('create') > 0){
  create_question();

} else {

  get_selects();
  update_question_count();
}

jQuery.each(jQuery('textarea[data-autoresize]'), function() {
    var offset = this.offsetHeight - this.clientHeight + 1.5;

    var resizeTextarea = function(el) {
        jQuery(el).css('height', 'auto').css('height', (el.scrollHeight + offset) - 2);
    };

    resizeTextarea(this);

    $(window).on('resize', ()=>{ resizeTextarea(this); });

    jQuery(this).on('keyup input', function() { resizeTextarea(this); }).removeAttr('data-autoresize');
});
