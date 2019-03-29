
var q_sec = document.getElementById('question-section');
var question_selects, select_vals;

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
      <input type="text" class="title" name="questions[0][title]" autocomplete="off" placeholder="Untitled Open Question"/>
      ${select_div}
    </div>
    <input type="hidden" class="q-type" name="questions[0][type]" value="open"/>
    <div class="question-inputs"></div>
  </div>`;

/**
  *   Read Question Select Values
  */
function get_selects(){
  // Get Question Select Elements
  question_selects = document.getElementsByClassName('q-select');
  select_vals = [];

  // Get Question Select Values
  for (let i = 0; i < question_selects.length; i++) {
    select_vals[i] = question_selects[i].value;
  }

  console.log(select_vals);

  build_inputs();
}

function build_inputs() {
  let inputs = document.getElementsByClassName('question-inputs');

  let openElement = `<input class="open-input noselect" type="text" placeholder="Enter Answer Here..."/>`;

  for (let i = 0; i < inputs.length; i++) {
    inputs[i].innerHTML = select_vals[i] === "open" ? openElement : '';
  }

  console.log(inputs);
}

// Add questions
q_sec.innerHTML = question_div;
q_sec.innerHTML += question_div;
get_selects();


/**
  *   Add Click Listener on Type inputs.
  */
document.getElementById('question-section').addEventListener('click', function(e){
  if (e.target.tagName === "SELECT"){


    for(let i = 0; i < question_selects.length; i++){

      // Detect change and re-read selects.
      if(e.target === question_selects[i] && e.target.value !== select_vals[i]){

        let parent = e.target.parentNode.parentNode.parentNode;
        let question_type = select_vals[i] === "open" ? "closed" : "open";

        // console.log(parent);

        // Change Title
        parent.querySelector('input.title').placeholder = `Untitled ${question_type} Question`;
        // Change Question Type
        parent.querySelector('input.q-type').value = question_type;

        get_selects();
      }
    }
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
