$(document).ready(new function() {
  $('form#new_rma').bind('ajax:success', function(evt, data, status, xhr) {
    if (data.isSuccessful)
      $('#succeed').modal('show');
    else
      $('#failed').modal('show');
  });
});
