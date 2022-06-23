<%@ page import="java.util.ArrayList"%>
<%@ page import="br.com.officecleantech.model.entidade.Usuario"%>
<%@ page import="br.com.officecleantech.controller.ProdutoController" %>
<%@ page import="br.com.officecleantech.controller.FornecedorController" %>
<%@ page import="br.com.officecleantech.model.entidade.Fornecedor" %>
<%@ page import="br.com.officecleantech.model.entidade.Produto" %>
<%@ page import="java.util.ArrayList" %>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link
	href="https://fonts.googleapis.com/css2?family=Nunito:ital,wght@0,300;0,400;0,500;0,600;0,700;1,600&display=swap"
	rel="stylesheet">
<title>Dashboard - OCT</title>
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.1/css/all.min.css"
	integrity="sha512-KfkfwYDsLkIlwQp6LFnl8zNdLGxu9YAA1QvwINks4PhcElQSvqcyVLLD9aMhXd13uQjoXtEKNosOWaZqXgel0g=="
	crossorigin="anonymous" referrerpolicy="no-referrer" />
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.1/css/all.min.css"
	integrity="sha512-KfkfwYDsLkIlwQp6LFnl8zNdLGxu9YAA1QvwINks4PhcElQSvqcyVLLD9aMhXd13uQjoXtEKNosOWaZqXgel0g=="
	crossorigin="anonymous" referrerpolicy="no-referrer" />
<!-- CSS only -->
<!-- JavaScript Bundle with Popper -->
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/js/bootstrap.bundle.min.js"
	integrity="sha384-pprn3073KE6tl6bjs2QrFaJGz5/SUsLqktiwsUTF55Jfv3qYSDhgCecCxMW52nD2"
	crossorigin="anonymous"></script>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-0evHe/X+R7YkIZDRvuzKMRqM+OrBnVFBL6DOitfPri4tjfHxaWutUpFmBp4vmVor"
	crossorigin="anonymous">
<link rel="stylesheet" href="./css/style.css">
<!-- Scrollbar Custom CSS -->
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/malihu-custom-scrollbar-plugin/3.1.5/jquery.mCustomScrollbar.min.css">
</head>
<body>
	<!-- tratamento login -->
	<%
	if (session.getAttribute("usuarioLogado") == null) {
		RequestDispatcher rd = request.getRequestDispatcher("login.jsp");
		rd.forward(request, response);
	}
	Usuario u = (Usuario) session.getAttribute("usuarioLogado");
	%>
	<!-- fim tratamento login-->
	<div class="wrapper">
		<!-- Sidebar -->
		<nav id="sidebar">
			<div class="sidebar-header">
				<a href="#"> <img src="./img/oct.png"
					alt="Logo Office Clean Tech" style="height: 60px;">
				</a>
			</div>
			<ul class="list-unstyled components">

				<li>
					<div class="icons-menu">
						<i class="fa-solid fa-box-archive"></i> <a href="#">Produtos</a>
					</div>
				</li>
				<li><a href="#pageSubmenu" data-toggle="collapse"
					aria-expanded="false" class="dropdown-toggle ">Relat�rios</a>
					<ul class="collapse list-unstyled" id="pageSubmenu">
						<li>
							<div class="icons-menu">
								<i class="fa-solid fa-arrow-up"></i> <a href="relatorio_entrada.jsp">Entrada</a>
							</div>
						</li>
						<li>
							<div class="icons-menu">
								<i class="fa-solid fa-arrow-down"></i> <a href="relatorio_saida.jsp">Sa�da</a>
							</div>
						</li>
					</ul></li>
				<li>
					<div class="icons-menu">
						<i class="fa-solid fa-users"></i> <a href="fornecedores.jsp">Fornecedores</a>
					</div>
				</li>
				<li>
					<div class="icons-menu">
						<i class="fa-solid fa-user-plus"></i> <a href="usuarios.jsp">Usu�rios</a>
					</div>
				</li>
				<li id="li-logoff">
					<div class="icons-menu logoff">
						<i class="fa-solid fa-power-off"></i> <a href="LogoffServlet">Sair</a>
					</div>
				</li>
			</ul>
		</nav>
		<!-- Fim Sidebar -->
		<main id="content">
			<!-- Menu -->
			<nav class="navbar navbar-expand-lg navbar-light bg-light">
				<div class="container-fluid">
					<button type="button" id="sidebarCollapse" class="btn text-white"
						style="background-color: #77B800;">
						<i class="fas fa-align-left"></i> <span>Menu</span>
					</button>
				</div>
			</nav>
			<!-- Fim Menu -->
			<!-- Large modal -->
			<header
				class="d-flex align-items-center gap-4 justify-content-between"
				id="header__btn">
				<button type="button" class="btn text-white" data-toggle="modal"
					data-target="#exampleModal" data-whatever="@mdo"
					style="background-color: #2678D1;" id="btnProduto">Adicionar
					Produto</button>
				<div class="search-container">
					<%
						String nomeBuscar = request.getParameter("nomeBuscar");
					
						if(nomeBuscar == null) {
							nomeBuscar = "";
						}
					%>
					<form action="" method="post">
						<input type="text" placeholder="Buscar produto" name="nomeBuscar" value="<%= nomeBuscar %>">
						<button type="submit">
							<i class="fa fa-search"></i>
						</button>
					</form>
				</div>
			</header>
			<!-- Modal de Produto -->
			<div class="modal fade" id="exampleModal" tabindex="-1" role="dialog"
				aria-labelledby="exampleModalLabel" aria-hidden="true">
				<div class="modal-dialog modal-lg" role="document">
					<div class="modal-content">
						<div class="modal-header" style="border: 0;">
							<h5 class="modal-title" id="exampleModalLabel"></h5>
							<button type="button" class="close text-white"
								data-dismiss="modal" aria-label="Close"
								style="background-color: red; border: none; border-radius: 8px; padding: 5px 10px;">
								<span aria-hidden="true" class="">&times;</span>
							</button>
						</div>
						<div class="modal-body">
							<form class="" method="post" action="ProdutoServlet">
								<div class="form-group d-flex gap-4 mb-2 flex-row columnInput">
									<input type="number" class="form-control shadow-none"
										id="recipient-name" name="codigoBarra" placeholder="C�digo do produto"> <input
										type="text" class="form-control shadow-none"
										id="recipient-name" name="nome" placeholder="Nome do produto">
								</div>
								<div class="form-group d-flex gap-4 mb-2 flex-row columnInput">
									<!--  <input type="number" class="form-control shadow-none"
										id="recipient-name" placeholder="Valor Unidade">--> <select
										class="form-select shadow-none"
										aria-label="Default select example"
										style="padding: 0.375rem 0.75rem" name="catgoria">
										<option selected>Categoria</option>
										<option value="Equipamentos de Limpeza">Equipamentos de Limpeza</option>
										<option value="Acess�rios de Limpeza">Acess�rios de Limpeza</option>
										<option value="Produtos Qu�micos de Limpeza">Produtos Qu�micos de Limpeza</option>
										<option value="Pap�is">Pap�is</option>
									</select>
								</div>
								<div class="form-group d-flex gap-4 mb-2 flex-row columnInput">
									<!-- <input type="text" class="form-control shadow-none"
										id="recipient-name" placeholder="Estoque Atual"> --> <select
										class="form-select shadow-none"
										aria-label="Default select example"
										style="padding: 0.375rem 0.75rem" name="fornecedor">
										<option selected>Fornecedor</option>
										<%
											FornecedorController fcontroller = new FornecedorController();
											ArrayList<Fornecedor> flista = fcontroller.listar(nomeBuscar);
											
											for(Fornecedor f : flista) {
										%>
										<option value="<%= f.getId() %>"><%= f.getId() %> - <%= f.getNome() %></option>
										<% } %>
									</select>
								</div>
								<div class="form-group d-flex gap-4 mb-2 flex-row columnInput">
									<input type="text" class="form-control shadow-none"
										id="recipient-name" name="descricao" placeholder="Descri��o"> <!-- <input
										type="text" class="form-control shadow-none"
										id="recipient-name" placeholder="Localiza��o">-->
								</div>
								<div class="form-group d-flex gap-3 mb-2 flex-row">
									<input type="text" class="form-control shadow-none"
										id="recipient-name" name="estoqueMaximo" placeholder="Quantidade M�xima"> <input
										type="text" class="form-control shadow-none"
										id="recipient-name" name="estoqueMinimo" placeholder="Quantidade M�nima">
								</div>
								<div class="modal-footer">
									<button type="submit" class="btn text-white"
										style="background-color: #77B800;">Salvar Produto</button>
								</div>
							</form>
						</div>
					</div>
				</div>
			</div>
			<!-- Fim Modal de Produto -->
			<div
				class="table-responsive table-wrapper-scroll-y my-custom-scrollbar"
				style="margin-top: 40px; border-radius: 8px; box-shadow: 0px 4px 4px rgba(0, 0, 0, 0.15);">
				<table class="table">
					<thead
						style="box-shadow: 0px 4px 4px rgb(0 0 0/ 5%); border-radius: 8px;">
						<tr>
							<th scope="col">C�digo</th>
							<th scope="col">Nome</th>
							<th scope="col">Categoria</th>
							<th scope="col">Fornecedor</th>
							<th scope="col">Descri��o</th>
							<th scope="col">Estoque M�ximo</th>
							<th scope="col">Estoque M�nimo</th>
							<th scope="col">A��es</th>
						</tr>
					</thead>
					<tbody>
						<%
							ProdutoController controller = new ProdutoController();
							ArrayList<Produto> lista = controller.listar(nomeBuscar);
							
							
							Fornecedor f = new Fornecedor();
							
							for(Produto p : lista) {
						%>
						<tr>
							<th scope="row"><%= p.getCodigoBarra() %></th>
							<td><%= p.getNome() %></td>
							<td><%= p.getCategoria() %></td>
							<td><%= p.getFornecedor().getId() %> - <%= p.getFornecedor().getNome() %></td>
							<td><%= p.getDescricao() %></td>
							<td><%= p.getEstoqueMaximo() %></td>
							<td><%= p.getEstoqueMinimo() %></td>
							<td>
								<div class="d-flex gap-2">
									<div class="text-primary" data-toggle="modal"
										data-target="#exampleModal">
										<a href="InicioAlterarProduto?codigoBarra=<%= p.getCodigoBarra() %>"><i class="fa-solid fa-pen-to-square"></i></a>
									</div>
									<div class="text-danger">
										<a href="ExcluirProduto?codigoBarra=<%= p.getCodigoBarra() %>" onclick="return confirm('Deseja excluir esse registro?')"><i class="fa-solid fa-xmark"></i>
									</div>
								</div>
							</td>
						</tr>
						<% } %>
						<!--  <tr>
							<th scope="row">679432</th>
							<td>Cell</td>
							<td>Cell</td>
							<td>Cell</td>
							<td>
								<div class="d-flex gap-2">
									<div class="text-primary" data-toggle="modal"
										data-target="#exampleModal">
										<i class="fa-solid fa-pen-to-square"></i>
									</div>
									<div class="text-danger">
										</i><i class="fa-solid fa-xmark"></i>
									</div>
								</div>
							</td>
						</tr>-->
					</tbody>
				</table>
			</div>
		</main>
		<!-- jQuery CDN - Slim version (=without AJAX) -->
		<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"
			integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo"
			crossorigin="anonymous"></script>
		<!-- Popper.JS -->
		<script
			src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.0/umd/popper.min.js"
			integrity="sha384-cs/chFZiN24E4KMATLdqdvsezGxaGsi4hLGOzlXwp5UZB1LY//20VyM2taTB4QvJ"
			crossorigin="anonymous"></script>
		<!-- Bootstrap JS -->
		<script
			src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.0/js/bootstrap.min.js"
			integrity="sha384-uefMccjFJAIv6A+rW+L4AHf99KvxDjWSu1z9VI8SKNVmz4sk7buKt/6v9KI65qnm"
			crossorigin="anonymous"></script>
		<!-- jQuery Custom Scroller CDN -->
		<script
			src="https://cdnjs.cloudflare.com/ajax/libs/malihu-custom-scrollbar-plugin/3.1.5/jquery.mCustomScrollbar.concat.min.js"></script>
		<script type="text/javascript">
			$(document).ready(function() {
				$("#sidebar").mCustomScrollbar({
					theme : "minimal"
				});
				$('#sidebarCollapse').on('click', function() {
					$('#sidebar, #content').toggleClass('active');
					$('.collapse.in').toggleClass('in');
					$('a[aria-expanded=true]').attr('aria-expanded', 'false');
				});
			});
		</script>
</body>
</html>