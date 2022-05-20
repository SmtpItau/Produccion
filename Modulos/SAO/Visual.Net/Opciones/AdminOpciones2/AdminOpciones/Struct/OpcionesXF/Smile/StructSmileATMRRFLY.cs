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
    public class StructSmileATMRRFLY
    {
        //string Tenor, ATM, 25DRR, 25DBF, 10DRR, 10DBF
        public int Tenor { get; set; }
        public double ATM { get; set; }
        public double RR25D { get; set; }
        public double BF25D { get; set; }
        public double RR10D { get; set; }
        public double BF10D { get; set; }

        public StructSmileATMRRFLY()
        {
            Tenor = 0;
            ATM = 0;
            RR25D = 0;
            BF25D = 0;
            RR10D = 0;
            BF10D = 0;
        }

        public StructSmileATMRRFLY(int tenor,
                                    double atm,
                                    double rr25d,
                                    double bf25d,
                                    double rr10d,
                                    double bf10d)
        {
            Tenor = tenor;
            ATM = atm;
            RR25D = rr25d;
            BF25D = bf25d;
            RR10D = rr10d;
            BF10D = bf10d;
        }

        public static implicit operator StructSmileATMRRFLY(StructSmileGeneric g)
        {
            return g.toATMRRFLY();
        }

        public string sATM
        {
            get
            {
                return this.ATM.ToString("#,##0.#0");
            }
        }

        public string sRR25D
        {
            get
            {
                return this.RR25D.ToString("#,##0.#0");
            }
        }

        public string sBF25D
        {
            get
            {
                return this.BF25D.ToString("#,##0.#0");
            }
        }

        public string sRR10D
        {
            get
            {
                return this.RR10D.ToString("#,##0.#0");
            }
        }

        public string sBF10D
        {
            get
            {
                return this.BF10D.ToString("#,##0.#0");
            }
        }

        //Para grilla de topología
        public string sTopologiaATM
        {
            get
            {
                return this.ATM.ToString("#,##0");
            }
        }

        public string sTopologiaRR25D
        {
            get
            {
                return this.RR25D.ToString("#,##0");
            }
        }

        public string sTopologiaBF25D
        {
            get
            {
                return this.BF25D.ToString("#,##0");
            }
        }

        public string sTopologiaRR10D
        {
            get
            {
                return this.RR10D.ToString("#,##0");
            }
        }

        public string sTopologiaBF10D
        {
            get
            {
                return this.BF10D.ToString("#,##0");
            }
        }

    }
}
