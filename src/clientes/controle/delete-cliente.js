$(document).ready(function () {
  $("#table-cliente").on("click", "button.btn-delete", function (e) {
    e.preventDefault();

    let idcliente = `idcliente=${$(this).attr("id")}`;

    Swal.fire({
      title: "appAulaDS",
      text: "Deseja realmente excluir esse registro?",
      type: "question",
      showCancelButton: true,
      confirmButtonText: "Sim",
      cancelButtonText: "Não",
    }).then((result) => {
      if (result.value) {
        $.ajax({
          type: "POST",
          dataType: "json",
          assync: true,
          data: idcliente,
          url: "src/clientes/modelo/delete-cliente.php",
          success: function (dados) {
            Swal.fire({
              title: "appAulaDS",
              text: dados.mensagem,
              type: dados.tipo,
              confirmButtonText: "OK",
            });

            $("#modal-cliente").modal("hide");
            $("#table-cliente").DataTable().ajax.reload();
          },
        });
      }
    });
  });
});
