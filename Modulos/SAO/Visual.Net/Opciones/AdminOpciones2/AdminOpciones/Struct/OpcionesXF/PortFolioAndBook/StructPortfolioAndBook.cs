﻿using System;
using System.Net;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Documents;
using System.Windows.Ink;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Animation;
using System.Windows.Shapes;

namespace AdminOpciones.Struct.OpcionesXF.PortFolioAndBook
{
    public class StructPortfolioAndBook
    {
        public string Codigo {get;set;}
        public string Descripcion { get; set; }
        
        public StructPortfolioAndBook() { }
        
        public StructPortfolioAndBook(string codigo, string descripcion)
        {
            Codigo = codigo;
            Descripcion = descripcion;

        }


    }
}
