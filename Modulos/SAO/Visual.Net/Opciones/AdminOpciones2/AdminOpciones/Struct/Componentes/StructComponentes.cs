using System;
using System.Net;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Documents;
using System.Windows.Ink;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Animation;
using System.Windows.Shapes;
using System.Collections.Generic;

namespace AdminOpciones.Struct.Componentes
{
    public class StructComponentes
    {
        public List<string> Producto { get; set; }
        public List<string> CompraVenta { get; set; }
        public List<string> FechaVal { get; set; }
        public List<string> FechaVcto { get; set; }
        public List<string> Nominal { get; set; }
        public List<string> Strike { get; set; }
        public List<string> Prima { get; set; }
        public List<string> DeltaFwdPorcentage { get; set; }

        public List<string> Spot { get; set; }
        public List<string> PuntosFwd { get; set; }
        public List<string> Volatilidad { get; set; }
        public List<string> TasaLocal { get; set; }
        public List<string> TasaForanea { get; set; }

        public List<string> MtM { get; set; }
        public List<string> DeltaSpot { get; set; }
        public List<string> DeltaForward { get; set; }
        public List<string> Gamma { get; set; }
        public List<string> Vega { get; set; }
        public List<string> RhoDom { get; set; }
        public List<string> RhoFor { get; set; }
        public List<string> Theta { get; set; }
        public List<string> Charm { get; set; }
        public List<string> Vanna { get; set; }
        public List<string> Volga { get; set; }
        public List<string> Zomma { get; set; }
        public List<string> Speed { get; set; }


        public StructComponentes()
        {
            Producto = new List<string>();
            CompraVenta = new List<string>();
            FechaVal = new List<string>();
            FechaVcto = new List<string>();
            Nominal = new List<string>();
            Strike = new List<string>();
            Prima = new List<string>();
            DeltaFwdPorcentage = new List<string>();

            Spot = new List<string>();
            PuntosFwd = new List<string>();
            Volatilidad = new List<string>();
            TasaLocal = new List<string>();
            TasaForanea = new List<string>();

            MtM = new List<string>();
            DeltaSpot = new List<string>();
            DeltaForward = new List<string>();
            Gamma = new List<string>();
            Vega = new List<string>();
            RhoDom = new List<string>();
            RhoFor = new List<string>();
            Theta = new List<string>();
            Charm = new List<string>();
            Vanna = new List<string>();
            Volga = new List<string>();
            Zomma = new List<string>();
            Speed = new List<string>();



            Producto.Add("Producto");
            CompraVenta.Add("Compra/Venta");
            FechaVal.Add("Fecha Val.");
            FechaVcto.Add("Fecha Vcto.");
            Nominal.Add("Nocional");
            Strike.Add("Strike");
            Prima.Add("Prima");
            DeltaFwdPorcentage.Add("Delta Fwd %");

            Spot.Add("Spot");
            PuntosFwd.Add("Puntos Fwd");
            Volatilidad.Add("Volatilidad");
            TasaLocal.Add("Tasa Local");
            TasaForanea.Add("Tasa Foranea");

            MtM.Add("MtM");
            DeltaSpot.Add("Delta Spot");
            DeltaForward.Add("Delta Fwd");
            Gamma.Add("Gamma");
            Vega.Add("Vega");
            RhoDom.Add("Rho Dom");
            RhoFor.Add("Rho For");
            Theta.Add("Theta");
            Charm.Add("Charm");
            Vanna.Add("Vanna");
            Volga.Add("Volga");
            Zomma.Add("Zomma");
            Speed.Add("Speed");
        }

        public int Count()
        {
            return this.Producto.Count;
        }


        


    }
}
