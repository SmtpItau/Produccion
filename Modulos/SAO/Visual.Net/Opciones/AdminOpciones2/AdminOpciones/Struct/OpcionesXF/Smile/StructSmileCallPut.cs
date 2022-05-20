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

namespace AdminOpciones.Struct.OpcionesXF.Smile
{
    public class StructSmileCallPut
    {

        public int Tenor { get; set; }
        public double Put10 { get; set; }
        public double Put25 { get; set; }
        public double Atm { get; set; }
        public double Call25 { get; set; }
        public double Call10 { get; set; }

        public StructSmileCallPut() { }

        public StructSmileCallPut(int tenor,
                                   double put10,
                                   double put25,
                                   double atm,
                                   double call25,
                                   double call10)
        {

            Tenor = tenor;
            Put10 = put10;
            Put25 = put25;
            Atm = atm;
            Call25 = call25;
            Call10 = call10;

        }

        public string sPut10
        {
            get
            {
                return this.Put10.ToString("#,##0.#0");
            }
        }

        public string sPut25
        {
            get
            {
                return this.Put25.ToString("#,##0.#0");
            }
        }

        public string sAtm
        {
            get
            {
                return this.Atm.ToString("#,##0.#0");
            }
        }

        public string sCall25
        {
            get
            {
                return this.Call25.ToString("#,##0.#0");
            }
        }

        public string sCall10
        {
            get
            {
                return this.Call10.ToString("#,##0.#0");
            }
        }

        //Para grilla de topología
        public string sTopologiaPut10
        {
            get
            {
                return this.Put10.ToString("#,##0");
            }
        }

        public string sTopologiaPut25
        {
            get
            {
                return this.Put25.ToString("#,##0");
            }
        }

        public string sTopologiaAtm
        {
            get
            {
                return this.Atm.ToString("#,##0");
            }
        }

        public string sTopologiaCall25
        {
            get
            {
                return this.Call25.ToString("#,##0");
            }
        }

        public string sTopologiaCall10
        {
            get
            {
                return this.Call10.ToString("#,##0");
            }
        }

    }
}
