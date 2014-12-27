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
//= require bootsy
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

//Toolbox ---------------------------------------------
function splitPath(path){
  var file = path.match(/(.+\/)(\w+)\.(.+)/);
  return {
    path_to_file: file[1],
    file_name: file[2],
    extension: file[3]
  };

}
function imageHover(selector){
  //selector is an img tag. This expects that any file that has this class will have a corresponding file
  //with the name [file_name]_hover.[file-extension] in the same folder.
  $(selector).hover(function(){
    var split_path = splitPath($(this).attr('src'));
    var new_path = split_path.path_to_file + split_path.file_name + "_hover." + split_path.extension;
    $(this).attr('src', new_path);
  }, function(){
    var split_path = splitPath($(this).attr('src'));
    var new_file_name = split_path.file_name.match(/(.+)_hover/)[1]
    var new_path = split_path.path_to_file + new_file_name + "." + split_path.extension;
    $(this).attr('src', new_path);
  })
}

