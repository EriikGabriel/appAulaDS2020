<?php

include('../../banco/conexao.php');

if ($conexao) {
    $requestData = $_REQUEST;

    $id = isset($requestData['idcliente']) ? $requestData['idcliente'] : '';

    $sql = "SELECT idcliente, nome, email, telefone, ativo, DATE_FORMAT(datacriacao,'%d/%m/%Y %H:%i:%s') as datacriacao, DATE_FORMAT(datamodificacao, '%d/%m/%Y %H:%i:%s') as datamodificacao FROM clientes WHERE idcliente = $id ";

    $resultado = mysqli_query($conexao, $sql);

    if ($resultado && mysqli_num_rows($resultado) > 0) {
        while ($linha = mysqli_fetch_assoc($resultado)) {
            $dadosCliente = array_map('utf8_encode', $linha);
        }

        $dados = array("tipo" => "success", "mensagem" => "", "dados" => $dadosCliente);
    } else {
        $dados = array("tipo" => "error", "mensagem" => "Não possível localizar o cliente.", "dados" => array());
    }

    mysqli_close($conexao);
} else {
    $dados = array("tipo" => "info", "mensagem" => "Não possível conecar ao banco de dados", "dados" => array());
}

echo utf8_decode(json_encode($dados, JSON_UNESCAPED_SLASHES | JSON_UNESCAPED_UNICODE));
