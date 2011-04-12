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
                    $.blockUI({ message: html, title : '' });
                }
            });
            return false;
        });
    },
    
});


//
// Common Site Tools
//
jQuery.extend(jQuery, {
    blank   : function(string) { return !$.present(string); },
    present : function(string) { return $.trim(string).length>0; },

    // HTML Encode -- trying to keep it similar to rail's h()
    h : function(string) {
        return $(document.createElement('span')).text(string).html();
    },

    preserve_newlines : function(string) {
        return $.h(string).replace(/\n/gi, '<br />');
    },

    // Take what we think is a function, check to make sure it is and call it
    // if we can returning the functions return value or false otherwise
    call_fn : function(fn, args) {
        if ( jQuery.isFunction(fn) ) return fn(args);
    }

});


jQuery.fn.get_permalink_version = function(opts){
    $(this).click(function(){
        opts = $.extend({}, {source : '', target : ''}, opts || {});

        // Hmmm, this is a developer problem, not a user issue
        if ( $.blank(opts.target) ) return true;

        if ( $.present(opts.source.val()) ) {
            var url = $(this).attr('href');
            $.get(url, 'string='+ opts.source.val(), function(resp) {
                opts.target.val(resp);
            });
        } else {
            $.Growl.show({
                message : "If you want to autogenerate a permalink, please enter something in the "
                          + opts.source.siblings('label').val() +" field.",
                icon    : 'error',
                timeout : 2500
            });
        }
        return false; 
    });
};

var Imageshow = function(container, args) { return this.init(container,args); }
jQuery.extend(Imageshow.prototype, {
    imageshow_defaults : {
        delay : 5000, // how long before they switch images?
        speed : 1000, // the speed at which it will transition/fade
        wait  : 0     // how long should we wait to queue up the first item?
    },

    init : function(container, args) {
        this.container = $(container);
        this.settings = $.extend({}, this.imageshow_defaults, args);
        var self = this;
        setTimeout(function(){self.queue_next_change();}, this.settings.wait);
        return this;
    },

    queue_next_change : function() {
        var self = this;
        setTimeout(function(){
            self.viewable_slide().fadeOut(self.settings.speed, function() {
                self.container.prepend($(this).remove().css('display',''));
                self.queue_next_change();
            });
        }, self.settings.delay);
    },

    viewable_slide : function(){
        return this.container.children(':last');
    }
});
