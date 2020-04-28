
$(document).on('turbolinks:load ready', () ->
	return unless $(".expenses").length > 0

	$('#autocomplete-job-for-exp').select2();
	$('#autocomplete-staff-for-exp').select2();

	$('#expense_table').on( 'click', 'tbody tr', () ->
			window.location.href = $(this).data("link")
		)

	unless $.fn.dataTable.isDataTable( '#expense_table' )
		$('#expense_table').append('<tfoot><th></th><th></th><th></th><th></th><th></th><th></th><th></th></tfoot>')
		table = $('#expense_table').DataTable({
			# responsive: true,
			"scrollX": true,
			"paging":   false,
			"dom": '<"row"<"col s6"l><"col s6"f>>r<"row"t><"row"<"col s6"i><"col s6"p>>',
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
			columnDefs: [ {
				targets: [ 0 ],
				orderData: [ 0, 1 ]
				}, {
				targets: [ 1 ],
				orderData: [ 1, 0 ]
				}, {
				targets: [ 4 ],
				orderData: [ 4, 0 ]
				}]
			})
		$('a.toggle-vis').on( 'click', (e) ->
			e.preventDefault()
			column = table.column( $(this).attr('data-column') )
			column.visible( ! column.visible() )
			)
		)
