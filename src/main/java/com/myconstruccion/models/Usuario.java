package com.myconstruccion.models;

import java.sql.Timestamp;

public class Usuario {
    private int id;
    private String username;
    private String password;
    private String nombre;
    private String email;
    private String rol;
    private Timestamp fechaCreacion;
    
    // Constructor vacío
    public Usuario() {}
    
    // Constructor con campos
    public Usuario(String username, String password, String nombre, String email, String rol) {
        this.username = username;
        this.password = password;
        this.nombre = nombre;
        this.email = email;
        this.rol = rol;
    }
    
    // Getters y Setters
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getRol() {
        return rol;
    }

    public void setRol(String rol) {
        this.rol = rol;
    }

    public Timestamp getFechaCreacion() {
        return fechaCreacion;
    }

    public void setFechaCreacion(Timestamp fechaCreacion) {
        this.fechaCreacion = fechaCreacion;
    }
}