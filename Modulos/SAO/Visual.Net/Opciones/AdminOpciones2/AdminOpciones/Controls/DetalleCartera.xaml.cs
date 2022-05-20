using System;
using System.Collections.Generic;
using System.Linq;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Input;
using System.Windows.Browser;
using AdminOpciones.Struct;
using AdminOpciones.Struct.Generic;
using AdminOpciones.Recursos;
using System.Threading;
using System.Xml.Linq;
using System.Xml;
using System.Collections.ObjectModel;
using System.Globalization;
using System.Windows.Media.Imaging;
using System.Windows.Controls.Primitives;
using Liquid;
using System.Windows.Media;
using System.Windows.Data;
using System.Data;
using AdminOpciones.Struct.OpcionesXF.Customers;
using AdminOpciones.SrvDetalles;
using AdminOpciones.SrvAcciones;

namespace AdminOpciones.Controls
{


    public enum EnumDetalleCartera
    {
        Init = 0,
        ConsultaCartera = 1,
        MantencionCartera = 2,
        PrepararAccion = 3,
        AnticiparContratos = 4,
        FaxConfirmacion = 5,
        EmisionContratosEmpresas = 6
    }

    public partial class DetalleCartera : UserControl
    {

        #region Definición de Variables
               
        private AdminOpciones.SrvAcciones.WebAccionesSoapClient sva = wsGlobales.Acciones;

        private AdminOpciones.SrvDetalles.WebDetallesSoapClient svc = wsGlobales.Detalles;

        private List<StructCaContrato> _ContraList;
        //Strip ASIATICO: FILTRO ESTRUCTURA
        private List<StructCaContrato> ContraListFiltrado;
        private List<StructCodigoDescripcion> OpcionesEstructuraList;

        private ObservableCollection<StructCaContrato> ContraList;
        private ObservableCollection<StructCaContrato> PContraList;
        private ObservableCollection<StructMoCotizacion> CotizaList;
        private List<StructMoCotizacion> _CotizaList;
        private ObservableCollection<StructMoCotizacion> PCotizaList;
        private XDocument xmlContratos = new XDocument();
        private XDocument xmlResult = new XDocument();
        private XDocument xmlCotizacion = new XDocument();
        private bool _Estado;
        private string mDocumentType;
        private bool _Selected;

        private static String mError;
        private static String mStack;
        private EnumDetalleCartera TipoDetalleCartera { get; set; }

        public string XmlResultIniDia;
        public string XmlResultContra;
        public string XmlResultCotiza;
        public string FechaProc;
        public string Mensaje_ = string.Empty;

        //STRIP ASIATICO: FILTRO ESTRUCTURA
        public bool FiltroEstructura = false;

        public string _TipoUso;
        public class _ResultadosCotizacion
        {
            public string MsgStatus { get; set; }
            public override string ToString()
            {
                return string.Format("?MsgStatus={0}", MsgStatus);
            }
        }

        public class _Resultados
        {
            public string Folio { get; set; }
            public string Result { get; set; }

            public override string ToString()
            {
                return string.Format("?Folio={0}&Result={1}", Folio, Result);
            }
        }

        public class _Resultados_Estado
        {
            public string Contrato { get; set; }
            public string Fecha { get; set; }
            public string Result { get; set; }

            public override string ToString()
            {
                return string.Format("?Contrato={0}&Fecha={1}&Result={2}", Contrato, Fecha, Result);
            }
        }

        public class _Exporta
        {
            public string _TipoServ { get; set; }
            public string _CR { get; set; }
            public string _CT { get; set; }

            public override string ToString()
            {
                return string.Format("?TipoServicio={0}&CR={1}&CT={2}", _TipoServ, _CR, _CT);
            }
        }

        private bool Habilitado = true;

        #endregion

        public DetalleCartera()
        {
            InitializeComponent();
            
            btn_IngSDA.Visibility = Visibility.Collapsed;
            TipoDetalleCartera = EnumDetalleCartera.Init;
            _Selected = true;
            btn_filtro_estructura.IsEnabled = false;
            
            svc.CaEncContratoCompleted += new EventHandler<CaEncContratoCompletedEventArgs>(svc_CaEncContratoCompleted);
            svc.MoEncCotizacionCompleted += new EventHandler<MoEncCotizacionCompletedEventArgs>(svc_MoEncCotizacionCompleted);
            sva.ActualizaCaEncCompleted += new EventHandler<ActualizaCaEncCompletedEventArgs>(sva_ActualizaCaEncCompleted);
            sva.ActualizaEstadoCompleted += new EventHandler<ActualizaEstadoCompletedEventArgs>(sva_ActualizaEstadoCompleted);
            sva.InsertImpresionCompleted += new EventHandler<InsertImpresionCompletedEventArgs>(sva_InsertImpresionCompleted);
            sva.ModificaCotizaCompleted += new EventHandler<ModificaCotizaCompletedEventArgs>(sva_ModificaCotizaCompleted);
            svc.ConsultaOperacionCompleted += new EventHandler<ConsultaOperacionCompletedEventArgs>(svc_ConsultaOperacionCompleted);

            //SOLICITUDSDA
            _IngSolicitudSDA.MaskCollapsed += new AdminOpciones.Ejercer.Delegate(_IngSolicitudSDA_MaskCollapsed);
            _IngSolicitudSDA.SetData += new AdminOpciones.Ejercer.SetData(_IngSolicitudSDA_SetData);

            //IAF 24/11/2009 Nueva forma de cargar cartera de clientes. Se modifico para cargar de forma diferente en CondicionesGenerales.
            this.ctrCliente.isCondicionesGenerales = false;
            this.ctrCliente.Load();              

            if (globales._FechaContrato1 != string.Empty)
            {
                this.dataPickerFechaProceso_contrato1.Text = Convert.ToDateTime(Convert.ToString(globales._FechaContrato1)).ToString("dd/MM/yyyy");
            }

            if (globales._FechaContrato2 != string.Empty)
            {
                this.dataPickerFechaProceso_contrato2.Text = Convert.ToDateTime(Convert.ToString(globales._FechaContrato2)).ToString("dd/MM/yyyy");
            }

            if (globales._FechaEjercicio1 != string.Empty)
            {
                this.dataPickerFechaProceso_ejercicio1.Text = Convert.ToDateTime(Convert.ToString(globales._FechaEjercicio1)).ToString("dd/MM/yyyy");
            }

            if (globales._FechaEjercicio2 != string.Empty)
            {
                this.dataPickerFechaProceso_ejercicio2.Text = Convert.ToDateTime(Convert.ToString(globales._FechaEjercicio2)).ToString("dd/MM/yyyy");
            }

            btn_IngSDA.Visibility = Visibility.Collapsed;
            Listar_Fecha_IniDia();
            Listar_Detalle_Cartera();
        }

        #region Lista Fecha Proceso

        private void Listar_Fecha_IniDia()
        {
            FechaProc = globales._FechaProceso;
        }

        #endregion

        #region Listar Detalle Cartera

        private void Listar_Detalle_Cartera()
        {
            StartLoading();
            string _fContratoIni = Convert.ToDateTime(Convert.ToString(dataPickerFechaProceso_contrato1)).ToString("yyyy/MM/dd");
            string _fContratoFin = Convert.ToDateTime(Convert.ToString(dataPickerFechaProceso_contrato2)).ToString("yyyy/MM/dd");
            string _fEjercicioIni = Convert.ToDateTime(Convert.ToString(dataPickerFechaProceso_ejercicio1)).ToString("yyyy/MM/dd");
            string _fEjercicioFin = Convert.ToDateTime(Convert.ToString(dataPickerFechaProceso_ejercicio2)).ToString("yyyy/MM/dd");
            string _Relacionado = this.cmbRelacionado.SelectionBoxItem == null ? "" : this.cmbRelacionado.SelectionBoxItem.ToString();
            int _Estado = cmb_vgte_vcdo.SelectedIndex;

            if ((Convert.ToString(ctrCliente.autoCompleteBoxRut.Text)) != ""
                && (Convert.ToString(ctrCliente.comboCodigoRut.SelectedItem) != ""))
            {
                svc.CaEncContratoAsync(Convert.ToInt32(ctrCliente.autoCompleteBoxRut.SelectedItem), Convert.ToInt32(ctrCliente.comboCodigoRut.SelectedItem), _Estado, _fContratoIni, _fContratoFin, _fEjercicioIni, _fEjercicioFin,_Relacionado);
            }
            else
            {
                svc.CaEncContratoAsync(0, 0, _Estado, _fContratoIni, _fContratoFin, _fEjercicioIni, _fEjercicioFin, _Relacionado);
            }
        }

        private void svc_CaEncContratoCompleted(object sender, CaEncContratoCompletedEventArgs e)
        {            
            XmlResultContra = e.Result;
            if (XmlResultContra.Length > 0)
            {
                ContratoOPT(XmlResultContra);
                if (ContraList.Count > 0 && FiltroEstructura == false)
                {
                    _Selected = false;
                    dgPersona.ItemsSource = ContraList;
                    _Selected = true;
                }
                else
                {
                    if (ContraList.Count > 0 && FiltroEstructura == true)
                    {
                        _Selected = false;
                        ContraListFiltrado = new List<StructCaContrato>();

                        for (int i = 0; i < ContraList.Count; i++)
                        {
                            //((System.Windows.Controls.ComboBoxItem)(cmbFiltroEstructura.SelectedItem)).Tag
                            if (_ContraList[i].OpcEstCod == ((ComboBoxItem)(cmbFiltroEstructura.SelectedItem)).Tag.ToString())
                            {
                                ContraListFiltrado.Add(_ContraList[i]);
                            }
                        }
                        if (ContraListFiltrado.Count > 0)
                        {
                            dgPersona.ItemsSource = ContraListFiltrado;
                        }
                        else
                        {
                            System.Windows.Browser.HtmlPage.Window.Alert("No se encontraron registros");
                        }
                        _Selected = true;
                        FiltroEstructura = false;
                    }
                }
            }
            StopLoading();
            btn_filtro_estructura.IsEnabled = true;
        }

        #endregion

        #region Listar Cotizacion

        void ListarMoCotizacion()
        {
            svc.MoEncCotizacionAsync(globales._CliRut, globales._CliCod);

        }

        void svc_MoEncCotizacionCompleted(object sender, MoEncCotizacionCompletedEventArgs e)
        {
            XmlResultCotiza = e.Result;
            if (XmlResultCotiza.Length > 0)
            {
                CotizacionOPT(XmlResultCotiza);
                if (CotizaList.Count > 0)
                {
                    _gridresuModifica.ItemsSource = CotizaList;
                }
            }
            StopLoading();
        }

        #endregion

        #region Actualiza

        private void Actualiza(List<StructCaContrato> _List)
        {
            List<string> _valor = new List<string>();

            if (_List.Count > 0)
            {
                foreach (StructCaContrato _values in _List)
                {
                    _valor.Add(_values.NumContrato.ToString());
                }
                sva.ActualizaCaEncAsync(_valor.ToArray());
            }
        }
        
        void sva_ActualizaCaEncCompleted(object sender, ActualizaCaEncCompletedEventArgs e)
        {
            DeshabilitarControles();
            string _xmlResult = e.Result.ToString();
            xmlResult = XDocument.Parse(_xmlResult);
            List<_Resultados> _data = new List<_Resultados>();

            IEnumerable<XElement> elements = xmlResult.Element("Resultado").Elements("Data");
            foreach (XElement element in elements)
            {
                _Resultados _sData = new _Resultados();
                _sData.Folio = element.FirstAttribute.Value.ToString();
                _sData.Result = element.LastAttribute.Value.ToString();

                _data.Add(_sData);
            }
            _gridresu.ItemsSource = _data;
            _pop.Show();
        }

        #endregion

        #region Actualiza Estado

        private void ActualizaEstadoContratos(List<StructCaContrato> _List)
        {
            int fecha_int = 0;
            string tag = "";

            List<string> _valor = new List<string>();
            List<string> _Fecha = new List<string>();

            fecha_int = int.Parse(Convert.ToDateTime(Convert.ToString(FechaProc)).ToString("yyyyddMM"));

            if (_List.Count > 0)
            {
                foreach (StructCaContrato _values in _List)
                {   // MAP: Para permitir anular en el dia y revertir preparacion en cualquier dia  
                    //      MAP 23 Octubre se comenta temporalmente:

                    // if ((int.Parse(Convert.ToDateTime(Convert.ToString(_values.FechaContrato.ToString())).ToString("yyyyddMM")) < fecha_int)
                    //     ||
                    //     (cmbEstado.SelectionBoxItem.ToString() == "Anula")
                    //     ||
                    //     (cmbEstado.SelectionBoxItem.ToString() == "Sin Acción")
                    //     )
                    //{
                    _valor.Add(_values.NumContrato.ToString());
                    //}

                }

                tag = ((ComboBoxItem)cmbEstado.SelectedItem).Tag.ToString();

                sva.ActualizaEstadoAsync(_valor.ToArray(), globales._Usuario, tag);
            }
        }

        void sva_ActualizaEstadoCompleted(object sender, AdminOpciones.SrvAcciones.ActualizaEstadoCompletedEventArgs e)
        {
            DeshabilitarControles();
            string _xmlResult = e.Result.ToString();
            xmlResult = XDocument.Parse(_xmlResult);
            List<_Resultados_Estado> _data = new List<_Resultados_Estado>();

            IEnumerable<XElement> elements = xmlResult.Element("Resultado").Elements("Data");
            foreach (XElement element in elements)
            {
                _Resultados_Estado _sData = new _Resultados_Estado();
                _sData.Contrato = element.FirstAttribute.Value.ToString();
                _sData.Fecha = element.Attribute("Fecha").Value.ToString();
                _sData.Result = element.LastAttribute.Value.ToString();

                _data.Add(_sData);
            }
            _gridresuEstado.ItemsSource = _data;
            _popEstado.Show();

            for (int _Row = 0; _Row < ContraList.Count; _Row++)
            {
                ContraList[_Row].VF = "False";
            }
            _Estado = false;

            BitmapImage _Imagen = new BitmapImage();
            _Imagen.UriSource = new Uri("../Images/checkedbox.png", UriKind.Relative);
            this.SelTodo.Source = _Imagen;
            ToolTipService.SetToolTip(SelTodo, "Seleccionar Todo");

            //IAF Actualiza la grilla una vez que se prepara accion, para ver actualizado el nuevo estado.
            Listar_Detalle_Cartera();         

        }

        #endregion

        #region Imprimir Fax Contrato

        /// <summary>
        /// Invoca WS de impresión, armando xml con datos.
        /// </summary>
        /// <param name="listImp"></param>
        /// <param name="reportCode"></param>
        private void ImprimirFaxContrato(List<StructCaContrato> listImp, string reportCode)
        {
            if (listImp.Count > 0)
            {
                #region Generación de XML

                string _Xml = "<?xml version=\"1.0\" encoding=\"utf-8\"?>";

                _Xml += string.Format("<Options User='{0}' ReportCode='{1}' >", globales._Usuario, reportCode);
                foreach (StructCaContrato _Values in listImp)
                {
                    _Xml += string.Format(
                                           "<Option Contrato='{0}' Folio='{1}' />",
                                           _Values.NumContrato,
                                           _Values.NumFolio
                                         );
                    _Values.Marca = true;
                }
                _Xml += "</Options>";

                #endregion Generación de XML

                #region Ejecución del WebService
                sva.InsertImpresionAsync(_Xml);
                #endregion
            }
        }

        void sva_InsertImpresionCompleted(object sender, AdminOpciones.SrvAcciones.InsertImpresionCompletedEventArgs e)
        {
            if (e.Error == null)
            {
                XDocument _XMLValue = XDocument.Parse(e.Result);

                if (_XMLValue.Element("ID").Attribute("Error").Value.Equals("0"))
                {
                    ImprimirDocumento(int.Parse(_XMLValue.Element("ID").Attribute("Value").Value), _XMLValue.Element("ID").Attribute("ReportCode").Value);
                    //System.Windows.Browser.HtmlPage.Window.Alert(_XMLValue.Element("ID").Attribute("Value").Value);
                }
                else
                {
                    System.Windows.Browser.HtmlPage.Window.Alert("ERROR");
                }
            }
        }

        #endregion Imprimir Fax Contrato

        #region Modificar Cotiza

        private void ModificarCotiza()
        {
            bool _validacion = PreparaAplicar();
            if (_validacion)
            {
                foreach (StructMoCotizacion _values in globales._Cotizacion)
                {
                    globales._NumCotizacion = int.Parse(_values.NumContrato);
                }

                foreach (StructCaContrato _values in globales._Contrato)
                {
                    globales._NumContrato = int.Parse(_values.NumContrato);
                }


                if (globales._NumCotizacion != 0)
                {
                    string msg = "Contrato " + globales._NumContrato + " será modificado con Cotizacion " + globales._NumCotizacion + ", ¿continúa?";

                    if (System.Windows.Browser.HtmlPage.Window.Confirm(msg))
                    {
                        sva.ModificaCotizaAsync(globales._NumContrato, globales._NumCotizacion);
                    }
                }

                else
                {
                    System.Windows.Browser.HtmlPage.Window.Alert("No Existen Contratos Para Modificar");
                    HabilitarControlesBasicos();
                    _popModifica.Close();
                }


            }
            else
            { globales._Valida = _validacion; }
        }

        void sva_ModificaCotizaCompleted(object sender, AdminOpciones.SrvAcciones.ModificaCotizaCompletedEventArgs e)
        {
            string _xmlResult = e.Result.ToString();
            _ResultadosCotizacion _sData = new _ResultadosCotizacion();
            xmlResult = XDocument.Parse(_xmlResult);
            List<_ResultadosCotizacion> _data = new List<_ResultadosCotizacion>();

            IEnumerable<XElement> elements = xmlResult.Element("Resultado").Elements("Data");
            foreach (XElement element in elements)
            {
                //_Resultados _sData = new _Resultados();
                _sData.MsgStatus = element.FirstAttribute.Value.ToString();
                _data.Add(_sData);
            }

            Mensaje_ = _sData.MsgStatus.ToString();
            System.Windows.Browser.HtmlPage.Window.Alert(Mensaje_);
            HabilitarControlesBasicos();
            _popModifica.Close();
        }

        #endregion

        private void ImprimirDocumento(int id, string reportCode)
        {
            string _Nombre = "";
            string _Fecha = "";
            _Nombre = globales._Usuario;
            _Fecha = globales._FechaProceso;

            List<StructCaContrato> _ListImp = PreparaImpresion();
            List<KeyValuePair<string, string>> lst_;

            switch (mDocumentType)
            {
                case "C":
                    lst_ = new List<KeyValuePair<string, string>>();

                    lst_.Add(new KeyValuePair<string, string>("NumContrato", id.ToString()));
                    lst_.Add(new KeyValuePair<string, string>("RepName", "~/CrystalReportes/Papeleta_Cartera_Nivel_Fixing.rpt"));
                    lst_.Add(new KeyValuePair<string, string>("Tipo", "Cartera"));
                    lst_.Add(new KeyValuePair<string, string>("Usuario", _Nombre));
                    lst_.Add(new KeyValuePair<string, string>("Fecha", _Fecha));

                    this.ProcessCommand(lst_.ToArray());
                    break;
                case "F":
                    lst_ = new List<KeyValuePair<string, string>>();

                    lst_.Add(new KeyValuePair<string, string>("NumContrato", id.ToString()));
                    lst_.Add(new KeyValuePair<string, string>("RepName", "~/CrystalReportes/Fax_Opciones.rpt"));
                    lst_.Add(new KeyValuePair<string, string>("Tipo", "Fax"));
                    lst_.Add(new KeyValuePair<string, string>("Usuario", _Nombre));
                    lst_.Add(new KeyValuePair<string, string>("Fecha", _Fecha));

                    this.ProcessCommand(lst_.ToArray());
                    break;
                case "E":
                    string _NomReporte = "";
                    string _Tipo = "";
                    _Nombre = globales._Usuario;
                    _Fecha = globales._FechaProceso;

                    // MAP Ago 2009
                    //0          Vanilla
                    //1          Straddle
                    //2          Risk Reversal
                    //3          Butterfly
                    //4          Forward Utilidad Acotada
                    //5          Forward Perdida Acotada
                    //6          Forward Sintetico
                    //7          Strangle
                    _NomReporte = "Generico";
                    switch (reportCode)
                    {
                        case "1":
                            _NomReporte = "~/CrystalReportes/ContratoLegal_Vanilla.rpt";
                            _Tipo = "Vanilla";
                            break;
                        case "2":
                            _NomReporte = "~/CrystalReportes/ContratoLegal_Asiatica.rpt";
                            _Tipo = "Asiatica";
                            break;
                        case "3":
                            _NomReporte = "~/CrystalReportes/ContratoLegal_Straddle.rpt";
                            _Tipo = "Vanilla";
                            break;
                        case "4":
                            _NomReporte = "~/CrystalReportes/ContratoLegal_RiskReversal.rpt";
                            _Tipo = "Vanilla";
                            break;
                        case "5":
                            _NomReporte = "~/CrystalReportes/ContratoLegal_Butterfly.rpt";
                            _Tipo = "Vanilla";
                            break;
                        case "6":
                            _NomReporte = "~/CrystalReportes/ContratoLegal_ForwardAcotado.rpt";
                            _Tipo = "Vanilla";
                            break;
                        case "7":
                            _NomReporte = "~/CrystalReportes/ContratoLegal_ForwardAsiatico.rpt";
                            _Tipo = "Vanilla";
                            break;
                        case "8":
                            _NomReporte = "~/CrystalReportes/ContratoLegal_Strangle.rpt";
                            _Tipo = "Vanilla";
                            break;
                        case "9":
                            _NomReporte = "~/CrystalReportes/ContratoLegal_ForwardAmericano.rpt";
                            _Tipo = "Vanilla";
                            break;
                        case "10":
                        case "11":
                            _NomReporte = "~/CrystalReportes/ContratoLegal_StripAsiatico.rpt";
                            _Tipo = "Vanilla";
                            break;
                        case "12":
                            _NomReporte = "~/CrystalReportes/ContratoLegal_Call_Spread.rpt";
                            _Tipo = "Vanilla";
                            break;
                        case "13":
                            _NomReporte = "~/CrystalReportes/ContratoLegal_Put_Spread.rpt";
                            _Tipo = "Vanilla";
                            break;
                        case "14":
                            _NomReporte = "~/CrystalReportes/ContratoLegal_ForwardAsiaticoEntradaSalida.rpt";
                            _Tipo = "Vanilla"; //ASVG_20130212 PRD_12567 REVISAR
                            break;
                        case "15":
                            _NomReporte = "~/CrystalReportes/ContratoLegal_CallSpreadDoble.rpt";
                            _Tipo = "Vanilla";
                            break;
                        default:
                            _NomReporte = "~/CrystalReportes/ContratoLegal_Generico.rpt";
                            _Tipo = "Generico";
                            break;
                    }


                    // MAP Ago 2009

                    lst_ = new List<KeyValuePair<string, string>>();

                    lst_.Add(new KeyValuePair<string, string>("NumContrato", id.ToString()));
                    lst_.Add(new KeyValuePair<string, string>("RepName", _NomReporte));
                    lst_.Add(new KeyValuePair<string, string>("Tipo", _Tipo));
                    lst_.Add(new KeyValuePair<string, string>("Usuario", _Nombre));
                    lst_.Add(new KeyValuePair<string, string>("Fecha", _Fecha));
                    lst_.Add(new KeyValuePair<string, string>("RutRepCli01", "0"));
                    lst_.Add(new KeyValuePair<string, string>("RutRepCli02", "0"));
                    lst_.Add(new KeyValuePair<string, string>("RutRepBan01", "0"));
                    lst_.Add(new KeyValuePair<string, string>("RutRepBan02", "0"));

                    this.ProcessCommand(lst_.ToArray());
                    break;
            }

        }

        public void btn_Aplicar_Click(object sender, RoutedEventArgs e)
        {   //Cwaldhorn 26-08-2009
            ModificarCotiza();
        }

        private void Preparar_Click(object sender, RoutedEventArgs e)
        {
            List<StructCaContrato> _ListImp = PreparaImpresion();

            if (_ListImp.Count > 0)
            {
                ActualizaEstadoContratos(_ListImp);
            }
        }

        private void ContratoOPT(string strXMLContra)
        {
            xmlContratos = XDocument.Parse(strXMLContra);
            var CaContratos = from ContraOPTXML in xmlContratos.Descendants("Data")
                              select new StructCaContrato
                              {
                                  VF = ContraOPTXML.Attribute("VF").Value.ToString(),
                                  Objeto = ContraOPTXML.Attribute("Objeto").Value.ToString(),
                                  NumContrato = ContraOPTXML.Attribute("NumContrato").Value.ToString(),
                                  TipoTransaccion = ContraOPTXML.Attribute("TipoTransaccion").Value.ToString(),
                                  NumFolio = ContraOPTXML.Attribute("NumFolio").Value.ToString(),
                                  FechaContrato = ContraOPTXML.Attribute("FechaContrato").Value.ToString(),
                                  ConOpcEstCod = ContraOPTXML.Attribute("ConOpcEstCod").Value.ToString(),
                                  ConOpcEstDsc = ContraOPTXML.Attribute("ConOpcEstDsc").Value.ToString(),
                                  CliRut = ContraOPTXML.Attribute("CliRut").Value.ToString(),
                                  CliCod = ContraOPTXML.Attribute("CliCod").Value.ToString(),
                                  CliDv = ContraOPTXML.Attribute("CliDv").Value.ToString(),
                                  CliNom = ContraOPTXML.Attribute("CliNom").Value.ToString(),
                                  Operador = ContraOPTXML.Attribute("Operador").Value.ToString(),
                                  OpcEstCod = ContraOPTXML.Attribute("OpcEstCod").Value.ToString(),
                                  OpcEstDsc = ContraOPTXML.Attribute("OpcEstDsc").Value.ToString(),
                                  PayOffCod = ContraOPTXML.Attribute("PayOffCod").Value.ToString(),
                                  Contrapartida = ContraOPTXML.Attribute("Contrapartida").Value.ToString()
                              };

             ContraList = new ObservableCollection<StructCaContrato>();           
            _ContraList = new List<StructCaContrato>(CaContratos.ToList<StructCaContrato>());
             PContraList = new ObservableCollection<StructCaContrato>();
            foreach(StructCaContrato _Aux in _ContraList)
            {
                if (    this._TipoUso == "Preparar"   && ( _Aux.sConOpcEstCod == "U" || _Aux.sConOpcEstCod == "M" )
                     || this._TipoUso == "Anticipo"   && _Aux.sConOpcEstCod == "N"
                     || this._TipoUso == "Todas"
                     || this._TipoUso == "NoCotizaciones" && _Aux.sConOpcEstCod != "C" 
                    ) // MAP 28 Agosto 
                {
                    ContraList.Add(_Aux);
                    PContraList.Add(_Aux);
                }
            }
        }

        private void CotizacionOPT(string strXMLCotiza)
        {
            xmlCotizacion = XDocument.Parse(strXMLCotiza);
            var MoCotizacion = from CotizaOPTXML in xmlCotizacion.Descendants("Data")
                              select new StructMoCotizacion
                              {
                                    VF = CotizaOPTXML.Attribute("VF").Value.ToString(),
                                    NumContrato = CotizaOPTXML.Attribute("NumContrato").Value.ToString(),
                                    NumFolio = CotizaOPTXML.Attribute("NumFolio").Value.ToString(),
                                    CliNom = CotizaOPTXML.Attribute("CliNom").Value.ToString(),
                                    OpcEstDsc = CotizaOPTXML.Attribute("OpcEstDsc").Value.ToString(),
                                    Operador = CotizaOPTXML.Attribute("Operador").Value.ToString(),
                                    Objeto = CotizaOPTXML.Attribute("Objeto").Value.ToString(),
                                    CliCod = CotizaOPTXML.Attribute("CliCod").Value.ToString(),
                                    CliRut = CotizaOPTXML.Attribute("CliRut").Value.ToString(),
                                    CliDv = CotizaOPTXML.Attribute("CliDv").Value.ToString(),
                                    OpcEstCod = CotizaOPTXML.Attribute("OpcEstCod").Value.ToString(),
                                    FechaCreacionRegistro = CotizaOPTXML.Attribute("FechaCreacionRegistro").Value.ToString(),
                                    FechaContrato = CotizaOPTXML.Attribute("FechaContrato").Value.ToString()
                              };
            try
            {

                CotizaList = new ObservableCollection<StructMoCotizacion>();
                _CotizaList = new List<StructMoCotizacion>(MoCotizacion.ToList<StructMoCotizacion>());
                PCotizaList = new ObservableCollection<StructMoCotizacion>();
                foreach (StructMoCotizacion _Auxc in _CotizaList)
                {
                    CotizaList.Add(_Auxc);
                }
            }

            catch (Exception _Error)
            {
                mError = _Error.StackTrace;
                mStack = _Error.Message;
            }
        }
         
        private void Buscar_Click(object sender, RoutedEventArgs e)
        {          
            Listar_Detalle_Cartera();
            HabilitarControlesBasicos();
            _control.Close();
        }

        private void selTodo_Click(object sender, System.Windows.Input.MouseButtonEventArgs e)
        {
            if (ContraList != null)
            {
                if (Habilitado)
                {
                    int _Row;
                    if (ContraList == null)
                    {
                        return;
                    }
                    if (_Estado == false)
                    {
                        if (ContraList.Count > 0)
                        {
                            for (_Row = 0; _Row < ContraList.Count; _Row++)
                            {
                                ContraList[_Row].VF = "True";
                            }
                            _Estado = true;

                            BitmapImage _Imagen = new BitmapImage();
                            _Imagen.UriSource = new Uri("../Images/uncheked.PNG", UriKind.Relative);
                            this.SelTodo.Source = _Imagen;
                            ToolTipService.SetToolTip(SelTodo, "Deseleccionar Todo");
                        }
                    }
                    else
                    {
                        if (ContraList.Count > 0)
                        {
                            for (_Row = 0; _Row < ContraList.Count; _Row++)
                            {
                                ContraList[_Row].VF = "False";
                            }
                            _Estado = false;

                            BitmapImage _Imagen = new BitmapImage();
                            _Imagen.UriSource = new Uri("../Images/checkedbox.png", UriKind.Relative);
                            this.SelTodo.Source = _Imagen;
                            ToolTipService.SetToolTip(SelTodo, "Seleccionar Todo");
                        }
                    }
                    _Selected = false;
                    dgPersona.ItemsSource = null;
                    dgPersona.ItemsSource = ContraList;
                    _Selected = true;
                }
            }
        }

        #region Popup Handling

        private void Dialog_Minimizing(object sender, DialogEventArgs e)
        {
            Dialog dialog = (Dialog)sender;            
            e.Parameter = TransformToVisual(LayoutRoot).Transform(new Point(0, -dialog.MinimizedSize.Height));
        }

        private void Dialog_Minimized(object sender, DialogEventArgs e)
        {
            Dialog dialog = (Dialog)sender;

            if (dialogCanvas.Children.Contains(dialog))
            {
                dialogCanvas.Children.Remove(dialog);
                dockPanel.Children.Insert(0, dialog);
            }
        }

        private void Dialog_Restoring(object sender, DialogEventArgs e)
        {
            Dialog dialog = (Dialog)sender;

            if (dialog.SizeState == DialogSizeState.Minimized)
            {
                dockPanel.Children.Remove((Dialog)sender);
                dialogCanvas.Children.Add((Dialog)sender);
            }
        }

        #endregion

        #region ShowDialog

        private void ShowDialog_Clicked(object sender, RoutedEventArgs e)
        {
            DeshabilitarControles();
            _control.Show();
        }

        private void ShowDialog_Clicked2(object sender, RoutedEventArgs e)
        {
            SelectedOnlyForwardAmerican();
            DeshabilitarControles();
            _controlEstado.Show();
        }

        private void AreYouSure_Closed(object sender, EventArgs e)
        {
            if (_control.Result == DialogButtons.OK)
            {}
        }

        #endregion

        /*----------------------------------REPORTES v1.0 by Edo-------------------------------------------*/
        #region Reporte
        private void Imprimir_Click(object sender, RoutedEventArgs e)
        {
            if (ContraList != null)
            {
                if (Habilitado)
                {
                    List<StructCaContrato> _ListImp = PreparaImpresion();
                    List<StructCaContrato> _ListSel = new List<StructCaContrato>();
                    mDocumentType = Convert.ToString(Imprimir_Copy.Tag);
                    if (mDocumentType == "E")
                    {

                        //0          Vanilla
                        //1          Straddle
                        //2          Risk Reversal
                        //3          Butterfly
                        //4          Forward Utilidad Acotada
                        //5          Forward Perdida Acotada
                        //6          Forward Sintetico
                        //7          Strangle
                        //8          fw americano
                        //9          Strip Asiático CALL
                        //10         Strip Asiático PUT
                        /*
                        0	Vanilla
                        1	Straddle
                        2	Collar (Risk Reversal)
                        3	Butterfly
                        4	Forward Utilidad Acotada
                        5	Forward Perdida Acotada
                        6	Forward Sintético
                        7	Strangle
                        */

                        // ContratoLegal_Asiatica.rpt, Asiatica
                        _ListSel = _ListImp.Where(_Element => _Element.OpcEstCod.Equals("0") && _Element.PayOffCod.Equals("01")).ToList();
                        ImprimirFaxContrato(_ListSel, "1");

                        // ContratoLegal_Vanilla.rpt, Vanilla
                        _ListSel = _ListImp.Where(_Element => _Element.OpcEstCod.Equals("0") && _Element.PayOffCod.Equals("02")).ToList();
                        ImprimirFaxContrato(_ListSel, "2");

                        // ContratoLegal_Straddle.rpt, Vanilla
                        _ListSel = _ListImp.Where(_Element => _Element.OpcEstCod.Equals("1")).ToList();
                        ImprimirFaxContrato(_ListSel, "3");

                        // ContratoLegal_RiskReversal.rpt, Vanilla
                        _ListSel = _ListImp.Where(_Element => _Element.OpcEstCod.Equals("2")).ToList();
                        ImprimirFaxContrato(_ListSel, "4");

                        // ContratoLegal_Butterfly.rpt, Vanilla
                        _ListSel = _ListImp.Where(_Element => _Element.OpcEstCod.Equals("3")).ToList();
                        ImprimirFaxContrato(_ListSel, "5");

                        // ContratoLegal_ForwardAcotado.rpt, Vanilla
                        _ListSel = _ListImp.Where(_Element => _Element.OpcEstCod.Equals("4") || _Element.OpcEstCod.Equals("5")).ToList();
                        ImprimirFaxContrato(_ListSel, "6");

                        // ContratoLegal_ForwardAsiatico.rpt, Vanilla
                        _ListSel = _ListImp.Where(_Element => _Element.OpcEstCod.Equals("6")).ToList();
                        ImprimirFaxContrato(_ListSel, "7");

                        // ContratoLegal_Strangle.rpt, Vanilla
                        _ListSel = _ListImp.Where(_Element => _Element.OpcEstCod.Equals("7")).ToList();
                        ImprimirFaxContrato(_ListSel, "8");

                        //alanrevisar ojo esto no esta en el nuevo, tal vez hay que borrarlo
                        //ASVG_20110228 Agregado para forward Americano.
                        // ContratoLegal_ForwardAmericano.rpt, Vanilla
                        _ListSel = _ListImp.Where(_Element => _Element.OpcEstCod.Equals("8")).ToList();
                        ImprimirFaxContrato(_ListSel, "9");

                        //ContratoLegal_StripAsiatico.rpt, Vanilla CALL
                        _ListSel = _ListImp.Where(_Element => _Element.OpcEstCod.Equals("9")).ToList();
                        ImprimirFaxContrato(_ListSel, "10");

                        //ContratoLegal_StripAsiatico.rpt, Vanilla PUT
                        _ListSel = _ListImp.Where(_Element => _Element.OpcEstCod.Equals("10")).ToList();
                        ImprimirFaxContrato(_ListSel, "11");

                        //ContratoLegal_Call_Spread.rpt, CALL Spread
                        _ListSel = _ListImp.Where(_Element => _Element.OpcEstCod.Equals("11")).ToList();
                        ImprimirFaxContrato(_ListSel, "12");

                        //ContratoLegal_Put_Spread.rpt,  PUT Spread
                        _ListSel = _ListImp.Where(_Element => _Element.OpcEstCod.Equals("12")).ToList();
                        ImprimirFaxContrato(_ListSel, "13");

                        //ContratoLegal_ForwardAsiaticoEntradaSalida
                        _ListSel = _ListImp.Where(_Element => _Element.OpcEstCod.Equals("13")).ToList();
                        ImprimirFaxContrato(_ListSel, "14");//ASVG_20130212 PRD_12567

                        //ContratoLegal_CallSpreadDoble
                        _ListSel = _ListImp.Where(_Element => _Element.OpcEstCod.Equals("14")).ToList();
                        ImprimirFaxContrato(_ListSel, "15");//ASVG_20140731 PRD_20559

                        // ContratoLegal_Generico.rpt, Vanilla
                        _ListSel = _ListImp.Where(_Element => !_Element.Marca).ToList();
                        ImprimirFaxContrato(_ListSel, "-2");//OJO
                    }
                    else
                    {
                        ImprimirFaxContrato(_ListImp, "0");
                    }

                    Actualiza(_ListImp);
                }
            }
        }

        private void ProcessCommand(params KeyValuePair<string, string>[] values)
        {
            Uri serverUri_ = new Uri(wsGlobales.FullUri + "Default.aspx");
            HttpHelper helper = new HttpHelper(serverUri_, "POST", values);
            helper.ResponseComplete += new HttpResponseCompleteEventHandler(this.CommandComplete);
            helper.Execute();
        }

        private void CommandComplete(HttpResponseCompleteEventArgs e)
        {
            this.Dispatcher.BeginInvoke(() => this.WriteText(e.Response));
        }

        private void WriteText(string response)
        {
            HtmlPage.Window.Invoke("AbreReporte", response);
        }

        private List<StructCaContrato> PreparaImpresion() 
        {   
            List<StructCaContrato> _List = new List<StructCaContrato>();
            if (ContraList != null)
            {
                if (ContraList.Count > 0)
                {
                    foreach (StructCaContrato _Aux in ContraList)
                    {
                        if (_Aux.VF == "True")
                        {
                            _List.Add(_Aux);
                        }
                    }
                }
                return _List;
            }
            else
            {
                string Mensaje = "No existen contratos seleccionados para preparar";
                System.Windows.Browser.HtmlPage.Window.Alert(Mensaje);
                return _List;
            }
        }

        #endregion Reporte

        private void ExpExcel_MouseLeftButtonUp(object sender, MouseButtonEventArgs e)
        {
            if (Habilitado)
            {
                string _ID = ctrCliente.autoCompleteBoxRut.Text;
                int _i = cmbTContra.SelectedIndex;
                string _TC = "";

                if (_i > -1)
                {
                    _TC = cmbTContra.SelectedItem.ToString();
                }
                else
                {
                    _TC = "Nulo";
                }

                if (_ID == "")
                {
                    _ID = "Nulo";
                }
                _Exporta _ExportaExcel = new _Exporta { _TipoServ = "MoEncContrato", _CR = _ID, _CT = _TC };
                HtmlPage.Window.Invoke("ExportaExcel", new string[] { _ExportaExcel.ToString() });
            }
        }

        #region "Modificación Contrato"

        /*
         * valores para la variable accion: (0) modificar, (1) anular y (2) anticipar
         */
        private bool PreparaAplicar(int accion)
        {
            string _Title01 = "";
            string _Title02 = "";
            switch (accion)
            {
                case 0:
                    _Title01 = "modificar";
                    _Title02 = "modificación";
                    break;
                case 1:
                    _Title01 = "anular";
                    _Title02 = "anulación";
                    break;
            }

            bool _valor = false;
            if (ContraList != null)
            {
                List<StructCaContrato> _List = ContraList.Where(_Element => _Element.VF.Equals("True")).ToList();
                if (_List.Count > 1)
                {
                    string Mensaje = "Solo puede seleccionar un contrato para " + _Title01;
                    System.Windows.Browser.HtmlPage.Window.Alert(Mensaje);
                    _valor = false;
                }
                else if (_List.Count < 1)
                {
                    string Mensaje = "No existe contrato seleccionado para preparar " + _Title02;
                    System.Windows.Browser.HtmlPage.Window.Alert(Mensaje);
                }
                else
                {
                    globales._Contrato = _List;
                    _valor = true;
                }
            }
            else
            {
                string Mensaje = "No existe contrato seleccionado para preparar " + _Title02;
                System.Windows.Browser.HtmlPage.Window.Alert(Mensaje);
            }
            return _valor;

        }

        private bool PreparaAplicar()
        {
            string _Title01 = "";
            string _Title02 = "";
            _Title01 = "anticipar";
            _Title02 = "anticipación";

            int _cont = 0;
            Boolean _valor = false;
            List<StructMoCotizacion> _List = new List<StructMoCotizacion>();
            if (CotizaList != null)
            {
                if (CotizaList.Count > 0)
                {
                    foreach (StructMoCotizacion _Aux in CotizaList)
                    {
                        if (_Aux.VF == "True")
                        {
                            _List.Add(_Aux);
                            _cont++;
                        }
                    }
                    if (_cont == 1)
                    { _valor = true; globales._Cotizacion = _List; }
                    else
                    {
                        string Mensaje = "Solo puede seleccionar un contrato para " + _Title01;
                        System.Windows.Browser.HtmlPage.Window.Alert(Mensaje);
                        _valor = false;
                    }
                }

                return _valor;
            }
            else
            {
                string Mensaje = "No existe contrato seleccionado para preparar " + _Title02;
                System.Windows.Browser.HtmlPage.Window.Alert(Mensaje);
                return _valor;
            }

        }

        public void btn_Modificar_Click(object sender, RoutedEventArgs e)
        {   //Cwaldhorn 26-08-2009
            bool _validacion = PreparaAplicar(0);
            if (_validacion)
            {
                // MAP 28 Agosto 2009
                foreach (StructCaContrato _values in globales._Contrato)
                {
                    if (_values.ConOpcEstCod != "M")
                    {
                        System.Windows.Browser.HtmlPage.Window.Alert("El contrato no ha sido PREPARADO para Modificar");
                        _validacion = false;
                    }
                    else
                    {
                        foreach (StructCaContrato _values2 in globales._Contrato)
                        {
                            globales._CliRut = int.Parse(_values2.CliRut);
                            globales._CliCod = int.Parse(_values2.CliCod);
                        }

                        DeshabilitarControles();
                        _popModifica.Show();
                        ListarMoCotizacion();
                    }
                }
            }
            else
            { globales._Valida = _validacion; }
          


        }

        private void btn_Anular_Click(object sender, RoutedEventArgs e)
        {
            bool _validacion = PreparaAplicar(1);

            // MAP 17 Agosto 2009
            foreach (StructCaContrato _values in globales._Contrato)
            {
                if (_values.ConOpcEstCod != "U")
                {
                    System.Windows.Browser.HtmlPage.Window.Alert("El contrato no ha sido PREPARADO para Anular");
                    _validacion = false;
                }
            }

            if (_validacion)
            {
                foreach (StructCaContrato _values in globales._Contrato)
                {
                    globales._NumContrato = int.Parse(_values.NumContrato);
                    globales._NumFolio = int.Parse(_values.NumFolio);  
                }
                globales._Valida = _validacion;
            }
            else
            { globales._Valida = _validacion; }
        }

        #endregion        

        private void dgPersona_KeyDown(object sender, KeyEventArgs e)
        {
            #region Copy uisng Ctrl-C

            if (e.Key == Key.C &&
                ((Keyboard.Modifiers & ModifierKeys.Control) == ModifierKeys.Control
                || (Keyboard.Modifiers & ModifierKeys.Apple) == ModifierKeys.Apple)
                )
            {
                DataGrid DataGridRRFLY = sender as DataGrid;

                string textData = "";

                #region Head

                string _TextColumn = "";

                foreach (DataGridColumn _Column in dgPersona.Columns)
                {
                    if (_TextColumn != "")
                    {
                        _TextColumn += "\t";
                    }
                    _TextColumn += _Column.Header;
                }
                textData += _TextColumn + "\n";

                #endregion

                #region Value

                foreach (StructCaContrato _Item in DataGridRRFLY.ItemsSource)
                {
                    textData += string.Format(
                                               "{0}\t{1}\t{2}\t{3}\t{4}\t{5}\t{6}\t{7}\t{8}\t{9}\t{10}\t{11}\n",
                                               _Item.NumContrato.ToString(),
                                               _Item.NumFolio.ToString(),
                                               _Item.TipoTransaccion.ToString(),
                                               DateTime.Parse(_Item.FechaContrato).ToString("dd/MM/yyyy"),
                                               _Item.ConOpcEstDsc.ToString(),
                                               _Item.CliRut.ToString(),
                                               _Item.CliCod.ToString(),
                                               _Item.CliDv.ToString(),
                                               _Item.CliNom.ToString(),
                                               _Item.Contrapartida.ToString(),
                                               _Item.Operador.ToString(),
                                               _Item.OpcEstDsc.ToString()
                                             );
                }

                #endregion

                #region ClipBoardData

                ScriptObject clipboardData = (ScriptObject)HtmlPage.Window.GetProperty("clipboardData");
                if (clipboardData != null)
                {
                    bool success = (bool)clipboardData.Invoke("setData", "text", textData);
                }
                else
                {
                    Dispatcher.BeginInvoke(() => System.Windows.MessageBox.Show("Sorry, this functionality is only avaliable in Internet Explorer."));
                    return;
                }

                #endregion

            }

            #endregion
        }

        //Anticipo        
        #region "Anticipar Contrato"

        private bool PreparaAnticipo()
        {
            int _cont = 0;
            Boolean _valor = false;
            List<StructCaContrato> _List = new List<StructCaContrato>();
            if (ContraList != null)
            {
                if (ContraList.Count > 0)
                {
                    foreach (StructCaContrato _Aux in ContraList)
                    {
                        if (_Aux.VF == "True")
                        {
                            _List.Add(_Aux);
                            _cont++;
                        }
                    }
                    if (_cont == 1)
                    { _valor = true; globales._Contrato = _List; }
                    else
                    {
                        string Mensaje = "Solo puede seleccionar un contrato para Anticipar";
                        System.Windows.Browser.HtmlPage.Window.Alert(Mensaje);
                        _valor = false;
                    }
                }
                return _valor;
            }
            else
            {
                string Mensaje = "No existe contrato seleccionado para preparar Anticipo";
                System.Windows.Browser.HtmlPage.Window.Alert(Mensaje);
                return _valor;
            }
        }

        public void btn_Anticipar_Click(object sender, RoutedEventArgs e)
        {
            bool _validacion = PreparaAnticipo();

            // CER 21 Agosto 2009
            foreach (StructCaContrato _values in globales._Contrato)
            {
                if (_values.ConOpcEstCod != "N")
                {
                    System.Windows.Browser.HtmlPage.Window.Alert("El contrato no ha sido PREPARADO para Anticipar");
                    _validacion = false;
                }
            }


            if (_validacion)
            {
                foreach (StructCaContrato _values in globales._Contrato)
                {
                    globales._NumContrato = int.Parse(_values.NumContrato);
                    globales._NumFolio = int.Parse(_values.NumFolio);
                }
                globales._Valida = _validacion;
            }
            else
            { globales._Valida = _validacion; }
        }

        #endregion
        //Anticipo       

        private void dgPersona_SelectedChange(object sender, SelectionChangedEventArgs e)
        {
            if (_Selected)
            {
                if (((DataGrid)sender).CurrentColumn.DisplayIndex.Equals(0))
                {
                    if (dgPersona.SelectedIndex >= 0)
                    {
                        StructCaContrato _CaContrato = new StructCaContrato();
                        CheckBox _chkControl;
                        _CaContrato = (StructCaContrato)dgPersona.SelectedItem;
                        _chkControl = (CheckBox)dgPersona.Columns[0].GetCellContent(dgPersona.SelectedItem);
                        if (_chkControl != null)
                        {
                            _chkControl.IsChecked = !_chkControl.IsChecked;
                        }
                    }
                }
            }
        }

        private void StartLoading()
        {
            Mask.Visibility = Visibility.Visible;
        }

        private void StopLoading()
        {
            Mask.Visibility = Visibility.Collapsed;
        }

        public void ShowControls(EnumDetalleCartera value)
        {
            TipoDetalleCartera = value;
            HabilitarControlesBasicos();
        }

        private void HabilitarControlesBasicos()
        {
            ((ComboBoxItem)cmbEstado.Items[3]).IsEnabled = false;//combo de acciones
            switch (TipoDetalleCartera)
            {
                case EnumDetalleCartera.ConsultaCartera:
                    btn_Anular.IsEnabled = false;
                    btn_Modificar.IsEnabled = false;
                    btn_preparar.IsEnabled = false;
                    btn_Anticipar.IsEnabled = false;
                    Imprimir_Copy.Tag = "C";
                    _TipoUso = "Todas";
                    break;
                case EnumDetalleCartera.MantencionCartera:
                    btn_Anular.IsEnabled = true;
                    btn_Modificar.IsEnabled = true;
                    btn_preparar.IsEnabled = false;
                    btn_Anticipar.IsEnabled = false;
                    Imprimir_Copy.Tag = "C";
                    _TipoUso = "Preparar";
                    break;
                case EnumDetalleCartera.PrepararAccion:
                    btn_Anular.IsEnabled = false;
                    btn_Modificar.IsEnabled = false;
                    btn_preparar.IsEnabled = true;
                    btn_Anticipar.IsEnabled = false;
                    Imprimir_Copy.Tag = "C";
                    _TipoUso = "Todas";
                    break;
                case EnumDetalleCartera.AnticiparContratos:
                    btn_Anular.IsEnabled = false;
                    btn_Modificar.IsEnabled = false;
                    btn_preparar.IsEnabled = false;
                    btn_Anticipar.IsEnabled = true;
                    Imprimir_Copy.Tag = "C";
                    _TipoUso = "Anticipo";
                    break;
                case EnumDetalleCartera.FaxConfirmacion:
                    btn_Anular.IsEnabled = false;
                    btn_Modificar.IsEnabled = false;
                    btn_preparar.IsEnabled = false;
                    btn_Anticipar.IsEnabled = false;
                    Imprimir_Copy.Tag = "F";
                    _TipoUso = "NoCotizaciones";
                    break;
                case EnumDetalleCartera.EmisionContratosEmpresas:
                    btn_Anular.IsEnabled = false;
                    btn_Modificar.IsEnabled = false;
                    btn_preparar.IsEnabled = false;
                    btn_Anticipar.IsEnabled = false;
                    Imprimir_Copy.Tag = "E";
                    _TipoUso = "NoCotizaciones";
                    break;
                default:
                    break;
            }

            Habilitado = true;
            btn_filtro_cli.IsEnabled = true;
            dgPersona.IsEnabled = true;
        }

        private void SelectedOnlyForwardAmerican()
        {
            int _ContractFA = 0;
            int _ContractOT = 0;
            List<StructCaContrato> _List = new List<StructCaContrato>();

            if (ContraList != null)
            {
                if (ContraList.Count > 0)
                {
                    foreach (StructCaContrato _Contract in ContraList)
                    {
                        if (_Contract.VF == "True")
                        {
                            if ((_Contract.OpcEstCod.Equals("8")))
                            {
                                _ContractFA++;
                            }
                            else
                            {
                                _ContractOT++;
                            }
                        }
                    }
                }
            }

            if (!_ContractFA.Equals(0) && _ContractOT.Equals(0))
            {
                //ASVG_20110322 Id de Item por nombre en vez de posición.
                //((ComboBoxItem)cmbEstado.Items[3]).IsEnabled = true;
                ((ComboBoxItem)cmbEstado.FindName("E")).IsEnabled = true;
            }
            else
            {
                //ASVG_20110322 Solamente se puede "Ejercer" un Forward Americano.
                ((ComboBoxItem)cmbEstado.FindName("E")).IsEnabled = false;
            }
            if (cmbEstado.SelectedIndex == 3)
            {
                cmbEstado.SelectedIndex = 4;
            }
        }

        private void DeshabilitarControles()
        {
            btn_preparar.IsEnabled = false;
            btn_filtro_cli.IsEnabled = false;
            btn_Anular.IsEnabled = false;
            btn_Modificar.IsEnabled = false;
            btn_Anticipar.IsEnabled = false;

            Habilitado = false;
            dgPersona.IsEnabled = false;
        }

        private void CloseCompleted(object sender, DialogEventArgs e)
        {
            HabilitarControlesBasicos();
        }

        private void ShowFiltroEstructura(object sender, RoutedEventArgs e)
        {
            DeshabilitarControles();
            LoadEstructura();
           // _FiltroEstructura.Show();
        }

        private void btn_Filtro_Estructura(object sender, RoutedEventArgs e)
        {
            try
            {
                cmbFiltroEstructura.SelectionBoxItem.Equals("Forward Americano");
            }
            catch
            {
                System.Windows.Browser.HtmlPage.Window.Alert("Debe seleccionar tipo de estructura");
                return;
            }

            if (cmbFiltroEstructura.SelectionBoxItem.Equals("Forward Americano") )
            {
                switch (TipoDetalleCartera)
                {
                    case EnumDetalleCartera.ConsultaCartera:

                        this.btn_IngSDA.Visibility = Visibility.Visible;
                        break;
                }
            }
            else
            {
                this.btn_IngSDA.Visibility = Visibility.Collapsed;
            }

            FiltroEstructura = true;
            StartLoading();
            //REVISAR
            svc.CaEncContratoAsync(0, 0, 0, "1900-01-01", "2900-01-01", "1900-01- 01", "2900-01-01","");
            _FiltroEstructura.Close();
        }

        private void btn_Close_Filtro_Estructura(object sender, RoutedEventArgs e)
        {
            _FiltroEstructura.Close();
        }

        void LoadEstructura()
        {
            SrvLoadFront.LoadFrontSoapClient _SrvLoadEstructura = wsGlobales.LoadFront;// new AdminOpciones.SrvLoadFront.LoadFrontSoapClient();
            _SrvLoadEstructura.LoadFrontDataCompleted += new EventHandler<AdminOpciones.SrvLoadFront.LoadFrontDataCompletedEventArgs>(_SrvLoadEstructura_LoadEstructuraDataCompleted);
            _SrvLoadEstructura.LoadFrontDataAsync("");
        }

        private void _SrvLoadEstructura_LoadEstructuraDataCompleted(object sender, AdminOpciones.SrvLoadFront.LoadFrontDataCompletedEventArgs e)
        {
            string resultValue = e.Result.ToString();
            XDocument xdocLoadData = new XDocument(XDocument.Parse(resultValue));

            #region Estructuras

            try
            {
                //simplificar iterando directamente sobre el XML, sin pasar por la lista.
                var DataOpcionesEstructura = from itemDataLoad in xdocLoadData.Descendants("DataOpcionEstructura")
                                             select new StructCodigoDescripcion
                                             {
                                                 Codigo = itemDataLoad.Attribute("OpEstCod").Value.ToString(),
                                                 Descripcion = itemDataLoad.Attribute("OpEstDsc").Value.ToString()
                                             };

                OpcionesEstructuraList = new List<StructCodigoDescripcion>(DataOpcionesEstructura.ToList<StructCodigoDescripcion>());

                foreach (StructCodigoDescripcion optionItem in OpcionesEstructuraList)
                {
                    ComboBoxItem cbItem = new ComboBoxItem();
                    cbItem.Name = optionItem.Descripcion.ToString();
                    cbItem.Content = optionItem.Descripcion.ToString();
                    cbItem.Tag = optionItem.Codigo.ToString();

                    this.cmbFiltroEstructura.Items.Add(cbItem);
                }

            }
            catch { }
             StopLoading();
            _FiltroEstructura.Show();
            #endregion

        }

        //Prd_13090
        private void Even_tbtn_IngSDA_Click(object sender, RoutedEventArgs e)
        {
           
            List<StructCaContrato> _ListImp = PreparaImpresion();
         
            if (_ListImp.Count == 1)
            {
                _IngSolicitudSDA.TxtNumContrato.Text = _ListImp[0].NumContrato;
              
                svc.ConsultaOperacionAsync(_ListImp[0].NumContrato);
              
            }
            else
            {
                System.Windows.Browser.HtmlPage.Window.Alert("Debe seleccionar una operación");
                return;
            }
                                       
            _IngSolicitudSDA.TxtNumFolio.Visibility = Visibility.Collapsed;
            _IngSolicitudSDA.TblockNumFolio.Visibility = Visibility.Collapsed;
            _IngSolicitudSDA.BtnModificar.IsEnabled = false;          
            _IngSolicitudSDA.TxtNominal.IsEnabled = false;
            _IngSolicitudSDA.TxtSumaSolicitud.IsEnabled = false;
            _IngSolicitudSDA.DtFechaVencimiento.IsEnabled = false;
            _IngSolicitudSDA.DtFechaActivacion.Text = Convert.ToDateTime(globales._FechaProceso).ToString("dd/MM/yyyy");

            _IngSolicitudSDA.DtFechaIngreso.Text = Convert.ToDateTime(globales._FechaProceso).ToString("dd/MM/yyyy");

           
        }
       
        private void popUpEjercerFuturo_SizeChanged(object sender, SizeChangedEventArgs e)
        {

        }
      
        void _IngSolicitudSDA_MaskCollapsed()
        {
            dgPersona.IsEnabled = true;
            popUpIngSolicitudSDA.Close();
                    
        }

        private void _IngSolicitudSDA_SetData()
        {
           
        }

        private void popUpIngSolicitudSDA_Opened(object sender, DialogEventArgs e)
        {
            _IngSolicitudSDA.LoadFrontData();
        }

        private void CloseCompletedSDA(object sender, DialogEventArgs e)
        {
            dgPersona.IsEnabled = true;
        }

        private void dgPersona_LostFocus(object sender, RoutedEventArgs e)
        {
           

        }

        private void svc_ConsultaOperacionCompleted(object sender, AdminOpciones.SrvDetalles.ConsultaOperacionCompletedEventArgs e)
        {
            try
            {
                #region Validacion Cantera

                string _xmlResult = e.Result.ToString();
                string NumContrato = "";
                string NumFolio = "";
                string Nominal = "";
                string FechaVencOP = "";
                string CodEstructura = "";
                string TotalSolicitud = "";
                
                XDocument xmlResult = new XDocument();
                xmlResult = XDocument.Parse(_xmlResult);

                IEnumerable<XElement> elements = xmlResult.Element("Result").Elements("Status").Elements("Item");
                foreach (XElement element in elements)
                {
                    NumContrato = element.Attribute("CaNumContrato").Value.ToString() == "" ? "0" : element.Attribute("CaNumContrato").Value.ToString();
                    NumFolio = element.Attribute("CaNumFolio").Value.ToString();
                    Nominal = element.Attribute("CaMontoMon1").Value.ToString();
                    FechaVencOP = element.Attribute("CaFechaVcto").Value.ToString();
                    CodEstructura = element.Attribute("CaCodEstructura").Value.ToString();
                    TotalSolicitud = element.Attribute("Total_Solicitud").Value.ToString();
                   
                }

                if (_IngSolicitudSDA.TxtNumContrato.Text == NumContrato)
                {
                    _IngSolicitudSDA.TxtNominal.Text = Nominal;
                    _IngSolicitudSDA.TxtSumaSolicitud.Text = TotalSolicitud;
                    _IngSolicitudSDA.DtFechaVencimiento.Text = Convert.ToDateTime(FechaVencOP).ToString("dd/MM/yyyy");

                }
                else
                {
                    System.Windows.Browser.HtmlPage.Window.Alert("Operación no esta Vigente en cartera");
                    return;

                }
                  
                    popUpIngSolicitudSDA.Show();
                    dgPersona.IsEnabled = false;

               
                #endregion

            }
            catch
            {
                System.Windows.Browser.HtmlPage.Window.Alert("Error al Consultar Operación");
                return;
            }
        }

        public class _Modalidad
        {
            private string _Descripcion;
            /// <summary>
            /// Descripcion Modalidad
            /// </summary>
            public string Descripcion
            {
                get { return _Descripcion; }
                set { _Descripcion = value; }
            }

            private string _Identificador;
            /// <summary>
            /// Identificador Modalidad
            /// </summary>
            public string Identidicador
            {
                get { return _Identificador; }
                set { _Identificador = value; }
            }

            public _Modalidad(string Descripcion, string Identidicador)
            {
                this.Descripcion = Descripcion;
                this.Identidicador = Identidicador;
            }
        }//class _Modalidad

    }
}