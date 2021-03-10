CREATE DATABASE `vendas`;

use vendas;

CREATE TABLE `produto` (
  `codProduto` int NOT NULL AUTO_INCREMENT,
  `descricao` varchar(100) NOT NULL,
  `precoVenda` decimal(9,2) NOT NULL,
  PRIMARY KEY (`codProduto`)
) ENGINE=InnoDB AUTO_INCREMENT=21;

INSERT INTO `produto` VALUES (1,'Sabão em pó OMO 1.6 kg',11.99);
INSERT INTO `produto` VALUES (2,'Xbox one',4500.00);
INSERT INTO `produto` VALUES (3,'Macarrao integral parati',3.99);
INSERT INTO `produto` VALUES (4,'Tenis olympicus 42',77.99);
INSERT INTO `produto` VALUES (5,'Cartela de adesivos',1.00);
INSERT INTO `produto` VALUES (6,'Fiat Palio 2022',46900.00);
INSERT INTO `produto` VALUES (7,'Notebook dell usado',1950.00);
INSERT INTO `produto` VALUES (8,'Copo de vidro',10.00);
INSERT INTO `produto` VALUES (9,'Canudo de madeira',0.50);
INSERT INTO `produto` VALUES (10,'Grama m²',11.50);
INSERT INTO `produto` VALUES (11,'Tijolo 6 furos',1.99);
INSERT INTO `produto` VALUES (12,'Cobertor casal',229.00);
INSERT INTO `produto` VALUES (13,'Tinta azul',90.00);
INSERT INTO `produto` VALUES (14,'Tinta verde',90.00);
INSERT INTO `produto` VALUES (15,'Roupao',76.00);
INSERT INTO `produto` VALUES (16,'Arame',12.00);
INSERT INTO `produto` VALUES (17,'Celular LG K40S',1500.00);
INSERT INTO `produto` VALUES (18,'Modem ADSL',40.00);
INSERT INTO `produto` VALUES (19,'Kindle 10 geração',229.00);
INSERT INTO `produto` VALUES (20,'Aulas de yoga',90.00);

CREATE TABLE `cliente` (
  `codCliente` int NOT NULL,
  `nome` varchar(60) NOT NULL,
  `cidade` varchar(60) NOT NULL,
  `uf` char(2) NOT NULL,
  PRIMARY KEY (`codCliente`)
) ENGINE=InnoDB;

INSERT INTO `cliente` VALUES (1,'Giovani','Erval Velho','SC');
INSERT INTO `cliente` VALUES (2,'João','São Paulo','SC');
INSERT INTO `cliente` VALUES (3,'Maria','Pato Branco','PR');
INSERT INTO `cliente` VALUES (4,'Pablo','Rio de Janeiro','RJ');
INSERT INTO `cliente` VALUES (5,'Joaquim','Natal','RN');
INSERT INTO `cliente` VALUES (6,'Janete','Gramado','RS');
INSERT INTO `cliente` VALUES (7,'Luis','Brasilia','DF');
INSERT INTO `cliente` VALUES (8,'Antonio','Brasilia','DF');
INSERT INTO `cliente` VALUES (9,'Sergio','Joaçaba','SC');
INSERT INTO `cliente` VALUES (10,'Mario','Florianopolis','SC');
INSERT INTO `cliente` VALUES (11,'Mathias','Curitiba','PR');
INSERT INTO `cliente` VALUES (12,'Neiva','Campos Novos','SC');
INSERT INTO `cliente` VALUES (13,'Matheus','Fraiburgo','SC');
INSERT INTO `cliente` VALUES (14,'Nei','Canela','RN');
INSERT INTO `cliente` VALUES (15,'Edmara','Joaçaba','SC');
INSERT INTO `cliente` VALUES (16,'Guilhermina','São Paulo','SP');
INSERT INTO `cliente` VALUES (17,'Natalino','Herval Doeste','SC');
INSERT INTO `cliente` VALUES (18,'Avelino','Campos Novos Paulista','SP');
INSERT INTO `cliente` VALUES (19,'João Paulo','Itá','SC');
INSERT INTO `cliente` VALUES (20,'Joana','Itá','SC');

CREATE TABLE `pedido` (
  `nrPedido` int NOT NULL,
  `dataEmissao` datetime NOT NULL,
  `codCliente` int NOT NULL,
  `valorTotal` decimal(9,2) NOT NULL,
  PRIMARY KEY (`nrPedido`),
  KEY `fk_pedido_cliente_idx` (`codCliente`),
  CONSTRAINT `fk_pedido_cliente` FOREIGN KEY (`codCliente`) REFERENCES `cliente` (`codCliente`)
) ENGINE=InnoDB;

CREATE TABLE `pedido_produtos` (
  `idpedido_produtos` int NOT NULL AUTO_INCREMENT,
  `nrPedido` int NOT NULL,
  `codProduto` int NOT NULL,
  `quantidade` decimal(9,3) NOT NULL,
  `valorUnitario` decimal(9,2) NOT NULL,
  `valorTotal` decimal(9,2) NOT NULL,
  PRIMARY KEY (`idpedido_produtos`),
  KEY `fk_pedidos_produtos_pedido_idx` (`nrPedido`),
  KEY `fk_pedidos_produtos_produto_idx` (`codProduto`),
  CONSTRAINT `fk_pedidos_produtos_pedido` FOREIGN KEY (`nrPedido`) REFERENCES `pedido` (`nrPedido`),
  CONSTRAINT `fk_pedidos_produtos_produto` FOREIGN KEY (`codProduto`) REFERENCES `produto` (`codProduto`)
) ENGINE=InnoDB AUTO_INCREMENT=1;
