using System.ComponentModel;
namespace AdminOpciones.Struct
{
    public class StructCaContrato : INotifyPropertyChanged
    {
        public StructCaContrato() { }
        public StructCaContrato(string vf,
                                string objeto,
                                string numcontrato,
                                string tipotransaccion, 
                                string numfolio,        
                                string fechacontrato,   
                                string conopcestcod,
                                string conopcestdsc,
                                string clirut,          
                                string clicod,          
                                string clidv,           
                                string clinom,
                                string operador,
                                string opcestcod,
                                string opcestdsc,
                                string payoffcod,
                                string contrapartida)
        {
            VF = vf;
            Objeto = objeto;
            NumContrato = numcontrato;
            TipoTransaccion = tipotransaccion;
            NumFolio = numfolio;
            FechaContrato = fechacontrato;
            ConOpcEstCod = conopcestcod;
            ConOpcEstDsc = conopcestdsc;
            CliRut = clirut;
            CliCod = clicod;
            CliDv = clidv;
            CliNom = clinom;
            Operador = operador;
            OpcEstCod = opcestcod;
            OpcEstDsc = opcestdsc;
            PayOffCod = "payoffcod";
            Contrapartida = contrapartida;
            Marca = false;
        }

        public bool Marca { get; set; }
        public string VF { get; set; }
        public string Objeto { get; set; }
        public string NumContrato { get; set; }
        public string NumFolio { get; set; }
        public string FechaContrato { get; set; }
        public string ConOpcEstCod { get; set; }
        public string ConOpcEstDsc { get; set; }
        public string CliRut { get; set; }
        public string CliCod { get; set; }
        public string CliDv { get; set; } //ojo puede haber problemas con esta variable
        public string CliNom { get; set; }
        public string Operador { get; set; }
        public string OpcEstCod { get; set; }
        public string OpcEstDsc { get; set; }
        public string Contrapartida { get; set; }
        public string PayOffCod { get; set; }
        public string TipoTransaccion { get; set; }

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

        public string sObjeto
        {
            get
            {
                if (Objeto != "" && Objeto != null)
                {
                    return this.Objeto.ToString();
                }
                else
                {
                    return "";
                }
            }
            set
            {
                if (value != this.Objeto)
                {
                    this.Objeto = value;
                    NotifyPropertyChanged("Objeto");
                }
            }
        }

        public string sNumContrato
        {
            get
            {
                if (NumContrato != "" && NumContrato != null)
                {
                    return this.NumContrato;
                }
                else
                {
                    return "0";
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

        public string sNumFolio
        {
            get
            {
                if (NumFolio != "" && NumFolio != null)
                {
                    return this.NumFolio;
                }
                else
                {
                    return "0";
                }
            }
            set
            {
                if (value != this.NumFolio)
                {
                    this.NumFolio = value;
                    NotifyPropertyChanged("NumFolio");
                }
            }
        }

        public string sFechaContrato
        {
            get
            {
                if (FechaContrato != "" && FechaContrato != null)
                {
                    return this.FechaContrato.ToString();
                }
                else
                {
                    return "";
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
        } //tema de la fecha no olvidar

        public string sConOpcEstCod
        {
            get
            {
                if (ConOpcEstCod != "" && ConOpcEstCod != null)
                {
                    return this.ConOpcEstCod.ToString();
                }
                else
                {
                    return "";
                }
            }
            set
            {
                if (value != this.ConOpcEstCod)
                {
                    this.ConOpcEstCod = value;
                    NotifyPropertyChanged("ConOpcEstCod");
                }
            }
        }

        public string sConOpcEstDsc
        {
            get
            {
                if (ConOpcEstDsc != "" && ConOpcEstDsc != null)
                {
                    return this.ConOpcEstDsc.ToString();
                }
                else
                {
                    return "";
                }
            }
            set
            {
                if (value != this.ConOpcEstDsc)
                {
                    this.ConOpcEstDsc = value;
                    NotifyPropertyChanged("ConOpcEstDsc");
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

        public string sCliDv //ojo puede haber error en la conversion
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

        public string sOpcEstCod
        {
            get
            {
                if (OpcEstCod != "" && OpcEstCod != null)
                {
                    return this.OpcEstCod.ToString();
                }
                else
                {
                    return "";
                }
            }
            set
            {
                if (value != this.OpcEstCod)
                {
                    this.OpcEstCod = value;
                    NotifyPropertyChanged("OpcEstCod");
                }
            }
        }

        public string sOpcEstDsc
        {
            get
            {
                if (OpcEstDsc != "" && OpcEstDsc != null)
                {
                    return this.OpcEstDsc.ToString();
                }
                else
                {
                    return "";
                }
            }
            set
            {
                if (value != this.OpcEstDsc)
                {
                    this.OpcEstDsc = value;
                    NotifyPropertyChanged("OpcEstDsc");
                }
            }
        }

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

        public string sPayOffCod
        {
            get
            {
                if (PayOffCod != "" && PayOffCod != null)
                {
                    return this.PayOffCod.ToString();
                }
                else
                {
                    return "";
                }
            }
            set
            {
                if (value != this.PayOffCod)
                {
                    this.PayOffCod = value;
                    NotifyPropertyChanged("PayOffCod");
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

    }
}
