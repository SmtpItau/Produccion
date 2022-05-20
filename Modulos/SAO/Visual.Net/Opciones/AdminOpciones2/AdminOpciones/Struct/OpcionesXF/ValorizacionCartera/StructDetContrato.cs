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
    public delegate void delegate_Checked_DetContrato(int NumContrato, bool Value);

    public class StructDetContrato
    {
        public event delegate_Checked_DetContrato Detalle_Checked_detContrato;

        public int ID { get; set; }
        public bool isChecked;
        public bool Checked
        {
            get
            {
                return isChecked;
            }
            set
            {
                isChecked = value;
                Detalle_Checked_detContrato(NumContrato, isChecked);
            }
        }

        public bool Modalidad { get; set; }
        public int NumContrato { get; set; }
        public int CodEstructura { get; set; }
        public int NumEstructura { get; set; }
        public string CallPut { get; set; }
        public double MontoMon1 { get; set; }//nocional
        public double MontoMon2 { get; set; }//numeraire MAP 20130220 
        public string ParStrike { get; set; } //paridad
        public string Vinculacion { get; set; } // Individual, Estructura
        public string TipoPayOff { get; set; } //01, 02        
        public string CVOpc { get; set; } // C, V
        public string TipoEjercicio { get; set; }
        public string DescripTipoEjercicio
        {
            get
            {
                switch (TipoEjercicio)
                {
                    case "A": return "Americana";
                    case "E": return "Europea";
                    case "B": return "Bermuda";
                    default: return "No Definida";
                }
            }
        }
        public DateTime FechaInicioOpc { get; set; }
        public DateTime FechaVcto { get; set; }
        public double Strike { get; set; }
        public double PuntosFwd { get; set; }
        public double SpotDet { get; set; }
        public string CurveMon1 { get; set; }
        public string CurveMon2 { get; set; }
        public double PorcStrike { get; set; }//PDR_12567 Spread para fijación de entrada

        public int FormaPagoMon1 { get; set; }
        public int FormaPagoMon2 { get; set; }
        public int MdaCompensacion { get; set; }
        public int FormaPagoComp { get; set; }

        public double MtM { get; set; }
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
        public double Zomma { get; set; }
        public double Speed { get; set; }

        public string TipoTransaccion { get; set; }

        public string sStrike
        {
            get
            {
                return this.Strike.ToString("#,##0.#0");
            }
        }

        public string sSpotDet
        {
            get
            {
                return SpotDet.ToString("#,##0.#0");
            }
        }

        public string sCVOpc
        {
            get
            {
                if (CVOpc.Equals("C"))
                {
                    return "Compra";
                }
                else
                {
                    return "Venta";
                }

            }

        }

        public string sPorcStrike
        {
            get
            {
                return this.PorcStrike.ToString("0.#0");//PDR_12567 Spread para fijación de entrada
            }
        }

        public string sMtM
        {
            get
            {
                if (!MtM.Equals(double.NaN))
                {
                    return this.MtM.ToString("#,##0");
                }
                else
                {
                    return "";
                }
            }
        }

        public string sDeltaSpot
        {
            get
            {
                if (!DeltaSpot.Equals(double.NaN))
                {
                    return this.DeltaSpot.ToString("#,##0");
                }
                else
                {
                    return "";
                }
            }
        }

        public string sDeltaForward
        {
            get
            {
                if (!DeltaForward.Equals(double.NaN))
                {
                    return this.DeltaForward.ToString("#,##0");
                }
                else
                {
                    return "";
                }
            }
        }

        public string sGamma
        {
            get
            {
                if (!Gamma.Equals(double.NaN))
                {
                    return this.Gamma.ToString("#,##0");
                }
                else
                {
                    return "";
                }
            }
        }

        public string sVega
        {
            get
            {
                if (!Vega.Equals(double.NaN))
                {
                    return this.Vega.ToString("#,##0");
                }
                else
                {
                    return "";
                }

            }
        }

        public string sRhoDom
        {
            get
            {
                if (!RhoDom.Equals(double.NaN))
                {
                    return this.RhoDom.ToString("#,##0");
                }
                else
                {
                    return "";
                }

            }
        }

        public string sRhoFor
        {
            get
            {
                if (!RhoFor.Equals(double.NaN))
                {
                    return this.RhoFor.ToString("#,##0");
                }
                else
                {
                    return "";
                }

            }
        }

        public string sTheta
        {
            get
            {
                if (!Theta.Equals(double.NaN))
                {
                    return this.Theta.ToString("#,##0");
                }
                else
                {
                    return "";
                }
            }
        }

        public string sCharm
        {
            get
            {
                if (!Charm.Equals(double.NaN))
                {
                    return this.Charm.ToString("#,##0");
                }
                else
                {
                    return "";
                }
            }
        }

        public string sVanna
        {
            get
            {
                if (!Vanna.Equals(double.NaN))
                {
                    return this.Vanna.ToString("#,##0");
                }
                else
                {
                    return "";
                }

            }
        }

        public string sVolga
        {
            get
            {
                if (!Volga.Equals(double.NaN))
                {
                    return this.Volga.ToString("#,##0");
                }
                else
                {
                    return "";
                }
            }
        }

        public string sZomma
        {
            get
            {
                if (!Zomma.Equals(double.NaN))
                {
                    return this.Zomma.ToString("#,##0");
                }
                else
                {
                    return "";
                }

            }
        }

        public string sSpeed
        {
            get
            {
                if (!Speed.Equals(double.NaN))
                {
                    return this.Speed.ToString("#,##0");
                }
                else
                {
                    return "";
                }
            }
        }

        public string sFechaInicioOpc
        {
            get
            {
                return FechaInicioOpc.ToString("dd-MM-yyyy");
            }
        }

        public string sFechaVcto
        {
            get
            {
                return FechaVcto.ToString("dd-MM-yyyy");
            }
        }

        /// <summary>
        /// Este campo tiene glosas codificados en duro, revisar y mejorar.
        /// Afecta cada vez que se agrega una estructura.
        /// </summary>
        public string Estructura
        {
            get
            {
                if (!CodEstructura.Equals(0))
                {
                    switch (CodEstructura)
                    {
                        case 1:
                            return "Straddle";
                        case 2:
                            return "Risk Reversal";
                        case 3:
                            return "Butterfly";
                        case 4:
                            return "Forward Utilidad Acotada";
                        case 5:
                            return "Forward Perdida Acotada";
                        case 6:
                            return "Forward Sintetico";
                        case 7:
                            return "Strangle";
                        case 8:
                            return "Forward Americano";
                        case 9:
                            return "Strip Asiático Call";
                        case 10:
                            return "Strip Asiático Put";
                        case 11:
                            return "Call Spread";
                        case 12:
                            return "Put Spread";
                        case 13:
                            return "Forward Entrada Salida";
                        case 14:
                            return "Call Spread Doble";
                    }
                }
                else
                {
                    switch (CallPut)
                    {
                        case "Call":
                            return "Call";
                        case "Put":
                            return "Put";
                    }
                }
                return "";
            }
        }

        public string sTipoPayOff
        {
            get
            {
                switch (TipoPayOff)
                {
                    case "01":
                        return "Vanilla";
                    case "02":
                        return "Asiatica";
                    default:
                        return "";
                }
            }
        }

        public string sMontoMon1 //nocional
        {
            get
            {
                return this.MontoMon1.ToString("#,##0");
            }
        }

        public StructDetContrato()
        {
            MtM = double.NaN;
            DeltaSpot = double.NaN;
            DeltaForward = double.NaN;
            Gamma = double.NaN;
            Vega = double.NaN;
            RhoDom = double.NaN;
            RhoFor = double.NaN;
            Theta = double.NaN;
            Charm = double.NaN;
            Vanna = double.NaN;
            Volga = double.NaN;
            Zomma = double.NaN;
            Speed = double.NaN;
        }

    }
}

