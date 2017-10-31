
package com.fich.wafproject.model;

public class JasperCharts {
    private String campo;
    private Number valor;

    public JasperCharts() {
    }

    public JasperCharts(String campo, Number valor) {
        this.campo = campo;
        this.valor = valor;
    }

    public String getCampo() {
        return campo;
    }

    public void setCampo(String campo) {
        this.campo = campo;
    }

    public Number getValor() {
        return valor;
    }

    public void setValor(Number valor) {
        this.valor = valor;
    }

    
}
