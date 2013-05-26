$(document).ready(function() {
  $('#upload button[name="add_file"]').on('click', function(e) {
    e.preventDefault();
    var uploadTotal = $('#upload input[type="file"]').length;
    $('#upload input[type="file"]').last().after(newPhoto(uploadTotal));
  });

  $('#upload input[type="submit"]').on('click', function(e) {
    e.preventDefault();
    $(this).css("background-color", "green");
    $(this).attr("value", "BURNINATE THE QUARTER MILE");
    $(this).animate({
      width: '300px'
    },500);
    $(this).on('click', function() {
      $('#upload').submit();
    });
  });

  $(this).on('keyup', function(e) {
    if (e.which == 27) {
      $('.overlay').remove();
      $('#lightbox').remove();
    }
  });

  $('img').on('click', function() {
    $('body').prepend("<div class=\"overlay\"></div>"); 
    $('div').last().after("<div id=\"lightbox\"></div>");
    $('#lightbox').animate({width:'800px',left:'25%'},1000);
    var source = $(this).first().parent().first().attr('name');
    setTimeout(function() {
      $('#lightbox').prepend("<div id=\"lightbox-photo\"></div>");
      $('#lightbox-photo').prepend('<img src="'+source+'" />');
      },950);
  });

  $(document).on('mouseleave', '#lightbox', function() {
    $('.overlay').on('click', function() {
      $('.overlay').remove();
      $('#lightbox').remove();
    });
  });

  $(document).on('keyup', function(e) {
    if (($('#lightbox').html() != undefined) && (e.which == 37)) {
      
    }
  });

});

function newPhoto(x) {
  string = '<input type="file" name="photo[image'+(x+1)+']"><br />';
  return string;
}