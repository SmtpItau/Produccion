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
using AdminOpciones.Struct.Generic;

namespace AdminOpciones.Struct
{

    public class StructMonedaFormaPago
    {

        public int CodigoMoneda { get; set; }
        public bool Check { get; set; }
        public string Codigo { get; set; }
        public string Descripcion { get; set; }
        public double Valor { get; set; }      
        //PAE
        public bool isEnabled { get; set; }

    }

}
