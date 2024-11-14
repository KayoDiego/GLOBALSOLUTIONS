-- Tabela Usuário
CREATE TABLE Usuario (
    Id_usuario NUMBER PRIMARY KEY,
    Nome_usuario VARCHAR2(100) NOT NULL,
    Email_usuario VARCHAR2(100) UNIQUE NOT NULL,
    Senha_usuario VARCHAR2(255) NOT NULL
);

-- Tabela Pessoa_Física
CREATE TABLE Pessoa_Fisica (
    Id_usuario NUMBER PRIMARY KEY,
    Nr_rg VARCHAR2(20) NOT NULL,
    Nr_cpf VARCHAR2(11) UNIQUE NOT NULL,
    Dt_nascimento DATE NOT NULL,
    CONSTRAINT FK_PessoaFisica_Usuario FOREIGN KEY (Id_usuario)
        REFERENCES Usuario (Id_usuario)
);

-- Tabela Pessoa_Jurídica
CREATE TABLE Pessoa_Juridica (
    Id_usuario NUMBER PRIMARY KEY,
    Nr_cnpj VARCHAR2(14) UNIQUE NOT NULL,
    Ds_ramo_atividade VARCHAR2(100),
    CONSTRAINT FK_PessoaJuridica_Usuario FOREIGN KEY (Id_usuario)
        REFERENCES Usuario (Id_usuario)
);

-- Tabela Biorreatores
CREATE TABLE Biorreatores (
    Id_biorreator NUMBER PRIMARY KEY,
    Nome_biorreator VARCHAR2(100) NOT NULL,
    Tipo_biorreator VARCHAR2(50) NOT NULL,
    Ds_Localizacao VARCHAR2(100),
    Capacidade NUMBER,
    Dt_instalacao DATE,
    Ds_relatorio CLOB,
    Id_usuario NUMBER,
    CONSTRAINT FK_Biorreatores_Usuario FOREIGN KEY (Id_usuario)
        REFERENCES Usuario (Id_usuario)
);

-- Tabela Substratos
CREATE TABLE Substratos (
    Id_substrato NUMBER PRIMARY KEY,
    Tipo_substrato VARCHAR2(50) NOT NULL,
    Ds_substrato VARCHAR2(100),
    Qtd_substrato NUMBER
);

-- Tabela Biogas_Produzido
CREATE TABLE Biogas_Produzido (
    Id_biogas NUMBER PRIMARY KEY,
    Id_biorreator NUMBER,
    Id_substrato NUMBER,
    Qtd_produzida NUMBER NOT NULL,
    Dt_producao DATE NOT NULL,
    CONSTRAINT FK_Biogas_Biorreator FOREIGN KEY (Id_biorreator)
        REFERENCES Biorreatores (Id_biorreator),
    CONSTRAINT FK_Biogas_Substrato FOREIGN KEY (Id_substrato)
        REFERENCES Substratos (Id_substrato)
);

-- Tabela Manutencao_Biorreator
CREATE TABLE Manutencao_Biorreator (
    Id_manutencao NUMBER PRIMARY KEY,
    Id_biorreator NUMBER,
    Dt_inicial DATE NOT NULL,
    Dt_final DATE,
    Ds_manutencao VARCHAR2(255),
    CONSTRAINT FK_Manutencao_Biorreator FOREIGN KEY (Id_biorreator)
        REFERENCES Biorreatores (Id_biorreator)
);

-- Tabela Aplicacao_Biogas
CREATE TABLE Aplicacao_Biogas (
    Id_aplicacao NUMBER PRIMARY KEY,
    Id_biogas NUMBER,
    Qtd_produzida NUMBER NOT NULL,
    Ds_aplicacao VARCHAR2(255),
    Ds_relatorio CLOB,
    Dt_relatorio DATE,
    CONSTRAINT FK_Aplicacao_Biogas FOREIGN KEY (Id_biogas)
        REFERENCES Biogas_Produzido (Id_biogas)
);

-- Tabela Compensacao
CREATE TABLE Compensacao (
    Id_compensacao NUMBER PRIMARY KEY,
    Qtd_produzida NUMBER NOT NULL,
    Dt_producao DATE NOT NULL,
    Dt_compensacao DATE,
    Ds_compensacao VARCHAR2(255),
    CONSTRAINT FK_Compensacao_Biogas FOREIGN KEY (Qtd_produzida, Dt_producao)
        REFERENCES Biogas_Produzido (Qtd_produzida, Dt_producao) -- Isso precisa ser ajustado
);

-- Tabela para Relacionamento N:M entre Substratos e Biogas_Produzido
CREATE TABLE Substrato_Biogas (
    Id_substrato NUMBER,
    Id_biogas NUMBER,
    PRIMARY KEY (Id_substrato, Id_biogas),
    CONSTRAINT FK_Substrato_Biogas_Substrato FOREIGN KEY (Id_substrato)
        REFERENCES Substratos (Id_substrato),
    CONSTRAINT FK_Substrato_Biogas_Biogas FOREIGN KEY (Id_biogas)
        REFERENCES Biogas_Produzido (Id_biogas)
);