$(document).ready(function () {
  $("#table-cliente").on("click", "button.btn-edit", function (e) {
    e.preventDefault();

    $(".modal-title").empty();
    $(".modal-body").empty();

    $(".modal-title").append("Edição de cliente");

    let idcliente = `idcliente=${$(this).attr("id")}`;

    $.ajax({
      type: "POST",
      dataType: "JSON",
      assync: true,
      data: idcliente,
      url: "src/clientes/modelo/view-cliente.php",
      success: function (dado) {
        if (dado.tipo == "success") {
          $(".modal-body").load("src/clientes/visao/form-cliente.html", function () {
            $("#nome").val(dado.dados.nome);
            $("#email").val(dado.dados.email);
            $("#tel").val(dado.dados.telefone);
            $("#dataagora").val(dado.dados.datacriacao);

            if (dado.dados.ativo == "N") {
              $("#ativo").removeAttr("checked");
            }

            $("#idcliente").val(dado.dados.idcliente);
          });

          $(".btn-save").hide();
          $(".btn-update").show();
          $("#modal-cliente").modal("show");
        } else {
          Swal.fire({
            title: "appAulaDS",
            text: dado.mensagem,
            type: dado.tipo,
            confirmButtonText: "OK",
          });
        }
      },
    });
  });
});
