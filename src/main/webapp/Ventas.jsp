<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.myconstruccion.models.*"%>
<%
    // Verificación de sesión
    Usuario usuario = (Usuario) session.getAttribute("usuario");
    if(usuario == null) {
        response.sendRedirect("index.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Ventas - My Construcción</title>
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
        .resumen-ventas {
            border-left: 4px solid #0d6efd;
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
                        <a class="nav-link" href="Obras.jsp">
                            <i class="bi bi-building"></i> Obras
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="Clientes.jsp">
                            <i class="bi bi-people"></i> Clientes
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link active" href="Ventas.jsp">
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
            <h2><i class="bi bi-cart"></i> Gestión de Ventas</h2>
            <button class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#nuevaVentaModal">
                <i class="bi bi-plus-lg"></i> Nueva Venta
            </button>
        </div>

        <!-- Resumen de Ventas -->
        <div class="row mb-4">
            <div class="col-md-4">
                <div class="card resumen-ventas">
                    <div class="card-body">
                        <h6 class="text-primary">Ventas del Mes</h6>
                        <h3>$675.000.000</h3>
                        <p class="mb-0 text-success">
                            <i class="bi bi-arrow-up"></i> 15% vs mes anterior
                        </p>
                    </div>
                </div>
            </div>
            <div class="col-md-4">
                <div class="card resumen-ventas">
                    <div class="card-body">
                        <h6 class="text-primary">Pagos Pendientes</h6>
                        <h3>$125.000.000</h3>
                        <p class="mb-0 text-warning">3 pagos por cobrar</p>
                    </div>
                </div>
            </div>
            <div class="col-md-4">
                <div class="card resumen-ventas">
                    <div class="card-body">
                        <h6 class="text-primary">Total Obras Vendidas</h6>
                        <h3>3</h3>
                        <p class="mb-0">Este mes</p>
                    </div>
                </div>
            </div>
        </div>

        <!-- Filtros -->
        <div class="card mb-4">
            <div class="card-body">
                <form class="row g-3">
                    <div class="col-md-3">
                        <label class="form-label">Estado de Pago</label>
                        <select class="form-select">
                            <option value="">Todos</option>
                            <option>Pendiente</option>
                            <option>Parcial</option>
                            <option>Completado</option>
                        </select>
                    </div>
                    <div class="col-md-3">
                        <label class="form-label">Cliente</label>
                        <select class="form-select">
                            <option value="">Todos</option>
                            <option>Juan Pérez</option>
                            <option>María González</option>
                        </select>
                    </div>
                    <div class="col-md-3">
                        <label class="form-label">Fecha Desde</label>
                        <input type="date" class="form-control">
                    </div>
                    <div class="col-md-3">
                        <label class="form-label">Fecha Hasta</label>
                        <input type="date" class="form-control">
                    </div>
                </form>
            </div>
        </div>

        <!-- Tabla de Ventas -->
        <div class="card">
            <div class="card-body">
                <div class="table-responsive">
                    <table class="table table-hover">
                        <thead>
                            <tr>
                                <th>ID Venta</th>
                                <th>Obra</th>
                                <th>Cliente</th>
                                <th>Monto</th>
                                <th>Fecha</th>
                                <th>Estado Pago</th>
                                <th>Acciones</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td>#001</td>
                                <td>Casa Plaza Mayor</td>
                                <td>Juan Pérez</td>
                                <td>$150.000.000</td>
                                <td>15/01/2024</td>
                                <td>
                                    <span class="badge bg-warning">Parcial</span>
                                </td>
                                <td>
                                    <button class="btn btn-sm btn-info">
                                        <i class="bi bi-eye"></i> Ver
                                    </button>
                                    <button class="btn btn-sm btn-success">
                                        <i class="bi bi-cash"></i> Pago
                                    </button>
                                </td>
                            </tr>
                            <tr>
                                <td>#002</td>
                                <td>Edificio Los Pinos</td>
                                <td>María González</td>
                                <td>$500.000.000</td>
                                <td>01/02/2024</td>
                                <td>
                                    <span class="badge bg-danger">Pendiente</span>
                                </td>
                                <td>
                                    <button class="btn btn-sm btn-info">
                                        <i class="bi bi-eye"></i> Ver
                                    </button>
                                    <button class="btn btn-sm btn-success">
                                        <i class="bi bi-cash"></i> Pago
                                    </button>
                                </td>
                            </tr>
                            <tr>
                                <td>#003</td>
                                <td>Remodelación Oficina</td>
                                <td>Pedro Soto</td>
                                <td>$25.000.000</td>
                                <td>01/03/2024</td>
                                <td>
                                    <span class="badge bg-success">Completado</span>
                                </td>
                                <td>
                                    <button class="btn btn-sm btn-info">
                                        <i class="bi bi-eye"></i> Ver
                                    </button>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>

    <!-- Modal Nueva Venta -->
    <div class="modal fade" id="nuevaVentaModal" tabindex="-1">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">
                        <i class="bi bi-cart-plus"></i> Nueva Venta
                    </h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body">
                    <form id="nuevaVentaForm" class="row g-3">
                        <div class="col-md-6">
                            <label class="form-label">Obra</label>
                            <select class="form-select" required>
                                <option value="">Seleccione...</option>
                                <option>Casa Plaza Mayor</option>
                                <option>Edificio Los Pinos</option>
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
                            <label class="form-label">Monto</label>
                            <div class="input-group">
                                <span class="input-group-text">$</span>
                                <input type="number" class="form-control" required>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <label class="form-label">Fecha de Venta</label>
                            <input type="date" class="form-control" required>
                        </div>
                        <div class="col-md-6">
                            <label class="form-label">Estado de Pago</label>
                            <select class="form-select" required>
                                <option value="">Seleccione...</option>
                                <option>Pendiente</option>
                                <option>Parcial</option>
                                <option>Completado</option>
                            </select>
                        </div>
                        <div class="col-md-6">
                            <label class="form-label">Método de Pago</label>
                            <select class="form-select" required>
                                <option value="">Seleccione...</option>
                                <option>Transferencia</option>
                                <option>Cheque</option>
                                <option>Efectivo</option>
                            </select>
                        </div>
                        <div class="col-12">
                            <label class="form-label">Observaciones</label>
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