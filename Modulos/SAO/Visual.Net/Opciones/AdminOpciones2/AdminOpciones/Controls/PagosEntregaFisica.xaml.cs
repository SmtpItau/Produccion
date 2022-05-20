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

    public partial class PagosEntregaFisica : UserControl
    {

        #region Variables

        AdminOpciones.SrvAcciones.WebAccionesSoapClient sva = wsGlobales.Acciones;
        AdminOpciones.SrvDetalles.WebDetallesSoapClient svc = wsGlobales.Detalles;

        private List<StructPagosFisica> ListLiquidacion = new List<StructPagosFisica>();
        private List<StructPagosFisica> ListLiquidacionEjercicio = new List<StructPagosFisica>();
        private List<StructPagosFisica> ListLiquidacionForward = new List<StructPagosFisica>();//Papeleta Asiaticos


        private List<StructPagosFisica> _ContraList;
        private ObservableCollection<StructPagosFisica> ContraList;
        private ObservableCollection<StructPagosFisica> PContraList;
        XDocument xmlContratos = new XDocument();
        XDocument xmlResult = new XDocument();
        public string XmlResultContra;
        bool _Estado, _Estado2 = false;
        bool _FlagFormaPagoRecibir = false;
        bool _FlagFormaPagoPagar = false;
        private List<StructCodigoDescripcion> FormaPagoRecibirList;
        private List<StructCodigoDescripcion> FormaPagoPagarList;
        private StructPagosFisica _Item;
        private bool _Selected;
        private bool Habilitado = true;
        private bool CierreMesa = false;

        #endregion

        public PagosEntregaFisica()
        {
            InitializeComponent();
            svc.CaPagosEntregaCompleted += new EventHandler<AdminOpciones.SrvDetalles.CaPagosEntregaCompletedEventArgs>(svc_CaPagosEntregaCompleted);
            this.dgPersona.MouseLeftButtonUp += new MouseButtonEventHandler(dgPersona_SelectionChanged);
            svc.LoadFormaPagoCompleted += new EventHandler<AdminOpciones.SrvDetalles.LoadFormaPagoCompletedEventArgs>(svc_LoadFormaPagoCompleted);
            sva.ActualizaFormaPagoEntregaFisicaCompleted += new EventHandler<AdminOpciones.SrvAcciones.ActualizaFormaPagoEntregaFisicaCompletedEventArgs>(sva_ActualizaFormaPagoEntregaFisicaCompleted);
            _Selected = true;

            List<string> _carga = new List<string>();
            _carga.Add("");
            _carga.Add("Normal");
            _carga.Add("Interna");
            Listar_Entregas_Fisicas();

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

        void svc_LoadFormaPagoCompleted(object sender, AdminOpciones.SrvDetalles.LoadFormaPagoCompletedEventArgs e)
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

                _Contrato.Text = _Item.NumContrato.ToString();
                _Estructura.Text = _Item.NumEstructura.ToString();
                CierreMesa = xdocLoadData.Element("FormasPago").Attribute("CierreMesa").Value.Equals("1");
                if (_Item.MdaRecibirDsc.Equals(xdocLoadData.Element("FormasPago").Attribute("Moneda").Value))
                {
                    FormaPagoRecibirList = new List<StructCodigoDescripcion>(DataFormaDePago.ToList());
                    _FormaPagoRecibir.ItemsSource = FormaPagoRecibirList;
                    List<StructCodigoDescripcion> _Selected = FormaPagoRecibirList.Where(_Element => _Element.Codigo.Equals(_Item.FormaPagorecibirCod)).ToList();

                    if (_Selected.Count() > 0)
                    {
                        _FormaPagoRecibir.SelectedItem = _Selected[0];
                    }
                    _FlagFormaPagoRecibir = true;
                }
                else
                {
                    FormaPagoPagarList = new List<StructCodigoDescripcion>(DataFormaDePago.ToList());
                    _FormaPagoPagar.ItemsSource = FormaPagoPagarList;
                    List<StructCodigoDescripcion> _Selected = FormaPagoPagarList.Where(_Element => _Element.Codigo.Equals(_Item.FormaPagoPagarCod)).ToList();

                    if (_Selected.Count() > 0)
                    {
                        _FormaPagoPagar.SelectedItem = _Selected[0];
                    }
                    _FlagFormaPagoPagar = true;
                }
            }

            if (_FlagFormaPagoRecibir && _FlagFormaPagoPagar)
            {
                if (CierreMesa)
                {
                    System.Windows.Browser.HtmlPage.Window.Alert("No se puede actualizar las formas de pago debido a que la mesa se encuentra cerrada.");
                }
                else
                {
                    DeshabilitarControles();
                    _PopEntregaFisica.Show();
                }
            }

        }

        void sva_ActualizaFormaPagoEntregaFisicaCompleted(object sender, AdminOpciones.SrvAcciones.ActualizaFormaPagoEntregaFisicaCompletedEventArgs e)
        {
            HabilitarControles();
            Listar_Entregas_Fisicas();
            // _PopEntregaFisica.Close();  // MAP 27 Octubre 2009 Se traspasa Cambio realizado x DMatamala en Compensaciones
            _PopEntregaFisica.Visibility = Visibility.Collapsed; // MAP 27 Octubre 2009 
            dgPersona.Focus();            // MAP 27 Octubre 2009  Se traspasa cambio que DMatamala hizo para Compensacion 

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

        void svc_CaPagosEntregaCompleted(object sender, AdminOpciones.SrvDetalles.CaPagosEntregaCompletedEventArgs e)
        {
            XmlResultContra = e.Result;
            if (XmlResultContra.Length > 0)
            {
                ContratoOPT(XmlResultContra);
                if (ContraList.Count > 0)
                {
                    dgPersona.ItemsSource = ContraList;
                }
                else
                {   // MAP 04 Septiembre 2009 Limpiar la grilla si no hay nada
                    StructPagosFisica Vacio = new StructPagosFisica();
                    ContraList.Add(Vacio);
                    dgPersona.ItemsSource = ContraList;
                }
            }
            else
            {
                // MAP 04 Septiembre 2009 Limpiar la grilla si no hay nada
                StructPagosFisica Vacio = new StructPagosFisica();
                ContraList.Add(Vacio);
                dgPersona.ItemsSource = ContraList;
            
            }
            _Selected = true;
        }

        void ContratoOPT(string strXMLContra)
        {
            xmlContratos = XDocument.Parse(strXMLContra);
            var CaPagos = from ContraOPTXML in xmlContratos.Descendants("Data")
                          select new StructPagosFisica
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
                              MdaRecibirDsc = ContraOPTXML.Attribute("MdaRecibirDsc").Value.ToString(),
                              FormaPagorecibirCod = ContraOPTXML.Attribute("FormaPagoRecibirCod").Value.ToString(),
                              FormaPagorecibirDsc = ContraOPTXML.Attribute("FormaPagorecibirDsc").Value.ToString(),
                              MontoRecibir = ContraOPTXML.Attribute("MontoRecibir").Value.ToString(),
                              MdaPagarDsc = ContraOPTXML.Attribute("MdaPagarDsc").Value.ToString(),
                              FormaPagoPagarCod = ContraOPTXML.Attribute("FormaPagoPagarCod").Value.ToString(),
                              FormaPagoPagarDsc = ContraOPTXML.Attribute("FormaPagoPagarDsc").Value.ToString(),
                              MontoPagar = ContraOPTXML.Attribute("MontoPagar").Value.ToString(),
                              Temporalidad = ContraOPTXML.Attribute("Temporalidad").Value.ToString(),
                              MTMImplicito = ContraOPTXML.Attribute("MTMImplicito").Value.ToString(),
                              VctoValutaRecibir = ContraOPTXML.Attribute("VctoValutaRecibir").Value.ToString(),
                              VctoValutaPagar = ContraOPTXML.Attribute("VctoValutaPagar").Value.ToString(),
                              // ASVG_20110322 Para diferenciar reportes de vencimiento/pagos compensados.
                              CodEstructura = ContraOPTXML.Attribute("CodEstructura").Value.ToString(),
                              TipoBfwOpt = ContraOPTXML.Attribute("TipoBfwOpt").Value.ToString() //PRD_12567 Papeleta Asiaticos
                          };

            //ContraList = new List<StructMoContrato>(MoContratos.ToList<StructMoContrato>());            
            ContraList = new ObservableCollection<StructPagosFisica>();
            PContraList = new ObservableCollection<StructPagosFisica>();
            _ContraList = new List<StructPagosFisica>(CaPagos.ToList<StructPagosFisica>());
            int _ID = 0;
            foreach (StructPagosFisica _Aux in _ContraList)
            {
                if (_Aux.Temporalidad == Cmb_Estado.SelectionBoxItem.ToString())
                {
                    _ID++;
                    _Aux.ID = _ID;
                    ContraList.Add(_Aux);
                    PContraList.Add(_Aux);
                }
            }
        }

        void Listar_Entregas_Fisicas()
        {
            _Selected = true;
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

            svc.CaPagosEntregaAsync(int.Parse(txtCliRut.Text), int.Parse(txtCliCod.Text), _fDesde, _fHasta);
        }

        private void dgPersona_SelectionChanged(object sender, MouseEventArgs e)
        {
            if (_Selected)
            {
                if (((DataGrid)sender).CurrentColumn.DisplayIndex.Equals(0))
                {

                    if (dgPersona.SelectedIndex >= 0)
                    {
                        StructPagosFisica _CaContrato = new StructPagosFisica();
                        CheckBox _chkControl;
                        _CaContrato = (StructPagosFisica)dgPersona.SelectedItem;
                        _chkControl = (CheckBox)dgPersona.Columns[0].GetCellContent(dgPersona.SelectedItem);
                        if (_chkControl != null)
                        {
                            _chkControl.IsChecked = !_chkControl.IsChecked;
                            //ContraList[_Row].VF = _chkControl.IsChecked.ToString();
                        }
                    }
                }
            }
        }

        private void Buscar_Click(object sender, RoutedEventArgs e)
        {
            Listar_Entregas_Fisicas();
        }

        private void selTodo_Click(object sender, System.Windows.Input.MouseButtonEventArgs e)
        {
            if (ContraList != null)
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

        #region "esto estaba comentado"
        //private void Imprimir_Click(object sender, System.Windows.Input.MouseButtonEventArgs e)
        //{
        //    if (Habilitado)
        //    {
        //        string _Nombre = "";
        //        _Nombre = globales._Usuario;

        //        List<StructPagosFisica> _ListImp = PreparaImpresion();
        //        if (_ListImp.Count > 0)
        //        {
        //            foreach (StructPagosFisica _values in _ListImp)
        //            {
        //                if (_values.sNumContrato != "")
        //                {
        //                    List<KeyValuePair<string, string>> lst_ = new List<KeyValuePair<string, string>>();

        //                    lst_.Add(new KeyValuePair<string, string>("NumContrato", _values.NumContrato));
        //                    lst_.Add(new KeyValuePair<string, string>("RepName", "~/CrystalReportes/LIQUIDACION_OPCIONES.rpt"));
        //                    lst_.Add(new KeyValuePair<string, string>("Tipo", "Liquidacion"));
        //                    lst_.Add(new KeyValuePair<string, string>("Fecha", _values.FechaEjercicio));
        //                    lst_.Add(new KeyValuePair<string, string>("Usuario", _Nombre));

        //                    this.ProcessCommand(lst_.ToArray());
        //                }
        //            }

        //            Actualiza(_ListImp);
        //        }
        //    }
        //}
        #endregion

        private void Imprimir_Click(object sender, System.Windows.Input.MouseButtonEventArgs e)
        {
            if (ContraList != null)
            {
                if (Habilitado)
                {
                    //antes esta era la lista única _ContraList = ContraList.Where(_Element => _Element.VF == "True").ToList();
                    ListLiquidacion = new List<StructPagosFisica>();
                    //ListLiquidacion = ContraList.Where(_Element => _Element.VF == "True" && !_Element.CodEstructura.Equals("8")).ToList();
                    ListLiquidacion = ContraList.Where(_Element => _Element.VF == "True" && _Element.TipoBfwOpt.Equals("OPT")).ToList();
                    PrepararImpresion(ListLiquidacion, "1");

                    ListLiquidacionForward = new List<StructPagosFisica>();
                    //ListLiquidacionForward = ContraList.Where(_Element => _Element.OrigenDsc != "Pago Prima" && _Element.VF.ToUpper().Equals("TRUE") && _Element.CodEstructura.Equals("13")).ToList();
                    //ListLiquidacionForward = ContraList.Where(_Element => _Element.OrigenDsc != "Pago Prima" && _Element.VF.Equals("True") && _Element.TipoTransaccion.Equals("ANTICIPA") && _Element.TipoPayOff.Equals("02")).ToList();
                    ListLiquidacionForward = ContraList.Where(_Element => _Element.VF.Equals("True") && _Element.TipoBfwOpt.Equals("BFW") && !_Element.CodEstructura.Equals("8")).ToList();
                    PrepararImpresion(ListLiquidacionForward, "4");

                    ListLiquidacionEjercicio = new List<StructPagosFisica>();
                    ListLiquidacionEjercicio = ContraList.Where(_Element => _Element.VF == "True" && _Element.CodEstructura.Equals("8")).ToList();
                    PrepararImpresion(ListLiquidacionEjercicio, "3"); //ASVG_20110323 no se usa el 8 para no confundir conceptos.
                }
            }
        }

        private void PrepararImpresion(List<StructPagosFisica> listImp, string reportcode)
        {
            //if (ContraList.Count > 0)
            if (listImp.Count > 0)
            {
                #region Definicion de Variables

                string _Xml = "<?xml version=\"1.0\" encoding=\"utf-8\"?>";

                #endregion

                #region Generación de Formato XML

                _Xml += string.Format("<Options User='{0}' ReportCode='{1}' >", globales._Usuario, reportcode);
                foreach (StructPagosFisica _Values in listImp)
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
                //WebAccionesSoapClient _SrvAcciones = new WebAccionesSoapClient();
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
            }
        }

        private void ImprimirDocumento(int id, string reportCode)
        {
            string _Usuario = globales._Usuario;
            string system = System.Threading.Thread.CurrentThread.CurrentCulture.ToString();

            List<KeyValuePair<string, string>> lst_ = new List<KeyValuePair<string, string>>();

            lst_.Add(new KeyValuePair<string, string>("NumGrupo", id.ToString()));
            if (reportCode.Equals("3"))
            {
                lst_.Add(new KeyValuePair<string, string>("RepName", "~/CrystalReportes/Papeleta_Ejercicio.rpt"));
                lst_.Add(new KeyValuePair<string, string>("Tipo", "Liquidacion"));
            }
            else if(reportCode.Equals("4")) 
            {
                lst_.Add(new KeyValuePair<string, string>("RepName", "~/CrystalReportes/LIQUIDACION_FORWARD.rpt"));
                lst_.Add(new KeyValuePair<string, string>("Tipo", "Liquidacion"));
            }
            else
            {
            lst_.Add(new KeyValuePair<string, string>("RepName", "~/CrystalReportes/LIQUIDACION_OPCIONES.rpt"));
            lst_.Add(new KeyValuePair<string, string>("Tipo", "Liquidacion"));
            }
            //lst_.Add(new KeyValuePair<string, string>("RepName", "~/CrystalReportes/Papeleta_Ejercicio.rpt"));
            //lst_.Add(new KeyValuePair<string, string>("Tipo", "Liquidacion"));

            DateTime _Desde = DateTime.Parse(Dt_FechaDesde.Text);
            DateTime _Hasta = DateTime.Parse(Dt_FechaHasta.Text);

            lst_.Add(new KeyValuePair<string, string>("FechaDesde", _Desde.ToString("yyyyMMdd")));
            lst_.Add(new KeyValuePair<string, string>("FechaHasta", _Hasta.ToString("yyyyMMdd")));

            lst_.Add(new KeyValuePair<string, string>("Usuario", _Usuario));
            this.ProcessCommand(lst_.ToArray());

            if (reportCode.Equals("3"))
            {
                Actualiza(ListLiquidacionEjercicio);
            }
            else
            {
                Actualiza(ListLiquidacion);
            }

            //Actualiza(_ContraList);
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

        private List<StructPagosFisica> PreparaImpresion()
        {
            List<StructPagosFisica> _List = new List<StructPagosFisica>();
            if (ContraList.Count > 0)
            {
                foreach (StructPagosFisica _Aux in ContraList)
                {
                    if (_Aux.VF == "True")
                    {
                        _List.Add(_Aux);
                    }
                }
            }
            return _List;
        }

        private void Actualiza(List<StructPagosFisica> _List)
        {
            List<string> _valor = new List<string>();

            if (_List.Count > 0)
            {
                foreach (StructPagosFisica _values in _List)
                {
                    if (_values.sNumContrato != "")
                    {
                        _valor.Add(_values.NumContrato.ToString());
                    }
                }
                if (_valor.Count() > 0)
                {
                    sva.ActualizaMoEncAsync(_valor.ToArray());
                }
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
                DataGrid DataGridRRFLY = (DataGrid)sender;

                string textData = "";

                #region Head

                string _TextColumn = "";

                foreach (DataGridColumn _Column in DataGridRRFLY.Columns)
                {
                    if (_TextColumn != "" && _TextColumn != "ID")
                    {
                        _TextColumn += "\t";
                    }
                    _TextColumn += _Column.Header;
                }
                textData += _TextColumn + "\n";

                #endregion

                #region Value

                foreach (StructPagosFisica _Item in DataGridRRFLY.ItemsSource)
                {
                    textData += string.Format(
                                               "{0}\t{1}\t{2}\t{3}\t{4}\t{5}\t{6}\t{7}\t{8}\t{9}\t{10}\t{11}\t{12}\t{13}\t{14}\t{15}\t{16}\t{17}\n",
                                            _Item.NumContrato.ToString(),
                                            _Item.NumEstructura.ToString(),
                                             DateTime.Parse(_Item.FechaEjercicio).ToString("dd/MM/yyyy"),
                                             DateTime.Parse(_Item.FechaContrato).ToString("dd/MM/yyyy"),
                                            _Item.CliRut.ToString(),
                                            _Item.CliDv.ToString(),
                                            _Item.CliCod.ToString(),
                                            _Item.CliNom.ToString(),
                                            _Item.MdaRecibirDsc.ToString(),
                                            _Item.FormaPagorecibirDsc.ToString(),
                                            _Item.MontoRecibir.ToString(),
                                            _Item.MdaPagarDsc.ToString(),
                                            _Item.FormaPagoPagarDsc.ToString(),
                                            _Item.MontoPagar.ToString(),
                                            _Item.Temporalidad,
                                            _Item.MTMImplicito,
                                            DateTime.Parse( _Item.VctoValutaRecibir ).ToString("dd/MM/yyyy"),
                                            DateTime.Parse(_Item.VctoValutaPagar).ToString("dd/MM/yyyy") 
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

        private void btnAceptar_MouseEnter(object sender, MouseEventArgs e)
        {
            dgPersona.Focus();
        }

        private void btnAceptar_Click(object sender, RoutedEventArgs e)
        {
            if (_FormaPagoPagar.SelectedItem != null && _FormaPagoRecibir.SelectedItem != null)
            {
                StructCodigoDescripcion _FPagoPagar = (StructCodigoDescripcion)_FormaPagoPagar.SelectedItem;
                StructCodigoDescripcion _FPagoRecibir = (StructCodigoDescripcion)_FormaPagoRecibir.SelectedItem;
                sva.ActualizaFormaPagoEntregaFisicaAsync(
                                                          long.Parse(_Item.NumContrato),
                                                          long.Parse(_Item.NumEstructura),
                                                          int.Parse(_FPagoPagar.Codigo),
                                                          int.Parse(_FPagoRecibir.Codigo)
                                                        );
            }
        }

        private void btnCancelar_Click(object sender, RoutedEventArgs e)
        {
            HabilitarControles();
            _PopEntregaFisica.Close();
        }

        private void buttonID_Click(object sender, RoutedEventArgs e)
        {
            int _ID = (int)(((Button)sender).Tag) - 1;
            if (_ID >= 0)
            {
                try
                {
                    _Item = ContraList[_ID];

                    _FormaPagoRecibirLabel.Text = "Forma Pago Recibir " + _Item.MdaRecibirDsc;
                    _FormaPagoPagarLabel.Text = "Forma Pago Pagar " + _Item.MdaPagarDsc;

                    CierreMesa = false;
                    _FlagFormaPagoRecibir = false;
                    _FlagFormaPagoPagar = false;

                    svc.LoadFormaPagoAsync(_Item.MdaPagarDsc, globales._FechaProceso);
                    svc.LoadFormaPagoAsync(_Item.MdaRecibirDsc, globales._FechaProceso);
                }
                catch
                {
                }
            }
        }

        private void CloseCompleted(object sender, DialogEventArgs e)
        {
            HabilitarControles();
        }

        private void HabilitarControles()
        {
            Habilitado = true;

            txtCliRut.IsEnabled = true;
            txtCliCod.IsEnabled = true;
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
            txtCliCod.IsEnabled = false;
            Dt_FechaDesde.IsEnabled = false;
            Dt_FechaHasta.IsEnabled = false;
            Cmb_Estado.IsEnabled = false;
            dgPersona.IsEnabled = false;
            btn_cargar.IsEnabled = false;
        }

    }

}