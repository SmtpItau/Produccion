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

namespace AdminOpciones.Struct.OpcionesXF.ValorizacionCartera
{
    public delegate void delegate_Checked(int NumContrato, bool Value);

    public class StructEncContrato
    {
        public event delegate_Checked Encabezado_Checked;

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
                Encabezado_Checked(NumContrato, isChecked);
            }
        }
        //PRD_10449
        public int RelacionaPAE { get; set; }
        public string sRelacionaPAE
        {
            get
            {
                if (!this.RelacionaPAE.Equals(null))
                {
                    return this.RelacionaPAE.ToString("#,##0");
                }
                else
                {
                    return "";
                }
            }
        }
        public int NumContrato { get; set; }
        public int NumFolio { get; set; }
        public int CodEstructura { get; set; }
        public string CVEstructura { get; set; } // C, V 
        public DateTime FechaContrato { get; set; }
        public DateTime FecValorizacion { get; set; }
        public int CarteraFinanciera { get; set; }
        public string FinancialPortfolio { get; set; }
        public int Libro { get; set; }
        public string Book { get; set; }
        public string CarNormativa { get; set; }
        public string PortfolioRules { get; set; }
        public int SubCarNormativa { get; set; }
        public string SubPortfolioRules { get; set; }
        public int RutCliente { get; set; }
        public int Codigo { get; set; }
        public string NombreCliente { get; set; }
        public string TipoContrapartida { get; set; }
        public int CodMonPagPrima { get; set; }
        public double PrimaInicial { get; set; }
        public double ParMdaPrima { get; set; }
        public double PrimaInicialML { get; set; }
        public int fPagoPrima { get; set; }
        public string Estado { get; set; }
        public string GlosaEstado { get; set; }
        public string Opcion { get; set; }
        public string Glosa { get; set; }
        public string FormaPagoPrima { get; set; }
        //5843
        public double ResultadoVta { get; set; }

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

        public string sFechaContrato
        {
            get
            {
                return FechaContrato.ToString("dd/MM/yyyy");
            }
        }

        public string sFecValorizacion
        {
            get
            {
                return FecValorizacion.ToString("dd/MM/yyyy");
            }
        }

        public string Estructura
        {
            get
            {
                return Opcion;
            }
        }

        public string sCVEstructura
        {
            get
            {
                if (CVEstructura.Equals("C"))
                {
                    return "Compra";
                }
                else
                {
                    return "Venta";
                }

            }

        }

        public string sPrimaInicial
        {
            get
            {
                if (!PrimaInicial.Equals(double.NaN))
                {
                    return PrimaInicial.ToString("#,##0");
                }
                else
                {
                    return "";
                }
            }
        }


        //5843
        public string sResultadoVta
        {
            get
            {
                if (!ResultadoVta.Equals(double.NaN))
                {
                    return ResultadoVta.ToString("#,##0");
                }
                else
                {
                    return "";
                }
            }
        }

        public StructEncContrato()
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
