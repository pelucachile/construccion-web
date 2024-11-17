package com.myconstruccion.servlets;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/logout")
public class LogoutServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        // Obtener la sesión actual
        HttpSession session = request.getSession(false);
        
        // Si existe una sesión, la invalidamos
        if (session != null) {
            session.invalidate();
        }
        
        // Redirigir al login
        response.sendRedirect("index.jsp");
    }
}