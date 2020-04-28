# This is a manifest file that'll be compiled into application.js, which will include all the files
# listed below.
#
# Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
# or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
#
# It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
# compiled file.
#
# Read Sprockets README (https:#github.com/rails/sprockets#sprockets-directives) for details
# about supported directives.
#
#= require jquery
#= require jquery_ujs
#= require moment 
#= require bootstrap-datetimepicker
#= require fullcalendar
#= require turbolinks
#= require materialize-sprockets
#= require dataTables/jquery.dataTables
#= require dataTables/extras/dataTables.responsive
#= require select2
#= require html2canvas/html2canvas
#= require jsPDF/jspdf
#= require jsPDF/split_text_to_size
#= require jsPDF/standard_fonts_metrics
#= require jsPDF/jspdf
#= require_tree .

link_to_clock_in = () ->
	newurl2 = window.location.origin + '/time_clocks/sign_in'
	$.get(
		url: newurl2,
		dataType: 'html',
		data: {
			time: $.now()
		},
		(response) ->
			modal = $("#modal-clock-in")
			modal.find(".modal-content").html(response)
			modal.openModal()
		)
	return false

link_to_clock_out = () ->
	newurl2 = window.location.origin + '/time_clocks/sign_out'
	$.post(
		url: newurl2,
		dataType: 'html',
		data: {
			time: $.now()
		},
		(response) ->
			window.location = response.split("\"")[1]
	)
		# )
	return false

# Initialize jQuery
$(document).on('turbolinks:load ready', () ->
	$('a#navclock_in').click( (e) -> 
		e.preventDefault()
		link_to_clock_in()
		)
	$('a#navclock_out').click( (e) -> 
		e.preventDefault()
		link_to_clock_out()
		)
	$('.datepicker').pickadate({
		selectMonths: true, 
		selectYears: 15 
		})
	# Scrollspy scrolling tracking
	$('.scrollspy').scrollSpy()
	# to make matrailize's select work
	$('select').material_select()
	# collapsable
	$('.collapsible').collapsible({
		accordion : false
	})
	# dismiss the popup
	$('.modal-trigger').leanModal({dismissible : true})
	# reintialize the button waves issue
	Waves.displayEffect()
	$('.button-collapse').sideNav({menuWidth: 200, closeOnClick: true})

	$('#calendar').fullCalendar #events: '/calendars.json')
		editable: false,
		slotEventOverlap: false,

		columnFormat: {
		  month: 'dddd', 
		  week: 'dddd d', 
		  day: 'ddd' 
		}
		buttonText: {
		  today:    'today',
		  month:    'month',
		  week:     'week',
		  day:      'day'
		}

		minTime: "08:00:00"
		maxTime: "23:00:00"
		header:
		  left: 'prev,next today', 
		  center: 'title', 
		  right: ''
		firstDay: 1


		selectable: true
		selectHelper: true
		select: (start, end) ->
			$.get
				url: '/calendars/new'
				(response) ->
					modal = $("#modal-event")
					modal.find(".modal-content").html(response)
					modal.find('#calendar_event_start').data("DateTimePicker").date(start)
					$('label[for="#calendar_event_start"]').addClass('active')
					modal.openModal()
		  # title = prompt("Event Title:")
		  # eventData = undefined
		  # if title
		  #   eventData =
		  #     title: title
		  #     start: start
		  #     end: end
		    # $("#calendar").fullCalendar "renderEvent", eventData, true # stick? = true
		  # $("#calendar").fullCalendar "unselect"


		defaultView: 'month',
		allDaySlot: false,
		height: 500, 
		slotMinutes: 30, 
		eventSources: [{ 
		  url: '/calendars.json', 
		}],
		eventClick: (event, jsEvent) ->
			jsEvent.preventDefault()
			$.get
				url: '/calendars/' + event.id
				(response) ->
					modal = $("#modal-event")
					modal.find(".modal-content").html(response)
					modal.openModal()
		timeFormat: 'h:mmt', 
		dragOpacity: "0.5" 
		eventDrop: (event, dayDelta, minuteDelta, allDay, revertFunc) -> 
		  updateEvent(event) 
		eventResize: (event, dayDelta, minuteDelta, revertFunc) -> 
		  updateEvent(event)


	)