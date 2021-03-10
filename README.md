#### Projeto desenvolvido por Giovani Raci Paganini 
# Favor ler o descritivo abaixo


Devido à avaliação técnica ter o intuito de analisar meu conhecimento, optei por utilizar o menos possível de rotinas prontas do Delphi, para tentar explanar diversas estruturas de programação que possuo conhecimento.
Abaixo detalho como fiz, e a maneira "mais fácil" que poderia ser utilizada em projetos deste tipo:

- Criação de uma classe de pedido para armazenar dados do mesmo: Poderia ser apenas trabalhado com os dados em um TFDQuery, onde os dados seriam lidos direto no banco
- Criação de uma classe de produtos de pedido: Poderia ser utilizado um segundo TFDQuery, linkando com o primeiro para mostrar apenas produtos do pedido do TFDQuery de pedidos
- Botões "Próximo" e "Anterior": Poderia ter sido utilizado um DBNavegator conectado com um Dataset (que estaria conectado a um FDQuery de produtos de pedido)
- Rotina de buscar dados (botão "buscar pedido"): Uma opção seria apenas alterar o FDQuery colocando um "where" para filtrar pelo pedido informado
- Uso de TEdit em vez de TDBEdit
1. Usar TDBEdit torna todo o processo de carregar dados e salvar mais simples, pois não precisa ser feito a mão. 
2. Além disso, as validações seriam mais fáceis
3. Por último, formatação de campos Float seria necessário apenas informar no campo DisplayFormat e/ou EditFormat
- Uso de TStringGrid: Ao optar por utilizar TDBGrid o processo de inserir e remover dados do grid (linhas inclusive) é automático conforme dados do FDQuery, reduzindo bastante o código.
- Limpeza de dados na tela: Se fosse utilizado TDBEdit e TDBGrid poderia ser apenas necessário fechar o dataset (.close) e todos os campos seriam limpos
- Controle de status (enable) dos edits: Se utilizado TDBGrid poderia ser colocado para que o status dos edits fossem determinados conforme o State do FDQuery, geralmente utilizado no DataChange e StateChange do TDataSource
- Gravação de dados: Em caso de utilizar TFDQuery e TDBEdit bastaria dar um .post e .applyupdates e os dados seriam inseridos ou atualizados para o banco. Todo o controle é feito pelo Firedac, mesmo o de saber se precisar incluir novo ou editar um existente.
- Excluir/Cancelar pedido: Em caso de utilizar TFDQuery e TDBEdit utilizar .delete já seria o suficiente

#### Note ainda que existe rotina para muita coisa, assim, tentei pensar em reaproveitar ao máximo os códigos e deixar mais genérico possível para ser fácil de realizar alterações futuras

#### Segui as premissas solicitadas, porém aponto as melhorias que eu faria em relação as tabelas

- Na tabela de produtos do pedido iria remover o campo de "valor total", visto que este sempre é "quantidade" * "valor unitário" não sendo assim necessário armazenar no banco.
- Na tabela de pedidos, removeria o campo "valor total" pois é a soma de todos os produtos do pedido não precisando armazenar no banco

#### Dados para acesso ao banco
- Usuário: root
- Senha: root
- Instalação em máquina local
- Versão mysql utilizada: 8.0
- Versão delphi: 10.3 Update 3 Community
