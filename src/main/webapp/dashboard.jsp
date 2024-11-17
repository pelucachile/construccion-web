<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.myconstruccion.models.*" %>
<%@ page import="com.myconstruccion.dao.*" %>
<%@ page import="java.util.List" %>
<%
    // Verificación de sesión
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
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.7.2/font/bootstrap-icons.css">
    <style>
        .card {
            box-shadow: 0 0.125rem 0.25rem rgba(0, 0, 0, 0.075);
        }
        .table td, .table th {
            vertical-align: middle;
        }
        .estado-badge {
            font-size: 0.875rem;
            padding: 0.5em 0.75em;
        }
    </style>
</head>
<body class="bg-light">
    <!-- Navbar -->
    <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
        <div class="container">
            <a class="navbar-brand" href="#">
                <i class="bi bi-buildings"></i> My Construcción
            </a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav me-auto">
                    <li class="nav-item">
                        <a class="nav-link" href="dashboard.jsp">
                            <i class="bi bi-house-door"></i> Inicio
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link active" href="Obras.jsp">
                            <i class="bi bi-building"></i> Obras
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="Clientes.jsp">
                            <i class="bi bi-people"></i> Clientes
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="Ventas.jsp">
                            <i class="bi bi-cart"></i> Ventas
                        </a>
                    </li>
                </ul>
                <ul class="navbar-nav">
                    <li class="nav-item dropdown">
                        <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" 
                           data-bs-toggle="dropdown" aria-expanded="false">
                            <i class="bi bi-person-circle"></i> <%= usuario.getNombre() %>
                        </a>
                        <ul class="dropdown-menu dropdown-menu-end" aria-labelledby="navbarDropdown">
                            <li><a class="dropdown-item" href="#">Mi Perfil</a></li>
                            <li><hr class="dropdown-divider"></li>
                            <li><a class="dropdown-item" href="logout">Cerrar Sesión</a></li>
                        </ul>
                    </li>
                </ul>
            </div>
        </div>
    </nav>

    <!-- Contenido Principal -->
    <div class="container mt-4">
        <!-- Encabezado -->
        <div class="d-flex justify-content-between align-items-center mb-4">
            <h2><i class="bi bi-building"></i> Gestión de Obras</h2>
            <button class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#nuevaObraModal">
                <i class="bi bi-plus-lg"></i> Nueva Obra
            </button>
        </div>

        <!-- Filtros -->
        <div class="card mb-4">
            <div class="card-body">
                <form class="row g-3">
                    <div class="col-md-3">
                        <label class="form-label">Estado</label>
                        <select class="form-select">
                            <option value="">Todos</option>
                            <option>En Proyecto</option>
                            <option>En Construcción</option>
                            <option>Finalizada</option>
                        </select>
                    </div>
                    <div class="col-md-3">
                        <label class="form-label">Tipo de Obra</label>
                        <select class="form-select">
                            <option value="">Todos</option>
                            <option>Casa</option>
                            <option>Edificio</option>
                            <option>Remodelación</option>
                        </select>
                    </div>
                    <div class="col-md-4">
                        <label class="form-label">Buscar</label>
                        <input type="text" class="form-control" placeholder="Nombre de obra o cliente...">
                    </div>
                    <div class="col-md-2 align-self-end">
                        <button type="submit" class="btn btn-primary w-100">
                            <i class="bi bi-search"></i> Buscar
                        </button>
                    </div>
                </form>
            </div>
        </div>

        <!-- Tabla de Obras -->
        <div class="card">
            <div class="card-body">
                <div class="table-responsive">
                    <table class="table table-hover">
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
                                        <td>
                                            <span class="badge bg-primary estado-badge">
                                                <%= obra.getEstado() %>
                                            </span>
                                        </td>
                                        <td>$<%= String.format("%,.0f", obra.getPresupuesto()) %></td>
                                        <td>
                                            <button class="btn btn-sm btn-info">
                                                <i class="bi bi-eye"></i> Ver
                                            </button>
                                            <button class="btn btn-sm btn-warning">
                                                <i class="bi bi-pencil"></i> Editar
                                            </button>
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
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">
                        <i class="bi bi-building-add"></i> Nueva Obra
                    </h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body">
                    <form id="nuevaObraForm" class="row g-3">
                        <div class="col-md-6">
                            <label class="form-label">Nombre de la Obra</label>
                            <input type="text" class="form-control" required>
                        </div>
                        <div class="col-md-6">
                            <label class="form-label">Tipo de Obra</label>
                            <select class="form-select" required>
                                <option value="">Seleccione...</option>
                                <option>Casa</option>
                                <option>Edificio</option>
                                <option>Remodelación</option>
                            </select>
                        </div>
                        <div class="col-md-6">
                            <label class="form-label">Cliente</label>
                            <select class="form-select" required>
                                <option value="">Seleccione...</option>
                                <option>Juan Pérez</option>
                                <option>María González</option>
                            </select>
                        </div>
                        <div class="col-md-6">
                            <label class="form-label">Presupuesto</label>
                            <div class="input-group">
                                <span class="input-group-text">$</span>
                                <input type="number" class="form-control" required>
                            </div>
                        </div>
                        <div class="col-md-12">
                            <label class="form-label">Dirección</label>
                            <input type="text" class="form-control" required>
                        </div>
                        <div class="col-md-6">
                            <label class="form-label">Fecha Inicio</label>
                            <input type="date" class="form-control" required>
                        </div>
                        <div class="col-md-6">
                            <label class="form-label">Fecha Fin Estimada</label>
                            <input type="date" class="form-control" required>
                        </div>
                        <div class="col-12">
                            <label class="form-label">Descripción</label>
                            <textarea class="form-control" rows="3"></textarea>
                        </div>
                    </form>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">
                        <i class="bi bi-x-lg"></i> Cancelar
                    </button>
                    <button type="button" class="btn btn-primary">
                        <i class="bi bi-save"></i> Guardar
                    </button>
                </div>
            </div>
        </div>
    </div>

    <footer class="footer mt-auto py-3 bg-light">
        <div class="container text-center">
            <span class="text-muted">© 2024 My Construcción. Todos los derechos reservados.</span>
        </div>
    </footer>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>