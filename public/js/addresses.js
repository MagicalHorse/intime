var areaMap;
$(document).ready(new function() {
  $.get('/front/addresses/supportshipments.json', function(result) {
    areaMap = result.datas;
  });
});
