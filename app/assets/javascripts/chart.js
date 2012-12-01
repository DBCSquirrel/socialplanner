$(document).ready( function() {
  $('.remove_sched').click( function() {
    alert("clicked?");
      $(this).preventDefault();
      $(this).parent().remove();
  });
});