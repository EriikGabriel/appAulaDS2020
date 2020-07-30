<?php

include('../../banco/conexao.php');

if (!$conexao) {
    $dados = array(
        "tipo" => "info",
        "mensagem" => "Não possível conecar ao banco de dados",
        "dados" => array()
    );
} else {
    $sql = "SELECT idcategoria, nome FROM categorias WHERE ativo = 'S' ";
    $resultado = mysqli_query($conexao, $sql);

    $dadosCategoria = array();

    if ($resultado && mysqli_num_rows($resultado) > 0) {
        while ($linha = mysqli_fetch_assoc($resultado)) {
            $dadosCategoria[] = array_map('utf8_encode', $linha);
        }
        $dados = array(
            "tipo" => "success",
            "mensagem" => "",
            "dados" => $dadosCategoria
        );
    } else {
        $dados = array(
            "tipo" => "error",
            "mensagem" => "Não possível localizar a categoria.",
            "dados" => array()
        );
    }

    mysqli_close($conexao);
}

echo json_encode($dados, JSON_UNESCAPED_SLASHES | JSON_UNESCAPED_UNICODE);
