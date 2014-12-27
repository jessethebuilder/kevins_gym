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
    var day_cols = $('div.day_row');
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

    //hide elements for day calendar
    $('div.calendar_day_event').hide();
    $('.calendar_day_time_slot').hide();
}

function collapseDayOnWeek(selector, direction){
    if(direction == 'open'){
        $(selector).find('.calendar_week_time_slot').show();
//        $(selector).find('.week_collapse_open').hide();
//        $(selector).find('.week_collapse_close').show();
        $(selector).find('ul.calendar_week_events li').hide();
        $(selector).find('div.calendar_week_events').show();
    } else {
        $(selector).find('.calendar_week_time_slot').hide();
//        $(selector).find('.week_collapse_open').show();
//        $(selector).find('.week_collapse_close').hide();
        $(selector).find('ul.calendar_week_events li').show();
        $(selector).find('div.calendar_day_event').hide();
    }
}

function calendarDaySetup(){
  $('.day_row').hover(function(){
    placeEventsOnCalendarDay(this);
  }, function(){

  })

  placeEventsOnCalendarDay('.today');
}

function placeEventsOnCalendarDay(selector){
  $(selector).find('div.calendar_day_event').each(function(j, event){
    var start = $(event).attr('data-starts');
    $(selector).find('div.calendar_day_time_slot').each(function(j, slot){
      //find the slot that matches the starts_at time
        if($(slot).attr('data-time_slot') == start){
        $(slot).append(event).addClass('has_event');
      }
    })
  })

  //color calendar day to match current day
  if($(selector).hasClass('today') == true){
    $('#calendar_day').addClass('today');
  } else {
    $('#calendar_day').removeClass('today');
  }

  //copy the html into calendar day
  var content = $(selector).find('.week_calendar_content').html();
  $('#calendar_day').html(content);

  //show calendar day events
  $('#calendar_day').find('.calendar_day_time_slot').show();
  $('#calendar_day').find('.calendar_day_event').show();

  //hide calendar week events
  $('#calendar_day').find('ul.calendar_week_events').hide();

}

function toggleClass(selector, klass, persist){
  $(selector).hover(function(){
    $(this).addClass(klass);
  }, function(){
    $(this).removeClass(klass);
  })
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


      //place events on week calendar in the proper time slot
        calendarDaySetup();

//        toggleClass('.day_row', 'selected_options')
      $('.day_row').hover(function(){
        $('.day_row').removeClass('selected_option');
        $(this).addClass('selected_option');
      }, function(){
//        $(this).removeClass('selected_option');
      })


    }) // end document ready
}


