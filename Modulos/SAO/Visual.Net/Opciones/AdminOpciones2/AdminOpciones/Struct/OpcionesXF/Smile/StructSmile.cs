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
using System.Globalization;

namespace AdminOpciones.Struct.OpcionesXF.Smile
{
    public class StructSmile
    {
        public DateTime SmlFecha { get; set; }
        public string SmlParFor { get; set; }
        public string SmlEstructura { get; set; }
        public int SmlDelta { get; set; }
        public int SmlDias { get; set; }
        public double SmlBid { get; set; }
        public double SmlAsk { get; set; }
        public double SmlMid { get; set; }

        public StructSmile() { }

        public StructSmile(DateTime smlFecha,
                            string smlParFor,
                            string smlEstructura,
                            int smlDelta,
                            int smlDias,
                            double smlBid,
                            double smlAsk,
                            double smlMid)
        {
            SmlFecha = smlFecha;
            SmlParFor = smlParFor;
            SmlEstructura = smlEstructura;
            SmlDelta = smlDelta;
            SmlDias = smlDias;
            SmlBid = smlBid;
            SmlAsk = smlAsk;
            SmlMid = smlMid;
        }

        public string sSmlFecha
        {
            get
            {          
               return this.SmlFecha.ToString("dd-MM-yyyy", CultureInfo.CurrentCulture);
            }
        }

        public string sSmlBid
        {
            get
            {
                return this.SmlBid.ToString("#,##0.#0");
            }
        }
        public string sSmlAsk
        {
            get
            {
                return this.SmlAsk.ToString("#,##0.#0");
            }
        }
        public string sSmlMid
        {
            get
            {
                return this.SmlMid.ToString("#,##0.#0");
            }
        }

    }

    /// <summary>
    /// Esta clase encapsula los Smile en convención ATMRRFLY o CALLPUT
    /// </summary>
    public class StructSmileGeneric
    {
        StructSmileATMRRFLY ssATMRRFLY;
        StructSmileCallPut ssCALLPUT;
        int _Tenor;

        public StructSmileGeneric(string TipoSmile, int tenor, double a, double b, double c, double d, double e)
        {
            if (TipoSmile.Equals("RRFLY"))
            {
                this.ssATMRRFLY = new StructSmileATMRRFLY(tenor, c, d, b, e, a);
            }
            else if (TipoSmile.Equals("CALLPUT"))
            {
                this.ssCALLPUT = new StructSmileCallPut(tenor, a, b, c, d, e);
            }
            this._Tenor = tenor;
        }

        public static implicit operator StructSmileCallPut(StructSmileGeneric g)
        {
            return g.toCALLPUT();
        }

        public StructSmileATMRRFLY toATMRRFLY()
        {
            return this.ssATMRRFLY;
        }

        public StructSmileCallPut toCALLPUT()
        {
            return this.ssCALLPUT;
        }

        public int Tenor { get { return this._Tenor; } }

        public string sTopologiaPut10   { get { return this.ssCALLPUT.Put10.ToString("#,##0");  } }
        public string sTopologiaPut25   { get { return this.ssCALLPUT.Put25.ToString("#,##0");  } }
        public string sTopologiaAtm     { get { return this.ssCALLPUT.Atm.ToString("#,##0");    } }
        public string sTopologiaCall25  { get { return this.ssCALLPUT.Call25.ToString("#,##0"); } }
        public string sTopologiaCall10  { get { return this.ssCALLPUT.Call10.ToString("#,##0"); } }

        public string sTopologiaATM     { get { return this.ssATMRRFLY.ATM.ToString("#,##0");   } }
        public string sTopologiaRR25D   { get { return this.ssATMRRFLY.RR25D.ToString("#,##0"); } }
        public string sTopologiaBF25D   { get { return this.ssATMRRFLY.BF25D.ToString("#,##0"); } }
        public string sTopologiaRR10D   { get { return this.ssATMRRFLY.RR10D.ToString("#,##0"); } }
        public string sTopologiaBF10D   { get { return this.ssATMRRFLY.BF10D.ToString("#,##0"); } }

    }
}
