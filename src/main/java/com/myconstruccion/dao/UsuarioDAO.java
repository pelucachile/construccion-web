package com.myconstruccion.dao;

import com.myconstruccion.models.Usuario;
import com.myconstruccion.database.DatabaseConnection;
import java.sql.*;

public class UsuarioDAO {
    
    public Usuario validarUsuario(String username, String password) {
        System.out.println("\n=== Inicio validación de usuario ===");
        System.out.println("Intentando validar - Usuario: [" + username + "], Password: [" + password + "]");
        
        String sql = "SELECT * FROM usuarios WHERE username = ? AND password = ?";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, username);
            stmt.setString(2, password);
            
            System.out.println("Ejecutando consulta SQL...");
            
            try (ResultSet rs = stmt.executeQuery()) {
                // Primero, vamos a ver todos los usuarios en la base de datos
                Statement checkStmt = conn.createStatement();
                ResultSet allUsers = checkStmt.executeQuery("SELECT username, password FROM usuarios");
                System.out.println("\nUsuarios disponibles en la base de datos:");
                while(allUsers.next()) {
                    System.out.println("BD Usuario: [" + allUsers.getString("username") + 
                                     "], Password: [" + allUsers.getString("password") + "]");
                }
                
                if (rs.next()) {
                    System.out.println("\n¡Usuario encontrado!");
                    Usuario usuario = new Usuario();
                    usuario.setId(rs.getInt("id"));
                    usuario.setUsername(rs.getString("username"));
                    usuario.setNombre(rs.getString("nombre"));
                    usuario.setEmail(rs.getString("email"));
                    usuario.setRol(rs.getString("rol"));
                    return usuario;
                } else {
                    System.out.println("\nUsuario NO encontrado en la base de datos");
                    return null;
                }
            }
        } catch (SQLException e) {
            System.out.println("Error SQL: " + e.getMessage());
            e.printStackTrace();
            return null;
        }
    }
}