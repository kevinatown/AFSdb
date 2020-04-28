open_mod = (tag) ->
	$(tag).openModal()

close_mod = (tag) ->
	$(tag).closeModal()

comp_ease = () ->
	$(this).css('height', '')

@back_no_mod = (id) ->
	$(id).parent().addClass('active')
	$(id).siblings('.collapsible-body').stop(true,false).slideDown(duration: 350, easing: "easeOutQuart", queue: false, complete: comp_ease())

@back = (tag, id) ->
	close_mod(tag)
	document.querySelector('[id^=materialize-lean-overlay]').remove()
	@back_no_mod(id)

$(document).on('turbolinks:load ready', () ->
	return unless $(".profiles").length > 0

	$("input[name=is_job]").change( () ->
	  if this.id == 'y_job'
	    $("#title_location_row").slideUp()
	    $("#job_row").slideDown()
	  else if this.id == 'n_job'
	    $("#title_location_row").slideDown()
	    $("#job_row").slideUp()
	)
	# $('#calendar_event_start').datetimepicker({
 #    	# inline: true,
 #    	# sideBySide: true,
 #    	icons: {
	#         time: "fa fa-clock-o",
	#         date: "fa fa-calendar",
	#         up: "fa fa-arrow-up",
	#         down: "fa fa-arrow-down"
	#     }
	# 	})
	# $('#calendar_event_finish').datetimepicker({
 #    	# inline: true,
 #    	# sideBySide: true,
 #    	icons: {
 #    		time: "fa fa-clock-o",
 #    		date: "fa fa-calendar",
 #    		up: "fa fa-arrow-up",
 #    		down: "fa fa-arrow-down"
	# 	}
	# 	})
	)

