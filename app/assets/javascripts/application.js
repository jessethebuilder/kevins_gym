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
//= require moment
//= require bootstrap-datetimepicker
//= require pickers
//= require_tree .

$(document).ready(function(){
  $('.datetimepicker').datetimepicker();
})


//toolbox---------------------------------------------------------------------------------------

function onMediaQuery(screen_size, on_methods, off_methods) {
  var size = parseScreenSize(screen_size);

  enquire.register("screen and (max-width:" + size + "px)", [{
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
}

function parseScreenSize(size){
  var val
  switch(size){
    case 'sm':
      val = 768;
      break;
    case 'md':
      val = 992;
      break;
    case 'lg':
      val = 1200;
      break;
    default:
      val = size;
  }
  return val;
}

//Toolbox ---------------------------------------------
function splitPath(path){
  var file = path.match(/(.+\/)(\w+)\.(.+)/);
  return {
    path_to_file: file[1],
    file_name: file[2],
    extension: file[3]
  };

}
function imageChangeOnLinkHover(selector){
  $(selector).hover(function(){
    var img = $(this).find('img');
    var split_path = splitPath(img.attr('src'));
    var new_path = split_path.path_to_file + split_path.file_name + "_hover." + split_path.extension;
    img.attr('src', new_path);
  }, function(){
    var split_path = splitPath($(this).find('img').attr('src'));
    var new_file_name = split_path.file_name.match(/(.+)_hover/)[1]
    var new_path = split_path.path_to_file + new_file_name + "." + split_path.extension;
    $(this).find('img').attr('src', new_path);
  })
}

function toggleClassOnHover(selector, klass, persist){
  $(selector).hover(function(){
    $(this).addClass(klass);
  }, function(){
    $(this).removeClass(klass);
  })
}

