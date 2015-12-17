window.onload = function() {    // Después de cargar
    // Hace que #search-form envie la solicitud via ajax si está
    // en la página de búsqueda
    var form = $("#search-form");
    if (form.attr("search-page") !== undefined){
        form.submit(function(e) {
            $.ajax({
                type: form.attr("method"),
                url: form.attr("action"),
                data: form.serialize(),
                dataType: "script"
            });
            
            e.preventDefault();     // Evita que envie la solicitud normalmente
        });
    }
    
    // Hace que #search envie la solucitud cuando hay entrada

    var inputTimer; // Timer para esperar antes de mandar la solicitud
    var inputTimerInterval = 200;     // Tiempo de espera (0.2s)
    
    $("#search").on("input", function(e) {
        clearTimeout(inputTimer);
        inputTimer = setTimeout(function(e) {$("#search-form").submit();},
                                inputTimerInterval);
    });
}
