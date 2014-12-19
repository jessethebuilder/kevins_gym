//---------Month Scripts------------------------------------------
function grow_calendar_labels(){
    $('.calendar-header').css('font-size', '30px');
    $('.calendar-header a').css('font-size', '40px');
    $('.calendar_view_selector').css('font-size', '20px');
}

function shrink_calendar_labels(){
    $('.calendar-header').css('font-size', '25px');
    $('.calendar-header a').css('font-size', '30px');
    $('.calendar_view_selector').css('font-size', '16px');
}
function set_calendar_size(){
    var cell_width = $('#calendar_month').width() / 7;
    $('td.day').width(cell_width + 'px');
}

//---------Week Scripts------------------------------------------
function build_week_column(){
    var days = $('#calendar_week_table td.day');
    var day_rows = $('div.day_row');
    var class_list

    days.each(function(i, day){
        //move html from table to divs
        $(day_rows[i]).find('.day_col').html($(day).html());
        //add classes to new divs from td
        class_list = $(day).attr('class').split(' ');
        for(j = 0; j < class_list.length; j++ ){
            $(day_rows[i]).addClass(class_list[j]);
        }
    })

    //hide the original table
    $('#calendar_week_table').hide();
}