$(document).ready(function() {
    $.init_uso_modal();

    // We use a stylesheet for our modals. See jquery.modal.css
    $.blockUI.defaults.css = {};
});

jQuery.extend(jQuery, {
    // http://malsup.com/jquery/block/#demos
    init_uso_modal : function(){
        $('.uso_modal').click(function(){
            $.ajax({
                url      : $(this).attr('href'),
                dataType : 'html',
                success  : function(html){
                    $.blockUI({ message: html, title : 'ffobar' });
                }
            });
            return false;
        });
    }
});

jQuery.fn.simple_photo_swap = function(target_id){
    this.click(function(){
        $("#"+ target_id).attr({
            src : $(this).attr("href"),
            alt : $(this).attr("title")
        });
        return false;
    });
};

