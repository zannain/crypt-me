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


function changePercentageColumnClass(percentColumn) {
	for(var i = 0; i < percentColumn.length; i++) {
        if (percentColumn[i].innerHTML > 0) {
        percentColumn[i].classList.toggle("table-success");
        }
        else if (percentColumn[i].innerHTML < 0) {
        	percentColumn[i].classList.toggle("table-danger");
        }
    }    
}

function convertPercentageColumnToPercents(percentColumn) {
	for(var i=0; i< percentColumn.length; i++ ) {
		num = Number(percentColumn[i].innerHTML);
		num *= 100;
		percent = Math.floor(num) + "%";
		percentColumn[i].innerHTML = percent;
	}
}

$(document).on('turbolinks:load', function() {
  // console.log('document is ready!', new Date());
  $('#login_email').focus();
   $('.modal-footer .btn-primary').click(function() {
    $('.modal-body form').submit();
  }); 
  $('.carousel').carousel({
  	interval: 2000
});
$(".dropdown-toggle").dropdown();
$("#search").dataTable();
$('[data-toggle="tooltip"]').tooltip();
// Change Percentage Columns Classes Based on Values
var delta = document.getElementsByClassName("crypto-delta");
changePercentageColumnClass(delta);
// convertPercentageColumnToPercents(delta);
});

