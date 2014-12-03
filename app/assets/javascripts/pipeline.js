// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
$(document).ready(function() {

    $('.stage-select').bind("ajax:success", function () {
        var $rowElement = $(this).closest('tr');
        switch(this.innerHTML) {
            case "Won":
                $rowElement.attr("class", "success");
                break;
            case "Lost":
                $rowElement.attr("class","danger");
                break;
            default:
               $rowElement.removeAttr("class"); 
        }

    });

});