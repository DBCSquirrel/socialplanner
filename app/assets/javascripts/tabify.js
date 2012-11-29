// $(function() { // same as $(document).ready(...)
  // $('#roster tr:odd').addClass('zebra');

// $(function() { // same as $(document).ready(...)
//   // $('#roster tr:odd').addClass('zebra');

//   $('.tabs a').click(function(e) {  // listen for click on tab alt tags

//     $('.tabs li').removeClass('current'); // turn other tabs off
//     $(this).parent('li').addClass('current'); // highlight

//     // console.log(this.hash);
//     var page = this.hash.substr(1); // set hash sub-strings eq to variable
//     $.get('events/'+page+'.html',function(fetchHtml) { // pull page respective content dynamically
//       $('.main_grid').html(fetchHtml); // replace html with content pulled from desired page
//     });
//   });
//     if (location.hash) { $('a[href='+location.hash+']').click(); }
//     else { $('.tabs a:first').click(); }
// });

// // Bind
// $( ".tabs a" ).on( "click", function( e ) {} );
// $( ".tabs a" ).bind( "click", function( e ) {} );

// // Live
// $( document ).on( "click", ".todo-lists li a", function( e ) {} );
// $( ".tabs a" ).live( "click", function( e ) {} );

// // Delegate
// $( ".tabs a" ).on( "click", "li", function( e ) {} );
// $( ".tabs a" ).delegate( "li a", "click", function( e ) {} );