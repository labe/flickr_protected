$(document).ready(function() {
  var array;
  var url = "/auto";
  $.post(url, function(result) {
      // var allDBUsernames = result;
      array = result;
    }, "json");
  
    // alert(result);
      // var usernames = ["goats", "pickles"]
    // });
    
  $( "#usernames" ).autocomplete({
    source: array
  });

});