﻿<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%@ page import="java.util.List,com.hackathon.comparadorloa.Funcao" %>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="viewport" content="width=device-width, user-scalable=no">
<title>Comparador LOA</title>
<link rel="stylesheet" type="text/css" href="grid/grid.css"/>
<link rel="stylesheet" type="text/css" href="dist/css/bootstrap-theme.css"/>
<link rel="stylesheet" type="text/css" href="dist/css/bootstrap-theme.min.css"/>
<link rel="stylesheet" type="text/css" href="dist/css/bootstrap.css"/>
<link rel="stylesheet" type="text/css" href="dist/css/bootstrap.min.css"/>
<link rel="icon" type="image/x-icon" href="favicon.png" />

<script type="text/javascript" src="js/index.js"></script>
<style type="text/css">
#resultado-category-01,
#resultado-category-02,
#resultado-category-03,
#carregando, #dark{
	visibility:hidden;
	display:none;	
}
</style>
</head>

<body class="bg-pattern">
<div id="carregando">
Carregando
</div>
<div id="dark">
</div>
<header class="container">
<div class="col-md-7 col-md-offset-2 title text-center item">
<h1><span class="logo-comparador" title="JusBrasil | Comparador LOA"alt="Logo JusBrasil | Comparador LOA">Comparador LOA</span></h1>
<div class="text">Bem vindo ao <strong>Comparador LOA</strong>(<em>Lei Orçamentária Anual</em>), a mais nova ferramenta de comparação<br />
dos valores gastos entre as áreas e sub áreas do governo federal.<br />
<a href="http://www.jusbrasil.com.br/topicos/322848/lei-orcamentaria-anual">Clique aqui para saber mais sobre o <strong>LOA</strong>.</a></div>
</div>
</header>
<section class="container text-center">
<!-- CONTAINER - PRIMEIRO ITEM -->
<div class="col-md-7 col-md-offset-2 item">
<h4>Selecione as áreas que deseja comparar.</h4>
<div class="col-md-7">
<div class="title-topic">Selecione a primeira área.</div>
<div class="row">
<div class="col-md-8">
<select class="form-control" name="category-primary" size="1" id="first-category-primary" onchange="loadSubfuncoes('first-category-second', this)">
  <option value="0">Selecione área</option>
  <% List<Funcao> funcoes = (List<Funcao>) request.getAttribute("Funcoes");
  for(Funcao funcao : funcoes) {
    out.println("<option value=\""+funcao.id+"\">"+funcao.name+"</option>");
  }
  %>
</select>
</div>
<div class="col-md-4">
<span class="instructions" title="Função é o que a área exerce.">
<  Função  >
</span>
</div>
</div>
<div class="row">
<div class="col-md-8">
<select class="form-control" name="category-secondory" size="1" id="first-category-second">
	<option value="0">Nenhuma subfunção</option>
</select>
</div>
<div class="col-md-4">
<span class="instructions" title="Sub-função é o que a sub área exerce.">
< Sub-Função  >
</span>
</div>
</div>
</div>
<!-- CONTAINER - SEGUNDO ITEM -->
<div class="col-md-5">
<div class="title-topic text-center">Selecione a segunda área.</div>
<div class="col-md-11 col-md-offset-1">
<select class="form-control" name="category-primary" size="1" id="second-category-primary" onchange="loadSubfuncoes('second-category-second', this)">
  <option value="0">Selecione área</option>
  <% 
  for(Funcao funcao : funcoes) {
    out.println("<option value=\""+funcao.id+"\">"+funcao.name+"</option>");
  }
  %>
</select>
</div>
<div class="col-md-11 col-md-offset-1">
<select class="form-control" name="category-primary" size="1" id="second-category-second">
	<option value="0">Nenhuma subfunção</option>
</select>
</div>
</div>
</div>
<!--PERIODO DE COMPARAÇÃO-->
<div class="col-md-7 col-md-offset-2 item">
<h4>Selecione o período.</h4>
<div class="col-md-3 col-md-offset-3">
<div class="title-topic">Janeiro de:</div>
<select class="form-control" name="category-tertiary" size="1" id="first-category-third">
  <option value="0">----</option>
  <% List<String> anos = (List<String>) request.getAttribute("Anos");
  for(String ano: anos)
  	out.println("<option>"+ano+"</option>");
  %>
</select>
</div>
<div class="col-md-3">
<div class="title-topic">Até Dezembro de:</div>
<select class="form-control" name="category-tertiary" size="1" id="second-category-third">
  <option value="0">----</option>
  <% 
  for(String ano: anos)
  	out.println("<option>"+ano+"</option>");
  %>
</select>
</div>
</div>
<!--RESULTADOS DA COMPARAÇÃO-->
<div class="col-md-7 col-md-offset-2">
<div class="row">
<div id="resultado-category-01" class="col-md-5 col-md-offset-1">
<strong><div class="title-topic text-center" id="gasto-total1">Gasto Total:</div></strong>
<input type="text" value="R$0" class="text-danger" disabled="disabled" id="valor1" maxlength="25"></input>
</div>
<div id="resultado-category-02" class="col-md-6">
<strong><div class="title-topic text-center" id="gasto-total2">Gasto Total:</div></strong>
<input type="text" value="R$0" class="text-danger" disabled="disabled" id="valor2" maxlength="25"></input>
</div>
<div id="resultado-category-03" class="col-md-8 col-md-offset-2">
<div class="title-topic text-center"><strong>A diferença:</strong></div>
<input type="text" value="R$0" class="text-danger" disabled="disabled" id="valor3" maxlength="25"></input>
</div>
</div>
</div>
<!--BOTÃO - COMPARAR-->
<a name="resultado"></a>
<div class="col-md-7 col-md-offset-2">
<button class="btn btn-success" onclick="if(verificarCampos()){comparar()}" type="button" title="Clique para comparar os valores gastos no orçamento federal.">Comparar</button>
<button class="btn btn-danger col-md-offset-1" onclick="clearForm();" type="button" title="Clique para limpar os resultados.">Limpar</button>
</div>
</section>
<footer>
</footer>
</body>
</html>
