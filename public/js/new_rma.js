$(document).ready(new function() {
  $('form#new_rma').bind('ajax:success', function(evt, data, status, xhr) {
    if (data.isSuccessful)
      $('#succeed').modal('show');
    else
      $('#failed').modal('show');
  });

  $('select#rma_rmareason').on('change', function() {
    if ($('#rma_rmareason').val() == 'other')
      $('#rma_reason').show();
    else
      $('#rma_reason').hide();
  });
  
});
