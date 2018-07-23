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

//= require jquery
//= require jquery_ujs
//= require jquery.remotipart
//= require activestorage
//= require turbolinks
//= require twitter/bootstrap
//= require tinymce
//= require jquery-ui
//= require autocomplete-rails
//= require jquery.minicolors
//= require dropzone
//= require fancybox
//= require jquery_nested_form
//= require highcharts
//= require chartkick
//= require_tree .

$(function(){
	$('#Carousel').carousel();  

  $('#user_color').minicolors()

  $(document).on('click', '.toggle-window', function(e) {
    e.preventDefault();
    var panel = $(this).parent().parent();
    var messages_list = panel.find('.messages-list');

    panel.find('.panel-body').toggle();
    panel.attr('class', 'panel panel-default');

    if (panel.find('.panel-body').is(':visible')) {
      var height = messages_list[0].scrollHeight;
      messages_list.scrollTop(height);
    }
  });

  $('.carousel[data-type="multi"] .item').each(function(){
    var next = $(this).next();
    if (!next.length) {
      next = $(this).siblings(':first');
    }
    next.children(':first-child').clone().appendTo($(this));

    for (var i=0;i<4;i++) {
      next=next.next();
      if (!next.length) {
        next = $(this).siblings(':first');
      }
      
      next.children(':first-child').clone().appendTo($(this));
    }
  });
});

$(document).ready(function(){
  $(".fancybox").fancybox();

  Dropzone.autoDiscover = true;
  $("#new_gallery").dropzone({
    maxFilesize: 20,
    paramName: "gallery[image]",
    addRemoveLinks: true
  });
});
