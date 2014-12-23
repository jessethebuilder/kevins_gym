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
function build_week_columns(){
    var days = $('#calendar_week_table td.day');
    var day_cols = $('div.day_col');
    var class_list

    days.each(function(i, day){
        //move html from table to divs
        $(day_cols[i]).html($(day).html());
        //add classes to new divs from td
        class_list = $(day).attr('class').split(' ');
        for(j = 0; j < class_list.length; j++ ){
            $(day_cols[i]).addClass(class_list[j]);
        }
    })

    //hide the original table
    $('#calendar_week_table').detach();
}

function collapseDaysOnWeek(){
    collapseDayOnWeek('body', 'close');
    //collapseDayOnWeek('.today', 'open');
}

function collapseDayOnWeek(selector, direction){
    if(direction == 'open'){
        $(selector).find('.calendar_week_time_slot').show();
        $(selector).find('.week_collapse_open').hide();
        $(selector).find('.week_collapse_close').show();
        $(selector).find('ul.week_collapse_close_events li').hide();
        $(selector).find('span.week_collapse_open_event').show();



    } else {
        $(selector).find('.calendar_week_time_slot').hide();
        $(selector).find('.week_collapse_open').show();
        $(selector).find('.week_collapse_close').hide();
        $(selector).find('ul.week_collapse_close_events li').show();
        $(selector).find('span.week_collapse_open_event').hide();
    }
}

function placeEventsOnCollapseOpen(){

}

function setUpWeekCalendar(){
    $(document).ready(function(){
        //function to move data from table to columns
        build_week_columns();

        //hack to ensure labels are the correct size on larger (than xs) screens.
        if ($(window).width > '768px') {
            grow_calendar_labels()
        }

        set_calendar_size();

        //change label sizes on xs media query
        onMediaQuery(768, shrink_calendar_labels, grow_calendar_labels);

        //set the default view for the calendar.
        collapseDaysOnWeek();

        //place events on week calendar in the proper time slot
        placeEventsOnCollapseOpen();
    })
}