using System.ComponentModel;
namespace AdminOpciones.Struct
{
    public class StructCondicionesGenerales : INotifyPropertyChanged
    {
        public StructCondicionesGenerales() { }
        public StructCondicionesGenerales(string vf, string clrut, string cldv, string clcodigo, string clnombre, string clfechafirma_cond_opc, string clfechafirma_supl_opc, string clfechafirma_cond_opcchk, string clfechafirma_supl_opcchk, string chk_cond, string chk_supl)                                
        {
            VF = vf;
            ClRut = clrut;
            ClCodigo = clcodigo;
            ClDV = cldv;
            ClNombre = clnombre;
            ClFechaFirma_Cond_Opc = clfechafirma_cond_opc;
            ClFechaFirma_Supl_Opc = clfechafirma_supl_opc;
            ClFechaFirma_Supl_OpcChk = clfechafirma_supl_opcchk;
            ClFechaFirma_Cond_OpcChk = clfechafirma_cond_opcchk;
            Chk_Cond = chk_cond;
            Chk_Supl = chk_supl;
        }

        #region "Parametros publicos"   
        public string VF { get; set; }
        public string ClRut { get; set; }
        public string ClCodigo { get; set; }
        public string ClDV { get; set; } 
        public string ClNombre { get; set; }
        public string ClFechaFirma_Cond_Opc { get; set; }
        public string ClFechaFirma_Supl_Opc { get; set; }
        public string ClFechaFirma_Supl_OpcChk { get; set; }
        public string ClFechaFirma_Cond_OpcChk { get; set; }
        public string Chk_Cond { get; set; }
        public string Chk_Supl { get; set; }

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
                    return this.VF;
                }
                else
                {
                    return "0";
                }
            }
            set
            {
                if (value != this.VF)
                {
                    this.ClRut = value;
                    NotifyPropertyChanged("VF");
                }
            }
        }

        public string sClRut
        {
            get
            {
                if (ClRut != "" && ClRut != null)
                {
                    return this.ClRut;
                }
                else
                {
                    return "0";
                }
            }
            set
            {
                if (value != this.ClRut)
                {
                    this.ClRut = value;
                    NotifyPropertyChanged("ClRut");
                }
            }
        }

        public string sClCodigo
        {
            get
            {
                if (ClCodigo != "" && ClCodigo != null)
                {
                    return this.ClCodigo;
                }
                else
                {
                    return "0";
                }
            }
            set
            {
                if (value != this.ClCodigo)
                {
                    this.ClCodigo = value;
                    NotifyPropertyChanged("ClCodigo");
                }
            }
        }

        public string sClNombre
        {
            get
            {
                if (ClNombre != "" && ClNombre != null)
                {
                    return this.ClNombre.ToString();
                }
                else
                {
                    return "";
                }
            }
            set
            {
                if (value != this.ClNombre)
                {
                    this.ClNombre = value;
                    NotifyPropertyChanged("ClNombre");
                }
            }
        }

        public string sClDV 
        {
            get
            {
                if (ClDV != "" && ClDV != null)
                {
                    return this.ClDV.ToString();
                }
                else
                {
                    return "";
                }
            }
            set
            {
                if (value != this.ClDV)
                {
                    this.ClDV = value;
                    NotifyPropertyChanged("ClDV");
                }
            }
        }

        public string sClFechaFirma_Cond_Opc
        {
            get
            {
                if (ClFechaFirma_Cond_Opc != "" && ClFechaFirma_Cond_Opc != null)
                {
                    return this.ClFechaFirma_Cond_Opc.ToString();
                }
                else
                {
                    return "";
                }
            }
            set
            {
                if (value != this.ClFechaFirma_Cond_Opc)
                {
                    this.ClFechaFirma_Cond_Opc = value;
                    NotifyPropertyChanged("ClFechaFirma_Cond_Opc");
                }
            }
        }

        public string sClFechaFirma_Supl_Opc
        {
            get
            {
                if (ClFechaFirma_Supl_Opc != "" && ClFechaFirma_Supl_Opc != null)
                {
                    return this.ClFechaFirma_Supl_Opc.ToString();
                }
                else
                {
                    return "";
                }
            }
            set
            {
                if (value != this.ClFechaFirma_Supl_Opc)
                {
                    this.ClFechaFirma_Supl_Opc = value;
                    NotifyPropertyChanged("ClFechaFirma_Supl_Opc");
                }
            }
        }


        public string sClFechaFirma_Cond_OpcChk
        {
            get
            {
                if (ClFechaFirma_Cond_OpcChk != "" && ClFechaFirma_Cond_OpcChk != null)
                {
                    return this.ClFechaFirma_Cond_OpcChk.ToString();
                }
                else
                {
                    return "";
                }
            }
            set
            {
                if (value != this.ClFechaFirma_Cond_OpcChk)
                {
                    this.ClFechaFirma_Cond_OpcChk = value;
                    NotifyPropertyChanged("ClFechaFirma_Cond_OpcChk");
                }
            }
        }

        public string sClFechaFirma_Supl_OpcChk
        {
            get
            {
                if (ClFechaFirma_Supl_OpcChk != "" && ClFechaFirma_Supl_OpcChk != null)
                {
                    return this.ClFechaFirma_Supl_OpcChk.ToString();
                }
                else
                {
                    return "";
                }
            }
            set
            {
                if (value != this.ClFechaFirma_Supl_OpcChk)
                {
                    this.ClFechaFirma_Supl_OpcChk = value;
                    NotifyPropertyChanged("ClFechaFirma_Supl_OpcChk");
                }
            }
        }   

        public string sChk_Cond
        {
            get
            {
                if (Chk_Cond != "" && Chk_Cond != null)
                {
                    return this.Chk_Cond.ToString();
                }
                else
                {
                    return "";
                }
            }
            set
            {
                if (value != this.Chk_Cond)
                {
                    this.Chk_Cond = value;
                    NotifyPropertyChanged("Chk_Cond");
                }
            }
        }

        public string sChk_Supl
        {
            get
            {
                if (Chk_Supl != "" && Chk_Supl != null)
                {
                    return this.Chk_Supl.ToString();
                }
                else
                {
                    return "";
                }
            }
            set
            {
                if (value != this.Chk_Supl)
                {
                    this.Chk_Supl = value;
                    NotifyPropertyChanged("Chk_Supl");
                }
            }
        }  
    }
}