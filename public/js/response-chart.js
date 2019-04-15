
var question_ids = document.getElementsByClassName("question-id");

var total_labels = [];
var total_freq = [];
var total_types = [];

for (let i = 0; i < question_ids.length; i++) {
  let labels = [];
  let freq = [];

  $.get(`/responses/get/${question_ids[i].value}`, (data)=>{


    for (var j = 0; j < data.length; j++) {
      let found_label = false;
      let found_at = 0;

      if(total_types[i] == undefined){
        try {
          total_types.push(data[j]['type']);
        } catch (e) {}
      }

      for (var k = 0; k < labels.length; k++) {
        if(labels[k] == data[j]['response']){
          found_label = true;
          found_at = k;
        }
      }

      if(found_label){
        freq[found_at] += 1;
      } else {
        labels.push(data[j]['response']);
        freq.push(1);
      }
    }

  });

  total_labels.push(labels);
  total_freq.push(freq);

  if(i == question_ids.length-1){
    setTimeout(()=>{generate_charts()}, 200);
  }
}



var charts = [];

function create_new_chart(chart_el, chart_labels, chart_data){
  let ctx = chart_el.getContext('2d');
  let my_chart = new Chart(ctx, {
      type: "pie",
      data: {
          labels: chart_labels,
          datasets: [{
              data: chart_data,
              borderWidth: 1
          }]
      },
      options: {
          scales: {
              yAxes: [{
                  ticks: {
                      beginAtZero: true
                  }
              }]
          }
      }
  });

  // Adjust size - width is locked to height
  my_chart.canvas.parentNode.style.width = '328px';

  charts += my_chart;
}

function generate_charts(){
  for (var i = 0; i < total_labels.length; i++) {
    if(total_types[i] == "closed"){
      create_new_chart(document.getElementsByClassName("chart-element")[i],
      total_labels[i], total_freq[i]);
    } else {
      document.getElementsByClassName("chart-element")[i].style.height = 0;

      let response_div = document.getElementsByClassName("response")[i];
      response_div.innerHTML += '<div class="open-responses"></div>';

      let total_resp_div = response_div.getElementsByClassName("open-responses")[0];

      console.log(total_labels[i].length);

      for (var j = 0; j < total_labels[i].length; j++) {
        total_resp_div.innerHTML += `<p>${total_labels[i][j]}</p>`;
      }
    }
  }
}
