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

namespace AdminOpciones.Struct.Generic
{
    public class StructCodigoDescripcion
    {
        public bool Check { get; set; }
        public string Codigo { get; set; }
        public string Descripcion { get; set; }
        public double Valor { get; set; }      

        public StructCodigoDescripcion() { }

        public StructCodigoDescripcion(string c, string d)
        {
            Check = false;
            Codigo = c;
            Descripcion = d;
            Valor = 0;
        }
        public StructCodigoDescripcion(string c, string d, double v)
        {
            Check = false;
            Codigo = c;
            Descripcion = d;
            Valor = v;
        }


    }
}
