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

namespace AdminOpciones.Struct.OpcionesXF.ValorizacionCartera
{
    public class StructCurvaMoneda
    {
        public DateTime FechaGeneracion { get; set;}
        public string CodigoCurva { get; set;}
        public List<StructItemCurvaMoneda> CurvaMoneda;

        public StructCurvaMoneda()
        {            
            CurvaMoneda = new List<StructItemCurvaMoneda>();            
        }

        public StructCurvaMoneda(DateTime Fecha_Generacion, string Codigo_Curva)
        {
            FechaGeneracion = Fecha_Generacion;
            CurvaMoneda = new List<StructItemCurvaMoneda>();
            CodigoCurva = Codigo_Curva;                    
        }

        
    }
    public class StructItemCurvaMoneda
    {

        public int dias { get; set; }
        public double Bid { get; set; }
        public double Ask { get; set; }

        public StructItemCurvaMoneda()
        {
            Bid = double.NaN;
            Ask = double.NaN;
            dias = 0;
        }


        public string sBid
        {
            get
            {
                if (!Bid.Equals(double.NaN))
                {
                    return this.Bid.ToString("#,##0.#0000");
                }
                else
                {
                    return "";
                }
            }
        }

        public string sAsk
        {
            get
            {
                if (!Ask.Equals(double.NaN))
                {
                    return this.Ask.ToString("#,##0.#0000");
                }
                else
                {
                    return "";
                }
            }
        }
    }


    public class StructItemPuntosForward
    {

        public int dias { get; set; }
        public string tenor { get; set; }
        public double Puntos { get; set; }

        public StructItemPuntosForward()
        {
            Puntos = double.NaN;
            dias = 0;
        }


        public string sPuntos
        {
            get
            {
                if (!Puntos.Equals(double.NaN))
                {
                    return this.Puntos.ToString("#,##0.#0000");
                }
                else
                {
                    return "";
                }
            }
        }
    }



     

}
