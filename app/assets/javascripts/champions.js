

$(document).ready(function(){
  $('.results').hide();
  console.log("is this shit working?")
  $('.champimage').on('click',function(){
    $('.bigoverlay').css("background-color", "rgba(0, 0, 0, 0.79)");
    $('.bigoverlay').css("opacity, .5");
    $('.results').show();
  })
  $('.results').on('click', function(){
    $('.results').hide();
    $('.bigoverlay').css("background-color", "");
    $('.bigoverlay').css("opacity", 1);
  });
});