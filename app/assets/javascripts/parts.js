/*----------------------------------------------------
* Features Bar
----------------------------------------------------*/

//Features Bar
function prepareFeaturesBar(){
  onMediaQuery('sm', function(){
    $('.feature_col.center_col').css('border-top', '1px solid white');
    $('.feature_col.center_col').css('border-bottom', '1px solid white');
  }, function(){
    $('.feature_col.center_col').css('border-top-width', '0px');
    $('.feature_col.center_col').css('border-bottom-width', '0px');
  })
}

