function initializeLanding() {
  $("button:contains('Learn More')").on("click", function(e) {
        e.preventDefault();
        $("#myModal").modal('show');
  })

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
}

function validEmail(email) {
  var reg = /([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})/i
  return reg.test(email);
}

function clearModal(){
  $(".modal-body").text("Thanks for signing up! We'll let you know when Debatable ready to go.");
}
