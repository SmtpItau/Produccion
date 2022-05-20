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

namespace AdminOpciones.Struct
{
    public class StructFinancialPortFolio
    {
        public string Codigo {get;set;}
        public string Descripcion { get; set; }
        public string Prioridad { get; set; }
        
        public StructFinancialPortFolio() { }

        public StructFinancialPortFolio(string codigo, string descripcion, string prioridad)
        {
            Codigo = codigo;
            Descripcion = descripcion;
            Prioridad = prioridad;

        }


    }
}
