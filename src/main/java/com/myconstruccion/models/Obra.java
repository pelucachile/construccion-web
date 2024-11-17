package com.myconstruccion.models;

import java.util.Date;

public class Obra {
    private int id;
    private String nombre;
    private String descripcion;
    private int tipoObraId;
    private String tipoObraNombre;
    private String direccion;
    private Date fechaInicio;
    private Date fechaFinEstimada;
    private Date fechaFinReal;
    private String estado;
    private double presupuesto;
    private int clienteId;
    private String clienteNombre;
    private Date fechaRegistro;
    
    // Constructor vacío
    public Obra() {}
    
    // Getters y Setters
    public int getId() {
        return id;
    }
    
    public void setId(int id) {
        this.id = id;
    }
    
    public String getNombre() {
        return nombre;
    }
    
    public void setNombre(String nombre) {
        this.nombre = nombre;
    }
    
    public String getDescripcion() {
        return descripcion;
    }
    
    public void setDescripcion(String descripcion) {
        this.descripcion = descripcion;
    }
    
    public String getEstado() {
        return estado;
    }
    
    public void setEstado(String estado) {
        this.estado = estado;
    }
    
    public double getPresupuesto() {
        return presupuesto;
    }
    
    public void setPresupuesto(double presupuesto) {
        this.presupuesto = presupuesto;
    }
    
    public String getClienteNombre() {
        return clienteNombre;
    }
    
    public void setClienteNombre(String clienteNombre) {
        this.clienteNombre = clienteNombre;
    }
    
    public String getTipoObraNombre() {
        return tipoObraNombre;
    }
    
    public void setTipoObraNombre(String tipoObraNombre) {
        this.tipoObraNombre = tipoObraNombre;
    }
}