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

namespace AdminOpciones.Struct.OpcionesXF.ValorizacionCartera
{

    public class StructSensibilidad
    {
        // 		<Value Tenor='7290' MTM='-588371293,044892' MTMSens='-588371293,044889' Delta='0'>

        public StructSensibilidad()
        {
            Tenor = 0;
            MTM = 0;
            MTMSens = 0;
            Delta = 0;
        }

        public int Tenor { get; set; }
        public double MTM { get; set; }
        public double MTMSens { get; set; }
        public double Delta { get; set; }

        public string sMTM
        {
            get
            {
                return MTM.ToString("#,##0");
            }
        }

        public string sMTMSens
        {
            get
            {
                return MTMSens.ToString("#,##0");
            }
        }

        public string sDelta
        {
            get
            {
                return Delta.ToString("#,##0");
            }
        }

    }

}
