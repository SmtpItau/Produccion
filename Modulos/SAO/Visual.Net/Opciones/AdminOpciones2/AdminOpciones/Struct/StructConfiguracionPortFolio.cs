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
    public class StructConfiguracionPortFolio
    {
        public string Usuario{get;set;}
        public string LibroCod{get;set;}
        public string LibroDesc{get;set;}
        public string CartNormCod { get; set; }
        public string CartNormDesc { get; set; }
        public string SubCartNormCod { get; set; }
        public string SubCartNormDesc { get; set; }
        public string Prioridad{get;set;}
        //public string Cldirecc { get; set;}

        public StructConfiguracionPortFolio() { }

        public StructConfiguracionPortFolio(string usuario,
                                string libroCod,
                                string libroDesc,
                                string cartNormCod,
                                string cartNormDesc,
                                string subCartNormCod,
                                string subCartNormDesc,
                                string prioridad)
        {
            Usuario = usuario;
            LibroCod = libroCod;
            LibroDesc = libroDesc;
            CartNormCod = cartNormCod;
            CartNormDesc = cartNormDesc;
            SubCartNormCod = subCartNormCod;
            SubCartNormDesc = subCartNormDesc;
            Prioridad = prioridad;           

        }



    }
}
