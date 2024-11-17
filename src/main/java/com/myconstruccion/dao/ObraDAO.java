package com.myconstruccion.dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import com.myconstruccion.database.DatabaseConnection;
import com.myconstruccion.models.Obra;

public class ObraDAO {
    
    public int countObrasActivas() {
        String sql = "SELECT COUNT(*) FROM obras WHERE estado = 'En Construcción'";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }
    
    public List<Obra> getUltimasObras() {
        List<Obra> obras = new ArrayList<>();
        String sql = "SELECT o.*, c.nombre as cliente_nombre, t.nombre as tipo_obra_nombre " +
                    "FROM obras o " +
                    "LEFT JOIN clientes c ON o.cliente_id = c.id " +
                    "LEFT JOIN tipos_obra t ON o.tipo_obra_id = t.id " +
                    "ORDER BY o.fecha_registro DESC LIMIT 5";
                    
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                Obra obra = new Obra();
                obra.setId(rs.getInt("id"));
                obra.setNombre(rs.getString("nombre"));
                obra.setEstado(rs.getString("estado"));
                obra.setPresupuesto(rs.getDouble("presupuesto"));
                obra.setClienteNombre(rs.getString("cliente_nombre"));
                obra.setTipoObraNombre(rs.getString("tipo_obra_nombre"));
                obras.add(obra);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return obras;
    }
}
