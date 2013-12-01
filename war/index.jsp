<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%@ page import="java.util.List,com.hackathon.comparadorloa.FuncaoBean" %>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>Comparador LOA</title>
<link rel="stylesheet" type="text/css" href="grid/grid.css"/>

<link rel="stylesheet" type="text/css" href="dist/css/bootstrap-theme.css"/>
<link rel="stylesheet" type="text/css" href="dist/css/bootstrap-theme.min.css"/>
<link rel="stylesheet" type="text/css" href="dist/css/bootstrap.css"/>
<link rel="stylesheet" type="text/css" href="dist/css/bootstrap.min.css"/>
<link rel="icon" type="image/x-icon" href="favicon.png" />

<script type="text/javascript">
function makeVisible(id) {
	var element = document.getElementById(id);
	element.style.visibility = "visible";
	element.style.display = "block";
}
function makeClean(id) {
	var element = document.getElementById(id);
	element.style.visibility = "hidden";
	element.style.display = "none";
}
</script>
<style type="text/css">
#resultado-category-01,
#resultado-category-02{
	visibility:hidden;
	display:none;	
}
</style>
</head>

<body class="bg-pattern">
<div class="container">
<header>
<div class="col-md-7 col-md-offset-2 title text-center item">
<h1><span class="logo-comparador" title="JusBrasil | Comparador LOA">Comparador LOA</span></h1>
<div class="text">Bem vindo ao <strong>Comparador LOA</strong>, a mais nova ferramenta de comparação<br />
dos valores gastos entre as areas e sub areas do governo federal.</div>
</div>
</header>
<section class="text-center">
<!-- CONTAINER - PRIMEIRO ITEM -->
<div class="col-md-7 col-md-offset-2 item">
<div>Selecione as areas que deseja comparar.</div>
<div class="col-md-7">
<div class="title-topic">Selecione a primeira area.</div>
<div class="row">
<div class="col-md-8">
<select class="form-control" name="category-primary" size="1" id="category-primary">
  <% FuncaoBean funcaoBean = (FuncaoBean) request.getAttribute("FuncaoBean");
  List<String> funcoes = funcaoBean.getFuncoes();
  for(String funcao : funcoes) {
    out.println("<option>"+funcao+"</option>");
  }
  %>
</select>
</div>
<div class="col-md-3">
<span class="instructions">
<  Função  >
</span>
</div>
</div>
<div class="row">
<div class="col-md-8">
<select class="form-control" name="category-secondory" size="1" id="category-second">
  <option>Assistencia Geral</option>
  <option>Contabilidade e Planejamento</option>
</select>
</div>
<div class="col-md-3">
<span class="instructions">
< Sub-Função  >
</span>
</div>
</div>
</div>
<!-- CONTAINER - SEGUNDO ITEM -->
<div class="col-md-5">
<div class="title-topic">Selecione a segunda area.</div>
<div class="row">
<div class="col-md-12">
<select class="form-control" name="category-primary" size="1" id="category-primary">
  <% 
  for(String funcao : funcoes) {
    %><option><%= funcao %></option><%
  }
  %>
</select>
</div>
</div>
<div class="row">
<div class="col-md-12">
<select class="form-control" name="category-primary" size="1" id="category-primary">
  <option>Administracao</option>
  <option>Saude</option>
</select>
</div>
</div>
</div>
</div>
<!--PERIODO DE COMPARAÇÃO-->
<div class="col-md-7 col-md-offset-2 item">
<div>Selecione o período.</div>
<div class="col-md-3 col-md-offset-2">
<div class="title-topic">De:</div>
<select class="form-control" name="category-tertiary" size="1" id="category-second">
  <option>2010</option>
  <option>2011</option>
</select>
</div>
<div class="col-md-3 col-md-offset-2">
<div class="title-topic">Até:</div>
<select class="form-control" name="category-tertiary" size="1" id="category-second">
  <option>2010</option>
  <option>2011</option>
</select>
</div>
</div>
<div class="col-md-7 col-md-offset-3">
<div id="resultado-category-01" class="col-md-5 col-md-offset">
<div class="title-topic">Valor:</div>
<input type="text" value="R$0" class="text-danger" disabled="disabled"></input>
</div>
<div id="resultado-category-02" class="col-md-5 col-md-offset-2">
<div class="title-topic">Valor:</div>
<input type="text" value="R$0" class="text-danger" disabled="disabled"></input>
</div>
</div>
<div class="col-md-7 col-md-offset-3">
<button class="btn btn-success" onclick="makeVisible('resultado-category-01');makeVisible('resultado-category-02')" type="button">Comparar</button>
<button class="btn btn-danger col-md-offset-1" onclick="makeClean('resultado-category-01');makeClean('resultado-category-02')" type="button">Limpar</button>
</div>
</section>
<footer>
</footer>
</div>
</body>
</html>
