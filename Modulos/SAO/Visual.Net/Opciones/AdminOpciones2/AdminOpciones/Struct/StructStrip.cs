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

namespace AdminOpciones.Struct
{
    public class StructStrip
    {
        public int ID { get; set; }
        public double NocionalTotal { get; set; }
        public double NocionaPeriodo { get; set; }
        public double PrecioStrike { get; set; }
        public string FechaInicio { get; set; }
        public DateTime FechaInicioFixing { get; set; }
        public DateTime FechaVencimiento { get; set; }
        public string dFechaVencimiento { get { return FechaVencimiento.ToString("dd/MM/yyyy"); } }
        public double Fixing { get; set; }
        public List<StructFixingData> TablaFixing = new List<StructFixingData>();
        //public List<AdminOpciones.OpcionesFX.Asiatica.
    }
}
