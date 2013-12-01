<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%@ page import="java.util.List,com.hackathon.comparadorloa.Funcao" %>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Comparador LOA</title>
<link rel="stylesheet" type="text/css" href="grid/grid.css"/>

<link rel="stylesheet" type="text/css" href="dist/css/bootstrap-theme.css"/>
<link rel="stylesheet" type="text/css" href="dist/css/bootstrap-theme.min.css"/>
<link rel="stylesheet" type="text/css" href="dist/css/bootstrap.css"/>
<link rel="stylesheet" type="text/css" href="dist/css/bootstrap.min.css"/>
<script type="text/javascript" charset="utf-8">
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
function loadSubfuncoes(id, combobox)
{
var xmlhttp;
if (window.XMLHttpRequest)
  {// code for IE7+, Firefox, Chrome, Opera, Safari
  xmlhttp=new XMLHttpRequest();
  }
else
  {// code for IE6, IE5
  xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
  }
xmlhttp.onreadystatechange=function()
  {
  if (xmlhttp.readyState==4 && xmlhttp.status==200)
    {
    document.getElementById(id).innerHTML=xmlhttp.responseText;
    
    }
  }
xmlhttp.open("GET","subfuncao?Funcao="+combobox.value,true);
xmlhttp.send();
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
<div class="col-md-7 col-md-offset-3 title text-center item">
<h1><span class="logo-comparador">Comparador LOA</span></h1>
</div>
</header>
<section class="text-center">
<!-- CONTAINER - PRIMEIRO ITEM -->
<div class="col-md-7 col-md-offset-3 item">
<div>Escolha as areas que deseja comparar.</div>
<div class="col-md-5 col-md-offset">
Selecione a primeira area.
<div>
<select class="form-control" name="category-primary" size="1" id="category-primary" onchange="loadSubfuncoes('first-category-second', this)">
  <% List<Funcao> funcoes = (List<Funcao>) request.getAttribute("Funcoes");
  for(Funcao funcao : funcoes) {
    out.println("<option value=\""+funcao.id+"\">"+funcao.name+"</option>");
  }
  %>
</select>
</div>
<div>
<select class="form-control" name="category-secondory" size="1" id="first-category-second">
</select>
</div>
<div>
<select class="form-control" name="category-tertiary" size="1" id="category-second">
  <option>2010</option>
  <option>2011</option>
</select>
</div>
</div>
<!-- CONTAINER - SEGUNDO ITEM -->
<div class="col-md-5 col-md-offset-2">
Selecione a segunda area.
<div>
<select class="form-control" name="category-primary" size="1" id="category-primary" onchange="loadSubfuncoes('second-category-second', this)">
  <% 
  for(Funcao funcao : funcoes) {
    out.println("<option value=\""+funcao.id+"\">"+funcao.name+"</option>");
  }
  %>
</select>
</div>
<div>
<select class="form-control" name="category-secondory" size="1" id="second-category-second">
</select>
</div>
<div>
<select class="form-control" name="category-tertiary" size="1" id="category-second">
  <option>2010</option>
  <option>2011</option>
</select>
</div>
</div>
</div>
<!--RESULTADOS DA COMPARA����O-->
<div class="col-md-7 col-md-offset-3">
<div id="resultado-category-01" class="col-md-5 col-md-offset">
Valor:
<input type="text" value="Resultado" class="text-danger"></input>
</div>
<div id="resultado-category-02" class="col-md-5 col-md-offset-2">
Valor:
<input type="text" value="Resultado" class="text-danger"></input>
</div>
</div>
<!--BOT��O - COMPARAR-->
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
