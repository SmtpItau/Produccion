using System.ComponentModel;
namespace AdminOpciones.Struct
{
    public class StructPagosFisica : INotifyPropertyChanged
    {
        public StructPagosFisica() { }
        public StructPagosFisica(string vf,
                                     string numcontrato,
                                     string numestructura,
                                     string fechaejercicio,
                                     string fechacontrato,
                                     string clirut,
                                     string clidv,
                                     string clicod,
                                     string clinom,
                                     string mdarecibirdsc,
                                     string formapagorecibirdsc,
                                     string montorecibir,
                                     string mdapagardsc,
                                     string montopagar,
                                     string formapagopagardsc,
                                     string temporalidad,
                                     string mtmimplicito, 
                                     string vctoValutaRecibir,  
                                     string vctoValutaPagar,
                                     string codestructura,
                                     string tipobfwopt)      // ASVG_20110322 Para diferenciar reportes de vencimiento/pagos entrega física.
        {

            VF = vf;
            NumContrato = numcontrato;
            NumEstructura = numestructura;
            FechaEjercicio = fechaejercicio;
            FechaContrato = fechacontrato;
            CliRut = clirut;
            CliDv = clidv;
            CliCod = clicod;
            CliNom = clinom;
            MdaRecibirDsc = mdarecibirdsc;
            FormaPagorecibirDsc = formapagorecibirdsc;
            MontoRecibir = montorecibir;
            MdaPagarDsc = mdapagardsc;
            MontoPagar = montopagar;
            FormaPagoPagarDsc = formapagopagardsc;
            Temporalidad = temporalidad;
            MTMImplicito = mtmimplicito;
            VctoValutaRecibir = vctoValutaRecibir;
            VctoValutaPagar = vctoValutaPagar;
            CodEstructura = codestructura;
            TipoBfwOpt = tipobfwopt;

        }

        #region "Parametros publicos"

        public int ID { get; set; }
        public string VF { get; set; }
        public string NumContrato { get; set; }
        public string NumEstructura { get; set; }
        public string FechaEjercicio { get; set; }
        public string FechaContrato { get; set; }
        public string CliRut { get; set; }
        public string CliDv { get; set; }
        public string CliCod { get; set; }
        public string CliNom { get; set; }
        public string MdaRecibirDsc { get; set; }
        public string FormaPagorecibirCod { get; set; }
        public string FormaPagorecibirDsc { get; set; }
        public string MontoRecibir { get; set; }
        public string MdaPagarDsc { get; set; }
        public string MontoPagar { get; set; }
        public string FormaPagoPagarCod { get; set; }
        public string FormaPagoPagarDsc { get; set; }
        public string Temporalidad { get; set; }
        public string MTMImplicito { get; set; }
        public string VctoValutaRecibir { get; set; }
        public string VctoValutaPagar { get; set; }
        public string CodEstructura { get; set; }
        public string TipoBfwOpt { get; set; }

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

        public string sNumEstructura
        {
            get
            {
                if (NumEstructura != "" && NumEstructura != null)
                {
                    return this.NumEstructura.ToString();
                }
                else
                {
                    return "";
                }
            }
            set
            {
                if (value != this.NumEstructura)
                {
                    this.NumEstructura = value;
                    NotifyPropertyChanged("NumEstructura");
                }
            }
        }

        public string sFechaEjercicio
        {
            get
            {
                if (FechaEjercicio != "" && FechaEjercicio != null)
                {
                    return this.FechaEjercicio;
                }
                else
                {
                    return "0";
                }
            }
            set
            {
                if (value != this.FechaEjercicio)
                {
                    this.FechaEjercicio = value;
                    NotifyPropertyChanged("FechaEjercicio");
                }
            }
        }

        public string sFechaContrato
        {
            get
            {
                if (FechaContrato != "" && FechaContrato != null)
                {
                    return this.FechaContrato;
                }
                else
                {
                    return "0";
                }
            }
            set
            {
                if (value != this.FechaContrato)
                {
                    this.FechaContrato = value;
                    NotifyPropertyChanged("FechaContrato");
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

        public string sFormaPagorecibirDsc
        {
            get
            {
                if (FormaPagorecibirDsc != "" && FormaPagorecibirDsc != null)
                {
                    return this.FormaPagorecibirDsc.ToString();
                }
                else
                {
                    return "";
                }
            }
            set
            {
                if (value != this.FormaPagorecibirDsc)
                {
                    this.FormaPagorecibirDsc = value;
                    NotifyPropertyChanged("FormaPagorecibirDsc");
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
                    NotifyPropertyChanged("Operador");
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


        public string sTemporalidad
        {
            get
            {
                if (Temporalidad != "" && Temporalidad != null)
                {
                    return this.Temporalidad.ToString();
                }
                else
                {
                    return "";
                }
            }
            set
            {
                if (value != this.Temporalidad)
                {
                    this.Temporalidad = value;
                    NotifyPropertyChanged("Temporalidad");
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

        public string sVctoValutaPagar
        {
            get
            {
                if (VctoValutaPagar != "" && VctoValutaPagar != null)
                {
                    return this.VctoValutaPagar;
                }
                else
                {
                    return "0";
                }
            }
            set
            {
                if (value != this.VctoValutaPagar)
                {
                    this.VctoValutaPagar = value;
                    NotifyPropertyChanged("VctoValutaPagar");
                }
            }
        }
        public string sVctoValutaRecibir
        {
            get
            {
                if (VctoValutaRecibir != "" && VctoValutaRecibir != null)
                {
                    return this.VctoValutaRecibir;
                }
                else
                {
                    return "0";
                }
            }
            set
            {
                if (value != this.VctoValutaRecibir)
                {
                    this.VctoValutaRecibir = value;
                    NotifyPropertyChanged("VctoValutaRecibir");
                }
            }
        }
        public string sCodEstructura
        {
            get
            {
                if (CodEstructura != "" && CodEstructura != null)
                {
                    return this.CodEstructura.ToString();
                }
                else
                {
                    return "";
                }
            }
            set
            {
                if (value != this.CodEstructura)
                {
                    this.CodEstructura = value;
                    NotifyPropertyChanged("CodEstructura");
                }
            }
        }//ASVG_20110323 Replicado sin entender...

        public string sTipoBfwOpt
        {
            get
            {
                if (TipoBfwOpt != "" && TipoBfwOpt != null)
                {
                    return this.TipoBfwOpt.ToString();
                }
                else
                {
                    return "";
                }
            }
            set
            {
                if (value != this.TipoBfwOpt)
                {
                    this.TipoBfwOpt = value;
                    NotifyPropertyChanged("TipoBfwOpt");
                }
            }
        }
    }
}