using System.ComponentModel;
namespace AdminOpciones.Struct
{
    public class StructPagosCompensados : INotifyPropertyChanged
    {
        public StructPagosCompensados() { }
        public StructPagosCompensados(string vf,
                                     string numcontrato,
                                     string numestructura,
                                     string fechaejercicio,
                                     string fechacontrato,
                                     string clirut,
                                     string clidv,
                                     string clicod,
                                     string clinom,
                                     string mdacompdsc,
                                     string formapagocompdsc,
                                     string montorecibir,
                                     string montopagar,
                                     string origendsc,
                                     string temporalidad,
                                     string vctovaluta,         // Map 04 Septiembre 2009
                                     string codestructura,      // ASVG_20110322 Para diferenciar reportes de vencimiento/pagos compensados
                                     string tipotransaccion,
                                     string tipopayOff,
                                     string tipobfwopt)
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
            MdaCompDsc = mdacompdsc;
            FormaPagoCompDsc = formapagocompdsc;
            MontoRecibir = montorecibir;
            MontoPagar = montopagar;
            OrigenCod = "";
            OrigenDsc = origendsc;
            Temporalidad = temporalidad;
            FormaPagoCompCod = "";
            VctoValuta = VctoValuta; // MAP 04 Septiembre 2009
            CodEstructura = codestructura; // ASVG_20110322 Para diferenciar reportes de vencimiento/pagos compensados this.CodEstructura = codestructura;
            TipoTransaccion = tipotransaccion;
            TipoPayOff = tipopayOff;
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
        public string MdaCompDsc { get; set; }
        public string FormaPagoCompCod { get; set; }
        public string FormaPagoCompDsc { get; set; }
        public string MontoRecibir { get; set; }
        public string MontoPagar { get; set; }
        public string OrigenCod { get; set; }
        public string OrigenDsc { get; set; }
        public string Temporalidad { get; set; }
        public string VctoValuta { get; set; }  // MAP 04 Septiembre 2009
        public string CodEstructura { get; set; }       // ASVG_20110322 Para diferenciar reportes de vencimiento/pagos compensados
        public string TipoTransaccion { get; set; }
        public string TipoPayOff { get; set; }
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

        public string sMdaCompDsc
        {
            get
            {
                if (MdaCompDsc != "" && MdaCompDsc != null)
                {
                    return this.MdaCompDsc.ToString();
                }
                else
                {
                    return "";
                }
            }
            set
            {
                if (value != this.MdaCompDsc)
                {
                    this.MdaCompDsc = value;
                    NotifyPropertyChanged("MdaCompDsc");
                }
            }
        }

        public string sFormaPagoCompDsc
        {
            get
            {
                if (FormaPagoCompDsc != "" && FormaPagoCompDsc != null)
                {
                    return this.FormaPagoCompDsc.ToString();
                }
                else
                {
                    return "";
                }
            }
            set
            {
                if (value != this.FormaPagoCompDsc)
                {
                    this.FormaPagoCompDsc = value;
                    NotifyPropertyChanged("FormaPagoCompDsc");
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

        // MAP 04 Septiembre 2009
        public string sVctoValuta
        {
            get
            {
                if (VctoValuta != "" && VctoValuta  != null)
                {
                    return this.VctoValuta ;
                }
                else
                {
                    return "0";
                }
            }
            set
            {
                if (value != this.VctoValuta)
                {
                    this.VctoValuta = value;
                    NotifyPropertyChanged("VctoValuta");
                }
            }
        }
        // MAP 04 Septiembre 2009

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
        
        //Papeleta productos Asiáticos prd_12567
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