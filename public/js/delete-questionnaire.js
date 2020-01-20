let overlay = document.getElementById('overlay');

let switchOverlay = ()=>{
  overlay.className = overlay.className == "hidden" ? "" : "hidden";
  document.querySelector("nav.navbar").style.filter = overlay.className == "hidden" ? "" : "blur(4px)";
  document.getElementById('questionnaire-container').style.filter = overlay.className == "hidden" ? "" : "blur(4px)";
  document.getElementById('save-bar').style.filter = overlay.className == "hidden" ? "" : "blur(4px)";
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
