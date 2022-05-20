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
using AdminOpciones.SrvAcciones;

namespace AdminOpciones.Controls
{
    public partial class DetalleLiquidacionDef : UserControl
    {
        AdminOpciones.SrvAcciones.WebAccionesSoapClient sva = wsGlobales.Acciones;
        AdminOpciones.SrvDetalles.WebDetallesSoapClient svc = wsGlobales.Detalles;

        private List<StructLiquidacionDef> _ContraList;
        private ObservableCollection<StructLiquidacionDef> ContraList;
        private ObservableCollection<StructLiquidacionDef> PContraList;
        private List<StructLiquidacionDef> ListLiquidacion = new List<StructLiquidacionDef>();
        private List<StructLiquidacionDef> ListLiquidacionForward = new List<StructLiquidacionDef>();//Papeleta Asiaticos
        private List<StructLiquidacionDef> ListLiqudicionPrima = new List<StructLiquidacionDef>();
        private XDocument xmlContratos = new XDocument();
        private XDocument xmlResult = new XDocument();
        public string XmlResultContra;
        bool _Estado, _Estado2 = false;
        private bool Habilitado = true;

        public DetalleLiquidacionDef()
        {
            InitializeComponent();
            svc.CaLiquidacionCompleted += new EventHandler<AdminOpciones.SrvDetalles.CaLiquidacionCompletedEventArgs>(svc_CaLiquidacionCompleted);
            svc.VerificaFixingPendientesCompleted += new EventHandler<AdminOpciones.SrvDetalles.VerificaFixingPendientesCompletedEventArgs>(svc_VerificaFixingPendientesCompleted);
            this.dgPersona.MouseLeftButtonUp += new MouseButtonEventHandler(dgPersona_SelectionChanged);
            //this.dgPersona.LoadingRow += new EventHandler<DataGridRowEventArgs>(dgPersona_LoadingRow);

            List<string> _carga = new List<string>();
            _carga.Add("");
            _carga.Add("Normal");
            _carga.Add("Interna");
            StartLoading();
            VerificaFijacionesPendientes();

        }

        private void VerificaFijacionesPendientes()
        {
            svc.VerificaFixingPendientesAsync();
        }

        private void svc_VerificaFixingPendientesCompleted(object sender, AdminOpciones.SrvDetalles.VerificaFixingPendientesCompletedEventArgs e)
        {
            if (e.Error == null)
            {
                XDocument _XmlValue = XDocument.Parse(e.Result);

                if (_XmlValue.Element("Status").Attribute("ID").Value.Equals("0"))
                {

                    if (!_XmlValue.Element("Status").Attribute("Message").Value.Equals("OK"))
                    {
                        System.Windows.Browser.HtmlPage.Window.Alert(_XmlValue.Element("Status").Attribute("Message").Value);
                        StopLoading();
                    }
                    else
                    {
                        Listar_Detalle_Liquidacion();
                    }
                }
                else
                {
                    System.Windows.Browser.HtmlPage.Window.Alert(_XmlValue.Element("Status").Attribute("Message").Value);
                    StopLoading();
                }
            }
            else
            {
                StopLoading();
                System.Windows.Browser.HtmlPage.Window.Alert(e.Error.Message);
            }
        }


        public class _Resultados
        {
            public string Folio { get; set; }
            public string Result { get; set; }
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

        void svc_CaLiquidacionCompleted(object sender, AdminOpciones.SrvDetalles.CaLiquidacionCompletedEventArgs e)
        {
            XmlResultContra = e.Result;
            if (XmlResultContra.Length > 0)
            {
                ContratoOPT(XmlResultContra);
                if (ContraList.Count > 0)
                {
                    dgPersona.ItemsSource = ContraList;
                }
            }
            StopLoading();
        }

        void ContratoOPT(string strXMLContra)
        {
            xmlContratos = XDocument.Parse(strXMLContra);
            var CaLiquid_ = from ContraOPTXML in xmlContratos.Descendants("Data")
                              select new StructLiquidacionDef
                              {
                                  VF = ContraOPTXML.Attribute("VF").Value.ToString(),
                                  NumContrato = ContraOPTXML.Attribute("NumContrato").Value.ToString(),
                                  FechaEjercicio = ContraOPTXML.Attribute("FechaEjercicio").Value.ToString(),
                                  FechaContrato = ContraOPTXML.Attribute("FechaContrato").Value.ToString(),
                                  CliRut = ContraOPTXML.Attribute("CliRut").Value.ToString(),
                                  CliDv = ContraOPTXML.Attribute("CliDv").Value.ToString(),
                                  CliCod = ContraOPTXML.Attribute("CliCod").Value.ToString(),
                                  CliNom = ContraOPTXML.Attribute("CliNom").Value.ToString(),
                                  Estado = ContraOPTXML.Attribute("Estado").Value.ToString(),
                                  Contrapartida = ContraOPTXML.Attribute("Contrapartida").Value.ToString(),
                                  Operador = ContraOPTXML.Attribute("Operador").Value.ToString(),
                                  ModalidadDsc = ContraOPTXML.Attribute("ModalidadDsc").Value.ToString(),
                                  OrigenDsc = ContraOPTXML.Attribute("OrigenDsc").Value.ToString(),
                                  Mda1Dsc = ContraOPTXML.Attribute("Mda1Dsc").Value.ToString(),
                                  Mda1Mto = ContraOPTXML.Attribute("Mda1Mto").Value.ToString(),
                                  Mda2Dsc = ContraOPTXML.Attribute("Mda2Dsc").Value.ToString(),
                                  Mda2Mto = ContraOPTXML.Attribute("Mda2Mto").Value.ToString(),
                                  CodEstructura = ContraOPTXML.Attribute("CodEstructura").Value.ToString(), //PRD_12567 Papeleta Asiaticos
                                  TipoTransaccion = ContraOPTXML.Attribute("TipoTransaccion").Value.ToString(), //PRD_12567 Papeleta Asiaticos
                                  TipoPayOff = ContraOPTXML.Attribute("TipoPayOff").Value.ToString(), //PRD_12567 Papeleta Asiaticos
                                  TipoBfwOpt = ContraOPTXML.Attribute("TipoBfwOpt").Value.ToString() //PRD_12567 Papeleta Asiaticos
                              };

            ContraList = new ObservableCollection<StructLiquidacionDef>();
            PContraList = new ObservableCollection<StructLiquidacionDef>();
            _ContraList = new List<StructLiquidacionDef>(CaLiquid_.ToList<StructLiquidacionDef>());
            foreach (StructLiquidacionDef _Aux in _ContraList)
            {
                ContraList.Add(_Aux);
                PContraList.Add(_Aux);
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
                if (_cmbEstado == "Todo")
                {
                    tag = "T";
                }
                else
                {
                    tag = "H";
                }
            }
            svc.CaLiquidacionAsync(int.Parse(txtCliRut.Text), int.Parse(txtCliCod.Text), _fDesde, _fHasta, tag, globales._Usuario);
            
        }

        private void dgPersona_SelectionChanged(object sender, MouseEventArgs e)
        {
            int _Row;
            StructLiquidacionDef _CaLiquidacion = new StructLiquidacionDef();
            CheckBox _chkControl;
            _Row = dgPersona.SelectedIndex;
            if (_Row >= 0)
            {
                _CaLiquidacion = dgPersona.SelectedItem as StructLiquidacionDef;
                _chkControl = dgPersona.Columns[0].GetCellContent(dgPersona.SelectedItem) as CheckBox;
                _chkControl.IsChecked = !_chkControl.IsChecked;
                ContraList[_Row].VF = _chkControl.IsChecked.ToString();
                //ContraList[_Row].Impreso = "S";
                dgPersona.ItemsSource = ContraList;
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
            //ASVG estas tres listas se podrían combinar
            //primero requiere revisar la funcionalidad de imprimir varios contratos simultáneamente //Papeleta Asiaticos
            if (Habilitado)
            {
                ListLiquidacion = new List<StructLiquidacionDef>();
                //ListLiquidacion = ContraList.Where(_Element => _Element.OrigenDsc != "Pago Prima" && _Element.VF.Equals("True") && !_Element.CodEstructura.Equals("13")).ToList(); //Papeleta Asiaticos
                ListLiquidacion = ContraList.Where(_Element => _Element.OrigenDsc != "Pago Prima" && _Element.VF.Equals("True") && _Element.TipoBfwOpt.Equals("OPT")).ToList(); //Papeleta Asiaticos
                if (ListLiquidacion.Count > 0)
                {
                    PrepararImpresion(ListLiquidacion, "1");
                }
                //Papeleta Asiaticos
                ListLiquidacionForward = new List<StructLiquidacionDef>();
                //ListLiquidacionForward = ContraList.Where(_Element => _Element.OrigenDsc != "Pago Prima" && _Element.VF.Equals("True") && _Element.CodEstructura.Equals("13")).ToList();
                //ListLiquidacionForward = ContraList.Where(_Element => _Element.OrigenDsc != "Pago Prima" && _Element.VF.Equals("True") && _Element.TipoTransaccion.Equals("ANTICIPA") && _Element.TipoPayOff.Equals("02")).ToList();
                ListLiquidacionForward = ContraList.Where(_Element => _Element.OrigenDsc != "Pago Prima" && _Element.VF.Equals("True") && _Element.TipoBfwOpt.Equals("BFW")).ToList();
                if (ListLiquidacionForward.Count > 0)
                {
                    PrepararImpresion(ListLiquidacionForward, "3");
                }

                ListLiqudicionPrima = new List<StructLiquidacionDef>();
                ListLiqudicionPrima = ContraList.Where(_Element => _Element.OrigenDsc == "Pago Prima" && _Element.VF.Equals("True")).ToList();
                if (ListLiqudicionPrima.Count > 0)
                {
                    PrepararImpresion(ListLiqudicionPrima, "2");
                }
            }
        }

        private void PrepararImpresion(List<StructLiquidacionDef> listImp, string reportcode)
        {
            if (ContraList.Count > 0)
            {
                #region Definicion de Variables

                string _Xml = "<?xml version=\"1.0\" encoding=\"utf-8\"?>";

                #endregion

                #region Generación de Formato XML

                _Xml += string.Format("<Options User='{0}' ReportCode='{1}' >", globales._Usuario, reportcode);
                foreach (StructLiquidacionDef _Values in listImp)
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

            if (reportCode.Equals("1")) // -- MAP
            {
                lst_.Add(new KeyValuePair<string, string>("RepName", "~/CrystalReportes/LIQUIDACION_OPCIONES.rpt"));
                lst_.Add(new KeyValuePair<string, string>("Tipo", "Liquidacion"));
            }
            else if (reportCode.Equals("3")) //PRD_12567 Papeleta Asiaticos
            {
                lst_.Add(new KeyValuePair<string, string>("RepName", "~/CrystalReportes/LIQUIDACION_FORWARD.rpt"));
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
            else if (reportCode.Equals("3"))//Papeleta Asiaticos
            {
                Actualiza(ListLiquidacionForward);
            }
            else
            {
                Actualiza(ListLiqudicionPrima);
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

        private void Actualiza(List<StructLiquidacionDef> _List)
        {
            List<string> _valor = new List<string>();
            
            if (_List.Count > 0)
            {
                foreach (StructLiquidacionDef _values in _List)
                {
                    _valor.Add(_values.NumContrato.ToString());
                }
                sva.ActualizaMoEncAsync(_valor.ToArray());
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

                foreach (DataGridColumn _Column in DataGridRRFLY.Columns)
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

                foreach (StructLiquidacionDef _Item in DataGridRRFLY.ItemsSource)
                {
                    textData += string.Format(
                                               "{0}\t{1}\t{2}\t{3}\t{4}\t{5}\t{6}\t{7}\t{8}\t{9}\t{10}\t{11}\t{12}\t{13}\t{14}\n",
                                               _Item.NumContrato.ToString(),
                                               DateTime.Parse(_Item.FechaEjercicio).ToString("dd/MM/yyyy"),
                                               DateTime.Parse(_Item.FechaContrato).ToString("dd/MM/yyyy"),
                                               _Item.CliRut.ToString(),
                                               _Item.CliDv.ToString(),
                                               _Item.CliCod.ToString(),
                                               _Item.CliNom.ToString(),
                                               _Item.Estado.ToString(),
                                               _Item.Contrapartida.ToString(),
                                               _Item.Operador.ToString(),
                                               _Item.OrigenDsc.ToString(),
                                               _Item.Mda1Dsc.ToString(),
                                               _Item.Mda1Mto.ToString(),
                                               _Item.Mda2Dsc.ToString(),
                                               _Item.Mda2Mto.ToString()
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

        private void StartLoading()
        {
            Mask.Visibility = Visibility.Visible;
        }

        private void StopLoading()
        {
            Mask.Visibility = Visibility.Collapsed;
        }

    }
}
