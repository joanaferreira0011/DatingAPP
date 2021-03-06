--Clean tables
DROP TABLE IF EXISTS AnuncioTemplate;
DROP TABLE IF EXISTS TipoAnuncio;
DROP TABLE IF EXISTS Campanha;
DROP TABLE IF EXISTS Anunciante;
DROP TABLE IF EXISTS Interesse;
DROP TABLE IF EXISTS Denuncia;
DROP TABLE IF EXISTS Mensagem;
DROP TABLE IF EXISTS Encontro;
DROP TABLE IF EXISTS Local;
DROP TABLE IF EXISTS Match;
DROP TABLE IF EXISTS Like;
DROP TABLE IF EXISTS ContaFree;
DROP TABLE IF EXISTS ContaPremium;
DROP TABLE IF EXISTS User;
DROP TABLE IF EXISTS Hobby;

--Create tables

CREATE TABLE User(
  idUser INTEGER PRIMARY KEY AUTOINCREMENT,
  userName NVARCHAR(50) NOT NULL UNIQUE ,
  primeiroNome NVARCHAR(50) NOT NULL,
  ultimoNome NVARCHAR(50) NOT NULL,
  genero NVARCHAR(50) NOT NULL,
  password NVARCHAR(50) NOT NULL,
  email NVARCHAR(50) NOT NULL,
  dataNascimento TEXT NOT NULL,
  descricao TEXT NOT NULL,
  idHobby NUMBER REFERENCES Hobby(idHobby)
);

CREATE TABLE Hobby(
  idHobby INTEGER PRIMARY KEY AUTOINCREMENT,
  carros INT DEFAULT 0 CONSTRAINT isBool CHECK(carros=0 OR carros=1),--bool
  tecnologia INT DEFAULT 0 CONSTRAINT isBool CHECK(tecnologia=0 OR tecnologia=1),--bool
  comida INT DEFAULT 0 CONSTRAINT isBool CHECK(comida=0 OR comida=1)--bool
);

CREATE TABLE ContaPremium(
  idUser NUMBER REFERENCES User(idUser),
  dataPagamentoInicio TEXT NOT NULL,
  dataPagamentoProximo TEXT NOT NULL,
  saldo REAL NOT NULL
);

CREATE TABLE ContaFree(
  idContaFree INTEGER PRIMARY KEY AUTOINCREMENT,
  idUser NUMBER REFERENCES User(idUser),
  mesGratisUsado INT DEFAULT 0 CONSTRAINT isBool CHECK(mesGratisUsado=0 OR mesGratisUsado=1)--bool
);

CREATE TABLE Anunciante(
  idAnunciante INTEGER PRIMARY KEY AUTOINCREMENT,
  nome NVARCHAR(50) NOT NULL,
  saldo REAL NOT NULL
);


CREATE TABLE Campanha(
  idCampanha INTEGER PRIMARY KEY AUTOINCREMENT,
  conteudo TEXT NOT NULL,
  dataInicio TEXT NOT NULL,
  dataFim TEXT NOT NULL,
  idAnunciante NUMBER REFERENCES Anunciante(idAnunciante),
  custo REAL NOT NULL
);

CREATE TABLE TipoAnuncio(
  idTipoAnuncio INTEGER PRIMARY KEY AUTOINCREMENT,
  data TEXT NOT NULL,
  campanha NUMBER REFERENCES Campanha(idCampanha),
  interesse NUMBER REFERENCES Interesse(idInteresse)
);

CREATE TABLE Interesse(
  idInteresse INTEGER PRIMARY KEY AUTOINCREMENT,
  nivelInteresse REAL NOT NULL CONSTRAINT isPercentage CHECK(nivelInteresse >=0 AND nivelInteresse <=100)
);

CREATE TABLE AnuncioTemplate(
  idAnuncioTemplate INTEGER PRIMARY KEY AUTOINCREMENT,
  click INT NOT NULL CONSTRAINT isBool CHECK(click=0 OR click=1), --bool
  tipoAnuncio NUMBER REFERENCES TipoAnuncio(idTipoAnuncio),
  contaFree NUMBER REFERENCES ContaFree(idContaFree)
);


CREATE TABLE Like(
  idLike INTEGER PRIMARY KEY AUTOINCREMENT,
  user1 NUMBER REFERENCES User(idUser),
  user2 NUMBER REFERENCES User(idUser),
  data TEXT NOT NULL
);

CREATE TABLE Match(
  idMatch INTEGER PRIMARY KEY AUTOINCREMENT,
  like1 NUMBER REFERENCES Like(idLike),
  like2 NUMBER REFERENCES Like(idLike)
);

CREATE TABLE Local(
  idLocal INTEGER PRIMARY KEY AUTOINCREMENT,
  morada NVARCHAR(50) NOT NULL,
  pais NVARCHAR(50) NOT NULL
);

CREATE TABLE Encontro(
  idEncontro INTEGER PRIMARY KEY AUTOINCREMENT,
  match NUMBER REFERENCES Match(idMatch),
  local NUMBER REFERENCES Local(idLocal),
  data TEXT NOT NULL
);

CREATE TABLE Denuncia(
  idDenuncia INTEGER PRIMARY KEY AUTOINCREMENT,
  mensagem NUMBER REFERENCES Mensagem(idMensagem),
  descricao TEXT NOT NULL,
  data TEXT NOT NULL
);

CREATE TABLE Mensagem(
  idMensagem INTEGER PRIMARY KEY AUTOINCREMENT,
  match NUMBER REFERENCES Match(idMatch),
  remetente NUMBER REFERENCES User(idUser),
  conteudo TEXT NOT NULL,
  data TEXT NOT NULL
);
