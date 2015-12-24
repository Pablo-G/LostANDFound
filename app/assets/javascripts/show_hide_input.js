$(document).ready(function() {
    $(".specific-input").hide();
    $(".type-selector").change(function(){
        var type = $(this).val();
        $(".specific-input").hide();
        $(".specific-input[data-type='" + type + "']").show();
    });
});
