<?php

include('../../banco/conexao.php');

if ($conexao) {

    $requestData = $_REQUEST;

    if (empty($requestData['nome']) || empty($requestData['ativo'])) {
        $dados = array(
            "tipo" => "info",
            "mensagem" => "Existe(m) campo(s) obrigatório(s) em branco."
        );
    } else {
        $id = isset($requestData['idcliente']) ? $requestData['idcliente'] : '';
        $requestData['ativo'] = $requestData['ativo'] == "on" ? "S" : "N";

        $date = date_create_from_format('d/m/Y H:i:s', $requestData['dataagora']);
        $requestData['dataagora'] = date_format($date, 'Y-m-d H:i:s');

        $sql = "UPDATE clientes SET nome = '$requestData[nome]', email = '$requestData[email]', telefone = '$requestData[tel]', ativo = '$requestData[ativo]', datamodificacao = '$requestData[dataagora]' WHERE idcliente = $id ";

        $resultado = mysqli_query($conexao, $sql);

        if ($resultado) {
            $dados = array(
                "tipo" => "success",
                "mensagem" => "Cliente alterado com sucesso."
            );
        } else {
            $dados = array(
                "tipo" => "error",
                "mensagem" => mysqli_error($conexao)
            );
        }
    }

    mysqli_close($conexao);
} else {
    $dados = array(
        "tipo" => "info",
        "mensagem" => "Ops... não foi possível conectar ao banco de dados"
    );
}

echo utf8_decode(json_encode($dados, JSON_UNESCAPED_SLASHES | JSON_UNESCAPED_UNICODE));
