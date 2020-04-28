
$(document).on('turbolinks:load ready', () ->
	return unless $(".properties").length > 0

	$('#property_table').on( 'click', 'tbody tr', () ->
			window.location.href = $(this).data("link")
		)

	unless $.fn.dataTable.isDataTable( '#property_table' )
		table = $('#property_table').DataTable({
			# responsive: true,
			"paging":   false,
			"scrollX": true,
			"dom": '<"row"<"col s6"l><"col s6"f>>r<"row"t><"row"<"col s6"i><"col s6"p>>',
			columnDefs: [ {
				targets: [ 0 ],
				orderData: [ 0, 1 ]
				}, {
				targets: [ 1 ],
				orderData: [ 1, 0 ]
				}, {
				targets: [ 2 ],
				orderData: [ 2, 0 ]
				}]
			})
		# $('a.toggle-vis').on( 'click', (e) ->
		# 	e.preventDefault()
		# 	column = table.column( $(this).attr('data-column') )
		# 	column.visible( ! column.visible() )
		# 	)
		)

