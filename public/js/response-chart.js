
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
    setTimeout(()=>{generate_charts()}, 1000);
  }
}



var charts = [];

function create_new_chart(chart_el, chart_type, chart_labels, chart_data){
  let ctx = chart_el.getContext('2d');
  let my_chart = new Chart(ctx, {
      type: chart_type == "open" ? "bar" : "pie",
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
    console.log(total_types[i]);
    create_new_chart(document.getElementsByClassName("chart-element")[i],
    total_types[i], total_labels[i], total_freq[i]);
  }
}
