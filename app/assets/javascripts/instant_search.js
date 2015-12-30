function submit_with_ajax(form){
    form.submit(function(e) {
        $.ajax({
            type: form.attr("method"),
            url: form.attr("action"),
            data: $("#advanced-search-form, #search-form").serialize(),
            dataType: "script"
        });
        
        e.preventDefault();     // Evita que envie la solicitud normalmente
    });
}

$(document).ready(function() {    // Después de cargar
    // Hace que #search-form envie la solicitud via ajax si está
    // en la página de búsqueda
    var form = $("#search-form");
    if (form.attr("search-page") !== undefined){
        submit_with_ajax(form);
    }
    
    // Hace que #search envie la solucitud cuando hay entrada

    var inputTimer; // Timer para esperar antes de mandar la solicitud
    var inputTimerInterval = 200;     // Tiempo de espera (0.2s)
    
    $("#search").on("input", function(e) {
        clearTimeout(inputTimer);
        inputTimer = setTimeout(function(e) {$("#search-form").submit();},
                                inputTimerInterval);
    });

    $(window).on("popstate", function(e){
        var state = $(e.originalEvent.state)
        if(state != null && state.attr("page") !== undefined){
            window.location.replace(state.attr("page"));
        }
    });


    // Hace que #advanced-search-form envie solicitudes con ajax
    var adv_form = $("#advanced-search-form");
    submit_with_ajax(adv_form);
    // Hace que envie una solicitud en cada cambio
    adv_form.change(function(e){
        adv_form.submit();
    });

    $(".checkbox-using").change(function(){
        var checkbox = $(this);
        var target = $("#" + checkbox.attr("data-target"));
        target.prop("disabled", !checkbox.is(":checked"));
        if(checkbox.attr("data-target") == "actable_type"){
            var selected_type = $(".type-selector").val();
            var selected_inputs =
                $(".specific-input .toggleable [data-type='"
                  + selected_type + "']");
            selected_inputs.find("*").prop("disabled", !checkbox.is(":checked"));
        }
    });
});
