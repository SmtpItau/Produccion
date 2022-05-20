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

namespace AdminOpciones.Struct.OpcionesXF.Customers
{
    public class StructCustomers
    {
        public string Clrut{get;set;}
        public string Cldv{get;set;}
        public string Clcodigo{get;set;}
        public string Clnombre{get;set;}
        //public string Cldirecc { get; set;}

        public StructCustomers() { }

        public StructCustomers(string clrut,
                                string cldv,
                                string clcodigo,
                                string clnombre)
        {
            Clrut = clrut;
            Cldv = cldv;
            Clcodigo = clcodigo;
            Clnombre = clnombre;           
        }
        
    }
}
