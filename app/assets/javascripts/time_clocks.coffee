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
	return unless $(".time_clocks").length > 0

	$('#autocomplete-jobs').select2();


	unless $.fn.dataTable.isDataTable( '#time_clock_table' )
		$('#time_clock_table').DataTable({
			responsive: true,
			"paging":   false,
			"dom": '<"row"<"col s6"l><"col s6"f>><"row"t><"row"<"col s6"i><"col s6"p>>'
			})

	unless $.fn.dataTable.isDataTable( '#payroll_table' )
		$('#payroll_table').append('<tfoot><th></th><th></th><th></th><th></th><th></th><th></th><th></th><th></th></tfoot>')
		$('#payroll_table').DataTable({
			responsive: true,
			"paging":   false,
			"dom": '<"row"<"col s6"l><"col s6"f>>r<"row"t><"row" F><"row"<"col s6"i><"col s6"p>>',
			"footerCallback": ( row, data, start, end, display ) ->
				api = this.api data
				intVal = ( i ) ->
					return if typeof i == 'string' then i.replace(/[\$,]|[ hrs]/g, '')*1 else if typeof i == 'number' then i else 0;
				totalH = api
					.column(5, { page: 'current'})
					.data()
					.reduce ((a, b) ->
						intVal(a) + intVal(b)
					), 0
				totalM = api
					.column(6, { page: 'current'})
					.data()
					.reduce ((a, b) ->
						intVal(a) + intVal(b)
					), 0
				$(api.column(5).footer()).html('total '+totalH.toFixed(2)+' hrs')
				$(api.column(6).footer()).html('total '+'$'+ totalM.toFixed(2))
			})
		# $('#payroll_table').append('<tfoot><th></th></tfoot>')
		# console.log($('#payroll_table').DataTable().column(5).data().sum())
			# pageTotal = api
	  #               .column( 4, { page: 'current'} )
	  #               .data()
	  #               .reduce( function (a, b) {
	  #                   return intVal(a) + intVal(b);
	  #               }, 0 );
	 
   #           # Update footer
   #          $( api.column( 4 ).footer() ).html(
   #              '$'+pageTotal +' ( $'+ total +' total)'
   #          );
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

