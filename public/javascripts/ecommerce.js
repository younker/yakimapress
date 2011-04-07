jQuery.fn.simple_photo_swap = function(target_id){
    this.click(function(){
        $("#"+ target_id).attr({
            src : $(this).attr("href"),
            alt : $(this).attr("title")
        });
        return false;
    });
};

