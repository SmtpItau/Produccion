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

namespace AdminOpciones.Struct.OpcionesXF.Smile
{
    public class StructGriegas
    {


        public double DeltaSpot { get; set; }
        public double DeltaForward { get; set; }
        public double Gamma { get; set; }
        public double Vega { get; set; }
        public double RhoDom { get; set; }
        public double RhoFor { get; set; }
        public double Theta { get; set; }
        public double Charm { get; set; }
        public double Vanna { get; set; }
        public double Volga { get; set; }
        //public double Zomma{ get; set; }
        //public double Speed{ get; set; }




        public StructGriegas() { }

        public StructGriegas(double deltaspot,
                               double deltaforward,
                               double gamma,
                               double vega,
                               double rhodom,
                               double rhofor,
                               double theta,
                               double charm,
                               double vanna,
                               double volga)
        //double zomma,
        //double speed)
        {

            DeltaSpot = deltaspot;
            DeltaForward = deltaforward;
            Gamma = gamma;
            Vega = vega;
            RhoDom = rhodom;
            RhoFor = rhofor;
            Theta = theta;
            Charm = charm;
            Vanna = vanna;
            Volga = volga;
            //Zomma = zomma;
            //Speed = speed;


        }
        public string sDeltaSpot
        {
            get
            {
                return this.DeltaSpot.ToString("#,##0");
            }
        }
        public string sDeltaForward
        {
            get
            {
                return this.DeltaForward.ToString("#,##0");
            }
        }
        public string sGamma
        {
            get
            {
                return this.Gamma.ToString("#,##0");
            }
        }


        public string sVega
        {
            get
            {
                return this.Vega.ToString("#,##0");
            }
        }
        public string sRhoDom
        {
            get
            {
                return this.RhoDom.ToString("#,##0");
            }
        }
        public string sRhoFor
        {
            get
            {
                return this.RhoFor.ToString("#,##0");
            }
        }
        public string sTheta
        {
            get
            {
                return this.Theta.ToString("#,##0");
            }
        }
        public string sCharm
        {
            get
            {
                return this.Charm.ToString("#,##0");
            }
        }
        public string sVanna
        {
            get
            {
                return this.Vanna.ToString("#,##0");
            }
        }

        public string sVolga
        {
            get
            {
                return this.Volga.ToString("#,##0");
            }
        }
        //public string sZomma
        // {
        //     get
        //     {
        //         return this.Zomma.ToString("#,##0.#0000");
        //     }
        // }
        //public string sSpeed
        // {
        //     get
        //     {
        //         return this.Speed.ToString("#,##0.#0000");
        //     }
        // }


    }
}
