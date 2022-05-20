using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace AdminOpciones.Web.Struct
{
    public class StructFixingData
    {
        public DateTime Fecha { get; set; }
        public double Valor { get; set; }
        public double Peso { get; set; }
        public double Volatilidad { get; set; }
        public int Plazo { get; set; }

        public StructFixingData() { }

        public StructFixingData(DateTime fecha,
                            double valor,
                            double peso,
                            double volatilidad,
                            int plazo)
        {
            Fecha = Fecha;
            Valor = valor;
            Peso = peso;
            Volatilidad = volatilidad;
            Plazo = plazo;
        }

        public string sFecha
        {
            get
            {
                return Fecha.ToString("dd-MM-yyyy");
            }
        }

        public string sPlazo
        {
            get
            {
                return Plazo.ToString("#,##0");
            }
        }
        public string sValor
        {
            get
            {
                return this.Valor.ToString("#,##0.#00");
            }
        }
        public string sPeso
        {
            get
            {
                return this.Peso.ToString("#,##0.#00");
            }
        }
        public string sVolatilidad
        {
            get
            {
                return this.Volatilidad.ToString("#,##0.#00");
            }
        }
    }
}
