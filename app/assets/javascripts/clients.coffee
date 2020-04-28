$(document).on('turbolinks:load ready', () ->
  return unless $(".clients").length > 0

  unless $.fn.dataTable.isDataTable( '#clients_table' )
    $('#clients_table').DataTable({
      # responsive: true,
      "paging":   false,
      "dom": '<"row"<"col s6"l><"col s6"f>><"row"t><"row"<"col s6"i><"col s6"p>>'
      })
)
