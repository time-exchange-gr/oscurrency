show_openid = function() {
    $('#openid').show();
    $('#standard').hide();
    $('#openid_link').hide();
    $('#standard_link').show();
    $('#person_openid_identifier').val('http://');
}
show_standard = function() {
    $('#openid').hide();
    $('#standard').show();
    $('#openid_link').show();
    $('#standard_link').hide();
    $('#person_openid_identifier').val('');
}

$(function() {
  $('#openid').hide();
  $('#new_person').submit(function() {
      if( $('#person_accept_agreement:checked').val() != 1 ) {
        alert('Πρέπει να αποδεχθείτε την δήλωση μέλους για να συνεχίσετε.\n\nYou have to accept the member agreement to continue.');
        return false;
      }
  });

  if(($('#person_email').val() == "")) {
    $('#standard_link').hide();
    $('#noscript').show();
  }
});
