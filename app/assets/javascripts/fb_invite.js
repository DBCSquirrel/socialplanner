$(document).ready(function(){
  $("div#facebook_ids:checkbox").hide();
  $('div#facebook_ids img').click(function(){
      $(this).closest(':checkbox:checked');
      $(this).addClass('user-card img:hover');
   });
});


