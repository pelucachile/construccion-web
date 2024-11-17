<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.myconstruccion.models.*" %>
<%@ page import="com.myconstruccion.dao.*" %>
<%@ page import="java.util.List" %>
<%
    Usuario usuario = (Usuario) session.getAttribute("usuario");
    if(usuario == null) {
        response.sendRedirect("index.jsp");
        return;
    }
    
    ObraDAO obraDAO = new ObraDAO();
    List<Obra> obras = obraDAO.getUltimasObras();
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Obras - My Construcción</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
    <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
        <div class="container">
            <a class="navbar-brand" href="#">My Construcción</a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav me-auto">
                    <li class="nav-item">
                        <a class="nav-link" href="dashboard.jsp">Inicio</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link active" href="obras.jsp">Obras</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="clientes.jsp">Clientes</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="ventas.jsp">Ventas</a>
                    </li>
                </ul>
                <ul class="navbar-nav">
                    <li class="nav-item">
                        <span class="nav-link">Bienvenido, <%= usuario.getNombre() %></span>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="logout">Cerrar Sesión</a>
                    </li>
                </ul>
            </div>
        </div>
    </nav>

    <div class="container mt-4">
        <div class="d-flex justify-content-between align-items-center mb-4">
            <h2>Gestión de Obras</h2>
            <button class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#nuevaObraModal">
                Nueva Obra
            </button>
        </div>

        <div class="card">
            <div class="card-body">
                <div class="table-responsive">
                    <table class="table table-striped">
                        <thead>
                            <tr>
                                <th>Nombre</th>
                                <th>Tipo</th>
                                <th>Cliente</th>
                                <th>Estado</th>
                                <th>Presupuesto</th>
                                <th>Acciones</th>
                            </tr>
                        </thead>
                        <tbody>
                            <% if(obras != null && !obras.isEmpty()) { 
                                for(Obra obra : obras) { %>
                                    <tr>
                                        <td><%= obra.getNombre() %></td>
                                        <td><%= obra.getTipoObraNombre() %></td>
                                        <td><%= obra.getClienteNombre() %></td>
                                        <td><%= obra.getEstado() %></td>
                                        <td>$<%= String.format("%,.0f", obra.getPresupuesto()) %></td>
                                        <td>
                                            <button class="btn btn-sm btn-info">Ver</button>
                                            <button class="btn btn-sm btn-warning">Editar</button>
                                        </td>
                                    </tr>
                                <% }
                            } else { %>
                                <tr>
                                    <td colspan="6" class="text-center">No hay obras registradas</td>
                                </tr>
                            <% } %>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>

    <!-- Modal Nueva Obra -->
    <div class="modal fade" id="nuevaObraModal" tabindex="-1">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Nueva Obra</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body">
                    <form id="nuevaObraForm">
                        <div class="mb-3">
                            <label for="nombre" class="form-label">Nombre de la Obra</label>
                            <input type="text" class="form-control" id="nombre" required>
                        </div>
                        <div class="mb-3">
                            <label for="tipo" class="form-label">Tipo de Obra</label>
                            <select class="form-control" id="tipo" required>
                                <option value="">Seleccione...</option>
                                <option value="1">Casa</option>
                                <option value="2">Edificio</option>
                                <option value="3">Remodelación</option>
                            </select>
                        </div>
                        <div class="mb-3">
                            <label for="cliente" class="form-label">Cliente</label>
                            <select class="form-control" id="cliente" required>
                                <option value="">Seleccione...</option>
                                <option value="1">Juan Pérez</option>
                                <option value="2">María González</option>
                            </select>
                        </div>
                        <div class="mb-3">
                            <label for="presupuesto" class="form-label">Presupuesto</label>
                            <input type="number" class="form-control" id="presupuesto" required>
                        </div>
                    </form>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cerrar</button>
                    <button type="button" class="btn btn-primary">Guardar</button>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>