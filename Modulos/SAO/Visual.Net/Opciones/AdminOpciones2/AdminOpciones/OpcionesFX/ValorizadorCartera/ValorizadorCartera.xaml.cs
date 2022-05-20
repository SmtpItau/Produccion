using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Windows;
using System.Windows.Browser;
using System.Windows.Controls;
using System.Windows.Documents;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Animation;
using System.Windows.Shapes;
using AdminOpciones.OpcionesFX.Asiatica;
using System.Windows.Controls.Primitives;
using System.Xml.Linq;
using AdminOpciones.Struct.Generic;
using AdminOpciones.Struct.OpcionesXF.Asiatica;
using AdminOpciones.Struct.OpcionesXF.Customers;
using AdminOpciones.Struct.OpcionesXF.Smile;
using System.Text.RegularExpressions;
using AdminOpciones.Struct.Componentes;
using AdminOpciones.Valid;
using AdminOpciones.Struct.OpcionesXF.ValorizacionCartera;
using System.Windows.Data;
using AdminOpciones.OpcionesFX.Converter;
using System.Collections;
using System.Threading;
using AdminOpciones.OpcionesFX;
using AdminOpciones.OpcionesFX.Componentes;
using AdminOpciones.Recursos;

namespace AdminOpciones.OpcionesFX.ValorizadorCartera
{
    public partial class ValorizadorCartera : UserControl
    {
        AdminOpciones.SrvAcciones.WebAccionesSoapClient sva = wsGlobales.Acciones;

        #region "Variables"

        public DateTime DateProcess;
        public class _Resultados
        {
            public string MsgStatus { get; set; }
            public override string ToString()
            {
                return string.Format("?MsgStatus={0}", MsgStatus);
            }
        }

        private List<StructCustomers> CustomersList;
        private List<StructCodigoDescripcion> FinancialPortFolioList;
        private List<StructCodigoDescripcion> BookList;
        private List<StructCodigoDescripcion> SubPortFolioRulesList;
        //private List<StructCodigoDescripcion> OpcionesEstructuraList;
        private List<StructCodigoDescripcion> PortFolioRulesList;

        //Valorizacion Cartera
        DateTime FechaDeProceso = new DateTime();  // Se carga a traves de BD con la fecha actual de proceso y no se modifica;
        List<StructDetContrato> DetContratoList;
        List<StructEncContrato> EncContratoList;
        List<StructFixingDataContrato> FijacionesList;
        List<StructDetContrato> MtMGriegasTotalizador;
        DateTime _FechaValoracionCartera;
        double BSSpotValorizacion = double.NaN;
        private List<StructSmileATMRRFLY> SmileATMRRFLYList = new List<StructSmileATMRRFLY>();
        private List<StructSmileCallPut> SmileCallPutList = new List<StructSmileCallPut>();
        private List<StructSmileCallPut> SmileStrikesList = new List<StructSmileCallPut>();
        private List<StructSmileATMRRFLY> TopologiaVegaATMRRFLYList = new List<StructSmileATMRRFLY>();
        private List<StructSmileCallPut> TopologiaVegaCALLPUTList = new List<StructSmileCallPut>();

        List<StructCurvaMoneda> CurvasMonedasList;
        List<StructItemPuntosForward> CurvaFwUSD;

        //----------------
        Icon  RotateIcon = new Icon();
        //Canvas TransparentMask;       
        
        public TablaFixing _TablaFixing;
        public Popup popUpTablaFixing;
        private int setPreciosValCartera = 0;

        public AdminOpciones.OpcionesFX.Guardar.GuardarOpcion _Guardar;
        public Popup popUpGuardar;

        public Componentes.Componentes _ComponentesTable;        
        public Popup popUpComponentes;

        public AdminOpciones.OpcionesFX.TopologiaVegaPricing.TopoLogiaVegaPricingControl _TopologiaVegaPricingControl;
        public Popup popUpTopologiaVegaPricing;


        // se carga desde SmileOpciones
        public List<StructFixingData> FixingDataList = new List<StructFixingData>();
        public string FixingDataString = "";
        // public string estructura;
        public int Town;

        public string XMLResult = "";
        public StructGriegas griegas;

        //private List<ItemGrid> listaStrike, listaDelta;

        public const string paridad = "CLP/USD";
        public const string curvaDom = "CurvaSwapCLP";
        public const string curvaFor = "CurvaSwapUSDLocal";
        public const string codigoMon1 = "13"; //USD
        public const string codigoMon2 = "999";//CLP
        public const string afirme_cotizacion = "";

        public string call_put;
        public string compra_venta;
        public double nocional;
        public double NocionalStrangle;
        public double nocionalContraMonedaMonto = 0;
        public double spot;
        public double PuntosCosto;
        public double SpotContrato;
        //public double PuntosContrato;
        public double PrimaContrato;
        public double ParidadPrima;
        public double Unwind;
        public double Distribucion;
        public double MtMContrato;

        public double strike;
        public double strike2;
        public double strike3;
        public double delta1;
        public double delta2;
        public double delta3;

        public double Strike_InterpVol;
        public int Plazo_InterpVol;

        public string TopologiaVegaPricingInput="";
        public bool isTopoLogiaVegaPricing = false;

        public string strikes_delta_flag = "strikes"; // corresponde a "strikes" o "delta" segun se activen los strikes o los delta. Se utiliza para indicarle a las estructuras si los valores son entregados a través de strikes o delta

        XDocument xmlResult = new XDocument();
        public string Mensaje_;
        public Canvas ProcessStatus { get; set; }

        //private bool ValidProcess { get; set; }
        //private bool StartLoadDateProcess { get; set; }
        //private bool StartLoadCustomers { get; set; }
        //private bool StartLoadPortfolioAndBook { get; set; }
        //private bool StartTableClose { get; set; }
        private bool TableClose { get; set; }
        private bool? __ValorizarCartera { get; set; }
        private bool? __GrabarValorizacion { get; set; }
        //private bool __LoadData { get; set; }
        //private bool __CheckValidProcess { get; set; }
        private bool IsSpotValid { get; set; }

        bool LoadedSetPricing = false;
        bool LoadedTableInfo = false;
        bool LoadedDateProcess =  false;
        bool LoadedPortFolio = false;
        bool Status = false;

        DateTime FechaSetdePrecios = new DateTime(1900, 1, 1);


        #endregion

        public ValorizadorCartera()
        {

            InitializeComponent();
            //StartLoading();
            PutLayer(this.CanvasPrincipalValorizadorCartera, "CARGANDO OPERACIONES VALORIZADOR...");
           
            //ValidProcess = false;
            //__LoadData = true;
            //IsSpotValid = false;

            #region Procesos Concurentes
            
            LoadDateProcess();
            LoadSetPrecios(DateTime.Parse(globales._FechaProceso), curvaDom,curvaFor, this.setPreciosValCartera);
            LoadTableClose();
            //LoadCheckValuator();

            #endregion

            // MAP Agosto 10 2009
            // Cambio de título
            this.btnValorizadorCartera.Content = "Esperar...";
            this.btnValorizadorCartera.IsEnabled = false;
            __ValorizarCartera = false;
            __GrabarValorizacion = false;
        }

        #region Check Valuator

        //private void LoadCheckValuator()
        //{
        //    DateTime _Date = DateTime.Parse(globales._FechaProceso);
        //    __CheckValidProcess = true;
        //    sva.CheckValuatorCompleted += new EventHandler<AdminOpciones.SrvAcciones.CheckValuatorCompletedEventArgs>(CheckValuatorCompleted);
        //    sva.CheckValuatorAsync(_Date);
        //}

        //private void CheckValuatorCompleted(object sender, AdminOpciones.SrvAcciones.CheckValuatorCompletedEventArgs e)
        //{
        //    IsSpotValid = false; ;
        //    if (e.Error == null)
        //    {
        //        //<CheckValue><Value Smile='1' Yield1='1' Yield2='1' /></CheckValue>
        //        string _Message = "";
        //        XDocument _xmlValue = XDocument.Parse(e.Result);
        //        XElement _Check = _xmlValue.Element("CheckValue").Element("Value");
        //        List<string> _ListValid = new List<string>();

        //        if (_Check.Attribute("Smile").Value.Equals("1"))
        //        {
        //            _ListValid.Add("SMILE");
        //        }
        //        if (_Check.Attribute("Yield1").Value.Equals("1"))
        //        {
        //            _ListValid.Add("CURVASWAPCLP");
        //        }
        //        if (_Check.Attribute("Yield2").Value.Equals("1"))
        //        {
        //            _ListValid.Add("CURVASWAPUSDLOCAL");
        //        }

        //        if (_Check.Attribute("Spot").Value.Equals("1"))
        //        {
        //            _ListValid.Add("Spot");
        //        }else
        //        {                    
        //            IsSpotValid = true;
        //        }

        //        switch (_ListValid.Count)
        //        {
        //            case 0:
        //                ValidProcess = true;
        //                break;
        //            case 1:
        //                _Message = string.Format("Falta que se ingresen el siguiente valor {0}", _ListValid[0]);
        //                break;
        //            case 2:
        //                _Message = string.Format("Falta que se ingresen los siguientes valor {0} y {1}", _ListValid[0], _ListValid[1]);
        //                break;
        //            case 3:
        //                _Message = string.Format("Falta que se ingresen los siguientes valor {0}, {1} y {2}", _ListValid[0], _ListValid[1], _ListValid[2]);
        //                break;
        //            case 4:
        //                _Message = string.Format("Falta que se ingresen los siguientes valor {0}, {1} ,{2} y {3}", _ListValid[0], _ListValid[1], _ListValid[2], _ListValid[3]);
        //                break;
        //        }
        //        if (!_Message.Equals(""))
        //        {
        //            System.Windows.Browser.HtmlPage.Window.Alert(_Message);
        //        }
        //    }            
        //    __CheckValidProcess = false;
        //    LoadPortfolioData();
        //    StopLoading(0);
        //}

        #endregion

        #region Valorización Cartera

        private void event_btnValorizadorCartera_Clicked(object sender, RoutedEventArgs e)
        {
            this.grdValCartera.Focus();
            this.grdValCarteraEstructuras.Focus();
            __ValorizarCartera = true;
            __GrabarValorizacion = true;
            StartLoading(CanvasPrincipalValorizadorCartera);
            ValorizaCartera();
        }

        private void ValorizaCartera()
        {
            DataGrid grdValCarteraDetalle = itemTabDetContrato.Content as DataGrid;
            DataGrid grdValCarteraEncabezados = this.itemTabEncContrato.Content as DataGrid;
            grdValCarteraDetalle.Focus();
            grdValCarteraEncabezados.Focus();


            string _DetContratoFixingData = "<Data>\n";

            _DetContratoFixingData += "<FechaValorizacion Fecha='" + this.DateProcess.ToString("dd-MM-yyyy") + "'/>\n";
            _DetContratoFixingData += "<SpotValorizacion Spot='" + this.BSSpotValorizacion + "'/>\n";
            _DetContratoFixingData += "<DetContrato>\n";
            List<StructDetContrato> DetContratlo_CHECKED_List = new List<StructDetContrato>();

            //DetContratlo_CHECKED_List = DetContratoList.Where<StructDetContrato>(x => x.Checked.Equals(true)).ToList<StructDetContrato>();

            for (int i = 0; i < DetContratoList.Count; i++)
            {
                _DetContratoFixingData += "<itemDetContrato Checked='" + DetContratoList[i].Checked + "'";
                _DetContratoFixingData += " NumContrato='" + DetContratoList[i].NumContrato + "' ";
                _DetContratoFixingData += "CodEstructura='" + DetContratoList[i].CodEstructura + "' ";
                _DetContratoFixingData += "NumEstructura='" + DetContratoList[i].NumEstructura + "' ";
                _DetContratoFixingData += "Vinculacion='" + DetContratoList[i].Vinculacion + "' ";
                _DetContratoFixingData += "TipoPayOff='" + DetContratoList[i].TipoPayOff + "' ";
                _DetContratoFixingData += "CallPut='" + DetContratoList[i].CallPut + "' ";
                _DetContratoFixingData += "ParStrike='" + DetContratoList[i].ParStrike + "' ";
                _DetContratoFixingData += "MontoMon1='" + DetContratoList[i].MontoMon1 + "' ";
                _DetContratoFixingData += "CVOpc='" + DetContratoList[i].CVOpc + "' ";
                _DetContratoFixingData += "FechaInicioOpc='" + DetContratoList[i].FechaInicioOpc.ToString("dd-MM-yyyy") + "' ";
                _DetContratoFixingData += "FechaVcto='" + DetContratoList[i].FechaVcto.ToString("dd-MM-yyyy") + "' ";
                _DetContratoFixingData += "Strike='" + DetContratoList[i].Strike + "' ";
                _DetContratoFixingData += "PuntosFwd='0' ";
                _DetContratoFixingData += "SpotDet='" + DetContratoList[i].SpotDet + "' ";
                _DetContratoFixingData += "CurveMon1='" + DetContratoList[i].CurveMon1 + "' ";
                _DetContratoFixingData += "CurveMon2='" + DetContratoList[i].CurveMon2 + "' ";
                _DetContratoFixingData += "PorcStrike='" + DetContratoList[i].PorcStrike + "' "; // PRD_12567
                _DetContratoFixingData += "  />\n";

            }

            _DetContratoFixingData += "</DetContrato>\n";

            int _NumContrato, _NumEstructura;
            StructFixingDataContrato _itemFixindData = new StructFixingDataContrato();
            _DetContratoFixingData += "<Fixing>\n";
            for (int i = 0; i < DetContratoList.Count; i++)
            {
                _NumContrato = DetContratoList[i].NumContrato;
                _NumEstructura = DetContratoList[i].NumEstructura;

                try
                {
                    _itemFixindData = FijacionesList.Where<StructFixingDataContrato>(fijacion => fijacion.NumContrato == _NumContrato && fijacion.NucEstructura == _NumEstructura).ToList<StructFixingDataContrato>()[0];
                }
                catch
                {
                    _itemFixindData = null;
                }

                if (_itemFixindData != null)
                {
                    for (int j = 0; j < _itemFixindData.Fijaciones.Count; j++)
                    {
                        _DetContratoFixingData += "<itemFixing NumContrato='" + _itemFixindData.NumContrato + "' ";
                        _DetContratoFixingData += "NumEstructura='" + _itemFixindData.NucEstructura + "' ";
                        _DetContratoFixingData += "FixFecha='" + _itemFixindData.Fijaciones[j].Fecha + "' ";
                        _DetContratoFixingData += "FixNumero='" + (j + 1) + "' ";
                        _DetContratoFixingData += "PesoFij='" + _itemFixindData.Fijaciones[j].Peso + "' ";
                        _DetContratoFixingData += "VolFij='" + _itemFixindData.Fijaciones[j].Volatilidad + "' ";
                        _DetContratoFixingData += "Fijacion='" + _itemFixindData.Fijaciones[j].Valor + "' />\n";
                    }
                }

            }
            _DetContratoFixingData += "</Fixing>\n";
            _DetContratoFixingData += "</Data>";

            SrvValorizador.SrvValorizadorCarteraSoapClient _SrvValorizador = wsGlobales.Valorizador;//new AdminOpciones.SrvValorizador.SrvValorizadorCarteraSoapClient();
            _SrvValorizador.ValorizarCarteraCompleted += new EventHandler<AdminOpciones.SrvValorizador.ValorizarCarteraCompletedEventArgs>(_SrvValorizador_ValorizarCarteraCompleted);
            _SrvValorizador.ValorizarCarteraAsync(_DetContratoFixingData, DateProcess , setPreciosValCartera);

        }

        private void _SrvValorizador_ValorizarCarteraCompleted(object sender, AdminOpciones.SrvValorizador.ValorizarCarteraCompletedEventArgs e)
        {
            if (e.Error == null)
            {
                __ValorizarCartera = false;
                string MtMGriegas = e.Result;

                XDocument _MtMGriegasXML = new XDocument();

                //Grabamos resultado de valorización
                try
                {
                    _MtMGriegasXML = XDocument.Parse(MtMGriegas);
                    ActualizaCaDet(_MtMGriegasXML);
                }
                catch
                {
                    _MtMGriegasXML = null;
                }

                if (_MtMGriegasXML != null)
                {
                    int _NumContrato, _NumEstructura;
                    MtMGriegasTotalizador = new List<StructDetContrato>();

                    StructDetContrato _itemMtMTotalizador = new StructDetContrato();
                    double _MtM, _DeltaSpot, _DeltaForward, _Gamma, _Vega, _RhoDom, _RhoFor, _Theta, _Charm, _Vanna, _Volga;

                    _itemMtMTotalizador.MtM = 0;
                    _itemMtMTotalizador.DeltaSpot = 0;
                    _itemMtMTotalizador.DeltaForward = 0;
                    _itemMtMTotalizador.Gamma = 0;
                    _itemMtMTotalizador.Vega = 0;
                    _itemMtMTotalizador.Vanna = 0;
                    _itemMtMTotalizador.Volga = 0;
                    _itemMtMTotalizador.Theta = 0;
                    _itemMtMTotalizador.RhoDom = 0;
                    _itemMtMTotalizador.RhoFor = 0;
                    _itemMtMTotalizador.Charm = 0;

                    int oldNumContrato;
                    oldNumContrato = -1;

                    foreach (XElement _elementOpcion in _MtMGriegasXML.Descendants("Opcion"))
                    {
                        try
                        {
                            StructDetContrato _DetContratoElement;

                            string _TipoPayOff = _elementOpcion.Element("detContrato").Element("DetallesOpcion").Attribute("MoTipoPayOff").Value;

                            _NumContrato = int.Parse(_elementOpcion.Attribute("NumContrato").Value);
                            _NumEstructura = int.Parse(_elementOpcion.Attribute("NumEstructura").Value);

                            _DetContratoElement = DetContratoList.First<StructDetContrato>(x => x.NumContrato.Equals(_NumContrato) && x.NumEstructura.Equals(_NumEstructura));

                            _MtM = double.Parse(_elementOpcion.Element("detContrato").Element("MtM").Attribute("MoVrDet").Value);
                            _DeltaSpot = double.Parse(_elementOpcion.Element("GriegasMonto").Attribute("Delta").Value);

                            //PRD_12567
                            //MEJORAR
                            /*
                             * No entiendo porqué está esto, las operaciones asiáticas también tienen delta Forward,
                             * sin importar cómo se calcule (por fórmula directa o por aproximación numérica).
                             * */
                            //ASVG_20130726
                            if (true)//!_TipoPayOff.Equals("02"))
                            {
                                _DeltaForward = double.Parse(_elementOpcion.Element("GriegasMonto").Attribute("DeltaForward").Value);
                            }
                            else
                            {
                                _DeltaForward = double.NaN;
                            }
                            try { _DeltaForward = double.Parse(_elementOpcion.Element("GriegasMonto").Attribute("DeltaForward").Value); }
                            catch { _DeltaForward = double.NaN; }

                            _Gamma = double.Parse(_elementOpcion.Element("GriegasMonto").Attribute("Gamma").Value);
                            _Vega = double.Parse(_elementOpcion.Element("GriegasMonto").Attribute("Vega").Value);
                            _Vanna = double.Parse(_elementOpcion.Element("GriegasMonto").Attribute("Vanna").Value);
                            _Volga = double.Parse(_elementOpcion.Element("GriegasMonto").Attribute("Volga").Value);
                            _Theta = double.Parse(_elementOpcion.Element("GriegasMonto").Attribute("Theta").Value);
                            _RhoDom = double.Parse(_elementOpcion.Element("GriegasMonto").Attribute("Rho").Value);
                            _RhoFor = double.Parse(_elementOpcion.Element("GriegasMonto").Attribute("Rhof").Value);
                            _Charm = double.Parse(_elementOpcion.Element("GriegasMonto").Attribute("Charm").Value);

                            if (oldNumContrato != _NumContrato)
                            {
                                EncContratoList.First(x => x.NumContrato.Equals(_NumContrato)).MtM = _MtM;
                                EncContratoList.First(x => x.NumContrato.Equals(_NumContrato)).DeltaSpot = _DeltaSpot;
                                //PRD_12567 Esto es redundante con lo de arriba
                                //ASVG_20130726
                                if (true)//!_TipoPayOff.Equals("02"))
                                {
                                    EncContratoList.First(x => x.NumContrato.Equals(_NumContrato)).DeltaForward = _DeltaForward;
                                }
                                else
                                {
                                    EncContratoList.First(x => x.NumContrato.Equals(_NumContrato)).DeltaForward = double.NaN;
                                }

                                EncContratoList.First(x => x.NumContrato.Equals(_NumContrato)).Gamma = _Gamma;
                                EncContratoList.First(x => x.NumContrato.Equals(_NumContrato)).Vega = _Vega;
                                EncContratoList.First(x => x.NumContrato.Equals(_NumContrato)).Vanna = _Vanna;
                                EncContratoList.First(x => x.NumContrato.Equals(_NumContrato)).Volga = _Volga;
                                EncContratoList.First(x => x.NumContrato.Equals(_NumContrato)).Theta = _Theta;
                                EncContratoList.First(x => x.NumContrato.Equals(_NumContrato)).RhoDom = _RhoDom;
                                EncContratoList.First(x => x.NumContrato.Equals(_NumContrato)).RhoFor = _RhoFor;
                                EncContratoList.First(x => x.NumContrato.Equals(_NumContrato)).Charm = _Charm;
                                oldNumContrato = _NumContrato;

                            }
                            else
                            {
                                EncContratoList.First(x => x.NumContrato.Equals(_NumContrato)).MtM += _MtM;
                                EncContratoList.First(x => x.NumContrato.Equals(_NumContrato)).DeltaSpot += _DeltaSpot;

                                //ASVG_20130726 REVISAR
                                if (true)//!_TipoPayOff.Equals("02"))
                                {
                                    EncContratoList.First(x => x.NumContrato.Equals(_NumContrato)).DeltaForward += _DeltaForward;
                                }
                                else
                                {
                                    EncContratoList.First(x => x.NumContrato.Equals(_NumContrato)).DeltaForward = double.NaN;
                                }

                                EncContratoList.First(x => x.NumContrato.Equals(_NumContrato)).Gamma += _Gamma;
                                EncContratoList.First(x => x.NumContrato.Equals(_NumContrato)).Vega += _Vega;
                                EncContratoList.First(x => x.NumContrato.Equals(_NumContrato)).Vanna += _Vanna;
                                EncContratoList.First(x => x.NumContrato.Equals(_NumContrato)).Volga += _Volga;
                                EncContratoList.First(x => x.NumContrato.Equals(_NumContrato)).Theta += _Theta;
                                EncContratoList.First(x => x.NumContrato.Equals(_NumContrato)).RhoDom += _RhoDom;
                                EncContratoList.First(x => x.NumContrato.Equals(_NumContrato)).RhoFor += _RhoFor;
                                EncContratoList.First(x => x.NumContrato.Equals(_NumContrato)).Charm += _Charm;
                            }


                            _DetContratoElement.MtM = _MtM;
                            _DetContratoElement.DeltaSpot = _DeltaSpot;

                            //ASVG_20130726 REVISAR
                            if (true)//!_TipoPayOff.Equals("02"))
                            {
                                _DetContratoElement.DeltaForward = _DeltaForward;
                            }
                            else
                            {
                                _DetContratoElement.DeltaForward = double.NaN;
                            }

                            _DetContratoElement.Gamma = _Gamma;
                            _DetContratoElement.Vega = _Vega;
                            _DetContratoElement.Vanna = _Vanna;
                            _DetContratoElement.Volga = _Volga;
                            _DetContratoElement.Theta = _Theta;
                            _DetContratoElement.RhoDom = _RhoDom;
                            _DetContratoElement.RhoFor = _RhoFor;
                            _DetContratoElement.Charm = _Charm;

                            if (_DetContratoElement.Checked.Equals(true))
                            {

                                _itemMtMTotalizador.MtM += _MtM;
                                _itemMtMTotalizador.DeltaSpot += _DeltaSpot;

                                //ASVG_20130726 REVISAR
                                if (true)//!_TipoPayOff.Equals("02"))
                                {
                                    _itemMtMTotalizador.DeltaForward += _DeltaForward;
                                }
                                else
                                {
                                    _itemMtMTotalizador.DeltaForward += 0;
                                }

                                _itemMtMTotalizador.Gamma += _Gamma;
                                _itemMtMTotalizador.Vega += _Vega;
                                _itemMtMTotalizador.Vanna += _Vanna;
                                _itemMtMTotalizador.Volga += _Volga;
                                _itemMtMTotalizador.Theta += _Theta;
                                _itemMtMTotalizador.RhoDom += _RhoDom;
                                _itemMtMTotalizador.RhoFor += _RhoFor;
                                _itemMtMTotalizador.Charm += _Charm;
                            }

                        }
                        catch { }

                    }

                    MtMGriegasTotalizador.Add(_itemMtMTotalizador);

                    DataGrid grdValCarteraDetalle = itemTabDetContrato.Content as DataGrid;
                    grdValCarteraDetalle.ItemsSource = null;
                    grdValCarteraDetalle.ItemsSource = DetContratoList;

                    DataGrid grdValCarteraEncabezados = this.itemTabEncContrato.Content as DataGrid;
                    grdValCarteraEncabezados.ItemsSource = null;
                    grdValCarteraEncabezados.ItemsSource = EncContratoList;
                }
            }
            else
            {
                __GrabarValorizacion = null;
                System.Windows.Browser.HtmlPage.Window.Alert(e.Error.Message);
            }            

            if (__GrabarValorizacion == false && __ValorizarCartera == false)
            {
                StopLoading(CanvasPrincipalValorizadorCartera);
                System.Windows.Browser.HtmlPage.Window.Alert("La valorización de cartera termino exitosamente.");
            }
            else if (__GrabarValorizacion == null && __ValorizarCartera == true)
            {
                StopLoading(CanvasPrincipalValorizadorCartera);
                System.Windows.Browser.HtmlPage.Window.Alert("Error en la valorización de cartera.");
            }

        }

        #endregion

        #region LoadDateProcess

        private void LoadDateProcess()
        {
            //StartLoadDateProcess = true;
            LoadedDateProcess = false;
            SrvLoadFront.LoadFrontSoapClient _SrvLoadFont = wsGlobales.LoadFront;//new AdminOpciones.SrvLoadFront.LoadFrontSoapClient();
            _SrvLoadFont.LoadDateProcessCompleted += new EventHandler<AdminOpciones.SrvLoadFront.LoadDateProcessCompletedEventArgs>(_SrvLoadFont_LoadDateProcessCompleted);
            _SrvLoadFont.LoadDateProcessAsync();
        }

        private void _SrvLoadFont_LoadDateProcessCompleted(object sender, AdminOpciones.SrvLoadFront.LoadDateProcessCompletedEventArgs e)
        {
           // StartLoadDateProcess = false;
            int Error = 0;
            string MsgError = "Error: \n";

            XDocument xDate = new XDocument(XDocument.Parse(e.Result));

            Error = Math.Max(Error, Convert.ToInt32(xDate.Element("DataLoadFront").Element("DateProccess").Attribute("Error").Value));

            if (Error == 0)
            {
                DateProcess = DateTime.Parse(xDate.Element("DataLoadFront").Element("DateProccess").Attribute("DateProccess").Value);
                txtFechaValCartera.Text = DateProcess.ToString("dd/MM/yyyy");
            }
            else 
            {
                DateProcess = new DateTime(1900, 1, 1);
                txtFechaValCartera.Text = "";
                MsgError += "- "+xDate.Element("DataLoadFront").Element("DateProccess").Attribute("Mensaje").Value + "\n";
            }

            if (Error > 0)
            {
                System.Windows.Browser.HtmlPage.Window.Alert(MsgError);

            }

            //Error = 0;

            //Error = Math.Max(Error, Convert.ToInt32(xDate.Element("DataLoadFront").Element("DataSpotBS").Attribute("Error").Value));

            //if (Error == 0)
            //{
            //    BSSpotValorizacion = ValidValue(xDate.Element("DataLoadFront").Element("DataSpotBS").Attribute("SpotBS").Value);
            //}
            //else
            //{
            //    //MsgError += "- " + xDate.Element("DataLoadFront").Element("DataSpotBS").Attribute("Mensaje").Value + "\n";
            //}

            LoadedDateProcess = true;
            
            LoadPortfolioData();

            //if (e.Error == null)
            //{
            //    //<DataLoadFront> <DateProccess DateProccess= '05-12-2008 0:00:00' /> </DataLoadFront></string> 
            //    XDocument xDate = new XDocument(XDocument.Parse(e.Result));
            //    DateProcess = DateTime.Parse(xDate.Element("DataLoadFront").Element("DateProccess").Attribute("DateProccess").Value);
            //    txtFechaValCartera.Text = DateProcess.ToString("dd/MM/yyyy");
            //    BSSpotValorizacion = ValidValue(xDate.Element("DataLoadFront").Element("DataSpotBS").Attribute("SpotBS").Value);
            //    LoadPortfolioData();
            //}
            //else
            //{
            //    System.Windows.Browser.HtmlPage.Window.Alert("Error en la carga de la Fecha de Proceso");
            //}
        }

        #endregion

        #region LoadTableClose

        private void LoadTableClose()
        {
            //StartTableClose = true;
            LoadedTableInfo = false;
            AdminOpciones.SrvDetalles.WebDetallesSoapClient _SrvCierreMesa = wsGlobales.Detalles;

            _SrvCierreMesa.RetornaCierreMesaCompleted += new EventHandler<AdminOpciones.SrvDetalles.RetornaCierreMesaCompletedEventArgs>(LoadTableCloseCompleted);
            _SrvCierreMesa.RetornaCierreMesaAsync(Convert.ToDateTime(Convert.ToString(globales._FechaProceso)).ToString());
        }

        void LoadTableCloseCompleted(object sender, AdminOpciones.SrvDetalles.RetornaCierreMesaCompletedEventArgs e)
        {
            //StartTableClose = false;
            string _fproc = Convert.ToDateTime(Convert.ToString(globales._FechaProceso)).ToString("yyyyMMdd");
            string _xmlResult = e.Result.ToString();
            xmlResult = XDocument.Parse(_xmlResult);
            List<AdminOpciones.Page._Resultado_Mesa> _data = new List<AdminOpciones.Page._Resultado_Mesa>();

            IEnumerable<XElement> elements = xmlResult.Element("CierreMesa").Elements("Data");
            foreach (XElement element in elements)
            {

                AdminOpciones.Page._Resultado_Mesa _sData = new AdminOpciones.Page._Resultado_Mesa();
                _sData.ResultMesa = element.FirstAttribute.Value.ToString();
                TableClose = Convert.ToInt32(_sData.ResultMesa) == 1 ? true : false;
            }
            LoadedTableInfo = true;
            LoadPortfolioData();
        }

        #endregion

        #region getDetContratoFijaciones

        private void LoadPortfolioData()
        {
            //if (!__CheckValidProcess && IsSpotValid && !StartLoadDateProcess && !StartTableClose)
            if (LoadedDateProcess && LoadedTableInfo)
            {
                getDetContratoFijaciones();
            }
            else
            {
                //if (!__CheckValidProcess && !IsSpotValid && !StartLoadDateProcess && !StartTableClose)
                //{
                //    getDetContratoFijaciones();
                //}
            }
        }

        private void getDetContratoFijaciones()
        {
            LoadedPortFolio = false;
            string Estado = "";
            this.SmileStrikesList.Clear();
            this.SmileATMRRFLYList.Clear();
            this.SmileCallPutList.Clear();

            SrvValorizador.SrvValorizadorCarteraSoapClient _SrvValorizador = wsGlobales.Valorizador;//new AdminOpciones.SrvValorizador.SrvValorizadorCarteraSoapClient();
            _SrvValorizador.getDetContratoFixingCompleted += new EventHandler<AdminOpciones.SrvValorizador.getDetContratoFixingCompletedEventArgs>(_SrvValorizador_getDetContratoFixingCompleted);
            _SrvValorizador.getDetContratoFixingAsync(DateProcess, Estado, DateProcess);
        }

        private void _CheckedNull(int NumContrato, bool Value)
        {
        }

        private void _SrvValorizador_getDetContratoFixingCompleted(object sender, AdminOpciones.SrvValorizador.getDetContratoFixingCompletedEventArgs e)
        {
            try
            {
                string _EncContrato = e.Result;

                XDocument xdoc = new XDocument();
                xdoc = XDocument.Parse(_EncContrato);

                EncContratoList = new List<StructEncContrato>();
                DetContratoList = new List<StructDetContrato>();
                FijacionesList = new List<StructFixingDataContrato>();
                SmileATMRRFLYList = new List<StructSmileATMRRFLY>();
                SmileCallPutList = new List<StructSmileCallPut>();
                SmileStrikesList = new List<StructSmileCallPut>();

                StructEncContrato _itemEncContratoStruct;
                StructDetContrato _itemDetContratoStruct;
                StructFixingDataContrato _itemFixingData;

                int _idDet = 0;
                int _idEnc = 0;

                foreach (XElement itemEncContrato in xdoc.Descendants("Opcion"))
                {
                    _idEnc++;
                    _itemEncContratoStruct = new StructEncContrato();
                    _itemEncContratoStruct.Encabezado_Checked += new delegate_Checked(_CheckedNull);

                    #region Setea encabezados

                    _itemEncContratoStruct.Estado = itemEncContrato.Element("itemEncContrato").Attribute("Estado").Value;
                    _itemEncContratoStruct.GlosaEstado = "";
                    _itemEncContratoStruct.ID = _idEnc;
                    _itemEncContratoStruct.Checked = true;
                    _itemEncContratoStruct.NumContrato = int.Parse(itemEncContrato.Element("itemEncContrato").Attribute("NumContrato").Value);
                    _itemEncContratoStruct.NumFolio = int.Parse(itemEncContrato.Element("itemEncContrato").Attribute("NumFolio").Value);
                    _itemEncContratoStruct.CodEstructura = int.Parse(itemEncContrato.Element("itemEncContrato").Attribute("CodEstructura").Value);
                    _itemEncContratoStruct.Opcion = itemEncContrato.Element("itemEncContrato").Attribute("Opcion").Value;
                    _itemEncContratoStruct.CVEstructura = itemEncContrato.Element("itemEncContrato").Attribute("CVEstructura").Value;
                    _itemEncContratoStruct.FechaContrato = DateTime.Parse(itemEncContrato.Element("itemEncContrato").Attribute("FechaContrato").Value);
                    _itemEncContratoStruct.FecValorizacion = DateTime.Parse(itemEncContrato.Element("itemEncContrato").Attribute("FecValorizacion").Value);
                    _itemEncContratoStruct.CarteraFinanciera = int.Parse(itemEncContrato.Element("itemEncContrato").Attribute("CarteraFinanciera").Value);
                    _itemEncContratoStruct.Libro = int.Parse(itemEncContrato.Element("itemEncContrato").Attribute("Libro").Value);
                    _itemEncContratoStruct.CarNormativa = itemEncContrato.Element("itemEncContrato").Attribute("CarNormativa").Value;
                    _itemEncContratoStruct.SubCarNormativa = int.Parse(itemEncContrato.Element("itemEncContrato").Attribute("SubCarNormativa").Value);
                    _itemEncContratoStruct.RutCliente = int.Parse(itemEncContrato.Element("itemEncContrato").Attribute("RutCliente").Value);
                    _itemEncContratoStruct.Codigo = int.Parse(itemEncContrato.Element("itemEncContrato").Attribute("Codigo").Value);
                    _itemEncContratoStruct.TipoContrapartida = itemEncContrato.Element("itemEncContrato").Attribute("TipoContrapartida").Value;

                    if (itemEncContrato.Element("itemEncContrato").Attribute("PrimaInicial").Value != "")
                    {
                        _itemEncContratoStruct.PrimaInicial = double.Parse(itemEncContrato.Element("itemEncContrato").Attribute("PrimaInicial").Value);
                    }
                    else
                    {
                        _itemEncContratoStruct.PrimaInicial = double.NaN;
                    }

                    _itemEncContratoStruct.fPagoPrima = int.Parse(itemEncContrato.Element("itemEncContrato").Attribute("CafPagoPrima").Value);
                    _itemEncContratoStruct.CodMonPagPrima = int.Parse(itemEncContrato.Element("itemEncContrato").Attribute("CaCodMonPagPrima").Value);

                    #endregion

                    foreach (XElement itemdetContrato in itemEncContrato.Descendants("itemDetContrato"))
                    {
                        _itemDetContratoStruct = new StructDetContrato();
                        _itemDetContratoStruct.Detalle_Checked_detContrato += new delegate_Checked_DetContrato(_CheckedNull);

                        _idDet++;
                        _itemDetContratoStruct.ID = _idDet;
                        _itemDetContratoStruct.Checked = true;
                        _itemDetContratoStruct.NumContrato = int.Parse(itemdetContrato.Attribute("NumContrato").Value);
                        _itemDetContratoStruct.CodEstructura = int.Parse(itemdetContrato.Attribute("CodEstructura").Value);
                        _itemDetContratoStruct.NumEstructura = int.Parse(itemdetContrato.Attribute("NumEstructura").Value);
                        _itemDetContratoStruct.Vinculacion = itemdetContrato.Attribute("Vinculacion").Value;
                        _itemDetContratoStruct.TipoPayOff = itemdetContrato.Attribute("TipoPayOff").Value;
                        _itemDetContratoStruct.CallPut = itemdetContrato.Attribute("CallPut").Value;
                        _itemDetContratoStruct.CVOpc = itemdetContrato.Attribute("CVOpc").Value;
                        _itemDetContratoStruct.FechaInicioOpc = DateTime.Parse(itemdetContrato.Attribute("FechaInicioOpc").Value);
                        _itemDetContratoStruct.FechaVcto = DateTime.Parse(itemdetContrato.Attribute("FechaVcto").Value);
                        _itemDetContratoStruct.Strike = double.Parse(itemdetContrato.Attribute("Strike").Value);
                        _itemDetContratoStruct.MontoMon1 = double.Parse(itemdetContrato.Attribute("MontoMon1").Value);
                        _itemDetContratoStruct.ParStrike = itemdetContrato.Attribute("ParStrike").Value;
                        _itemDetContratoStruct.SpotDet = double.Parse(itemdetContrato.Attribute("SpotDet").Value);
                        _itemDetContratoStruct.CurveMon1 = curvaDom;
                        _itemDetContratoStruct.CurveMon2 = curvaFor;
                        _itemDetContratoStruct.CurveMon1 = itemdetContrato.Attribute("CurveMon1").Value;
                        _itemDetContratoStruct.CurveMon2 = itemdetContrato.Attribute("CurveMon2").Value;
                        _itemDetContratoStruct.FormaPagoMon1 = int.Parse(itemdetContrato.Attribute("CaFormaPagoMon1").Value);
                        _itemDetContratoStruct.FormaPagoMon2 = int.Parse(itemdetContrato.Attribute("CaFormaPagoMon2").Value);
                        _itemDetContratoStruct.MdaCompensacion = int.Parse(itemdetContrato.Attribute("CaMdaCompensacion").Value);
                        _itemDetContratoStruct.FormaPagoComp = int.Parse(itemdetContrato.Attribute("CaFormaPagoComp").Value);
                        _itemDetContratoStruct.PorcStrike = double.Parse(itemdetContrato.Attribute("CaPorcStrike").Value);
                        //REVISAR impacto de esto...
                        if ( _itemDetContratoStruct.CodEstructura == 13 )
                            _itemDetContratoStruct.Strike = _itemDetContratoStruct.PorcStrike;
                        
                        DetContratoList.Add(_itemDetContratoStruct);
                    }

                    StructFixingData itemFijacion;

                    int _auxNumContrato = -1;
                    int _auxNumEstructura = -1;
                    foreach (XElement itemdFixing in itemEncContrato.Descendants("itemFixing"))
                    {
                        itemFijacion = new StructFixingData();

                        if (!_auxNumContrato.Equals(int.Parse(itemdFixing.Attribute("NumContrato").Value)) || !_auxNumEstructura.Equals(int.Parse(itemdFixing.Attribute("NumEstructura").Value)))
                        {
                            _auxNumContrato = int.Parse(itemdFixing.Attribute("NumContrato").Value);
                            _auxNumEstructura = int.Parse(itemdFixing.Attribute("NumEstructura").Value);

                            _itemFixingData = new StructFixingDataContrato();
                            _itemFixingData.NumContrato = _auxNumContrato;
                            _itemFixingData.NucEstructura = _auxNumEstructura;

                            itemFijacion.Fecha = DateTime.Parse(itemdFixing.Attribute("FixFecha").Value);
                            itemFijacion.Peso = double.Parse(itemdFixing.Attribute("PesoFij").Value);
                            itemFijacion.Volatilidad = double.Parse(itemdFixing.Attribute("VolFij").Value);
                            itemFijacion.Valor = double.Parse(itemdFixing.Attribute("Fijacion").Value);

                            _itemFixingData.Fijaciones.Add(itemFijacion);

                            FijacionesList.Add(_itemFixingData);
                        }
                        else
                        {
                            itemFijacion.Fecha = DateTime.Parse(itemdFixing.Attribute("FixFecha").Value);
                            itemFijacion.Peso = double.Parse(itemdFixing.Attribute("PesoFij").Value);
                            itemFijacion.Volatilidad = double.Parse(itemdFixing.Attribute("VolFij").Value);
                            itemFijacion.Valor = double.Parse(itemdFixing.Attribute("Fijacion").Value);
                            FijacionesList[FijacionesList.Count - 1].Fijaciones.Add(itemFijacion);
                        }
                    }

                    EncContratoList.Add(_itemEncContratoStruct);

                }

                grdValCarteraEstructuras.ItemsSource = EncContratoList;
                grdValCartera.ItemsSource = DetContratoList;

                XElement _Deltas = new XElement(xdoc.Element("Data").Element("Deltas"));

                //XElement _ATMRRFLY = new XElement(xdoc.Element("Data").Element("ATMRRFLY"));

                //StructSmileATMRRFLY Item_ATMRRFLY;
                //foreach (XElement _itemATMRRFLY in _ATMRRFLY.Descendants("itemATMRRFLY"))
                //{
                //    Item_ATMRRFLY = new StructSmileATMRRFLY();
                //    Item_ATMRRFLY.Tenor = int.Parse(_itemATMRRFLY.Attribute("TENOR").Value);
                //    Item_ATMRRFLY.ATM = double.Parse(_itemATMRRFLY.Attribute("ATM").Value);
                //    Item_ATMRRFLY.RR25D = double.Parse(_itemATMRRFLY.Attribute("RR25D").Value);
                //    Item_ATMRRFLY.BF25D = double.Parse(_itemATMRRFLY.Attribute("BF25D").Value);
                //    Item_ATMRRFLY.RR10D = double.Parse(_itemATMRRFLY.Attribute("RR10D").Value);
                //    Item_ATMRRFLY.BF10D = double.Parse(_itemATMRRFLY.Attribute("BF10D").Value);

                //    this.SmileATMRRFLYList.Add(Item_ATMRRFLY);
                //}

                //XElement _CALLPUT = new XElement(xdoc.Element("Data").Element("CALLPUT"));


                //StructSmileCallPut ItemCallPut;

                //foreach (XElement _itemCALLPUT in _CALLPUT.Descendants("itemCALLPUT"))
                //{
                //    ItemCallPut = new StructSmileCallPut();

                //    ItemCallPut.Tenor = int.Parse(_itemCALLPUT.Attribute("TENOR").Value);
                //    ItemCallPut.Put10 = double.Parse(_itemCALLPUT.Attribute("PUT10D").Value);
                //    ItemCallPut.Put25 = double.Parse(_itemCALLPUT.Attribute("PUT25D").Value);
                //    ItemCallPut.Atm = double.Parse(_itemCALLPUT.Attribute("ATM").Value);
                //    ItemCallPut.Call10 = double.Parse(_itemCALLPUT.Attribute("CALL10D").Value);
                //    ItemCallPut.Call25 = double.Parse(_itemCALLPUT.Attribute("CALL25D").Value);

                //    SmileCallPutList.Add(ItemCallPut);
                //}


                //XElement _STRIKES = new XElement(xdoc.Element("Data").Element("STRIKES"));


                //StructSmileCallPut ItemStrike;

                //foreach (XElement _itemSTRIKES in _STRIKES.Descendants("itemSTRIKES"))
                //{
                //    ItemStrike = new StructSmileCallPut();

                //    ItemStrike.Tenor = int.Parse(_itemSTRIKES.Attribute("TENOR").Value);
                //    ItemStrike.Put10 = ValidValue(_itemSTRIKES.Attribute("PUT10D").Value);
                //    ItemStrike.Put25 = ValidValue(_itemSTRIKES.Attribute("PUT25D").Value);
                //    ItemStrike.Atm = ValidValue(_itemSTRIKES.Attribute("ATM").Value);
                //    ItemStrike.Call10 = ValidValue(_itemSTRIKES.Attribute("CALL10D").Value);
                //    ItemStrike.Call25 = ValidValue(_itemSTRIKES.Attribute("CALL25D").Value);

                //    SmileStrikesList.Add(ItemStrike);
                //}

                if (_idEnc > 0)
                {
                    // MAP Agosto 10 2009, para permitir valorizar una vez
                    if (!TableClose)
                    {
                        System.Windows.Browser.HtmlPage.Window.Alert("La mesa esta abierta, no se puede valorizar.");
                    }
                }
                else
                {
                    this.btnValorizadorCartera.IsEnabled = false;
                    System.Windows.Browser.HtmlPage.Window.Alert("No existe Cartera.");
                    // Actualiza Flag Valorizacion
                    ActualizaFlagValorizacion();
                }

                LoadedPortFolio = true;
            }
            catch
            {
                LoadedPortFolio = false;
            }
            //__LoadData = false;
            StopLoading(CanvasPrincipalValorizadorCartera);
            
            this.btnValorizadorCartera.IsEnabled = (Status && TableClose && LoadedSetPricing && LoadedPortFolio);
            this.btnValorizadorCartera.Content = "Valorizar" ;            

        }

        private void ActualizaFlagValorizacion()
        {
            AdminOpciones.SrvBDOpciones.BDOpcionesSoapClient _SrvBDOpciones = wsGlobales.BDOpciones;// new AdminOpciones.SrvBDOpciones.BDOpcionesSoapClient();
            _SrvBDOpciones.UpdateFlagValuatorCompleted += new EventHandler<AdminOpciones.SrvBDOpciones.UpdateFlagValuatorCompletedEventArgs>(UpdateFlagValuatorCompleted);
            _SrvBDOpciones.UpdateFlagValuatorAsync();
        }

        private void UpdateFlagValuatorCompleted(object sender, AdminOpciones.SrvBDOpciones.UpdateFlagValuatorCompletedEventArgs e)
        {
            //<Value Status='1' Message='ERROR' />
            if (e.Error == null)
            {
                XDocument _xmlValue = XDocument.Parse(e.Result);
                if (!_xmlValue.Element("Value").Attribute("Status").Value.Equals("0"))
                {
                    System.Windows.Browser.HtmlPage.Window.Alert(_xmlValue.Element("Value").Attribute("Message").Value);
                }
                else
                {
                    System.Windows.Browser.HtmlPage.Window.Alert("Se actualizo el flag del devengamiento, ya que no existe cartera");
                }
            }
        }

        private double ValidValue(string value)
        {
            try
            {
                return double.Parse(value);
            }
            catch
            {
                return 0;
            }
        }

        #endregion

        #region Administración de Estado

        //private void StartLoading()
        //{
        //    Mask.Visibility = Visibility.Visible;
        //}

        //private void StopLoading(int proc)
        //{
        //    if (proc.Equals(0))
        //    {
        //        if (!__LoadData && !__CheckValidProcess)                
        //        {
        //            Mask.Visibility = Visibility.Collapsed;
        //        }
        //        this.btnValorizadorCartera.IsEnabled = (TableClose && ValidProcess);
        //        this.btnValorizadorCartera.Content = "Valorizar";
        //    }
        //    else
        //    {

        //        if ((__GrabarValorizacion == false) && (__ValorizarCartera == false))
        //        {
        //            if (__GrabarValorizacion == false && __ValorizarCartera == false)
        //            {
        //                System.Windows.Browser.HtmlPage.Window.Alert("La valorización de cartera termino exitosamente.");
        //            }
        //            Mask.Visibility = Visibility.Collapsed;
        //        }
        //    }
        //}

        #endregion

        #region Actualiza Cartera

        private void ActualizaCaDet(XDocument xdcInsertar)
        {
            SrvBDOpciones.BDOpcionesSoapClient _SrvBDOpciones = wsGlobales.BDOpciones;// new AdminOpciones.SrvBDOpciones.BDOpcionesSoapClient();
            _SrvBDOpciones.UpdateOptionCompleted += new EventHandler<AdminOpciones.SrvBDOpciones.UpdateOptionCompletedEventArgs>(_SrvBDOpciones_UpdateOptionCompleted);
            _SrvBDOpciones.UpdateOptionAsync(xdcInsertar.ToString());
        }

        void _SrvBDOpciones_UpdateOptionCompleted(object sender, AdminOpciones.SrvBDOpciones.UpdateOptionCompletedEventArgs e)
        {
            __GrabarValorizacion = false;                        
            if (__GrabarValorizacion == false && __ValorizarCartera == false)
            {
                StopLoading(CanvasPrincipalValorizadorCartera);                
                if (e.Result.Equals(""))
                {
                System.Windows.Browser.HtmlPage.Window.Alert("La valorización de cartera termino exitosamente.");
            }
                else
                {
                    System.Windows.Browser.HtmlPage.Window.Alert(e.Result);
                }
            }
        }

        #endregion


        ////#######################
        ////CAMBIOS IVAN 4-11-2009
        ////#######################

        void LoadSetPrecios(DateTime FechaProceso, string CurvaDom, string curvaFor, int enumSetpricing)
        {
            Status = false;
            LoadedSetPricing = false;
            string _idCurvasXML = "<CurvasMoneda >\n";
            _idCurvasXML += "<itemCurva ID='" + CurvaDom + "'/>\n";
            _idCurvasXML += "<itemCurva ID='" + curvaFor + "'/>\n";
            _idCurvasXML += "<itemCurva ID='" + "CurvaFwCLP" + "'/>\n";
            _idCurvasXML += "<itemCurva ID='" + "CurvaFwUSD" + "'/>\n";
            _idCurvasXML += "</CurvasMoneda>";

            SrvValorizador.SrvValorizadorCarteraSoapClient SrvValorizador = wsGlobales.Valorizador;
            SrvValorizador.GetSetPreciosCompleted += new EventHandler<AdminOpciones.SrvValorizador.GetSetPreciosCompletedEventArgs>(SrvValorizador_GetSetPreciosCompleted);
            SrvValorizador.GetSetPreciosAsync(FechaProceso, paridad, "DO", _idCurvasXML, enumSetpricing);
        }

        void SrvValorizador_GetSetPreciosCompleted(object sender, AdminOpciones.SrvValorizador.GetSetPreciosCompletedEventArgs e)
        {
            bool fechaAnt = false;

            try
            {
                XDocument SetPreciosXML = new XDocument(XDocument.Parse(e.Result));

                SmileATMRRFLYList = new List<StructSmileATMRRFLY>();
                SmileCallPutList = new List<StructSmileCallPut>();
                SmileStrikesList = new List<StructSmileCallPut>();

                #region Fecha Set de Precios

                FechaSetdePrecios = DateTime.Parse(SetPreciosXML.Element("Data").Element("FechaSetPrecios").Attribute("Fecha").Value);

                #endregion

                #region SpotBS
                this.spot = Convert.ToDouble(SetPreciosXML.Element("Data").Element("Spot").Attribute("Value").Value);
                this.BSSpotValorizacion = this.spot;
                #endregion

                #region Smile

                #region Carga ATMRRFLY

                XElement _ATMRRFLY = new XElement(SetPreciosXML.Element("Data").Element("ATMRRFLY"));

                StructSmileATMRRFLY Item_ATMRRFLY;
                foreach (XElement _itemATMRRFLY in _ATMRRFLY.Descendants("itemATMRRFLY"))
                {
                    Item_ATMRRFLY = new StructSmileATMRRFLY();
                    Item_ATMRRFLY.Tenor = int.Parse(_itemATMRRFLY.Attribute("TENOR").Value);
                    Item_ATMRRFLY.ATM = double.Parse(_itemATMRRFLY.Attribute("ATM").Value);
                    Item_ATMRRFLY.RR25D = double.Parse(_itemATMRRFLY.Attribute("RR25D").Value);
                    Item_ATMRRFLY.BF25D = double.Parse(_itemATMRRFLY.Attribute("BF25D").Value);
                    Item_ATMRRFLY.RR10D = double.Parse(_itemATMRRFLY.Attribute("RR10D").Value);
                    Item_ATMRRFLY.BF10D = double.Parse(_itemATMRRFLY.Attribute("BF10D").Value);

                    this.SmileATMRRFLYList.Add(Item_ATMRRFLY);
                }

                #endregion

                #region Carga CALLPUT

                XElement _CALLPUT = new XElement(SetPreciosXML.Element("Data").Element("CALLPUT"));

                StructSmileCallPut ItemCallPut;

                foreach (XElement _itemCALLPUT in _CALLPUT.Descendants("itemCALLPUT"))
                {
                    ItemCallPut = new StructSmileCallPut();

                    ItemCallPut.Tenor = int.Parse(_itemCALLPUT.Attribute("TENOR").Value);
                    ItemCallPut.Put10 = double.Parse(_itemCALLPUT.Attribute("PUT10D").Value);
                    ItemCallPut.Put25 = double.Parse(_itemCALLPUT.Attribute("PUT25D").Value);
                    ItemCallPut.Atm = double.Parse(_itemCALLPUT.Attribute("ATM").Value);
                    ItemCallPut.Call10 = double.Parse(_itemCALLPUT.Attribute("CALL10D").Value);
                    ItemCallPut.Call25 = double.Parse(_itemCALLPUT.Attribute("CALL25D").Value);

                    SmileCallPutList.Add(ItemCallPut);
                }

                #endregion

                #region Carga STRIKES

                XElement _STRIKES = new XElement(SetPreciosXML.Element("Data").Element("STRIKES"));


                StructSmileCallPut ItemStrike;

                foreach (XElement _itemSTRIKES in _STRIKES.Descendants("itemSTRIKES"))
                {
                    ItemStrike = new StructSmileCallPut();

                    ItemStrike.Tenor = int.Parse(_itemSTRIKES.Attribute("TENOR").Value);
                    ItemStrike.Put10 = double.Parse(_itemSTRIKES.Attribute("PUT10D").Value);
                    ItemStrike.Put25 = double.Parse(_itemSTRIKES.Attribute("PUT25D").Value);
                    ItemStrike.Atm = double.Parse(_itemSTRIKES.Attribute("ATM").Value);
                    ItemStrike.Call10 = double.Parse(_itemSTRIKES.Attribute("CALL10D").Value);
                    ItemStrike.Call25 = double.Parse(_itemSTRIKES.Attribute("CALL25D").Value);

                    SmileStrikesList.Add(ItemStrike);
                }

                #endregion

                #endregion

                #region Curvas

                StructCurvaMoneda _CurvaElement;
                StructItemCurvaMoneda _itemCurvaMoneda;
                if (CurvasMonedasList == null)
                    CurvasMonedasList = new List<StructCurvaMoneda>();
                else
                    CurvasMonedasList.Clear();


                foreach (XElement _Curva in SetPreciosXML.Descendants("Curva"))
                {
                    _CurvaElement = new StructCurvaMoneda();

                    foreach (XElement _itemCurva in _Curva.Descendants("itemCurva"))
                    {
                        _itemCurvaMoneda = new StructItemCurvaMoneda();

                        _CurvaElement.FechaGeneracion = DateTime.Parse(_itemCurva.Attribute("FechaGeneracion").Value);
                        _CurvaElement.CodigoCurva = _itemCurva.Attribute("CodigoCurva").Value;
                        _itemCurvaMoneda.dias = int.Parse(_itemCurva.Attribute("Dias").Value);
                        _itemCurvaMoneda.Ask = double.Parse(_itemCurva.Attribute("ValorAsk").Value);
                        _itemCurvaMoneda.Bid = double.Parse(_itemCurva.Attribute("ValorBid").Value);

                        _CurvaElement.CurvaMoneda.Add(_itemCurvaMoneda);
                    }

                    CurvasMonedasList.Add(_CurvaElement);
                }

                #endregion

                #region Puntos Fwd

                CurvaFwUSD = new List<StructItemPuntosForward>();

                StructItemPuntosForward _itemCurvaForward;

                foreach (XElement _itemCurva in SetPreciosXML.Element("Data").Element("PesosForward").Descendants("itemCurva"))
                {
                    _itemCurvaForward = new StructItemPuntosForward();

                    _itemCurvaForward.dias = int.Parse(_itemCurva.Attribute("Dias").Value);
                    _itemCurvaForward.Puntos = double.Parse(_itemCurva.Attribute("Puntos").Value);
                    CurvaFwUSD.Add(_itemCurvaForward);
                }

                #endregion

                Status = SetPreciosXML.Element("Data").Element("Status").Attribute("Value").Value.Equals("OK") ? true : false;
                fechaAnt = SetPreciosXML.Element("Data").Element("Status").Attribute("FechaAnt").Value.Equals("1") ? true : false;

                Status = Status && !fechaAnt ? true : false;
            }            
            catch
            {
                Status = false;
            }
            
            LoadedSetPricing = true;

            if (!Status)
            {
                System.Windows.Browser.HtmlPage.Window.Alert("SET DE PRECIOS INCOMPLETO");
            }

            //if (!Status)
            //{
            //    QuitLayer(this.CanvasPrincipalValorizadorCartera);
            //    PutLayer(this.CanvasPrincipalValorizadorCartera, "SET DE PRECIOS INCOMPLETO");
                
            //}
            //else
            //{
            //    QuitLayer(this.CanvasPrincipalValorizadorCartera);                
            //}

            QuitLayer(this.CanvasPrincipalValorizadorCartera); 

            this.btnValorizadorCartera.IsEnabled = (Status && TableClose && LoadedSetPricing && LoadedPortFolio);
            this.btnValorizadorCartera.Content = "Valorizar";

            //throw new NotImplementedException();
        }

        private void QuitLayer(Canvas CanvasParent)
        {
            Type _type = CanvasParent.GetType();
            bool _exist = false;
            Canvas _TransparentMasnk = null;

            foreach (FrameworkElement _element in CanvasParent.Children)
            {
                if (_element.GetType().Equals(_type) && _element.GetValue(NameProperty).Equals(CanvasParent.Name + "Layer"))
                {
                    _exist = true;
                    _TransparentMasnk = _element as Canvas;
                }
            }
            if (_exist && _TransparentMasnk != null)
            {
                CanvasParent.Children.Remove(_TransparentMasnk);
                CanvasParent.Children.Remove(_TransparentMasnk);
            }
        }

        private void PutLayer(Canvas CanvasParent, string message)
        {
            bool _exist = false;
            Type _type = CanvasParent.GetType();

            foreach (FrameworkElement _element in CanvasParent.Children)
            {
                if (_element.GetType().Equals(_type) && _element.GetValue(NameProperty).Equals(CanvasParent.Name + "Layer"))
                {
                    _exist = true;
                }
            }

            if (!_exist)
            {
                double _width, _height;

                Canvas TransparentLayer = new Canvas();
                TransparentLayer.Name = CanvasParent.Name + "Layer";

                _width = CanvasParent.Width;
                _height = CanvasParent.Height;

                TransparentLayer.SetValue(Canvas.LeftProperty, CanvasParent.GetValue(Canvas.LeftProperty));
                TransparentLayer.SetValue(Canvas.TopProperty, CanvasParent.GetValue(Canvas.TopProperty));

                TransparentLayer.Width = _width;
                TransparentLayer.Height = _height;
                TransparentLayer.Background = new SolidColorBrush(Colors.LightGray);
                TransparentLayer.Opacity = 0.9;

                Border _border = new Border();
                _border.BorderBrush = new SolidColorBrush(Colors.Gray);
                _border.BorderThickness = new Thickness(2, 2, 2, 2);

                TextBlock _message = new TextBlock();
                _message.TextWrapping = TextWrapping.Wrap;
                _message.Text = message;
                _message.Width = 200.0;
                _message.Margin = new Thickness(5, 10, 5, 10);

                _message.TextAlignment = TextAlignment.Center;

                _message.Opacity = 1.0;

                _message.FontSize = 14.0;
                _message.Foreground = new SolidColorBrush(Colors.Black);

                StackPanel _StackPanelMessage = new StackPanel();
                _StackPanelMessage.VerticalAlignment = VerticalAlignment.Center;
                _StackPanelMessage.Background = new SolidColorBrush(Colors.White);
                _StackPanelMessage.Children.Add(_message);
                _message.VerticalAlignment = VerticalAlignment.Center;

                _border.Child = _StackPanelMessage;

                _border.SetValue(Canvas.LeftProperty, (_width / 2.0) - 100);
                _border.SetValue(Canvas.TopProperty, (_height / 2.0) - 100);

                TransparentLayer.Children.Add(_border);

                CanvasParent.Children.Add(TransparentLayer);
            }
        }

        private void StartLoading(Canvas canvas)
        {
            bool _exist = false;
            Type _type = canvas.GetType();

            foreach (FrameworkElement _element in canvas.Children)
            {
                if (_element.GetType().Equals(_type) && _element.GetValue(NameProperty).Equals(canvas.Name + "Mask"))
                {
                    _exist = true;
                }
            }

            if (!_exist)
            {
                Canvas TransparentMask = new Canvas();
                TransparentMask.Name = canvas.Name + "Mask";
                double _width, _height;
                _width = canvas.Width;
                _height = canvas.Height;

                TransparentMask.SetValue(Canvas.LeftProperty, 0.0);
                TransparentMask.SetValue(Canvas.TopProperty, 0.0);

                TransparentMask.Width = _width;
                TransparentMask.Height = _height;
                TransparentMask.Background = new SolidColorBrush(Colors.LightGray);
                TransparentMask.Opacity = 0.4;

                Icon RotateIconDynamic = new Icon();

                RotateIconDynamic.SetValue(Canvas.LeftProperty, (_width / 2.0) - 30.0);
                RotateIconDynamic.SetValue(Canvas.TopProperty, (_height / 2.0) - 30.0);

                TransparentMask.Children.Add(RotateIconDynamic);
                TransparentMask.Visibility = Visibility.Visible;

                canvas.Children.Add(TransparentMask);
            }
        }

        private void StopLoading(Canvas canvas)
        {
            Type _type = canvas.GetType();
            bool _exist = false;
            Canvas _TransparentMasnk = null;

            foreach (FrameworkElement _element in canvas.Children)
            {
                if (_element.GetType().Equals(_type) && _element.GetValue(NameProperty).Equals(canvas.Name + "Mask"))
                {
                    _exist = true;
                    _TransparentMasnk = _element as Canvas;
                }
            }
            if (_exist && _TransparentMasnk != null)
            {
                canvas.Children.Remove(_TransparentMasnk);
                canvas.Children.Remove(_TransparentMasnk);
            }

            //Canvas _TransparentMasnk = canvas.Children.First(x => x.GetValue(NameProperty).Equals(canvas.Name + "Mask")) as Canvas;
            //canvas.Children.Remove(_TransparentMasnk);
        }

        private string CreateSmileXML()
        {
            string Smile = "<Smile>\n";

            #region ATMRRFLY

            Smile += "\t<ATMRRFLY>\n";



            for (int i = 0; i < this.SmileATMRRFLYList.Count; i++)
            {
                Smile += string.Format(
                                             "\t\t<itemATMRRFLY TENOR='{0}' ATM='{1}' RR10D='{2}' BF10D='{3}' RR25D='{4}' BF25D='{5}' />\n",
                                             SmileATMRRFLYList[i].Tenor,// 00
                                             SmileATMRRFLYList[i].ATM,  // 01
                                             SmileATMRRFLYList[i].RR10D,// 02
                                             SmileATMRRFLYList[i].BF10D,// 03
                                             SmileATMRRFLYList[i].RR25D,// 04
                                             SmileATMRRFLYList[i].BF25D// 05

                                           );
            }
            Smile += "\t</ATMRRFLY>\n";

            #endregion

            #region CALLPUT

            Smile += "\t<CALLPUT>\n";

            for (int i = 0; i < this.SmileCallPutList.Count; i++)
            {
                Smile += string.Format(
                                             "\t\t<itemCALLPUT TENOR='{0}' PUT10D='{1}' PUT25D='{2}' ATM='{3}' CALL25D='{4}' CALL10D='{5}' />\n",
                                             SmileCallPutList[i].Tenor,      // 00
                                             SmileCallPutList[i].Put10,    // 01
                                             SmileCallPutList[i].Put25,    // 02
                                             SmileCallPutList[i].Atm,    // 03
                                             SmileCallPutList[i].Call25,    // 04
                                             SmileCallPutList[i].Call10    // 05
                                           );
            }

            Smile += "\t</CALLPUT>\n";

            #endregion

            #region STRIKES

            Smile += "\t<STRIKES>\n";

            for (int i = 0; i < this.SmileStrikesList.Count; i++)
            {
                Smile += string.Format(
                                             "\t\t<itemSTRIKES TENOR='{0}' PUT10D='{1}' PUT25D='{2}' ATM='{3}' CALL25D='{4}' CALL10D='{5}' />\n",
                                             SmileStrikesList[i].Tenor,          // 00
                                             SmileStrikesList[i].Put10,      // 01
                                             SmileStrikesList[i].Put25,      // 02
                                             SmileStrikesList[i].Atm,      // 03
                                             SmileStrikesList[i].Call25,      // 04
                                             SmileStrikesList[i].Call10       // 05
                                           );
            }

            Smile += "\t</STRIKES>\n";

            #endregion

            Smile += "</Smile>\n";

            return Smile;
        }
    }
}