$(document).ready(function() {
    $(".specific-input").hide();
    $(".specific-input").find("*").prop("disabled", true);
    
    $(".type-selector").change(function(){
        var type = $(this).val();
        var all = $(".specific-input");
        all.hide();
        all.find(".toggleable").prop("disabled", true);
        var choosen = $(".specific-input[data-type='"
                        + type + "']");
        choosen.show();
        choosen.find(".toggleable").prop("disabled", false);
    });
});
