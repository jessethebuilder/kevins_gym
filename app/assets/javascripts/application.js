// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require bootstrap
//= require turbolinks
//= require_tree .
//ca

//calendar scripts ------------------------------------------------------------------------

//end calendar scripts ------------------------------------------------------------------------

//toolbox---------------------------------------------------------------------------------------

function onMediaQuery(screen_size, on_methods, off_methods) {
    enquire.register("screen and (max-width:" + screen_size + "px)", [{
        match: function () {
            if(typeof on_methods == "function"){on_methods = [on_methods]}
            on_methods.forEach(function(method){
                method();
            })
        },
        unmatch: function () {
            if(typeof off_methods == "function"){off_methods = [off_methods]}
            off_methods.forEach(function(method){
                method();
            })

        }
    }
    ])
};