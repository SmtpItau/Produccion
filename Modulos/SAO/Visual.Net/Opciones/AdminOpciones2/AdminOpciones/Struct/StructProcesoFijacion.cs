using System.ComponentModel;
using System;
namespace AdminOpciones.Struct
{
    public class StructProcesoFijacion : INotifyPropertyChanged
    {
        public StructProcesoFijacion() { }
        public StructProcesoFijacion(string numcontrato,
                                     DateTime fechafijacion,
                                     string opcestdsc,
                                     string opcestcod,
                                     string clirut,
                                     string clidv,
                                     string clicod,
                                     string clinom,
                                     string numcomponente,
                                     string payofftipdsc,
                                     string callput,
                                     string compraventaopcdsc,
                                     string fechapagoejer,
                                     string mon1dsc,
                                     string modalidaddsc,
                                     string mdacompensaciondsc,
                                     string strike,
                                     string pesofijacion,
                                     string fixbenchcompdsc,
                                     string fixparbench,
                                     string fixbenchcomphora,
                                     string fixValorfijacion,
                                     string fixbenchmdacodvalordefvalor,
                                     string refijable,
                                     string fixbencheseditable,
                                     string numerofijacion)
        {
            NumContrato = numcontrato;
            FechaFijacion = fechafijacion;
            OpcEstDsc = opcestdsc;
            OpcEstCod = opcestcod;
            CliRut = clirut;
            CliDv = clidv;
            CliCod = clicod;
            CliNom = clinom;
            NumComponente = numcomponente;
            PayOffTipDsc = payofftipdsc;
            CallPut = callput;
            CompraVentaOpcDsc = compraventaopcdsc;
            FechaPagoEjer = fechapagoejer;
            Mon1Dsc = mon1dsc;
            ModalidadDsc = modalidaddsc;
            MdaCompensacionDsc = mdacompensaciondsc;
            Strike = strike;
            PesoFijacion = pesofijacion;
            FixBenchCompDsc = fixbenchcompdsc;
            FixParBench = fixparbench;
            FixBenchCompHora = fixbenchcomphora;
            FixValorFijacion = fixValorfijacion;
            FixBenchMdaCodValorDefValor = fixbenchmdacodvalordefvalor;
            Refijable = refijable;
            FixBenchEsEditable = fixbencheseditable; 
            NumeroFijacion = numerofijacion;

        }

        #region "Parametros publicos"
        public string NumContrato { get; set; }
        public DateTime FechaFijacionAux { get; set; }
        public DateTime FechaFijacion { get; set; }
        public string OpcEstDsc { get; set; }
        public string OpcEstCod { get; set; }
        public string CliRut { get; set; }
        public string CliDv { get; set; }
        public string CliCod { get; set; }
        public string CliNom { get; set; }
        public string NumComponente { get; set; }
        public string PayOffTipDsc { get; set; }
        public string CallPut { get; set; }
        public string CompraVentaOpcDsc { get; set; }
        public string FechaPagoEjer { get; set; }
        public string Mon1Dsc { get; set; }
        public string ModalidadDsc { get; set; }
        public string MdaCompensacionDsc { get; set; }
        public string Strike { get; set; }
        public string PesoFijacion { get; set; }
        public string FixBenchCompDsc { get; set; }
        public string FixParBench { get; set; }
        public string FixBenchCompHora { get; set; }
        public string FixValorFijacion { get; set; }
        public string FixBenchMdaCodValorDefValor { get; set; }
        public string Refijable { get; set; }
        public string FixBenchEsEditable { get; set; }
        public string NumeroFijacion { get; set; }

        
        #endregion

        public event PropertyChangedEventHandler PropertyChanged;

        private void NotifyPropertyChanged(string p)
        {
            if (PropertyChanged != null)
            {
                PropertyChanged(this, new PropertyChangedEventArgs(p));
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

        public string sFechaFijacion
        {
            get
            {
                if ((FechaFijacion != new DateTime(1900,1,1)) && FechaFijacion != null)
                {
                    return this.FechaFijacion.ToString("dd/MM/yyyy");
                }
                else
                {
                    return "0";
                }
            }
            set
            {
                if (DateTime.Parse(value) != this.FechaFijacion)
                {
                    this.FechaFijacion = DateTime.Parse(value);
                    NotifyPropertyChanged("FechaFijacion");
                }
            }
        }

        public string sOpcEstDsc
        {
            get
            {
                if (OpcEstDsc != "" && OpcEstDsc != null)
                {
                    return this.OpcEstDsc;
                }
                else
                {
                    return "0";
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

        public string sOpcEstCod
        {
            get
            {
                if (OpcEstCod != "" && OpcEstCod != null)
                {
                    return this.OpcEstCod;
                }
                else
                {
                    return "0";
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

        public string sCallPut
        {
            get
            {
                if (CallPut != "" && CallPut != null)
                {
                    return this.CallPut.ToString();
                }
                else
                {
                    return "";
                }
            }
            set
            {
                if (value != this.CallPut)
                {
                    this.CallPut = value;
                    NotifyPropertyChanged("CallPut");
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

        public string sMon1Dsc
        {
            get
            {
                if (Mon1Dsc != "" && Mon1Dsc != null)
                {
                    return this.Mon1Dsc.ToString();
                }
                else
                {
                    return "";
                }
            }
            set
            {
                if (value != this.Mon1Dsc)
                {
                    this.Mon1Dsc = value;
                    NotifyPropertyChanged("Mon1Dsc");
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

        public string sMdaCompensacionDsc
        {
            get
            {
                if (MdaCompensacionDsc != "" && MdaCompensacionDsc != null)
                {
                    return this.MdaCompensacionDsc.ToString();
                }
                else
                {
                    return "";
                }
            }
            set
            {
                if (value != this.MdaCompensacionDsc)
                {
                    this.MdaCompensacionDsc = value;
                    NotifyPropertyChanged("MdaCompensacionDsc");
                }
            }
        }

        public string sStrike
        {
            get
            {
                if (Strike != "" && Strike != null)
                {
                    return this.Strike.ToString();
                }
                else
                {
                    return "";
                }
            }
            set
            {
                if (value != this.Strike)
                {
                    this.Strike = value;
                    NotifyPropertyChanged("Strike");
                }
            }
        }

        public string sPesoFijacion
        {
            get
            {
                if (PesoFijacion != "" && PesoFijacion != null)
                {
                    return this.PesoFijacion.ToString();
                }
                else
                {
                    return "";
                }
            }
            set
            {
                if (value != this.PesoFijacion)
                {
                    this.PesoFijacion = value;
                    NotifyPropertyChanged("PesoFijacion");
                }
            }
        }

        public string sFixBenchCompDsc
        {
            get
            {
                if (FixBenchCompDsc != "" && FixBenchCompDsc != null)
                {
                    return this.FixBenchCompDsc.ToString();
                }
                else
                {
                    return "";
                }
            }
            set
            {
                if (value != this.FixBenchCompDsc)
                {
                    this.FixBenchCompDsc = value;
                    NotifyPropertyChanged("FixBenchCompDsc");
                }
            }
        }

        public string sFixParBench
        {
            get
            {
                if (FixParBench != "" && FixParBench != null)
                {
                    return this.FixParBench.ToString();
                }
                else
                {
                    return "";
                }
            }
            set
            {
                if (value != this.FixParBench)
                {
                    this.FixParBench = value;
                    NotifyPropertyChanged("FixParBench");
                }
            }
        }

        public string sFixBenchCompHora
        {
            get
            {
                if (FixBenchCompHora != "" && FixBenchCompHora != null)
                {
                    return this.FixBenchCompHora.ToString();
                }
                else
                {
                    return "";
                }
            }
            set
            {
                if (value != this.FixBenchCompHora)
                {
                    this.FixBenchCompHora = value;
                    NotifyPropertyChanged("FixBenchCompHora");
                }
            }
        }

        public string sFixValorFijacion
        {
            get
            {
                if (FixValorFijacion != "" && FixValorFijacion != null)
                {
                    return this.FixValorFijacion.ToString();
                }
                else
                {
                    return "";
                }
            }
            set
            {
                if (value != this.FixValorFijacion)
                {
                    this.FixValorFijacion = value;
                    NotifyPropertyChanged("FixValorFijacion");
                }
            }
        }

        public string sFixBenchMdaCodValorDefValor
        {
            get
            {
                if (FixBenchMdaCodValorDefValor != "" && FixBenchMdaCodValorDefValor != null)
                {
                    return this.FixBenchMdaCodValorDefValor.ToString();
                }
                else
                {
                    return "";
                }
            }
            set
            {
                if (value != this.FixBenchMdaCodValorDefValor)
                {
                    this.FixBenchMdaCodValorDefValor = value;
                    NotifyPropertyChanged("FixBenchMdaCodValorDefValor");
                }
            }
        }

        public string sRefijable
        {
            get
            {
                if (Refijable != "" && Refijable != null)
                {
                    return this.Refijable.ToString();
                }
                else
                {
                    return "";
                }
            }
            set
            {
                if (value != this.Refijable)
                {
                    this.Refijable = value;
                    NotifyPropertyChanged("Refijable");
                }
            }
        }

        public string sFixBenchEsEditable
        {
            get
            {
                if (FixBenchEsEditable != "" && FixBenchEsEditable != null)
                {
                    return this.FixBenchEsEditable.ToString();
                }
                else
                {
                    return "";
                }
            }
            set
            {
                if (value != this.FixBenchEsEditable)
                {
                    this.FixBenchEsEditable = value;
                    NotifyPropertyChanged("FixBenchEsEditable");
                }
            }
        }

        public string sNumeroFijacion
        {
            get
            {
                if (NumeroFijacion != "" && NumeroFijacion != null)
                {
                    return this.NumeroFijacion.ToString();
                }
                else
                {
                    return "";
                }
            }
            set
            {
                if (value != this.NumeroFijacion)
                {
                    this.NumeroFijacion = value;
                    NotifyPropertyChanged("NumeroFijacion");
                }
            }
        }
        
    }
}