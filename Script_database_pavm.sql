
CREATE DATABASE IF NOT EXISTS universidade_dw;

USE universidade_dw;

CREATE TABLE Dim_Tempo (
    sk_tempo INT PRIMARY KEY AUTO_INCREMENT, -- Chave Primária da Dimensão (Surrogate Key)
    DataCompleta DATE NOT NULL,
    Dia INT NOT NULL,
    Mes INT NOT NULL,
    NomeMes VARCHAR(20) NOT NULL,
    Ano INT NOT NULL,
    Trimestre INT NOT NULL,
    Semestre INT NOT NULL,
    DiaDaSemana VARCHAR(20) NOT NULL
);


CREATE TABLE Dim_Departamento (
    sk_departamento INT PRIMARY KEY AUTO_INCREMENT,
    idDepartamento INT,
    Nome VARCHAR(45),
    Campus VARCHAR(45),
    NomeCoordenador VARCHAR(255)
);

CREATE TABLE Dim_Professor (
    sk_professor INT PRIMARY KEY AUTO_INCREMENT,
    idProfessor INT,
    NomeProfessor VARCHAR(255)
);

CREATE TABLE Dim_Curso (
    sk_curso INT PRIMARY KEY AUTO_INCREMENT,
    idCurso INT,
    NomeCurso VARCHAR(255)
);

CREATE TABLE Dim_Disciplina (
    sk_disciplina INT PRIMARY KEY AUTO_INCREMENT,
    idDisciplina INT,
    NomeDisciplina VARCHAR(255)
);


CREATE TABLE Fato_AtividadeProfessor (
    sk_tempo INT,
    sk_departamento INT,
    sk_professor INT,
    sk_curso INT,
    sk_disciplina INT,

    -- Métricas (dados a serem analisados)
    CargaHoraria INT,
    QtdOfertada INT DEFAULT 1,

    -- Definição das conexões (Foreign Key Constraints)
    FOREIGN KEY (sk_tempo) REFERENCES Dim_Tempo(sk_tempo),
    FOREIGN KEY (sk_departamento) REFERENCES Dim_Departamento(sk_departamento),
    FOREIGN KEY (sk_professor) REFERENCES Dim_Professor(sk_professor),
    FOREIGN KEY (sk_curso) REFERENCES Dim_Curso(sk_curso),
    FOREIGN KEY (sk_disciplina) REFERENCES Dim_Disciplina(sk_disciplina)
);

SELECT 'Banco de dados universidade_dw e tabelas criados com sucesso!' AS Status;

SHOW tables;