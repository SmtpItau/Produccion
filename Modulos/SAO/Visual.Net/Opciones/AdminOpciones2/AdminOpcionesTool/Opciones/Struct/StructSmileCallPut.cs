using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace AdminOpcionesTool.Opciones.Struct
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

    }
}
