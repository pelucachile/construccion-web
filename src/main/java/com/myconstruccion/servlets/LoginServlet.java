package com.myconstruccion.servlets;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.myconstruccion.dao.UsuarioDAO;
import com.myconstruccion.models.Usuario;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private UsuarioDAO usuarioDAO;
    
    public void init() {
        usuarioDAO = new UsuarioDAO();
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        System.out.println("\n=== Inicio proceso de login ===");
        
        // Obtener parámetros
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        
        System.out.println("Datos recibidos del formulario:");
        System.out.println("Username: [" + username + "]");
        System.out.println("Password: [" + password + "]");
        
        if (username == null || password == null) {
            System.out.println("Error: username o password es null");
            request.setAttribute("error", "Todos los campos son requeridos");
            request.getRequestDispatcher("index.jsp").forward(request, response);
            return;
        }
        
        // Eliminar espacios en blanco
        username = username.trim();
        password = password.trim();
        
        System.out.println("Datos después de trim:");
        System.out.println("Username: [" + username + "]");
        System.out.println("Password: [" + password + "]");
        
        try {
            Usuario usuario = usuarioDAO.validarUsuario(username, password);
            
            if (usuario != null) {
                System.out.println("Login exitoso - Usuario autenticado: " + username);
                HttpSession session = request.getSession();
                session.setAttribute("usuario", usuario);
                response.sendRedirect("dashboard.jsp");
            } else {
                System.out.println("Login fallido - Usuario no autenticado: " + username);
                request.setAttribute("error", "Usuario o contraseña incorrectos");
                request.getRequestDispatcher("index.jsp").forward(request, response);
            }
        } catch (Exception e) {
            System.out.println("Error durante el login: " + e.getMessage());
            e.printStackTrace();
            request.setAttribute("error", "Error del sistema");
            request.getRequestDispatcher("index.jsp").forward(request, response);
        }
    }
}