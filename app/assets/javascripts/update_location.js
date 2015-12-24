function update_options(selected_id) {
    var selector = $(".location-selector");
    $.getJSON( "/locations", { id: selected_id },
               function (data) {
                   selector.html($("<option value=''>Seleccionar ubicación</option</option>"));
                   if(data.length==0)
                       selector.attr("disabled", true);
                   else
                       selector.attr("disabled", false);
                   
                   $.each(data, function(index, loc) {
                       selector.append($("<option value='" + loc.id +
                                         "'>" + loc.name + "</option>"));
                   });
               });
    selector.blur();
}

function remove_location(obj) {
    obj.nextAll().remove();
    id = obj.attr("data-location");
    update_options(id);
    $("#lost_object_location_id").val(id);
}

function update_location() {
    var selected = $(".location-selector option:selected");
    if (!selected.val())
        return;
    var list = $("#selected-locations");
    $("#lost_object_location_id").val(selected.val());
    var new_li = $("<li class='remove-location' data-location='" +
                   selected.val() + "'>" +
                   selected.text() +
                   "</li>");
    list.append(new_li);
    new_li.click(function(e) {
        remove_location($(e.target));
        e.preventDefault();
    });
    update_options(selected.val());
}

$(document).ready(function() {
    $(".location-selector").change(function(){
        update_location();
    });
});
