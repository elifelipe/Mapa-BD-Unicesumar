-- CRIA O BANCO DE DADOS SE NÃO EXISTIR
CREATE SCHEMA IF NOT EXISTS Mapa;
-- USA O BANCO DE DADOS CRIADO ACIMA
USE Mapa;

-- TABELA CATEGORIA
CREATE TABLE IF NOT EXISTS Mapa.Categoria (
  idCategoria INT NOT NULL AUTO_INCREMENT,
  Categoria VARCHAR(70) NULL,
  PRIMARY KEY (idCategoria));

-- TABELA CIDADE
CREATE TABLE IF NOT EXISTS Mapa.Cidade (
  idCidade INT NOT NULL AUTO_INCREMENT,
  cidade VARCHAR(45) NULL,
  uf VARCHAR(45) NULL,
  PRIMARY KEY (idCidade));

-- TABELA FORNECEDOR
CREATE TABLE IF NOT EXISTS Mapa.Fornecedor (
  idFornecedor INT NOT NULL AUTO_INCREMENT,
  fornecedor VARCHAR(45) NULL,
  endereco VARCHAR(45) NULL,
  num INT NULL,
  bairro VARCHAR(45) NULL,
  CEP VARCHAR(45) NULL,
  contato VARCHAR(45) NULL,
  CNPJ VARCHAR(45) NULL,
  insc VARCHAR(45) NULL,
  tel VARCHAR(45) NULL,
  cidade_idCidade INT NULL,
  PRIMARY KEY (idFornecedor),
  INDEX fk_Fornecedor_1_idx (cidade_idCidade ASC) VISIBLE,
  CONSTRAINT fk_Fornecedor_1
    FOREIGN KEY (cidade_idCidade)
    REFERENCES Mapa.Cidade (idCidade)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

-- TABELA PRODUTO
CREATE TABLE IF NOT EXISTS Mapa.Produto (
  idProduto INT NOT NULL AUTO_INCREMENT,
  descricao VARCHAR(45) NULL,
  peso DOUBLE NULL,
  controlado VARCHAR(45) NULL,
  qtdeMin DOUBLE NULL,
  fornecedor_idFornecedor INT NULL,
  categoria_idCategoria INT NULL,
  PRIMARY KEY (idProduto),
  INDEX fk_Produto_1_idx (fornecedor_idFornecedor ASC),
  INDEX fk_Produto_2_idx (categoria_idCategoria ASC),
  CONSTRAINT fk_Produto_1
    FOREIGN KEY (fornecedor_idFornecedor)
    REFERENCES Mapa.Fornecedor (idFornecedor)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_Produto_2
    FOREIGN KEY (categoria_idCategoria)
    REFERENCES Mapa.Categoria (idCategoria)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

-- TABELA LOJA
CREATE TABLE IF NOT EXISTS Mapa.Loja (
  idLoja INT NOT NULL AUTO_INCREMENT,
  nome VARCHAR(45) NULL,
  endereco VARCHAR(45) NULL,
  num INT NULL,
  bairro VARCHAR(45) NULL,
  tel BIGINT(10) NULL,
  insc VARCHAR(45) NULL,
  CNPJ VARCHAR(45) NULL,
  cidade_idCidade INT NULL,
  PRIMARY KEY (idLoja),
  INDEX fk_Loja_1_idx (cidade_idCidade ASC) VISIBLE,
  CONSTRAINT fk_Loja_1
    FOREIGN KEY (cidade_idCidade)
    REFERENCES Mapa.Cidade (idCidade)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

-- TABELA TRANSPORTADORA
CREATE TABLE IF NOT EXISTS Mapa.Transportadora (
  idTransportadora INT NOT NULL AUTO_INCREMENT,
  transportadora VARCHAR(45) NULL,
  endereco VARCHAR(45) NULL,
  num INT NULL,
  bairro VARCHAR(45) NULL,
  cep VARCHAR(45) NULL,
  cnpj VARCHAR(45) NULL,
  insc VARCHAR(45) NULL,
  contato VARCHAR(45) NULL NULL,
  tel VARCHAR(45) NULL NULL,
  cidade_idCidade INT NULL,
  PRIMARY KEY (idTransportadora),
  INDEX fk_Transportadora_1_idx (cidade_idCidade ASC) VISIBLE,
  CONSTRAINT fk_Transportadora_1
    FOREIGN KEY (cidade_idCidade)
    REFERENCES Mapa.Cidade (idCidade)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

-- TABELA SAIDA
CREATE TABLE IF NOT EXISTS Mapa.Saida (
  idSaida INT NOT NULL AUTO_INCREMENT,
  total VARCHAR(45) NULL,
  frete DOUBLE NULL,
  imposto VARCHAR(45) NULL,
  loja_idLoja INT NULL,
  transportadora_idTransportadora INT NULL,
  PRIMARY KEY (idSaida),
  INDEX fk_Saida_1_idx (loja_idLoja ASC) VISIBLE,
  INDEX fk_Saida_2_idx (transportadora_idTransportadora ASC) VISIBLE,
  CONSTRAINT fk_Saida_1
    FOREIGN KEY (loja_idLoja)
    REFERENCES Mapa.Loja (idLoja)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_Saida_2
    FOREIGN KEY (transportadora_idTransportadora)
    REFERENCES Mapa.Transportadora (idTransportadora)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

-- TABELA SAIDA
CREATE TABLE IF NOT EXISTS Mapa.Saida (
  idSaida INT NOT NULL AUTO_INCREMENT,
  total VARCHAR(45) NULL,
  frete DOUBLE NULL,
  imposto VARCHAR(45) NULL,
  loja_idLoja INT NULL,
  transportadora_idTransportadora INT NULL,
  PRIMARY KEY (idSaida),
  INDEX fk_Saida_1_idx (loja_idLoja ASC) VISIBLE,
  INDEX fk_Saida_2_idx (transportadora_idTransportadora ASC) VISIBLE,
  CONSTRAINT fk_Saida_1
    FOREIGN KEY (loja_idLoja)
    REFERENCES Mapa.Loja (idLoja)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_Saida_2
    FOREIGN KEY (transportadora_idTransportadora)
    REFERENCES Mapa.Transportadora (idTransportadora)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

-- TABELA ITEM SAIDA
CREATE TABLE IF NOT EXISTS Mapa.ItemSaida (
  idItemSaida INT NOT NULL AUTO_INCREMENT,
  lote VARCHAR(45) NULL,
  qtde INT NULL,
  valor DOUBLE NULL,
  produto_idProduto INT NULL,
  saida_idSaida INT,
  PRIMARY KEY (idItemSaida),
  INDEX fk_ItemSaida_1_idx (produto_idProduto ASC) VISIBLE,
  INDEX fk_ItemSaida_2_idx (saida_idSaida ASC) VISIBLE,
  CONSTRAINT fk_ItemSaida_1
    FOREIGN KEY (produto_idProduto)
    REFERENCES Mapa.Produto (idProduto)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_ItemSaida_2
    FOREIGN KEY (saida_idSaida)
    REFERENCES Mapa.Saida (idSaida)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

-- TABELA ENTRADA
CREATE TABLE IF NOT EXISTS Mapa.Entrada (
  idEntrada INT NOT NULL AUTO_INCREMENT,
  dataPed DATE NULL,
  dataEnt DATE NULL,
  total VARCHAR(45) NULL,
  frete DOUBLE NULL,
  numNf INT NULL,
  imposto VARCHAR(45) NULL,
  transportadora_idTransportadora INT NULL,
  PRIMARY KEY (idEntrada),
  INDEX fk_Entrada_1_idx (transportadora_idTransportadora ASC) VISIBLE,
  CONSTRAINT fk_Entrada_1
    FOREIGN KEY (transportadora_idTransportadora)
    REFERENCES Mapa.Transportadora (idTransportadora)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

-- TABELA ITEM ENTRADA
CREATE TABLE IF NOT EXISTS Mapa.ItemEntrada (
  idItemEntrada INT NOT NULL AUTO_INCREMENT,
  lote VARCHAR(45) NULL,
  qtde INT NULL,
  valor FLOAT NULL,
  produto_idProduto INT NULL,
  entrada_idEntrada INT NULL,
  PRIMARY KEY (idItemEntrada),
  INDEX fk_ItemEntrada_1_idx (produto_idProduto ASC) VISIBLE,
  INDEX fk_ItemEntrada_2_idx (entrada_idEntrada ASC) VISIBLE,
  CONSTRAINT fk_ItemEntrada_1
    FOREIGN KEY (produto_idProduto)
    REFERENCES Mapa.Produto (idProduto)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_ItemEntrada_2
    FOREIGN KEY (entrada_idEntrada)
    REFERENCES Mapa.Entrada (idEntrada)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

-- DADOS DA TABELA CATEGORIAS
INSERT INTO Categoria (categoria) VALUES ("Fitoterápico");
INSERT INTO Categoria (categoria) VALUES ("Alopático");
INSERT INTO Categoria (categoria) VALUES ("Homeopático");

-- DADOS DA TABELA CIDADES
INSERT INTO Cidade (cidade, uf) VALUES ("Navegantes", "SC");
INSERT INTO Cidade (cidade, uf) VALUES ("Maringa", "PR");
INSERT INTO Cidade (cidade, uf) VALUES ("Rio de Janeiro", "RJ");

-- DADOS ENTRADA DE PRODUTOS
INSERT INTO Entrada (dataPed, dataEnt, total, frete, numNF, imposto) VALUES ("2021-07-01", "2020-06-01", "100", "20.00", "1", "2.00");
INSERT INTO Entrada (dataPed, dataEnt, total, frete, numNF, imposto) VALUES ("2021-06-01", "2020-05-01", "100", "30.00", "2", "3.00");
INSERT INTO Entrada (dataPed, dataEnt, total, frete, numNF, imposto) VALUES ("2021-06-01", "2020-04-01", "100", "40.00", "3", "4.00");

-- DADOS DE FORNECEDORES
INSERT INTO Fornecedor (fornecedor, endereco, num, bairro, CEP, contato, CNPJ, insc, tel) VALUES 
("Farmais", "Rua. Nereu Liberato", "1180", "centro", "88370232", "Joaquin", "16.481.536/0001-06", "Felipe", "47992082011");
INSERT INTO Fornecedor (fornecedor, endereco, num, bairro, CEP, contato, CNPJ, insc, tel) VALUES 
("PagmenosFarma", "Rua. Abraão chico", "170", "Meia Praia", "88370332", "Elaine", "16.481.536/0001-06", "Daiane", "47984550266");
INSERT INTO Fornecedor (fornecedor, endereco, num, bairro, CEP, contato, CNPJ, insc, tel) VALUES 
("Rei Do Remedio", "Rua. Paraguai", "10", "Cordeiros", "88370333", "Lucas", "16.481.536/0001-06", "André", "47986220515");

-- DADOS ITEM DE ENTRADA
INSERT INTO ItemEntrada (lote, qtde, valor) VALUES ("Remedios", "2000", "10000");
INSERT INTO ItemEntrada (lote, qtde, valor) VALUES ("Perfumes", "300", "2000");
INSERT INTO ItemEntrada (lote, qtde, valor) VALUES ("Limpeza", "400", "4000");

-- DADOS ITEM SAIDA
INSERT INTO ItemSaida (lote, qtde, valor) VALUES ("Limpeza", "200", "2000");
INSERT INTO ItemSaida (lote, qtde, valor) VALUES ("Remedios", "1000", "5000");
INSERT INTO ItemSaida (lote, qtde, valor) VALUES ("Perfumes", "150", "1000");

-- DADOS DE LOJA
INSERT INTO Loja (nome, endereco, num, bairro, tel, insc, CNPJ) VALUES 
("Farmacia da tia jurema", "Rua. veneza", "20", "centro", "992082011", "Jurema da silva", "16.481.536/0001-06");
INSERT INTO Loja (nome, endereco, num, bairro, tel, insc, CNPJ) VALUES 
("Dorgas Farma", "Rua. 30 de fevereiro", "510", "centro", "992082011", "Adebardo cardiaco da silva", "16.481.536/0001-06");
INSERT INTO Loja (nome, endereco, num, bairro, tel, insc, CNPJ) VALUES 
("Farma+", "Rua. venancio", "50", "centro", "992082011", "Adebardo cardiaco da silva", "16.481.536/0001-06");

-- DADOS DO PRODUTO
INSERT INTO Produto (descricao, peso, controlado, qtdeMin) VALUES ("Dipirona", "0.50", "sim", "40.00");
INSERT INTO Produto (descricao, peso, controlado, qtdeMin) VALUES ("Ibuprofeno", "0.80", "não", "50.00");
INSERT INTO Produto (descricao, peso, controlado, qtdeMin) VALUES ("Dramin", "0.90", "sim", "3.00");

-- DADOS DE SAIDA
INSERT INTO Saida (total, frete, imposto) VALUES ("1000", "800.90", "40.00");
INSERT INTO Saida (total, frete, imposto) VALUES ("4000", "700.90", "40.00");
INSERT INTO Saida (total, frete, imposto) VALUES ("2000", "500.90", "40.00");

-- DADOS DE TRANSPORTADORA
INSERT INTO Transportadora (Transportadora, endereco, num, bairro, cep, cnpj, insc, contato, tel) VALUES 
("Leva e tras", "Rua. dos transportes", "12", "centro", "12334324", "16.481.536/0001-06", "05", "Joao", "4799522155");
INSERT INTO Transportadora (Transportadora, endereco, num, bairro, cep, cnpj, insc, contato, tel) VALUES 
("Mão na roda", "Rua. gonsalo", "172", "pontal", "154165465", "16.481.536/0001-06", "04", "MARIA", "4799522155");
INSERT INTO Transportadora (Transportadora, endereco, num, bairro, cep, cnpj, insc, contato, tel) VALUES 
("Transbeto", "Rua. trapixe", "1447", "penha", "272587241", "16.481.536/0001-06", "07", "Dayane", "4799522155");

-- - 03 consultas (SELECT), WHERE; INNER JOIN; RIGHT JOIN;
SELECT categoria FROM Categoria WHERE categoria = 'Homeopático';
SELECT c.categoria, p.descricao FROM Categoria AS c INNER JOIN Produto AS p ON p.idProduto = c.idCategoria;
SELECT * FROM Categoria RIGHT OUTER JOIN Produto ON Categoria.idCategoria = Produto.idProduto;

-- - 03 consultas (SELECT) DISTINCT; GROUP BY; INSERT INTO SELECT;
SELECT DISTINCT dataPed, dataEnt, total, frete, numNF, imposto FROM Entrada;
SELECT idSaida, MAX(total) FROM Saida GROUP BY idSaida HAVING MAX(total) > 1000;
SELECT endereco, num, bairro FROM Transportadora ORDER BY 
(CASE WHEN num IS NULL THEN bairro ELSE num END);

-- 02 consultas (SELECT) MAX; COUNT;
SELECT MAX(qtde) AS MaiorQtde FROM ItemEntrada;
SELECT COUNT(idProduto) AS NumeroDeProdutos FROM Produto;

-- 01 consultas (SELECT) AND; OR; NOT; LIKE; IN; BETWEEN; UNION; EXISTS; ANY; ALL;
SELECT * FROM Produto WHERE peso BETWEEN 0.60 AND 2.00;

-- 01 gatilho (TRIGGER);
DELIMITER $

CREATE TRIGGER Tgr_ItensEntrada_Insert AFTER INSERT
ON ItemEntrada
FOR EACH ROW
BEGIN
	UPDATE Entrada SET total = total - NEW.qtde
WHERE total = NEW.lote;
END$

CREATE TRIGGER Tgr_ItensSaida_Delete AFTER DELETE
ON ItemSaida
FOR EACH ROW
BEGIN
	UPDATE Saida SET total = total + OLD.qtde
WHERE total = OLD.lote;
END$

DELIMITER ;

SHOW TRIGGERS;
