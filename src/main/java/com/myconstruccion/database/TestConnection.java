package com.myconstruccion.database;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.sql.SQLException;

public class TestConnection {
    public static void main(String[] args) {
        try {
            System.out.println("Intentando conectar a la base de datos...");
            Connection conn = DatabaseConnection.getConnection();
            System.out.println("Conexión exitosa!");
            
            // Probar login específico
            String username = "veronica";
            String password = "gorra123";
            
            String sql = "SELECT * FROM usuarios WHERE username = ? AND password = ?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, username);
            stmt.setString(2, password);
            
            System.out.println("Ejecutando consulta para usuario: " + username);
            ResultSet rs = stmt.executeQuery();
            
            if (rs.next()) {
                System.out.println("Usuario encontrado!");
                System.out.println("Nombre: " + rs.getString("nombre"));
                System.out.println("Rol: " + rs.getString("rol"));
            } else {
                System.out.println("Usuario NO encontrado");
                
                // Verificar todos los usuarios en la base de datos
                Statement checkStmt = conn.createStatement();
                ResultSet allUsers = checkStmt.executeQuery("SELECT username, password FROM usuarios");
                System.out.println("\nUsuarios en la base de datos:");
                while(allUsers.next()) {
                    System.out.println("Usuario: [" + allUsers.getString("username") + 
                                     "], Password: [" + allUsers.getString("password") + "]");
                }
            }
            
        } catch (Exception e) {
            System.out.println("Error: " + e.getMessage());
            e.printStackTrace();
        }
    }
}