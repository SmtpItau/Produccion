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
    public class StructGeneric
    {
        public Object A { get; set; }
        public Object B { get; set; }
        public Object C { get; set; }

        public StructGeneric() { }

        public StructGeneric(Object a, Object b)
        {
            A = a;
            B = b;
        }


    }
}
