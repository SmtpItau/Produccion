using System.ComponentModel;
namespace AdminOpciones.Struct
{
    public class StructMoCotizacion : INotifyPropertyChanged
    {
        public StructMoCotizacion() { }
        public StructMoCotizacion(string vf,
                                string numcontrato,    
                                string numfolio,              
                                string clinom,
                                string opcestdsc,
                                string operador,
                                string objeto,
                                string clicod,
                                string clirut,
                                string clidv,
                                string opcestcod,
                                string fechacreacionregistro,
                                string fechacontrato)
        {
            VF = vf;
            NumContrato = numcontrato;
            NumFolio = numfolio;
            CliNom = clinom;
            OpcEstDsc = opcestdsc;
            Operador = operador;
            Objeto = objeto;
            CliCod = clicod;
            CliRut = clirut;
            CliDv = clidv;
            OpcEstCod = opcestcod;
            FechaCreacionRegistro = fechacreacionregistro;
            FechaContrato = fechacontrato;

        }

        #region "Parametros publicos"
        
        public string VF { get; set; }
        public string NumContrato { get; set; }
        public string NumFolio { get; set; }
        public string CliNom { get; set; }
        public string OpcEstDsc { get; set; }
        public string Operador { get; set; }
        public string Objeto { get; set; }
        public string CliCod { get; set; }
        public string CliRut { get; set; }
        public string CliDv { get; set; }
        public string OpcEstCod { get; set; }
        public string FechaCreacionRegistro { get; set; }
        public string FechaContrato { get; set; }

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

        public string sCliDv 
        {
            get
            {
                if (CliDv != "" && CliDv != null)
                {
                    return this.CliDv.ToString();
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

        public string sFechaCreacionRegistro
        {
            get
            {
                if (FechaCreacionRegistro != "" && FechaCreacionRegistro != null)
                {
                    return this.FechaCreacionRegistro.ToString();
                }
                else
                {
                    return "";
                }
            }
            set
            {
                if (value != this.FechaCreacionRegistro)
                {
                    this.FechaCreacionRegistro = value;
                    NotifyPropertyChanged("FechaCreacionRegistro");
                }
            }
        }
    }
}