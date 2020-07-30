$(document).ready(function () {
  $(".btn-update").click(function (e) {
    e.preventDefault();

    let dados = $("#form-cliente").serialize();

    $("input[type=checkbox]").each(function () {
      if (!this.checked) {
        dados += "&" + this.name + "=off";
      }
    });

    const datamodificacao = new Date().toLocaleString();

    dados += `&datamodificacao=${datamodificacao}`;

    $.ajax({
      type: "POST",
      dataType: "json",
      assync: true,
      data: dados,
      url: "src/clientes/modelo/update-cliente.php",
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
  });
});
