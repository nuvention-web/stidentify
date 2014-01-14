function initializeLanding() {
  $(".landing-learn-more").on("click", function(e) {
      e.preventDefault();
      $("#myModal").modal('show');
  })

  $(".landing-read-more").on("click", function(e) {
    e.preventDefault();
    $(".modal-body").prepend("<p>Sign up below to read the full article</p>");
    $("#myModal").modal('show');
  });

  $("form").on("submit", function(e) {
    e.preventDefault();
    var email = $('#initial_user_email').val()
    
    if (validEmail(email)) {
      $.ajax({
        url: "<%= initial_users_path %>",
        type: "POST",
        dataType: 'json',
        data: "initial_user[" + $(this).serialize(),
        context: this,
        success: clearModal()
      });
    } else {
      $('.modal-body').prepend("<p>That's not a valid email address!</p>");
    }
  })

  $(".thumbnail").on("mouseenter", function(){
    $(this).css("background-color", "#5B6FC6");
    $(this).find("p").css("color", "white");
    $(this).find("h3").css("color", "white");
  })

  $(".thumbnail").on("mouseleave", function(){
    $(this).css("background-color", "white");
    $(this).find("p").css("color", "black");
    $(this).find("h3").css("color", "black");
  })
}

function validEmail(email) {
  var reg = /([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})/i
  return reg.test(email);
}

function clearModal(){
  $(".modal-body").text("Thanks for signing up! We'll let you know when Debatable ready to go.");
}
