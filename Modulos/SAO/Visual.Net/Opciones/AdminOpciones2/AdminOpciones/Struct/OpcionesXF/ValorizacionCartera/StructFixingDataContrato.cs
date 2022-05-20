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
using AdminOpciones.Struct.OpcionesXF.Asiatica;

namespace AdminOpciones.Struct.OpcionesXF.ValorizacionCartera
{
    public class StructFixingDataContrato
    {
        public int NumContrato { get; set;} 
        public int NucEstructura { get; set; } // componente de la estructura
        public List<StructFixingData> Fijaciones;
        
        public StructFixingDataContrato()
        {
            Fijaciones = new List<StructFixingData>();
        }

        public StructFixingDataContrato(StructFixingDataContrato value)
        {
            NumContrato = value.NumContrato;
            NucEstructura = value.NucEstructura;

            Fijaciones = new List<StructFixingData>();
           
            foreach (StructFixingData _Item in value.Fijaciones)
            {
                Fijaciones.Add(new StructFixingData(_Item));
            }
        }

    }
}
