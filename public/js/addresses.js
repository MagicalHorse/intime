$(document).ready(new function(){$("#add_address").click(function(){});$("#add01 form").bind("ajax:success",function(b,c,a,d){if(c.isSuccessful){$("#add01 div.messages").html('<div class="alert alert-success"><a class="close" data-dismiss="alert" href="#">x</a>'+c.message+"</div>");document.location.reload()}else{$("#add01 div.messages").html('<div class="alert alert-error"><a class="close" data-dismiss="alert" href="#">x</a>'+c.message+"</div>")}});$("a.delete_address").bind("ajax:success",function(b,c,a,e){var d=$(b.currentTarget);if(c.isSuccessful){d.parents("div.modal").modal("hide");d.parents("form").remove();$("#messages").html('<div class="alert alert-success"><a class="close" data-dismiss="alert" href="#">x</a>'+c.message+"</div>");$("#left_addresses_size").html(parseInt($("#left_addresses_size").html())+1)}else{d.parents("div.modal").modal("hide");$("#messages").html('<div class="alert alert-error"><a class="close" data-dismiss="alert" href="#">x</a>'+c.message+"</div>")}});$("form.update_address").bind("ajax:success",function(b,d,a,e){var c=$(b.currentTarget).find("div.messages");if(d.isSuccessful){c.html('<div class="alert alert-success"><a class="close" data-dismiss="alert" href="#">x</a>'+d.message+"</div>");document.location.reload()}else{c.html('<div class="alert alert-error"><a class="close" data-dismiss="alert" href="#">x</a>'+d.message+"</div>")}})});