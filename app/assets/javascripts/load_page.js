function setPagination() {
    // Hace que los objetos de clase .search-page-link manden una
    // solicitud ajax cuando se hace click en lugar de cargar todo
    $(".search-page-link").click(function(e) {
        $.ajax({
            url: e.target,
            dataType: "script"
        });
        e.preventDefault();
    });
}

$(setPagination);

$.ajaxSetup({
    complete: function(){
        setPagination();
    }
});
