<?php

include('../../banco/conexao.php');

if (!$conexao) {
    $dados = array(
        'tipo' => 'info',
        'mensagem' => 'Ops, não foi possível obter uma conexão com o banco de dados, tente mais tarde...'
    );
} else {
    $requestData = $_REQUEST;

    if (empty($requestData['nome']) || empty($requestData['ativo'])) {
        $dados = array(
            'tipo' => 'info',
            'mensagem' => 'Existe(m) campo(s) obrigatório(s) vazio(s).'
        );
    } else {
        $requestData['ativo'] = $requestData['ativo'] == "on" ? "S" : "N";

        $date = date_create_from_format('d/m/Y H:i:s', $requestData['dataagora']);
        $requestData['dataagora'] = date_format($date, 'Y-m-d H:i:s');

        $sql = "INSERT INTO CLIENTES (nome, email, telefone, ativo, datacriacao, datamodificacao)
        VALUES ('$requestData[nome]', '$requestData[email]', '$requestData[tel]', '$requestData[ativo]', '$requestData[dataagora]', '$requestData[dataagora]')";

        $resultado = mysqli_query($conexao, $sql);

        if ($resultado) {
            $dados = array(
                'tipo' => 'success',
                'mensagem' => 'Cliente criado com sucesso.'
            );
        } else {
            $dados = array(
                'tipo' => 'error',
                'mensagem' => 'Não foi possível criar o cliente.' . mysqli_error($conexao)
            );
        }
    }

    mysqli_close($conexao); //Fechando a conexão com o banco
}

echo utf8_decode(json_encode($dados, JSON_UNESCAPED_SLASHES | JSON_UNESCAPED_UNICODE));
