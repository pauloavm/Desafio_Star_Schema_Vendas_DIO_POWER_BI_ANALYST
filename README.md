# Desafio de Modelagem Dimensional: Star Schema para Universidade

Este repositório contém a solução para um desafio de modelagem de dados, cujo objetivo é converter um modelo relacional de um sistema universitário em um modelo dimensional (Star Schema) otimizado para análises de Business Intelligence (BI).

## Objetivo do Desafio

O objetivo principal é criar um diagrama dimensional com foco na análise dos dados de **professores**. A partir de um diagrama relacional existente, foi desenvolvida uma estrutura composta por uma tabela fato e suas respectivas tabelas de dimensão para permitir consultas analíticas sobre as atividades dos professores, como cursos ministrados e departamentos associados.

### Requisitos Principais

* **Foco da Análise:** Professor.
* **Estrutura:** Criação de uma tabela fato e múltiplas tabelas de dimensão.
* **Dimensão de Tempo:** Adição de uma tabela de dimensão de datas, assumindo a existência de dados temporais como data de oferta de disciplinas.
* **Exclusão:** Os dados sobre alunos não fazem parte do escopo deste modelo

## Solução Proposta: Star Schema

A solução implementada é um modelo Star Schema clássico, ideal para performance e simplicidade em consultas analíticas. A estrutura é composta por:

* **Tabela Fato (`Fato_AtividadeProfessor`):** O núcleo do modelo. Cada registro representa uma disciplina ofertada por um professor em um curso e em uma data específica. Contém métricas como `CargaHoraria` e `QtdOfertada`.

* **Tabelas de Dimensão:** Fornecem o contexto descritivo para os dados da tabela fato.
    * `Dim_Tempo`: Detalhes de tempo (dia, mês, ano, semestre, etc.).
    * `Dim_Professor`: Atributos do professor (nome, etc.).
    * `Dim_Departamento`: Informações do departamento (nome, campus, etc.).
    * `Dim_Curso`: Detalhes sobre os cursos.
    * `Dim_Disciplina`: Atributos das disciplinas.

## Estrutura do Banco de Dados (SQL)

O script SQL abaixo cria o banco de dados `universidade_dw` e todas as tabelas do modelo dimensional.

```sql
-- Cria o banco de dados para o Data Warehouse.
CREATE DATABASE IF NOT EXISTS universidade_dw;

-- Seleciona o banco de dados para uso.
USE universidade_dw;

-- Criação da Tabela Dimensão: Tempo
CREATE TABLE Dim_Tempo (
    sk_tempo INT PRIMARY KEY AUTO_INCREMENT,
    DataCompleta DATE NOT NULL,
    Dia INT NOT NULL,
    Mes INT NOT NULL,
    NomeMes VARCHAR(20) NOT NULL,
    Ano INT NOT NULL,
    Trimestre INT NOT NULL,
    Semestre INT NOT NULL,
    DiaDaSemana VARCHAR(20) NOT NULL
);

-- Criação da Tabela Dimensão: Departamento
CREATE TABLE Dim_Departamento (
    sk_departamento INT PRIMARY KEY AUTO_INCREMENT,
    idDepartamento INT,
    Nome VARCHAR(45),
    Campus VARCHAR(45),
    NomeCoordenador VARCHAR(255)
);

-- Criação da Tabela Dimensão: Professor
CREATE TABLE Dim_Professor (
    sk_professor INT PRIMARY KEY AUTO_INCREMENT,
    idProfessor INT,
    NomeProfessor VARCHAR(255)
);

-- Criação da Tabela Dimensão: Curso
CREATE TABLE Dim_Curso (
    sk_curso INT PRIMARY KEY AUTO_INCREMENT,
    idCurso INT,
    NomeCurso VARCHAR(255)
);

-- Criação da Tabela Dimensão: Disciplina
CREATE TABLE Dim_Disciplina (
    sk_disciplina INT PRIMARY KEY AUTO_INCREMENT,
    idDisciplina INT,
    NomeDisciplina VARCHAR(255)
);

-- Criação da Tabela Fato: Atividade do Professor
CREATE TABLE Fato_AtividadeProfessor (
    sk_tempo INT,
    sk_departamento INT,
    sk_professor INT,
    sk_curso INT,
    sk_disciplina INT,
    CargaHoraria INT,
    QtdOfertada INT DEFAULT 1,
    FOREIGN KEY (sk_tempo) REFERENCES Dim_Tempo(sk_tempo),
    FOREIGN KEY (sk_departamento) REFERENCES Dim_Departamento(sk_departamento),
    FOREIGN KEY (sk_professor) REFERENCES Dim_Professor(sk_professor),
    FOREIGN KEY (sk_curso) REFERENCES Dim_Curso(sk_curso),
    FOREIGN KEY (sk_disciplina) REFERENCES Dim_Disciplina(sk_disciplina)
);
