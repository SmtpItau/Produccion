using System.ComponentModel;
namespace AdminOpciones.Struct
{
    public class StructProcesoDecisionEjer : INotifyPropertyChanged
    {
        public StructProcesoDecisionEjer() { }
        public StructProcesoDecisionEjer(string vf,
                                     string numcontrato,
                                     string fechapagoejer,
                                     string modalidaddsc,
                                     string clirut,
                                     string clidv,
                                     string clicod,
                                     string clinom,
                                     string numcomponente,
                                     string numcajfolio,
                                     string payofftipcod,
                                     string payofftipdsc,
                                     string compraventaopcdsc,
                                     string mdarecibirdsc,
                                     string formapagorecibirdsc,
                                     string montorecibir,
                                     string mdapagardsc,
                                     string formapagopagardsc,
                                     string montopagar,
                                     string mtmimplicito,
                                     string estadoejerciciodsc)
        {
            VF = vf;
            NumContrato = numcontrato;
            FechaPagoEjer = FechaPagoEjer;
            ModalidadDsc = modalidaddsc;
            CliRut = clirut;
            CliDv = clirut;
            CliCod = clicod;
            CliNom = clinom;
            NumComponente = numcomponente;
            NumCajFolio = numcajfolio;
            PayOffTipCod = payofftipcod;
            PayOffTipDsc = payofftipdsc;
            CompraVentaOpcDsc = compraventaopcdsc;
            MdaRecibirDsc = mdarecibirdsc;
            FormaPagoRecibirDsc = formapagorecibirdsc;
            MontoRecibir = montorecibir;
            MdaPagarDsc = mdapagardsc;
            FormaPagoPagarDsc = formapagopagardsc;
            MontoPagar = montopagar;
            MTMImplicito = mtmimplicito;
            EstadoEjercicioDsc = estadoejerciciodsc;
        }

        #region "Parametros publicos"
        public string VF { get; set; }
        public string NumContrato { get; set; }
        public string FechaPagoEjer { get; set; }
        public string ModalidadDsc { get; set; }
        public string CliRut { get; set; }
        public string CliDv { get; set; }
        public string CliCod { get; set; }
        public string CliNom { get; set; }
        public string NumComponente { get; set; }
        public string NumCajFolio { get; set; }
        public string PayOffTipCod { get; set; }
        public string PayOffTipDsc { get; set; }
        public string CompraVentaOpcDsc { get; set; }
        public string MdaRecibirDsc { get; set; }
        public string FormaPagoRecibirDsc { get; set; }
        public string MontoRecibir { get; set; }
        public string MdaPagarDsc { get; set; }
        public string FormaPagoPagarDsc { get; set; }
        public string MontoPagar { get; set; }
        public string MTMImplicito { get; set; }
        public string EstadoEjercicioDsc { get; set; }

        #endregion

        public event PropertyChangedEventHandler PropertyChanged;

        private void NotifyPropertyChanged(string p)
        {
            if (PropertyChanged != null)
            {
                PropertyChanged(this, new PropertyChangedEventArgs(p));
            }
        }

        public string sVF
        {
            get
            {
                if (VF != "" && VF != null)
                {
                    return this.VF.ToString();
                }
                else
                {
                    return "";
                }
            }
            set
            {
                if (value != this.VF)
                {
                    this.VF = value;
                    NotifyPropertyChanged("VF");
                }
            }
        }

        public string sNumContrato
        {
            get
            {
                if (NumContrato != "" && NumContrato != null)
                {
                    return this.NumContrato.ToString();
                }
                else
                {
                    return "";
                }
            }
            set
            {
                if (value != this.NumContrato)
                {
                    this.NumContrato = value;
                    NotifyPropertyChanged("NumContrato");
                }
            }
        }

        public string sCliRut
        {
            get
            {
                if (CliRut != "" && CliRut != null)
                {
                    return this.CliRut;
                }
                else
                {
                    return "0";
                }
            }
            set
            {
                if (value != this.CliRut)
                {
                    this.CliRut = value;
                    NotifyPropertyChanged("CliRut");
                }
            }
        }

        public string sCliCod
        {
            get
            {
                if (CliCod != "" && CliCod != null)
                {
                    return this.CliCod;
                }
                else
                {
                    return "0";
                }
            }
            set
            {
                if (value != this.CliCod)
                {
                    this.CliCod = value;
                    NotifyPropertyChanged("CliCod");
                }
            }
        }

        public string sCliNom
        {
            get
            {
                if (CliNom != "" && CliNom != null)
                {
                    return this.CliNom.ToString();
                }
                else
                {
                    return "";
                }
            }
            set
            {
                if (value != this.CliNom)
                {
                    this.CliNom = value;
                    NotifyPropertyChanged("CliNom");
                }
            }
        }

        public string sCliDv
        {
            get
            {
                if (CliDv != "" && CliDv != null)
                {
                    return this.CliNom.ToString();
                }
                else
                {
                    return "";
                }
            }
            set
            {
                if (value != this.CliDv)
                {
                    this.CliDv = value;
                    NotifyPropertyChanged("CliDv");
                }
            }
        }

        public string sNumComponente
        {
            get
            {
                if (NumComponente != "" && NumComponente != null)
                {
                    return this.NumComponente.ToString();
                }
                else
                {
                    return "";
                }
            }
            set
            {
                if (value != this.NumComponente)
                {
                    this.NumComponente = value;
                    NotifyPropertyChanged("NumComponente");
                }
            }
        }

        public string sPayOffTipDsc
        {
            get
            {
                if (PayOffTipDsc != "" && PayOffTipDsc != null)
                {
                    return this.PayOffTipDsc.ToString();
                }
                else
                {
                    return "";
                }
            }
            set
            {
                if (value != this.PayOffTipDsc)
                {
                    this.PayOffTipDsc = value;
                    NotifyPropertyChanged("PayOffTipDsc");
                }
            }
        }


        public string sCompraVentaOpcDsc
        {
            get
            {
                if (CompraVentaOpcDsc != "" && CompraVentaOpcDsc != null)
                {
                    return this.CompraVentaOpcDsc.ToString();
                }
                else
                {
                    return "";
                }
            }
            set
            {
                if (value != this.CompraVentaOpcDsc)
                {
                    this.CompraVentaOpcDsc = value;
                    NotifyPropertyChanged("CompraVentaOpcDsc");
                }
            }
        }

        public string sFechaPagoEjer
        {
            get
            {
                if (FechaPagoEjer != "" && FechaPagoEjer != null)
                {
                    return this.FechaPagoEjer.ToString();
                }
                else
                {
                    return "";
                }
            }
            set
            {
                if (value != this.FechaPagoEjer)
                {
                    this.FechaPagoEjer = value;
                    NotifyPropertyChanged("FechaPagoEjer");
                }
            }
        }

        public string sNumCajFolio
        {
            get
            {
                if (NumCajFolio != "" && NumCajFolio != null)
                {
                    return this.NumCajFolio.ToString();
                }
                else
                {
                    return "";
                }
            }
            set
            {
                if (value != this.NumCajFolio)
                {
                    this.NumCajFolio = value;
                    NotifyPropertyChanged("NumCajFolio");
                }
            }
        }

        public string sPayOffTipCod
        {
            get
            {
                if (PayOffTipCod != "" && PayOffTipCod != null)
                {
                    return this.PayOffTipCod.ToString();
                }
                else
                {
                    return "";
                }
            }
            set
            {
                if (value != this.PayOffTipCod)
                {
                    this.PayOffTipCod = value;
                    NotifyPropertyChanged("PayOffTipCod");
                }
            }
        }

        public string sMdaRecibirDsc
        {
            get
            {
                if (MdaRecibirDsc != "" && MdaRecibirDsc != null)
                {
                    return this.MdaRecibirDsc.ToString();
                }
                else
                {
                    return "";
                }
            }
            set
            {
                if (value != this.MdaRecibirDsc)
                {
                    this.MdaRecibirDsc = value;
                    NotifyPropertyChanged("MdaRecibirDsc");
                }
            }
        }

        public string sFormaPagoRecibirDsc
        {
            get
            {
                if (FormaPagoRecibirDsc != "" && FormaPagoRecibirDsc != null)
                {
                    return this.FormaPagoRecibirDsc.ToString();
                }
                else
                {
                    return "";
                }
            }
            set
            {
                if (value != this.FormaPagoRecibirDsc)
                {
                    this.FormaPagoRecibirDsc = value;
                    NotifyPropertyChanged("FormaPagoRecibirDsc");
                }
            }
        }

        public string sMontoRecibir
        {
            get
            {
                if (MontoRecibir != "" && MontoRecibir != null)
                {
                    return this.MontoRecibir.ToString();
                }
                else
                {
                    return "";
                }
            }
            set
            {
                if (value != this.MontoRecibir)
                {
                    this.MontoRecibir = value;
                    NotifyPropertyChanged("MontoRecibir");
                }
            }
        }

        public string sMdaPagarDsc
        {
            get
            {
                if (MdaPagarDsc != "" && MdaPagarDsc != null)
                {
                    return this.MdaPagarDsc.ToString();
                }
                else
                {
                    return "";
                }
            }
            set
            {
                if (value != this.MdaPagarDsc)
                {
                    this.MdaPagarDsc = value;
                    NotifyPropertyChanged("MdaPagarDsc");
                }
            }
        }

        public string sFormaPagoPagarDsc
        {
            get
            {
                if (FormaPagoPagarDsc != "" && FormaPagoPagarDsc != null)
                {
                    return this.FormaPagoPagarDsc.ToString();
                }
                else
                {
                    return "";
                }
            }
            set
            {
                if (value != this.FormaPagoPagarDsc)
                {
                    this.FormaPagoPagarDsc = value;
                    NotifyPropertyChanged("FormaPagoPagarDsc");
                }
            }
        }

        public string sMontoPagar
        {
            get
            {
                if (MontoPagar != "" && MontoPagar != null)
                {
                    return this.MontoPagar.ToString();
                }
                else
                {
                    return "";
                }
            }
            set
            {
                if (value != this.MontoPagar)
                {
                    this.MontoPagar = value;
                    NotifyPropertyChanged("MontoPagar");
                }
            }
        }

        public string sMTMImplicito
        {
            get
            {
                if (MTMImplicito != "" && MTMImplicito != null)
                {
                    return this.MTMImplicito.ToString();
                }
                else
                {
                    return "";
                }
            }
            set
            {
                if (value != this.MTMImplicito)
                {
                    this.MTMImplicito = value;
                    NotifyPropertyChanged("MTMImplicito");
                }
            }
        }

        public string sEstadoEjercicioDsc
        {
            get
            {
                if (EstadoEjercicioDsc != "" && EstadoEjercicioDsc != null)
                {
                    return this.EstadoEjercicioDsc.ToString();
                }
                else
                {
                    return "";
                }
            }
            set
            {
                if (value != this.EstadoEjercicioDsc)
                {
                    this.EstadoEjercicioDsc = value;
                    NotifyPropertyChanged("EstadoEjercicioDsc");
                }
            }
        }
    }
}