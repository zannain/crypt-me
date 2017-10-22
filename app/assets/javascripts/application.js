// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require rails-ujs
//= require jquery3
//= require popper
//= require bootstrap-sprockets
//= require jquery-ui/widgets/datepicker
//= require jquery-ui/widgets/slider
//= require jquery-ui/core
//= require jquery-ui/widgets/mouse
//= require datatables
//= require jquery_ujs
//= require turbolinks
//= require_tree .
//

var delta = document.getElementsByClassName("crypto-delta");  // ALL DELTA COLUMNS
var search = document.getElementById("search");               // ENTIRE SEARCH TABLE
const coinmarket = "https://api.coinmarketcap.com/v1/ticker/";  // COINMARKETCAP BASE URL

changePercentageColumnClass = (percentColumn) => { // Function that changes column color of Delta columns
  for(var i = 0; i < percentColumn.length; i++) {
        if (percentColumn[i].innerHTML > 0) {
        percentColumn[i].classList.toggle("table-success");
        }
        else if (percentColumn[i].innerHTML < 0) {
          percentColumn[i].classList.toggle("table-danger");
        }
    }
  }
calculateRange = (sliderVal, currentValue) => ((1 + sliderVal/100) * currentValue).toFixed(2);
setSliderValues = () => { // Function to set Slider Values in Alert Min/Max Input Fields
  $( ".alert-slider" ).slider({
      range: true,
      min: 0,
      max: 100,
      step: 5,
      values: [ 25, 75 ],
      slide: function( event, ui ) {
        $( ".alert-min" ).val(calculateRange(ui.values[0], $(".alert-value").val()));
        $( ".alert-max" ).val(calculateRange(ui.values[1], $(".alert-value").val()));
        $( ".alert-max--badge" ).html(ui.values[1]);
        $( ".alert-min--badge" ).html(ui.values[0]);
      }
    });}
callCoinMarketCap = (value, id) => {
  var urlToRequest = coinmarket + id + "/";
  fetch(urlToRequest).then(response => {
    if (response.ok) {
      console.log(response.json());
    }
    throw new Error('Request failed');  // handle errors 
  }, networkError => console.log(networkError.message))
  .then(jsonResponse => {  //handle successes 
    return jsonResponse[0];
  });
}
// When TurboLinks Loads
$(document).on('turbolinks:load', function() {
  $('#login_email').focus();  // Set focus on Login form to the email field
  $('.modal-footer .btn-primary').click(function() { 
  $('.modal-body form').submit();   // Submit form with Bootstrap-provided submit button on click
  })
  $('.carousel').carousel({ 
    interval: 2000 // set the Header Carousel Interval
  });
  changePercentageColumnClass(delta); 
  $("#search").dataTable(); // Convert CoinMarketCap Response to DataTable
  $('[data-toggle="tooltip"]').tooltip();
})


// TODO Feature: User can set an alert for cryptocurrency deprecating in values
  // calculateDownRange
// TODO Function to convert CoinMarketCapi Response Delta Values to Percents
  // function convertPercentageColumnToPercents(percentColumn) {
  // for(var i=0; i< percentColumn.length; i++ ) {
  //   num = Number(percentColumn[i].innerHTML);
  //   num *= 100;
  //   percent = Math.floor(num) + "%";
  //   percentColumn[i].innerHTML = percent;
  // }}
  // convertPercentageColumnToPercents(delta);

// TODO $(".dropdown-toggle").dropdown();



