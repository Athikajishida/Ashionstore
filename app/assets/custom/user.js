
$('#table_filter').DataTable({
    "processing": true,
    "serverSide": true,
    "ordering": true,
    "searching": true,
    "bAutoWidth": false,
    order: [
      [0, "asc"]
    ],
    ajax: {
      "data": function () {
        var info = $("#table_filter").DataTable().page.info();
        $("#table_filter").DataTable().ajax.url("http://localhost:3000/user_list?page=" + (info.page + 1));
      },
      headers: {
        'Authorization': $('body').data('token')
      },
      "type": 'GET',
      "dataType": "json",
      "dataSrc": "data"
    },
    "columns": [
      { "data": "id" },
      { "data": "email" },
    {
        "data": null,
        orderable: false,
        "render": function (data, type, row) {
        status_btn = '<div class="form-check form-switch"><label class="form-check-label" for="flexSwitchCheckDefault"><input type="checkbox" class="chk_status form-check-input" id="switch-p-' + row.id + '" data-id="' + row.id + '" data-is_active="' + row.blocked + '"' + (row.blocked ? ' checked' : '') + '><label for="switch-p-' + row.id + '" class="cr"></label></div>';          // const editBtn = '<a class="btn drp-icon btn-rounded btn-success" href="#" data-toggle="modal" data-target="#edit_asset_types" data-asset_type_id=' + row.id + ' data-asset_type="' + row.asset_type + '"><i class="fa-solid fa-pen-to-square"></i></a>';
          return status_btn + '&nbsp;&nbsp';
        }
      } ,

      
    ]
  });