# open_mod = (tag) ->
# 	$(tag).openModal()

# close_mod = (tag) ->
# 	$(tag).closeModal()

# comp_ease = () ->
# 	$(this).css('height', '')

# @back_no_mod = (id) ->
# 	$(id).parent().addClass('active')
# 	$(id).siblings('.collapsible-body').stop(true,false).slideDown(duration: 350, easing: "easeOutQuart", queue: false, complete: comp_ease())

# @back = (tag, id) ->
# 	close_mod(tag)
# 	document.querySelector('[id^=materialize-lean-overlay]').remove()
# 	@back_no_mod(id)

$(document).on('turbolinks:load ready', () ->
	return unless $(".jobs").length > 0

	$('#autocomplete-props-for-jobs').select2();
	# $('b[role="presentation"]').hide();
	# $('.select2-selection__arrow').append('<span class="caret">▼</span>');

	$('#autocomplete-cats-for-jobs').select2();
	$('#job_table').on( 'click', 'tbody tr', () ->
			window.location.href = $(this).data("link")
		)
	$('#job_open_table').on( 'click', 'tbody tr', () ->
			window.location.href = $(this).data("link")
		)
	$('#job_bid_table').on( 'click', 'tbody tr', () ->
			window.location.href = $(this).data("link")
		)
	$('#job_invoice_table').on( 'click', 'tbody tr', () ->
			window.location.href = $(this).data("link")
		)
	$('#job_tc_table').on( 'click', 'tbody tr', () ->
			window.location.href = $(this).data("link")
		)
	$('#job_expense_table').on( 'click', 'tbody tr', () ->
			window.location.href = $(this).data("link")
		)

	unless $.fn.dataTable.isDataTable( '#job_table' )
		$('#job_table').append('<tfoot><th></th><th></th><th></th><th></th><th></th><th></th><th></th><th></th><th></th><th></th><th></th></tfoot>')
		table = $('#job_table').DataTable({
			# responsive: true,
			"scrollX": true,
			"paging":   false,
			"dom": '<"row"<"col s6"l><"col s6"f>>r<"row"t><"row"<"col s6"i><"col s6"p>>',
			columnDefs: [ {
				targets: [ 0 ],
				orderData: [ 0, 1 ]
				}, {
				targets: [ 1 ],
				orderData: [ 1, 0 ]
				}, {
				targets: [ 4 ],
				orderData: [ 4, 0 ]
				}],
			"fnDrawCallback": () ->
				$("#job_table").show()
				this.api().columns.adjust()
			"footerCallback": ( row, data, start, end, display ) ->
				api = this.api data
				intVal = ( i ) ->
					return if typeof i == 'string' then i.replace(/[\$,]|[ hrs]/g, '')*1 else if typeof i == 'number' then i else 0;
				totalM = api
					.column(7, { page: 'current'})
					.data()
					.reduce ((a, b) ->
						intVal(a) + intVal(b)
					), 0
				$(api.column(7).footer()).html('total '+'$'+ totalM.toFixed(2))
			})
		$('a.toggle-vis').on( 'click', (e) ->
			e.preventDefault()
			column = table.column( $(this).attr('data-column') )
			column.visible( ! column.visible() )
			)

	unless $.fn.dataTable.isDataTable( '#job_bid_table' )
		$('#job_bid_table').append('<tfoot><th></th><th></th><th></th><th></th><th></th><th></th></tfoot>')
		tableb = $('#job_bid_table').DataTable({
			# responsive: true,
			"scrollX": true,
			"paging":   false,
			"dom": '<"row"<"col s6"l><"col s6"f>>r<"row"t><"row"<"col s6"i><"col s6"p>>',
			columnDefs: [ {
				targets: [ 0 ],
				orderData: [ 0, 1 ]
				}, {
				targets: [ 1 ],
				orderData: [ 1, 0 ]
				}, {
				targets: [ 4 ],
				orderData: [ 4, 0 ]
				}],
			"fnDrawCallback": () ->
				$("#job_bid_table").show()
				this.api().columns.adjust()
			"footerCallback": ( row, data, start, end, display ) ->
				api = this.api data
				intVal = ( i ) ->
					return if typeof i == 'string' then i.replace(/[\$,]|[ hrs]/g, '')*1 else if typeof i == 'number' then i else 0;
				totalM = api
					.column(5, { page: 'current'})
					.data()
					.reduce ((a, b) ->
						intVal(a) + intVal(b)
					), 0
				$(api.column(5).footer()).html('total '+'$'+ totalM.toFixed(2))
			})
		$('a.toggle-viso').on( 'click', (e) ->
			e.preventDefault()
			column = tableo.column( $(this).attr('data-column') )
			column.visible( ! column.visible() )
			)

	unless $.fn.dataTable.isDataTable( '#job_open_table' )
		$('#job_open_table').append('<tfoot><th></th><th></th><th></th><th></th><th></th><th></th><th></th><th></th><th></th></tfoot>')
		tableo = $('#job_open_table').DataTable({
			# responsive: true,
			"scrollX": true,
			"paging":   false,
			"dom": '<"row"<"col s6"l><"col s6"f>>r<"row"t><"row"<"col s6"i><"col s6"p>>',
			columnDefs: [ {
				targets: [ 0 ],
				orderData: [ 0, 1 ]
				}, {
				targets: [ 1 ],
				orderData: [ 1, 0 ]
				}, {
				targets: [ 4 ],
				orderData: [ 4, 0 ]
				}],
			"fnDrawCallback": () ->
				$("#job_open_table").show()
				this.api().columns.adjust()
			"footerCallback": ( row, data, start, end, display ) ->
				api = this.api data
				intVal = ( i ) ->
					return if typeof i == 'string' then i.replace(/[\$,]|[ hrs]/g, '')*1 else if typeof i == 'number' then i else 0;
				totalM = api
					.column(6, { page: 'current'})
					.data()
					.reduce ((a, b) ->
						intVal(a) + intVal(b)
					), 0
				$(api.column(6).footer()).html('total '+'$'+ totalM.toFixed(2))
			})
		$('a.toggle-viso').on( 'click', (e) ->
			e.preventDefault()
			column = tableo.column( $(this).attr('data-column') )
			column.visible( ! column.visible() )
			)

	unless $.fn.dataTable.isDataTable( '#job_invoice_table' )
		$('#job_invoice_table').append('<tfoot><th></th><th></th><th></th><th></th><th></th><th></th><th></th><th></th></tfoot>')
		tablea = $('#job_invoice_table').DataTable({
			# responsive: true,
			"scrollX": true,
			"paging":   false,
			"dom": '<"row"<"col s6"l><"col s6"f>>r<"row"t><"row" F><"row"<"col s6"i><"col s6"p>>',
			columnDefs: [ {
				targets: [ 0 ],
				orderData: [ 0, 1 ]
				}, {
				targets: [ 1 ],
				orderData: [ 1, 0 ]
				}, {
				targets: [ 4 ],
				orderData: [ 4, 0 ]
				}],
			"fnDrawCallback": () ->
				$("#job_invoice_table").show()
				this.api().columns.adjust()
			"footerCallback": ( row, data, start, end, display ) ->
				api = this.api data
				intVal = ( i ) ->
					return if typeof i == 'string' then i.replace(/[\$,]|[ hrs]/g, '')*1 else if typeof i == 'number' then i else 0;
				totalM = api
					.column(3, { page: 'current'})
					.data()
					.reduce ((a, b) ->
						intVal(a) + intVal(b)
					), 0
				$(api.column(3).footer()).html('total '+'$'+ totalM.toFixed(2))
			})
		$('a.toggle-visa').on( 'click', (e) ->
			e.preventDefault()
			column = tablea.column( $(this).attr('data-column') )
			column.visible( ! column.visible() )
			)

	$('#jobo_header').on('click', () ->
		setTimeout(()->
			tableo.columns.adjust().draw()
		, 350)
		)
	$('#bid_header').on('click', () ->
		setTimeout(()->
			tableb.columns.adjust().draw()
		, 350)
		)
	$('#job_header').on('click', () ->
		setTimeout(()->
			table.columns.adjust().draw()
		, 350)
		)

		# tableo.columns.adjust().draw()
		# table.columns.adjust().draw()

	)

