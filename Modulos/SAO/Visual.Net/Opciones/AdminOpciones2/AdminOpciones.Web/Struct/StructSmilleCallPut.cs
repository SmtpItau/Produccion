using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace AdminOpciones.Web.Struct
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

    }
}
