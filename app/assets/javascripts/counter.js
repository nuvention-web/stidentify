function startCounter(){
  setInterval(function(){updateCounter()}, 1577);
}

function updateCounter(){
  var currentCount = parseInt($('.counter-real').html());
  $('.counter-real').html(currentCount + 1);
}