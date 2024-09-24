-- Atividade de banco de dados no schema universidade
-- Uso do JOIN

SET search_path TO universidade;

-- 1.1 Liste o nome das disciplinas que possuem turmas. - INNER JOIN

SELECT DISTINCT nome FROM disciplina d
	JOIN turma t
	USING(cod_disc)
	ORDER BY nome;

-- 1.2 Liste o primeiro nome e sobrenome do estudante e o nome de cada disciplina das turmas que ele está cursando. - INNER JOIN

SELECT * FROM estudante; -- cpf, matricula
SELECT * FROM usuario;   --nome e sobrenome, cpf, maticula
SELECT * FROM cursa;     --matricula, idturma
SELECT * FROM turma;     --coddisc, idturma
SELECT * FROM disciplina; --nome materia, cod_disc

SELECT u.primeiro_nome, u.sobrenome, d.nome
	FROM estudante e
	JOIN usuario u
	USING(cpf)
	JOIN cursa c
	USING(mat_estudante)
	JOIN turma t
	ON (c.id_turma = t.id_turma)
	JOIN disciplina d
	USING (cod_disc);

-- 1.3 Liste o primeiro nome e sobrenome do aluno e o primeiro nome e sobrenome de seu orientador. - INNER JOIN

SELECT * FROM cursa;
SELECT * FROM usuario;   --nome e sobrenome, cpf, maticula
SELECT * FROM plano; --mat_estudante, mat_professor
SELECT * FROM professor; --mat_professor, cpf

SELECT u.primeiro_nome, u.sobrenome, s.primeiro_nome, s.sobrenome
	FROM usuario u
	JOIN estudante e
	USING(cpf)
	JOIN plano l
	USING(mat_estudante)
	JOIN professor p
	USING(mat_professor)
	JOIN usuario s
	ON (s.cpf = p.cpf);

-- 1.4 Considerando todas as turmas, liste o primeiro nome e sobrenome do professor, o
--nome da disciplina que ele está lecionando, além disso liste o primeiro nome e sobrenome
--de todos os alunos cursando essas turmas. - INNER JOIN

SELECT * FROM professor;
SELECT * FROM usuario;
SELECT * FROM leciona; --mat_professor, id_turma
SELECT * FROM disciplina; --cod_disc, nome
SELECT * FROM turma; --id_turma, cod_disc
SELECT * FROM cursa;     --matricula, idturma
SELECT * FROM estudante;

SELECT u.primeiro_nome, u.sobrenome, d.nome, s.primeiro_nome, s.sobrenome
	FROM usuario u
	JOIN professor p
	USING (cpf)
	JOIN leciona l
	USING (mat_professor)
	JOIN turma t
	USING(id_turma)
	JOIN disciplina d
	USING (cod_disc)
	JOIN cursa c
	USING (id_turma)
	JOIN estudante e
	USING (mat_estudante)
	JOIN usuario s
	ON (s.cpf = e.cpf)
	ORDER BY u.sobrenome, d.nome, s.primeiro_nome;

--1.5 Liste o nome da disciplina e o nome do seu pré-requisito. - INNER JOIN
--juntar a tabela com ela mesma

SELECT * FROM disciplina; --cod_disc, nome, pre_req

SELECT d.nome, i.nome
	FROM disciplina d
	JOIN disciplina i
	ON (d.pre_req = i.cod_disc);

--1.6 Liste o primeiro nome e sobrenome do professor e o primeiro nome e sobrenome do seu chefe. - INNER JOIN

SELECT * FROM professor;
SELECT * FROM usuario;
SELECT * FROM departamento; -- chefe

SELECT u.primeiro_nome, u.sobrenome, u.email, s.primeiro_nome, s.sobrenome 
	--u.email só pra ter certeza que são professores diferentes
	FROM professor p
	JOIN usuario u
	USING(cpf)
	JOIN departamento d
	ON (d.cod_depto = p.departamento)
	JOIN professor r
	ON (r.mat_professor = d.chefe)
	JOIN usuario s
	ON (s.cpf = r.cpf);
	


