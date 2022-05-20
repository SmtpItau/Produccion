using System;
using System.Collections.Generic;
using System.Linq;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Input;
using System.Windows.Browser;
using AdminOpciones.Struct;
using AdminOpciones.Recursos;
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
using AdminOpciones.Struct.Generic;
using AdminOpciones.SrvAcciones;

namespace AdminOpciones.Controls
{
    public partial class PagosCompensados : UserControl
    {
        AdminOpciones.SrvAcciones.WebAccionesSoapClient sva = wsGlobales.Acciones;
        AdminOpciones.SrvDetalles.WebDetallesSoapClient svc = wsGlobales.Detalles;

        private List<StructPagosCompensados> ListLiquidacion = new List<StructPagosCompensados>();
        private List<StructPagosCompensados> ListLiquidacionPrima = new List<StructPagosCompensados>();
        private List<StructPagosCompensados> ListLiquidacionForwardAmericano = new List<StructPagosCompensados>();
        private List<StructPagosCompensados> ListLiquidacionForward = new List<StructPagosCompensados>();//Papeleta Asiaticos

        private List<StructPagosCompensados> _ContraList;
        private ObservableCollection<StructPagosCompensados> ContraList;
        private ObservableCollection<StructPagosCompensados> PContraList;
        private List<StructCodigoDescripcion> FormaPagoList;
        XDocument xmlContratos = new XDocument();
        XDocument xmlResult = new XDocument();
        public string XmlResultContra;
        bool _Estado, _Estado2 = false;
        private StructPagosCompensados _Item;
        private bool _Selected;
        private bool Habilitado = true;

        public PagosCompensados()
        {
            _Selected = true;
            InitializeComponent();
            svc.CaPagosCompCompleted += new EventHandler<AdminOpciones.SrvDetalles.CaPagosCompCompletedEventArgs>(svc_CaPagosCompCompleted);
            this.dgPersona.MouseLeftButtonUp += new MouseButtonEventHandler(dgPersona_SelectionChanged);
            svc.LoadFormaPagoCompleted += new EventHandler<AdminOpciones.SrvDetalles.LoadFormaPagoCompletedEventArgs>(svc_LoadFormaPagoCompleted);
            sva.ActualizaFormaPagoCompensacionCompleted += new EventHandler<AdminOpciones.SrvAcciones.ActualizaFormaPagoCompensacionCompletedEventArgs>(sva_ActualizaFormaPagoCompensacionCompleted);
            //this.dgPersona.LoadingRow += new EventHandler<DataGridRowEventArgs>(dgPersona_LoadingRow);

            List<string> _carga = new List<string>();
            _carga.Add("");
            _carga.Add("Normal");
            _carga.Add("Interna");
            Listar_Detalle_Liquidacion();

            // 29 Septiembre Transcribo correcion D. Matamala 
            _PopCompensacion.Show();     
            _PopCompensacion.Visibility = Visibility.Collapsed;
        }

        public class _Resultados
        {
            public string Folio { get; set; }
            public string Result { get; set; }
        }

        public void Consult(bool consult)
        {
            dgPersona.Columns[1].Visibility = consult ? Visibility.Collapsed : Visibility.Visible;
            dgPersona.FrozenColumnCount = consult ? 3 : 4;
        }

        void sva_ActualizaMoEncCompleted(object sender, AdminOpciones.SrvAcciones.ActualizaMoEncCompletedEventArgs e)
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

        void svc_CaPagosCompCompleted(object sender, AdminOpciones.SrvDetalles.CaPagosCompCompletedEventArgs e)
        {
            XmlResultContra = e.Result;
            if (XmlResultContra.Length > 0)
            {
                ContratoOPT(XmlResultContra);
                if (ContraList != null)
                {
                    if (ContraList.Count > 0)
                    {
                        //dgPersona.Focus();
                        dgPersona.ItemsSource = ContraList;
                    }
                    else
                    {
                        // MAP 04 Septiembre 2009 Limpiar la grilla si no hay nada
                        AddVacio();
                    }
                }
                else
                {
                    // MAP 04 Septiembre 2009 Limpiar la grilla si no hay nada
                    AddVacio();
                }
            }
            _Selected = true;
        }

        private void AddVacio()
        {
            ContraList = new ObservableCollection<StructPagosCompensados>();
            StructPagosCompensados Vacio = new StructPagosCompensados();
            ContraList.Add(Vacio);
            dgPersona.ItemsSource = ContraList;
        }

        private void svc_LoadFormaPagoCompleted(object sender, AdminOpciones.SrvDetalles.LoadFormaPagoCompletedEventArgs e)
        {
            if (e.Error == null)
            {
                XDocument xdocLoadData = new XDocument(XDocument.Parse(e.Result));
                var DataFormaDePago = from itemDataLoad in xdocLoadData.Descendants("Item")
                                      select new StructCodigoDescripcion
                                      {
                                          Codigo = itemDataLoad.Attribute("Codigo").Value.ToString(),
                                          Descripcion = itemDataLoad.Attribute("Descripcion").Value.ToString(),
                                          Valor = double.Parse(itemDataLoad.Attribute("Valuta").Value.ToString())
                                      };
                if (xdocLoadData.Element("FormasPago").Attribute("CierreMesa").Value.Equals("0"))
                {
                    DeshabilitarControles();
                    FormaPagoList = new List<StructCodigoDescripcion>(DataFormaDePago.ToList());
                    _FormaPago.ItemsSource = null; // 29 Septiembre transcripcion de D. MATAMALA en netbook
                    _FormaPago.UpdateLayout();     // 29 Septiembre transcripcion de D. MATAMALA en netbook

                    _FormaPago.ItemsSource = FormaPagoList;

                    _FormaPago.UpdateLayout();     // 29 Septiembre transcripcion de D. MATAMALA en netbook 

                    _Contrato.Text = _Item.NumContrato.ToString();
                    _Estructura.Text = _Item.NumEstructura.ToString();

                    List<StructCodigoDescripcion> _SelectedFP = FormaPagoList.Where(_Element => _Element.Codigo.Equals(_Item.FormaPagoCompCod)).ToList();

                    if (_SelectedFP.Count() > 0)
                    {
                        _FormaPago.SelectedItem = _SelectedFP[0];
                    }
                    _PopCompensacion.Visibility = Visibility.Visible; // 29 Septiembre transcripcion de D. MATAMALA en netbook
                    // _PopCompensacion.Show();   // 29 Septiembre comentado por D: Matamala en netbook
                }
                else
                {
                    System.Windows.Browser.HtmlPage.Window.Alert("No se puede actualizar las formas de pago debido a que la mesa se encuentra cerrada.");
                }
            }
        }

        void ContratoOPT(string strXMLContra)
        {
            xmlContratos = XDocument.Parse(strXMLContra);
            if (xmlContratos.Element("RetornaPagos").Attribute("Error").Value.Equals("0"))
            {
                var CaPagos = from ContraOPTXML in xmlContratos.Descendants("Data")
                              select new StructPagosCompensados
                              {
                                  VF = ContraOPTXML.Attribute("VF").Value.ToString(),
                                  NumContrato = ContraOPTXML.Attribute("NumContrato").Value.ToString(),
                                  NumEstructura = ContraOPTXML.Attribute("NumEstructura").Value.ToString(),
                                  FechaEjercicio = ContraOPTXML.Attribute("FechaEjercicio").Value.ToString(),
                                  FechaContrato = ContraOPTXML.Attribute("FechaContrato").Value.ToString(),
                                  CliRut = ContraOPTXML.Attribute("CliRut").Value.ToString(),
                                  CliDv = ContraOPTXML.Attribute("CliDv").Value.ToString(),
                                  CliCod = ContraOPTXML.Attribute("CliCod").Value.ToString(),
                                  CliNom = ContraOPTXML.Attribute("CliNom").Value.ToString(),
                                  MdaCompDsc = ContraOPTXML.Attribute("MdaCompDsc").Value.ToString(),
                                  FormaPagoCompCod = ContraOPTXML.Attribute("FormaPagoCompCod").Value,
                                  FormaPagoCompDsc = ContraOPTXML.Attribute("FormaPagoCompDsc").Value.ToString(),
                                  MontoRecibir = ContraOPTXML.Attribute("MontoRecibir").Value.ToString(),
                                  MontoPagar = ContraOPTXML.Attribute("MontoPagar").Value.ToString(),
                                  OrigenCod = ContraOPTXML.Attribute("OrigenCod").Value,
                                  OrigenDsc = ContraOPTXML.Attribute("OrigenDsc").Value.ToString(),
                                  Temporalidad = ContraOPTXML.Attribute("Temporalidad").Value.ToString(),
                                  // MAP 04 Septiembre 2009 Agrega Campo 
                                  VctoValuta   = ContraOPTXML.Attribute("VctoValuta").Value.ToString(),
                                  // ASVG_20110322 Para diferenciar reportes de vencimiento/pagos compensados.
                                  CodEstructura = ContraOPTXML.Attribute("CodEstructura").Value.ToString(),
                                  TipoTransaccion = ContraOPTXML.Attribute("TipoTransaccion").Value.ToString(), //PRD_12567 Papeleta Asiaticos
                                  TipoPayOff = ContraOPTXML.Attribute("TipoPayOff").Value.ToString(), //PRD_12567 Papeleta Asiaticos
                                  TipoBfwOpt = ContraOPTXML.Attribute("TipoBfwOpt").Value.ToString() //PRD_12567 Papeleta Asiaticos
                              };

                //ContraList = new List<StructMoContrato>(MoContratos.ToList<StructMoContrato>());            
                ContraList = new ObservableCollection<StructPagosCompensados>();
                PContraList = new ObservableCollection<StructPagosCompensados>();
                _ContraList = new List<StructPagosCompensados>(CaPagos.ToList<StructPagosCompensados>());
                int _ID = 0;
                foreach (StructPagosCompensados _Aux in _ContraList)
                {
                    // 04 Septiembre 2009 Activacion de filtro
                    if (_Aux.Temporalidad == Cmb_Estado.SelectionBoxItem.ToString())
                    {
                        _ID++;
                        _Aux.ID = _ID;
                        ContraList.Add(_Aux);
                        PContraList.Add(_Aux);
                    }
                }
            }
            else
            {
                System.Windows.Browser.HtmlPage.Window.Alert(xmlContratos.Element("RetornaPagos").Attribute("Message").Value);
            }
        }

        void Listar_Detalle_Liquidacion()
        {
            DateTime RestaDia = new DateTime();
            RestaDia = Convert.ToDateTime(globales._FechaProceso).AddDays(-1);
            string tag = "";
            string _fDesde = "";
            string _fHasta = "";
            string _cmbEstado = "";

            if (Dt_FechaDesde.Text == "" && Dt_FechaDesde.Text == "" && Cmb_Estado.SelectionBoxItem == null)
            {
                _fDesde = Convert.ToDateTime(Convert.ToString(RestaDia)).ToString("yyyyMMdd");
                _fHasta = Convert.ToDateTime(Convert.ToString(globales._FechaProceso)).ToString("yyyyMMdd");
                _cmbEstado = "Vigente";
            }
            else
            {
                _fDesde = Convert.ToDateTime(Convert.ToString(Dt_FechaDesde)).ToString("yyyyMMdd");
                _fHasta = Convert.ToDateTime(Convert.ToString(Dt_FechaHasta)).ToString("yyyyMMdd");
                _cmbEstado = Cmb_Estado.SelectionBoxItem.ToString();
            }

            if (_cmbEstado == "Vigente")
            {
                tag = "V";
            }

            else
            {
                tag = "H";
            }
            _Selected = false;
            svc.CaPagosCompAsync(int.Parse(txtCliRut.Text), int.Parse(txtCliCod.Text), _fDesde, _fHasta);

        }

        private void dgPersona_SelectionChanged(object sender, MouseEventArgs e)
        {
            if (_Selected)
            {
                if (((DataGrid)sender).CurrentColumn.DisplayIndex.Equals(0))
                {

                    if (dgPersona.SelectedIndex >= 0)
                    {
                        StructPagosCompensados _CaContrato = new StructPagosCompensados();
                        CheckBox _chkControl;
                        _CaContrato = (StructPagosCompensados)dgPersona.SelectedItem;
                        _chkControl = (CheckBox)dgPersona.Columns[0].GetCellContent(dgPersona.SelectedItem);
                        if (_chkControl != null)
                        {
                            _chkControl.IsChecked = !_chkControl.IsChecked;
                        }
                    }
                }
            }
        }

        private void Buscar_Click(object sender, RoutedEventArgs e)
        {
            Listar_Detalle_Liquidacion();
        }

        private void selTodo_Click(object sender, System.Windows.Input.MouseButtonEventArgs e)
        {
            if (Habilitado)
            {
                int _Row;
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
                dgPersona.ItemsSource = null;
                dgPersona.ItemsSource = ContraList;
            }
        }

        #region "Reportes"
        /*----------------------------------REPORTES v1.0 by Edo-------------------------------------------*/

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

        private void Imprimir_Click(object sender, System.Windows.Input.MouseButtonEventArgs e)
        {
            //ASVG_20131025 La implementación de reportería requiere una re-ingeniería.
            if (Habilitado)
            {
                ListLiquidacion = new List<StructPagosCompensados>();
                //ListLiquidacion = ContraList.Where(_Element => _Element.OrigenDsc != "Pago Prima" && _Element.VF.ToUpper().Equals("TRUE") && !_Element.CodEstructura.Equals("8") && !_Element.CodEstructura.Equals("13")).ToList(); //Papeleta Asiaticos
                ListLiquidacion = ContraList.Where(_Element => _Element.OrigenDsc != "Pago Prima" && _Element.VF.ToUpper().Equals("TRUE") && _Element.TipoBfwOpt.Equals("OPT") ).ToList(); //Papeleta Asiaticos
                PrepararImpresion(ListLiquidacion, "1");

                //PRD_12567 Forward Asiático Entrada Salida Papeleta Asiaticos
                ListLiquidacionForward = new List<StructPagosCompensados>();
                //ListLiquidacionForward = ContraList.Where(_Element => _Element.OrigenDsc != "Pago Prima" && _Element.VF.ToUpper().Equals("TRUE") && _Element.CodEstructura.Equals("13")).ToList();
                //ListLiquidacionForward = ContraList.Where(_Element => _Element.OrigenDsc != "Pago Prima" && _Element.VF.Equals("True") && _Element.TipoTransaccion.Equals("ANTICIPA") && _Element.TipoPayOff.Equals("02")).ToList();
                ListLiquidacionForward = ContraList.Where(_Element => _Element.OrigenDsc != "Pago Prima" && _Element.VF.Equals("True") && _Element.TipoBfwOpt.Equals("BFW") && !_Element.CodEstructura.Equals("8")).ToList();
                PrepararImpresion(ListLiquidacionForward, "4");

                ListLiquidacionForwardAmericano = new List<StructPagosCompensados>();
                ListLiquidacionForwardAmericano = ContraList.Where(_Element => _Element.OrigenDsc != "Pago Prima" && _Element.VF.ToUpper().Equals("TRUE") && _Element.CodEstructura.Equals("8")).ToList();
                PrepararImpresion(ListLiquidacionForwardAmericano, "3"); //ASVG_20110323 no se usa el 8 para no confundir conceptos.
                
                ListLiquidacionPrima = new List<StructPagosCompensados>();
                ListLiquidacionPrima = ContraList.Where(_Element => _Element.OrigenDsc == "Pago Prima" && _Element.VF.ToUpper().Equals("TRUE")).ToList();
                PrepararImpresion(ListLiquidacionPrima, "2");
            }
        }

        private void PrepararImpresion(List<StructPagosCompensados> listImp, string reportcode)
        {
            if (listImp.Count > 0)
            {
                #region Definicion de Variables

                string _Xml = "<?xml version=\"1.0\" encoding=\"utf-8\"?>";

                #endregion

                #region Generación de Formato XML

                _Xml += string.Format("<Options User='{0}' ReportCode='{1}' >", globales._Usuario, reportcode);
                foreach (StructPagosCompensados _Values in listImp)
                {
                    _Xml += string.Format(
                                           "<Option Contrato='{0}' Folio='{1}' />",
                                           _Values.NumContrato,
                                           0
                                         );
                    _Values.VF = "False";
                }
                _Xml += "</Options>";

                #endregion

                #region Ejecución del WebService
                AdminOpciones.SrvAcciones.WebAccionesSoapClient _SrvAcciones = wsGlobales.Acciones;
                _SrvAcciones.InsertImpresionCompleted += new EventHandler<InsertImpresionCompletedEventArgs>(InsertImpresionCompleted);
                _SrvAcciones.InsertImpresionAsync(_Xml);
                #endregion
            }

        }

        private void InsertImpresionCompleted(object sender, AdminOpciones.SrvAcciones.InsertImpresionCompletedEventArgs e)
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

                if (ContraList.Count > 0)
                {
                    //dgPersona.Focus();
                    dgPersona.ItemsSource = ContraList;
                }

            }
        }

        private void ImprimirDocumento(int id, string reportCode)
        {
            string _Usuario = globales._Usuario;
            string system = System.Threading.Thread.CurrentThread.CurrentCulture.ToString();

            List<KeyValuePair<string, string>> lst_ = new List<KeyValuePair<string, string>>();

            lst_.Add(new KeyValuePair<string, string>("NumGrupo", id.ToString()));

            /*
             * ASVG_20110322 Mezcla de conceptos...
             * 1 => no es pago compensado por prima
             * 2 => si es pago compensado de prima
             * 3 => es forward americano (y por ende, no es pago de prima)
             */
            if (reportCode.Equals("1")) // -- MAP --ASVG 1 => distinto de prima ;(
            {
                lst_.Add(new KeyValuePair<string, string>("RepName", "~/CrystalReportes/LIQUIDACION_OPCIONES.rpt"));
                lst_.Add(new KeyValuePair<string, string>("Tipo", "Liquidacion"));
            }
            else if (reportCode.Equals("4")) //Papeleta Asiaticos
            {
                lst_.Add(new KeyValuePair<string, string>("RepName", "~/CrystalReportes/LIQUIDACION_FORWARD.rpt"));
                lst_.Add(new KeyValuePair<string, string>("Tipo", "Liquidacion"));
            }
            else if (reportCode.Equals("3"))
            {
                lst_.Add(new KeyValuePair<string, string>("RepName", "~/CrystalReportes/Papeleta_Ejercicio.rpt"));
                lst_.Add(new KeyValuePair<string, string>("Tipo", "Liquidacion"));
            }
            else
            {
                lst_.Add(new KeyValuePair<string, string>("RepName", "~/CrystalReportes/LIQUIDACION_PRIMA.rpt"));
                lst_.Add(new KeyValuePair<string, string>("Tipo", "LiquidacionPrima"));
            }

            DateTime _Desde = DateTime.Parse(Dt_FechaDesde.Text);
            DateTime _Hasta = DateTime.Parse(Dt_FechaHasta.Text);

            lst_.Add(new KeyValuePair<string, string>("FechaDesde", _Desde.ToString("yyyyMMdd")));
            lst_.Add(new KeyValuePair<string, string>("FechaHasta", _Hasta.ToString("yyyyMMdd")));

            lst_.Add(new KeyValuePair<string, string>("Usuario", _Usuario));
            this.ProcessCommand(lst_.ToArray());

            if (reportCode.Equals("1"))
            {
                Actualiza(ListLiquidacion);
            }
            else if (reportCode.Equals("3"))
            {
                Actualiza(ListLiquidacionForwardAmericano);
            }
            else
            {
                Actualiza(ListLiquidacionPrima);
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

        private List<StructPagosCompensados> PreparaImpresion()
        {
            List<StructPagosCompensados> _List = new List<StructPagosCompensados>();
            if (ContraList.Count > 0)
            {
                foreach (StructPagosCompensados _Aux in ContraList)
                {
                    if (_Aux.VF == "True")
                    {
                        _List.Add(_Aux);
                    }
                }
            }
            return _List;
        }

        private void Actualiza(List<StructPagosCompensados> _List)
        {
            List<string> _valor = new List<string>();

            if (_List.Count > 0)
            {
                foreach (StructPagosCompensados _values in _List)
                {
                    if (_values.sNumContrato != "")   // MAP 04 Septiembre Control Filtros
                    {
                        _valor.Add(_values.NumContrato.ToString());
                    }
                }
                if (_valor.Count() > 0)               // MAP 04 Septiembre Control Filtros
                { sva.ActualizaMoEncAsync(_valor.ToArray()); }  // MAP 04 Septiembre Control Filtros   
            }
        }

        #endregion

        private void ExpExcel_MouseLeftButtonUp(object sender, MouseButtonEventArgs e)
        {
            if (Habilitado)
            {
                string _ID = txtCliCod.Text;
                int _i = 0;
                string _TC = "";

                if (_i > -1)
                {
                    _TC = "";
                }
                else
                {
                    _TC = "Nulo";
                }

                if (_ID == "")
                {
                    _ID = "Nulo";
                }
                _Exporta _ExportaExcel = new _Exporta { _TipoServ = "CaLiquidacion", _CR = _ID, _CT = _TC };
                HtmlPage.Window.Invoke("ExportaExcel", new string[] { _ExportaExcel.ToString() });
            }
        }

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
                    if (_TextColumn != "" && _TextColumn != "ID" )  // MAP 04 Septiembre al revisar copia a Excel
                    {
                        _TextColumn += "\t";
                    }
                    _TextColumn += _Column.Header;
                }
                textData += _TextColumn + "\n";

                #endregion

                #region Value

                foreach (StructPagosCompensados _Item in DataGridRRFLY.ItemsSource)
                {
                    // MAP 04 Septiembre 2009 Se agrega columna
                    textData += string.Format(
                                               // MAP "{0}\t{1}\t{2}\t{3}\t{4}\t{5}\t{6}\t{7}\t{8}\t{9}\t{10}\t{11}\t{12}\t{13}\n",
                                               "{0}\t{1}\t{2}\t{3}\t{4}\t{5}\t{6}\t{7}\t{8}\t{9}\t{10}\t{11}\t{12}\t{13}\t{14}\n",

                                               _Item.NumContrato.ToString(),
                                               _Item.NumEstructura.ToString(),
                                               DateTime.Parse(_Item.FechaEjercicio).ToString("dd/MM/yyyy"),
                                               DateTime.Parse(_Item.FechaContrato).ToString("dd/MM/yyyy"),
                                               _Item.CliRut.ToString(),
                                               _Item.CliDv.ToString(),
                                               _Item.CliCod.ToString(),
                                               _Item.CliNom.ToString(),
                                               _Item.MdaCompDsc.ToString(),
                                               _Item.FormaPagoCompDsc.ToString(),
                                               _Item.MontoRecibir.ToString(),
                                               _Item.MontoPagar.ToString(),
                                               _Item.OrigenDsc,
                                               _Item.Temporalidad,
                                               DateTime.Parse( _Item.VctoValuta ).ToString("dd/MM/yyyy")   // MAP
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

        private void buttonID_Click(object sender, RoutedEventArgs e)
        {
            try
            {
                int _ID = (int)(((Button)sender).Tag) - 1;
                if (_ID >= 0)
                {
                    _Item = ContraList[_ID];
                    svc.LoadFormaPagoAsync(_Item.MdaCompDsc, globales._FechaProceso);
                }
            }
            catch
            {
            }
        }

        private void btnAceptar_Click(object sender, RoutedEventArgs e)
        {
            if (_FormaPago.SelectedItem != null)
            {
                StructCodigoDescripcion _FPago = (StructCodigoDescripcion)_FormaPago.SelectedItem;
                sva.ActualizaFormaPagoCompensacionAsync(
                                                         long.Parse(_Item.NumContrato),
                                                         long.Parse(_Item.NumEstructura),
                                                         _Item.OrigenCod,
                                                         int.Parse(_FPago.Codigo)
                                                       );
            }
        }

        private void btnCancelar_Click(object sender, RoutedEventArgs e)
        {
            HabilitarControles();
            _PopCompensacion.Visibility = Visibility.Collapsed;  // 29 Septiembre Transfiriendo cambio DMATAMALA Netbook
            // _PopCompensacion.Close();    // 29 Septiembre Transfiriendo cambio DMATAMALA Netbook
            dgPersona.Focus();
        }

        private void sva_ActualizaFormaPagoCompensacionCompleted(object sender, AdminOpciones.SrvAcciones.ActualizaFormaPagoCompensacionCompletedEventArgs e)
        {
            HabilitarControles();
            Listar_Detalle_Liquidacion();
            _PopCompensacion.Visibility = Visibility.Collapsed; // 29 Septiembre Transfiriendo cambio DMATAMALA Netbook
            // _PopCompensacion.Close(); // 29 Septiembre Transfiriendo cambio DMATAMALA Netbook
            dgPersona.Focus();
        }

        private void btnAceptar_MouseEnter(object sender, MouseEventArgs e)
        {
            dgPersona.Focus();
        }

        private void CloseCompleted(object sender, DialogEventArgs e)
        {
            HabilitarControles();
        }

        private void HabilitarControles()
        {
            Habilitado = true;

            txtCliRut.IsEnabled = true;
            Dt_FechaDesde.IsEnabled = true;
            Dt_FechaHasta.IsEnabled = true;
            Cmb_Estado.IsEnabled = true;
            dgPersona.IsEnabled = true;
            btn_cargar.IsEnabled = true;
        }

        private void DeshabilitarControles()
        {
            Habilitado = false;

            txtCliRut.IsEnabled = false;
            Dt_FechaDesde.IsEnabled = false;
            Dt_FechaHasta.IsEnabled = false;
            Cmb_Estado.IsEnabled = false;
            dgPersona.IsEnabled = false;
            btn_cargar.IsEnabled = false;
        }

    }
}

