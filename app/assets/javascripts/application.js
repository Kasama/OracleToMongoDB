// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery.min
//= require jquery_ujs
//= require_tree .
//= require bootstrap.min

$(document).ready(function(){
	var selector = '#' + $("#page-name").data('page') + '-menu';
	$(selector).addClass('active');

    // add copy capabilities to all objects having 'copy-text' class
    $('.copy-text').click(function () {
        var text = '#' + $(this).data('id');
        window.prompt('Pressione Ctrl+C para copiar, depois OK', $(text).text());
    });
});
