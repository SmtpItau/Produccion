using System.ComponentModel;
namespace AdminOpciones.Struct
{
    public class StructLiquidacionDef : INotifyPropertyChanged
    {
        #region "Parametros publicos"

        public string VF { get; set; }
        public string NumContrato { get; set; }
        public string FechaEjercicio { get; set; }
        public string FechaContrato { get; set; }
        public string CliRut { get; set; }
        public string CliDv { get; set; }
        public string CliCod { get; set; }
        public string CliNom { get; set; }
        public string Estado { get; set; }
        public string Contrapartida { get; set; }
        public string Operador { get; set; }
        public string ModalidadDsc { get; set; }
        public string OrigenDsc { get; set; }
        public string Mda1Dsc { get; set; }
        public string Mda1Mto { get; set; }
        public string Mda2Dsc { get; set; }
        public string Mda2Mto { get; set; }
        public string CodEstructura { get; set; }//PRD_12567
        public string TipoTransaccion { get; set; }
        public string TipoPayOff { get; set; }
        public string TipoBfwOpt { get; set; }

        #endregion "Parametros publicos"

        #region Constructores

        public StructLiquidacionDef() { }
        public StructLiquidacionDef(string vf,
                                     string numcontrato,
                                     string fechaejercicio,
                                     string fechacontrato,
                                     string clirut,
                                     string clidv,
                                     string clicod,
                                     string clinom,
                                     string estado,
                                     string contrapartida,
                                     string operador,
                                     string modalidaddsc,
                                     string origendsc,
                                     string mda1dsc,
                                     string mda1mto,
                                     string mda2dsc,
                                     string mda2mto)
        {
            VF = vf;
            NumContrato = numcontrato;
            FechaEjercicio = fechaejercicio;
            FechaContrato = fechacontrato;
            CliRut = clirut;
            CliDv = clidv;
            CliCod = clicod;
            CliNom = clinom;
            Estado = estado;
            Contrapartida = contrapartida;
            Operador = operador;
            ModalidadDsc = modalidaddsc;
            OrigenDsc = origendsc;
            Mda1Dsc = mda1dsc;
            Mda1Mto = mda1mto;
            Mda2Dsc = mda2dsc;
            Mda2Mto = mda2mto;
            System.Windows.Browser.HtmlPage.Window.Alert("Constructor viejo");
        }

        public StructLiquidacionDef(string vf,
                                    string numcontrato,
                                    string fechaejercicio,
                                    string fechacontrato,
                                    string clirut,
                                    string clidv,
                                    string clicod,
                                    string clinom,
                                    string estado,
                                    string contrapartida,
                                    string operador,
                                    string modalidaddsc,
                                    string origendsc,
                                    string mda1dsc,
                                    string mda1mto,
                                    string mda2dsc,
                                    string mda2mto,
                                    string codestructura,
                                    string tipotransaccion,
                                    string tipopayOff,
                                    string tipobfwopt
            )
        {
            VF = vf;
            NumContrato = numcontrato;
            FechaEjercicio = fechaejercicio;
            FechaContrato = fechacontrato;
            CliRut = clirut;
            CliDv = clidv;
            CliCod = clicod;
            CliNom = clinom;
            Estado = estado;
            Contrapartida = contrapartida;
            Operador = operador;
            ModalidadDsc = modalidaddsc;
            OrigenDsc = origendsc;
            Mda1Dsc = mda1dsc;
            Mda1Mto = mda1mto;
            Mda2Dsc = mda2dsc;
            Mda2Mto = mda2mto;
            CodEstructura = codestructura;//Papeleta productos Asiáticos
            TipoTransaccion = tipotransaccion;
            TipoPayOff = tipopayOff;
            TipoBfwOpt = tipobfwopt;
            System.Windows.Browser.HtmlPage.Window.Alert("Constructor nuevo");
        }

        #endregion Constructores

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

        public string sEstado
        {
            get
            {
                if (Estado != "" && Estado != null)
                {
                    return this.Estado.ToString();
                }
                else
                {
                    return "";
                }
            }
            set
            {
                if (value != this.Estado)
                {
                    this.Estado = value;
                    NotifyPropertyChanged("Estado");
                }
            }
        }

        public string sContrapartida
        {
            get
            {
                if (Contrapartida != "" && Contrapartida != null)
                {
                    return this.Contrapartida.ToString();
                }
                else
                {
                    return "";
                }
            }
            set
            {
                if (value != this.Contrapartida)
                {
                    this.Contrapartida = value;
                    NotifyPropertyChanged("Contrapartida");
                }
            }
        }

        public string sOperador
        {
            get
            {
                if (Operador != "" && Operador != null)
                {
                    return this.Operador.ToString();
                }
                else
                {
                    return "";
                }
            }
            set
            {
                if (value != this.Operador)
                {
                    this.Operador = value;
                    NotifyPropertyChanged("Operador");
                }
            }
        }

        public string sModalidadDsc
        {
            get
            {
                if (ModalidadDsc != "" && ModalidadDsc != null)
                {
                    return this.ModalidadDsc.ToString();
                }
                else
                {
                    return "";
                }
            }
            set
            {
                if (value != this.ModalidadDsc)
                {
                    this.ModalidadDsc = value;
                    NotifyPropertyChanged("ModalidadDsc");
                }
            }
        }

        public string sOrigenDsc
        {
            get
            {
                if (OrigenDsc != "" && OrigenDsc != null)
                {
                    return this.OrigenDsc.ToString();
                }
                else
                {
                    return "";
                }
            }
            set
            {
                if (value != this.OrigenDsc)
                {
                    this.OrigenDsc = value;
                    NotifyPropertyChanged("OrigenDsc");
                }
            }
        }

        public string sMda1Dsc
        {
            get
            {
                if (Mda1Dsc != "" && Mda1Dsc != null)
                {
                    return this.Mda1Dsc.ToString();
                }
                else
                {
                    return "";
                }
            }
            set
            {
                if (value != this.Mda1Dsc)
                {
                    this.Mda1Dsc = value;
                    NotifyPropertyChanged("Mda1Dsc");
                }
            }
        }

        public string sMda1Mto
        {
            get
            {
                if (Mda1Mto != "" && Mda1Mto != null)
                {
                    return this.Mda1Mto.ToString();
                }
                else
                {
                    return "";
                }
            }
            set
            {
                if (value != this.Mda1Mto)
                {
                    this.Mda1Mto = value;
                    NotifyPropertyChanged("Mda1Mto");
                }
            }
        }

        public string sMda2Dsc
        {
            get
            {
                if (Mda2Dsc != "" && Mda2Dsc != null)
                {
                    return this.Mda2Dsc.ToString();
                }
                else
                {
                    return "";
                }
            }
            set
            {
                if (value != this.Mda2Dsc)
                {
                    this.Mda2Dsc = value;
                    NotifyPropertyChanged("Mda2Dsc");
                }
            }
        }

        public string sMda2Mto
        {
            get
            {
                if (Mda2Mto != "" && Mda2Mto != null)
                {
                    return this.Mda2Mto.ToString();
                }
                else
                {
                    return "";
                }
            }
            set
            {
                if (value != this.Mda2Mto)
                {
                    this.Mda2Mto = value;
                    NotifyPropertyChanged("Mda2Mto");
                }
            }
        }
       
        //PRD_12567
        //Se necesita el código de estructura para diferenciar el tipo de carta de liquidación.
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
        }

        //Papeleta productos Asiáticos
        public string sTipoTransaccion
        {
            get
            {
                if (TipoTransaccion != "" && TipoTransaccion != null)
                {
                    return this.TipoTransaccion.ToString();
                }
                else
                {
                    return "";
                }
            }
            set
            {
                if (value != this.TipoTransaccion)
                {
                    this.TipoTransaccion = value;
                    NotifyPropertyChanged("TipoTransaccion");
                }
            }
        }

        public string sTipoPayOff
        {
            get
            {
                if (TipoPayOff != "" && TipoPayOff != null)
                {
                    return this.TipoPayOff.ToString();
                }
                else
                {
                    return "";
                }
            }
            set
            {
                if (value != this.TipoPayOff)
                {
                    this.TipoPayOff = value;
                    NotifyPropertyChanged("TipoPayOff");
                }
            }
        }

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