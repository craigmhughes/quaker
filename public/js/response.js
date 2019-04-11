
let options = document.getElementsByClassName('input-option');

for (var i = 0; i < options.length; i++) {
  options[i].addEventListener('click', (e)=>{input_click(e)});
}

function input_click(e){
  let input = e.target;
  let input_container = e.target.closest(".question-inputs");
  let options = input_container.getElementsByClassName("input-option");


  /* Deselect all other options. Must use this as pretty-checkboxes is
    awkward with input structure and use of radio will not work.
  */
  for (var i = 0; i < options.length; i++) {
    if(options[i] !== input){
      options[i].checked = false;
    }
  }

  // Switch response val to recent clicked.
  input_container.getElementsByClassName("response-ans")[0].value = input.closest(".closed-option").getElementsByClassName("title")[0].innerText;
}
