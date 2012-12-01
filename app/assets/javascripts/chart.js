$(document).ready( function() {
  $('#chart').delegate( ".remove_sched", "click", function(e) {
    //confirm("clicked?");
      e.preventDefault();
      $(this).parent().slideUp('fast', function(){$(this).remove()});
  });
});