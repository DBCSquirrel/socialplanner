$(document).ready( function() {
  $('#chart').delegate( ".remove_sched", "click", function(e) {
      e.preventDefault();
      $(this).parent().fadeOut('fast', function(){$(this).remove()});
  });
});