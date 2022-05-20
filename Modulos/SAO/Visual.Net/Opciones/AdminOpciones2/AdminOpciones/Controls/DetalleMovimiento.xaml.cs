using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Linq;
using System.Windows;
using System.Windows.Browser;
using System.Windows.Controls;
using System.Windows.Input;
using System.Windows.Media.Imaging;
using System.Xml.Linq;
using AdminOpciones.Recursos;
using AdminOpciones.Struct;
using System.Windows.Media;
using AdminOpciones.SrvAcciones;

namespace AdminOpciones.Controls
{
    public enum EnumDetalleMovimiento
    {
        Init = 0,
        ConsultaMovimiento = 1,
        ConsultaAnticipo = 2,
        AnulacionAnticipo = 3,
        ConsultaSDA = 4
    }

    public partial class DetalleMovimiento : UserControl
    {
        SrvLoadFront.LoadFrontSoapClient _SrvLoadFront = wsGlobales.LoadFront;
        AdminOpciones.SrvDetalles.WebDetallesSoapClient svc = wsGlobales.Detalles;
        AdminOpciones.SrvAcciones.WebAccionesSoapClient sva = wsGlobales.Acciones;

        private List<StructMoContrato> ListMovimiento = new List<StructMoContrato>();
        private List<StructMoContrato> ListMovimientoEjercicio = new List<StructMoContrato>();
        private List<StructMoContrato> _ContraList;
        private ObservableCollection<StructMoContrato> ContraList;
        private ObservableCollection<StructMoContrato> PContraList;
        XDocument xmlContratos = new XDocument();
        XDocument xmlResult = new XDocument();
        public string XmlResultContra;
        public string Mensaje_ = string.Empty;
        bool _Estado = false;
        public string Tipo_Instancia;
        private EnumDetalleMovimiento TipoDetalleMovimiento { get; set; }
        private bool Habilitado = true;
        private List<StructMonedaFormaPago> formaDePagoList;
        private List<_Modalidad> Modalidad = new List<_Modalidad>();

        public DetalleMovimiento()
        {
            InitializeComponent();
            svc.MoEncContratoCompleted += new EventHandler<AdminOpciones.SrvDetalles.MoEncContratoCompletedEventArgs>(svc_MoEncContratoCompleted);
            sva.ActualizaMoEncCompleted += new EventHandler<AdminOpciones.SrvAcciones.ActualizaMoEncCompletedEventArgs>(sva_ActualizaMoEncCompleted);
            sva.DeshaceAnticipoCompleted += new EventHandler<AdminOpciones.SrvAcciones.DeshaceAnticipoCompletedEventArgs>(sva_DesahaceAnticipoCompleted);
            sva.AnulaSDACompleted += new EventHandler<AdminOpciones.SrvAcciones.AnulaSDACompletedEventArgs>(sva_AnulaSDACompleted);           
            svc.Trae_SDACompleted += new EventHandler<AdminOpciones.SrvDetalles.Trae_SDACompletedEventArgs>(svc_Trae_SDACompleted);
            svc.ConsultaOperacionCompleted += new EventHandler<AdminOpciones.SrvDetalles.ConsultaOperacionCompletedEventArgs>(svc_ConsultaOperacionCompleted);
            _SrvLoadFront.LoadFrontDataCompleted += new EventHandler<AdminOpciones.SrvLoadFront.LoadFrontDataCompletedEventArgs>(_SrvLoadFront_LoadFrontDataCompleted);
            this.dgPersona.MouseLeftButtonUp += new MouseButtonEventHandler(dgPersona_SelectionChanged);

            //SOLICITUDSDA
            _IngSolicitudSDA.MaskCollapsed += new AdminOpciones.Ejercer.Delegate(_IngSolicitudSDA_MaskCollapsed);
            _IngSolicitudSDA.SetData += new AdminOpciones.Ejercer.SetData(_IngSolicitudSDA_SetData);

            //this.dgPersona.LoadingRow += new EventHandler<DataGridRowEventArgs>(dgPersona_LoadingRow);

            List<string> _carga = new List<string>();
            _carga.Add("Todos");
            _carga.Add("Normal");
            _carga.Add("Interna");
            cmbTContra.ItemsSource = _carga;
            cmbTContra.SelectedIndex = 0;

            TipoDetalleMovimiento = EnumDetalleMovimiento.Init;

            Listar_Detalle_Movimiento();
            this.Btn_ModificaSDA.IsEnabled = false;
        }

        public class _Resultados
        {
            public string Folio { get; set; }
            public string Result { get; set; }
        }

        public class _ResultadosDeshaceAnticipo
        {
            public string MsgStatus { get; set; }
            public override string ToString()
            {
                return string.Format("?MsgStatus={0}", MsgStatus);
            }
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

        void svc_MoEncContratoCompleted(object sender, AdminOpciones.SrvDetalles.MoEncContratoCompletedEventArgs e)
        {
            if (e.Error == null)
            {
                XmlResultContra = e.Result;
                if (XmlResultContra.Length > 0)
                {
                    ContratoOPT(XmlResultContra);
                }
                FormateaPantalla();
            }
            else
            {
                System.Windows.Browser.HtmlPage.Window.Alert(e.Error.Message);
            }
        }

        void sva_DesahaceAnticipoCompleted(object sender, AdminOpciones.SrvAcciones.DeshaceAnticipoCompletedEventArgs e)
        {
            string _xmlResult = e.Result.ToString();
            _ResultadosDeshaceAnticipo _sData = new _ResultadosDeshaceAnticipo();
            xmlResult = XDocument.Parse(_xmlResult);
            List<_ResultadosDeshaceAnticipo> _data = new List<_ResultadosDeshaceAnticipo>();

            IEnumerable<XElement> elements = xmlResult.Element("Resultado").Elements("Data");
            foreach (XElement element in elements)
            {
                //_Resultados _sData = new _Resultados();
                _sData.MsgStatus = element.FirstAttribute.Value.ToString();
                _data.Add(_sData);
            }

            Mensaje_ = _sData.MsgStatus.ToString();
            System.Windows.Browser.HtmlPage.Window.Alert(Mensaje_);
            Listar_Detalle_Movimiento();
        }

        void ContratoOPT(string strXMLContra)
        {
            xmlContratos = XDocument.Parse(strXMLContra);

            if (xmlContratos.Element("MoEncContrato").Attribute("Error").Value.Equals("0"))
            {
                var MoContratos = from ContraOPTXML in xmlContratos.Descendants("Data")
                                  select new StructMoContrato
                                  {
                                      VF = ContraOPTXML.Attribute("VF").Value.ToString(),
                                      Objeto = ContraOPTXML.Attribute("Objeto").Value.ToString(),
                                      NumContrato = ContraOPTXML.Attribute("NumContrato").Value.ToString(),
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
                                      TipoTransaccion = ContraOPTXML.Attribute("TipoTransaccion").Value.ToString(),
                                      Contrapartida = ContraOPTXML.Attribute("Contrapartida").Value.ToString(),
                                      FechaCreacionRegistro = ContraOPTXML.Attribute("FechaCreacionRegistro").Value.ToString(),
                                      Impreso = ContraOPTXML.Attribute("Impreso").Value.ToString()
                                  };

                //ContraList = new List<StructMoContrato>(MoContratos.ToList<StructMoContrato>());            
                ContraList = new ObservableCollection<StructMoContrato>();
                PContraList = new ObservableCollection<StructMoContrato>();
                _ContraList = new List<StructMoContrato>(MoContratos.ToList<StructMoContrato>());
                foreach (StructMoContrato _Aux in _ContraList)
                {
                    if (this.Tipo_Instancia == "ConAnticipo" || this.Tipo_Instancia == "AnuAnticipo" || this.Tipo_Instancia == "ConSDA")
                    {
                        if (_Aux.TipoTransaccion == "ANTICIPA" || _Aux.TipoTransaccion == "EJERCE" || _Aux.TipoTransaccion == "SOLICITUD"||_Aux.TipoTransaccion == "LEASING")
                        {
                            ContraList.Add(_Aux);
                            PContraList.Add(_Aux);
                        }
                    }
                    else
                    {
                        ContraList.Add(_Aux);
                        PContraList.Add(_Aux);
                    }
                }
                dgPersona.ItemsSource = ContraList;
            }
            else
            {
                ContraList = new ObservableCollection<StructMoContrato>();
                PContraList = new ObservableCollection<StructMoContrato>();
                dgPersona.ItemsSource = ContraList;
                System.Windows.Browser.HtmlPage.Window.Alert(xmlContratos.Element("MoEncContrato").Attribute("Message").Value);
            }
        }

        void Listar_Detalle_Movimiento()
        {
            string _TipoContrato = "";

            int _ID;
            if (txtCliID.Text.Equals(""))
            {
                _ID = 0;
            }
            else
            {
                _ID = int.Parse(txtCliID.Text);
            }

            #region Activa Controles SDA

            if (globales._SDA == "Con_SDA")
            {
                _TipoContrato = "Solicitud";
                globales._SDA = "";
            }
            else
            {
                _TipoContrato = cmbTContra.SelectedItem.ToString();
            }
            this.Bnt_Anular_SDA.IsEnabled = false;

            if (Tipo_Instancia == "AnuAnticipo" && cmbTContra.SelectedItem.ToString() == "Solicitud")
            {
                this.Bnt_Anular_SDA.IsEnabled = true;
                this.Bnt_Anular_Anticipo.IsEnabled = false;

                this.Imprimir.Visibility = Visibility.Collapsed;
                this.ExpExcel.Visibility = Visibility.Collapsed;
                this.SelTodo.Visibility = Visibility.Collapsed;
             
            }
            else if (Tipo_Instancia == "AnuAnticipo")
            {
                this.Bnt_Anular_SDA.IsEnabled = false;
                this.Bnt_Anular_Anticipo.IsEnabled = true;

                this.Imprimir.Visibility = Visibility.Visible;
                this.ExpExcel.Visibility = Visibility.Visible;
                this.SelTodo.Visibility = Visibility.Visible;
                
            }

            #endregion

            svc.MoEncContratoCompleted += new EventHandler<AdminOpciones.SrvDetalles.MoEncContratoCompletedEventArgs>(svc_MoEncContratoCompleted);
            svc.MoEncContratoAsync(_ID, 0, _TipoContrato);
        }

        private void dgPersona_SelectionChanged(object sender, MouseEventArgs e)
        {
            try
            {
                ((DataGrid)sender).CurrentColumn.Equals(null);
            }
            catch  
            {               
                System.Windows.Browser.HtmlPage.Window.Alert("No Existen Datos");
               
                return;
            }
                 
            if (((DataGrid)sender).CurrentColumn.DisplayIndex.Equals(0))
            {
                if (dgPersona.SelectedIndex >= 0)
                {
                    StructMoContrato _MoContrato = (StructMoContrato)dgPersona.SelectedItem;

                    CheckBox _chkControl = (CheckBox)dgPersona.Columns[0].GetCellContent(dgPersona.SelectedItem);
                    _chkControl.IsChecked = !_chkControl.IsChecked;
                    _MoContrato.VF = _chkControl.IsChecked.ToString();
                    //ContraList[_Row].Impreso = "S";
                    dgPersona.ItemsSource = ContraList;
                }
            }
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

        private void Imprimir_Click(object sender, System.Windows.Input.MouseButtonEventArgs e)
        {
            if (ContraList != null)
            {
                if (Habilitado)
                {
                    ListMovimiento = new List<StructMoContrato>();
                    ListMovimiento = ContraList.Where(_Element => _Element.VF == "True" && !_Element.TipoTransaccion.Equals("EJERCE")).ToList();
                        PrepararImpresion(ListMovimiento, "1");

                    //ASVG_20110323 Hay que agrupar en listas separadas para aprovechar el reportcode
                    ListMovimientoEjercicio = new List<StructMoContrato>();
                    ListMovimientoEjercicio = ContraList.Where(_Element => _Element.VF == "True" && _Element.TipoTransaccion.Equals("EJERCE")).ToList();
                    //ASVG_20110303 Parche rápido para el nuevo reporte Papeleta_Ejercicio, reciclado del parámetro reportCode que no se usa.
                    //ASVG_20110323 Hay que agrupar en listas separadas para aprovechar el reportcode
                    PrepararImpresion(ListMovimientoEjercicio, "Ejercicio");
                }
            }
        }

        private void PrepararImpresion(List<StructMoContrato> listImp, string reportcode)
        {
            //if (ContraList.Count > 0) ASVG_20110323 Ahora hay más de una lista...
            if (listImp.Count > 0)
            {
                #region Definicion de Variables

                string _Xml = "<?xml version=\"1.0\" encoding=\"utf-8\"?>";

                #endregion

                #region Generación de Formato XML

                _Xml += string.Format("<Options User='{0}' ReportCode='{1}' >", globales._Usuario, reportcode);
                foreach (StructMoContrato _Values in listImp)
                {
                    _Xml += string.Format(
                                           "<Option Contrato='{0}' Folio='{1}' />",
                                           _Values.NumContrato,
                                           _Values.NumFolio
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
            //ASVG_20110303 Parche rápido para el nuevo reporte Papeleta_Ejercicio, reciclado del parámetro reportCode que no se usa.
            if (reportCode == "Ejercicio")
            {
                lst_.Add(new KeyValuePair<string, string>("RepName", "~/CrystalReportes/Papeleta_Ejercicio.rpt"));
            }
            else
            {
            lst_.Add(new KeyValuePair<string, string>("RepName", "~/CrystalReportes/Papeleta_Movimiento_Nivel_Fixing.rpt"));
            }
            lst_.Add(new KeyValuePair<string, string>("Tipo", "Movimiento"));
            lst_.Add(new KeyValuePair<string, string>("Usuario", globales._Usuario));

            this.ProcessCommand(lst_.ToArray());

            //ASVG_20110323 Evaluar cambio en forma de codificar.
            if (reportCode == "Ejercicio")
            {
                Actualiza(ListMovimientoEjercicio);
            }
            else
            {
            Actualiza(ListMovimiento);
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

        private List<StructMoContrato> PreparaImpresion()
        {
            List<StructMoContrato> _List = new List<StructMoContrato>();
            if (ContraList.Count > 0)
            {
                foreach (StructMoContrato _Aux in ContraList)
                {
                    if (_Aux.VF == "True")
                    {
                        _List.Add(_Aux);
                    }
                }
            }
            return _List;
        }


        private List<StructMoContrato> PreparaAnulacionAnticipo()
        {
            int _cont = 0;
            string Mensaje;

            List<StructMoContrato> _List = new List<StructMoContrato>();
            if (ContraList != null)
            {
                if (ContraList.Count > 0)
                {
                    foreach (StructMoContrato _Aux in ContraList)
                    {
                        if (_Aux.VF == "True")
                        {
                            _List.Add(_Aux);
                            _cont++;
                        }
                    }
                    if (_cont == 1)
                    { return _List; }
                    else
                    {
                        if (_cont == 0)
                        {
                            Mensaje = "Seleccionar un Anticipo para Anular";
                            System.Windows.Browser.HtmlPage.Window.Alert(Mensaje);
                            return null;
                        }
                        else
                        {
                            Mensaje = "Seleccionar solamente un Anticipo para Anular";
                            System.Windows.Browser.HtmlPage.Window.Alert(Mensaje);
                            return null;
                        }
                    }
                }
                return _List;
            }
            else
            {
                Mensaje = "No existen Anticipos seleccionados para Anular";
                System.Windows.Browser.HtmlPage.Window.Alert(Mensaje);
                return null;
            }
        }



        private void Actualiza(List<StructMoContrato> _List)
        {
            List<string> _valor = new List<string>();

            if (_List.Count > 0)
            {
                foreach (StructMoContrato _values in _List)
                {
                    _valor.Add(_values.NumFolio.ToString());
                }
                sva.ActualizaMoEncAsync(_valor.ToArray());
            }
        }

        #endregion

        private void ExpExcel_MouseLeftButtonUp(object sender, MouseButtonEventArgs e)
        {
            if (Habilitado)
            {
                string _ID = txtCliID.Text;
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

        private void Filtro_MouseLeftButtonUp(object sender, MouseButtonEventArgs e)
        {
            if (Habilitado)
            {
                Listar_Detalle_Movimiento();
            }
        }

        private void txtCliID_KeyDown(object sender, KeyEventArgs e)
        {
            string _key = e.Key.ToString();
            int _cont = _key.Length;
            if (_cont == 1)
            {
                if (Char.IsLetter(e.Key.ToString(), 0))
                {
                    e.Handled = true;
                }
                else if (Char.IsControl(e.Key.ToString(), 0))
                {
                    e.Handled = true;
                }
                else if (Char.IsSeparator(e.Key.ToString(), 0))
                {
                    e.Handled = true;
                }
                else
                {
                    e.Handled = false;
                }
            }

            if (_cont == 2)
            {
                if (Char.IsLetter(e.Key.ToString(), 1))
                {
                    e.Handled = true;
                }
                else if (Char.IsControl(e.Key.ToString(), 0))
                {
                    e.Handled = true;
                }
                else if (Char.IsSeparator(e.Key.ToString(), 0))
                {
                    e.Handled = true;
                }
                else
                {
                    e.Handled = false;
                }
            }

            if (_cont == 7)
            {
                if (Char.IsLetter(e.Key.ToString(), 6))
                {
                    e.Handled = true;
                }
                else if (Char.IsControl(e.Key.ToString(), 0))
                {
                    e.Handled = true;
                }
                else if (Char.IsSeparator(e.Key.ToString(), 0))
                {
                    e.Handled = true;
                }
                else
                {
                    e.Handled = false;
                }
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
                    if (!_Column.DisplayIndex.Equals(0))
                    {
                        if (_TextColumn != "")
                        {
                            _TextColumn += "\t";
                        }
                        _TextColumn += _Column.Header;
                    }
                }
                textData += _TextColumn + "\n";

                #endregion

                #region Value


                // Solo si se desea copiar lo seleccionado.
                //foreach (StructMoContrato _Item in DataGridRRFLY.SelectedItems)

                foreach (StructMoContrato _Item in DataGridRRFLY.ItemsSource)
                {
                    textData += string.Format(
                                               "{0}\t{1}\t{2}\t{3}\t{4}\t{5}\t{6}\t{7}\t{8}\t{9}\t{10}\t{11}\t{12}\t{13}\n",
                                               _Item.NumContrato.ToString(),
                                               _Item.NumFolio.ToString(),
                                               _Item.TipoTransaccion.ToString(),
                                               DateTime.Parse(_Item.FechaContrato).ToString("dd/MM/yyyy"),
                                               _Item.ConOpcEstDsc.ToString(),
                                               _Item.CliRut.ToString(),
                                               _Item.CliDv.ToString(),
                                               _Item.CliCod.ToString(),
                                               _Item.CliNom.ToString(),
                                               _Item.Contrapartida.ToString(),
                                               _Item.Operador.ToString(),
                                               _Item.OpcEstDsc.ToString(),
                                               _Item.FechaCreacionRegistro.ToString(),
                                               _Item.Impreso.ToString()
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

        private void Bnt_Anular_Anticipo_Click(object sender, System.Windows.RoutedEventArgs e)
        {

            string _Nombre = "";
            _Nombre = globales._Usuario;
            string Mensaje;

            List<StructMoContrato> _ListImp = PreparaAnulacionAnticipo();
            if (_ListImp != null)
            {
                if (_ListImp.Count > 0)
                {
                    foreach (StructMoContrato _values in _ListImp)
                    {
                        Mensaje = string.Format(" Se anulará el anticipo contrato {0}\t Folio: {1}\t  \n", _values.NumContrato, _values.NumFolio);
                        System.Windows.Browser.HtmlPage.Window.Alert(Mensaje);
                        //Mensaje = "Proceso Anular Anticipo PENDIENTE";
                        //System.Windows.Browser.HtmlPage.Window.Alert(Mensaje);

                        sva.DeshaceAnticipoAsync(Convert.ToInt32(_values.NumContrato), Convert.ToInt32(_values.NumFolio));
                    }
                }
            }
        }

        private void dgPersona_LoadingRow(object sender, DataGridRowEventArgs e)
        {
            StructMoContrato _Contract = (StructMoContrato)e.Row.DataContext;

            /*
             * (FFFFFFFF) ( ) Vigente
             * (FFD3D3D3) (C) Cotizacion
             * (FFC1C1C1) (M) Prep. Modificacion
             * (FF808080) (N) Prep. Anticipo
             * (FFA9A9A9) (P) Pendiente
             * (FFFF0000) (U) Prep. Anulacion.
             * () (E) Prep. Ejercer
             * (FFFFFFFF) Otros estados no definido.
             */

            if (_Contract.ConOpcEstCod.Equals(" "))
            {
                e.Row.Background = new SolidColorBrush(Color.FromArgb(0xFF, 0xFF, 0xFF, 0xFF));
            }
            else if (_Contract.ConOpcEstCod.Equals("C"))
            {
                e.Row.Background = new SolidColorBrush(Color.FromArgb(0xFF, 0xD3, 0xD3, 0xD3));
            }
            else if (_Contract.ConOpcEstCod.Equals("M"))
            {
                e.Row.Background = new SolidColorBrush(Color.FromArgb(0xFF, 0xC1, 0xC1, 0xC1));
            }
            else if (_Contract.ConOpcEstCod.Equals("N"))
            {
                e.Row.Background = new SolidColorBrush(Color.FromArgb(0xFF, 0x80, 0x80, 0x80));
            }
            else if (_Contract.ConOpcEstCod.Equals("P"))
            {
                e.Row.Background = new SolidColorBrush(Color.FromArgb(0xFF, 0xA9, 0xA9, 0xA9));
            }
            else if (_Contract.ConOpcEstCod.Equals("U"))
            {
                e.Row.Background = new SolidColorBrush(Colors.Red);
            }
            else if (_Contract.ConOpcEstCod.Equals("E"))
            {
                //e.Row.Background = new SolidColorBrush(Colors.Red);
            }
            else
            {
                e.Row.Background = new SolidColorBrush(Color.FromArgb(0xFF, 0xFF, 0xFF, 0xFF));
            }

        }

        private void Bnt_Refresh_Click(object sender, System.Windows.RoutedEventArgs e)
        {
            FormateaPantalla();
            Listar_Detalle_Movimiento();
        }

        public void ShowControls(EnumDetalleMovimiento value)
        {
            TipoDetalleMovimiento = value;
            HabilitarControlesBasicos();
        }

        private void HabilitarControlesBasicos()
        {
            List<string> _carga = new List<string>();

            switch (TipoDetalleMovimiento)
            {
                case EnumDetalleMovimiento.Init:
                    break;
                case EnumDetalleMovimiento.ConsultaMovimiento:
                    Bnt_Anular_Anticipo.IsEnabled = false;
                    Bnt_Anular_SDA.IsEnabled = false;
                    Tipo_Instancia = "MovDia";
                    break;
                case EnumDetalleMovimiento.ConsultaAnticipo:
                    Bnt_Anular_Anticipo.IsEnabled = false;
                    Bnt_Anular_SDA.IsEnabled = false;
                    Tipo_Instancia = "ConAnticipo";
                    break;
                case EnumDetalleMovimiento.AnulacionAnticipo:
                    Bnt_Anular_Anticipo.IsEnabled = true;
                    Bnt_Anular_Anticipo.IsEnabled = true;
                    Tipo_Instancia = "AnuAnticipo";
                    
                    List<string> _cargaAnu = new List<string>();
                    _cargaAnu.Add("Todos");
                    _cargaAnu.Add("Normal");
                    _cargaAnu.Add("Interna");
                    _cargaAnu.Add("Solicitud");

                    cmbTContra.ItemsSource = _cargaAnu;
                    cmbTContra.SelectedIndex = 0;
                    
                    break;
                case EnumDetalleMovimiento.ConsultaSDA:
                    Bnt_Anular_Anticipo.IsEnabled = false;
                    Bnt_Anular_SDA.IsEnabled = false;
                    this.Btn_ModificaSDA.IsEnabled = true;
                    Tipo_Instancia = "ConSDA";
                   
                    List<string> _cargaSDA = new List<string>();
                                      
                    _cargaSDA.Add("Solicitud");
                    _cargaSDA.Add("Leasing");

                    cmbTContra.ItemsSource = _cargaSDA;
                    cmbTContra.SelectedIndex = 0;
                    FormateaPantalla();                              
                    break;
                default:
                    break;
            }

            Habilitado = true;
            txtCliID.IsEnabled = true;
            cmbTContra.IsEnabled = true;
            dgPersona.IsEnabled = true;
        }

        private void DeshabilitarControles()
        {
            Bnt_Refresh.IsEnabled = false;
            Bnt_Anular_Anticipo.IsEnabled = false;
            txtCliID.IsEnabled = false;
            cmbTContra.IsEnabled = false;

            Habilitado = false;
            dgPersona.IsEnabled = false;
        }

        private void CloseCompleted(object sender, Liquid.DialogEventArgs e)
        {
            HabilitarControlesBasicos();
        }

        //PRD_13090
        private void Bnt_Anular_Sda_Click(object sender, System.Windows.RoutedEventArgs e)
        {
            string _Nombre = "";
            _Nombre = globales._Usuario;
            string Mensaje;

            List<StructMoContrato> _ListImp = PreparaAnulacionAnticipo();

            if (_ListImp[0].ConOpcEstDsc.Equals("VIGENTE"))
            {
                if (_ListImp != null)
                {
                    if (_ListImp.Count > 0)
                    {
                        foreach (StructMoContrato _values in _ListImp)
                        {
                            Mensaje = string.Format(" Se anulará Solicitud del  contrato N° {0}\t Folio: {1}\t  \n", _values.NumContrato, _values.NumFolio);
                            System.Windows.Browser.HtmlPage.Window.Alert(Mensaje);
                           
                            sva.AnulaSDAAsync(_values.NumContrato, _values.NumFolio);              
                        }
                    }
                }
            }
            else
            {
                System.Windows.Browser.HtmlPage.Window.Alert("Solo se anula solicitud con estado Vigente.");
                return;
            }
        }

        //PRD_13090
        void sva_AnulaSDACompleted(object sender, AdminOpciones.SrvAcciones.AnulaSDACompletedEventArgs e)
        {
            string _xmlResult = e.Result.ToString();

            if (_xmlResult == "SI")
            {
                System.Windows.Browser.HtmlPage.Window.Alert("Se anulo solicitud de forma correcta");
            }
            else
            {
                System.Windows.Browser.HtmlPage.Window.Alert("Ocurrio un error al intentar Anular solicitud");
            }
        }

        private void popUpEjercerFuturo_SizeChanged(object sender, System.Windows.SizeChangedEventArgs e)
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

        private void CloseCompletedSDA(object sender, Liquid.DialogEventArgs e)
        {
            dgPersona.IsEnabled = true;
        }

        private void Btn_ModificaSDA_Click(object sender, System.Windows.RoutedEventArgs e)
        {
            try
            {
                _IngSolicitudSDA.TxtNumFolio.IsEnabled = false;
                _IngSolicitudSDA.btnAceptarGuardar.IsEnabled = false;
                _IngSolicitudSDA.TxtNominal.IsEnabled = false;
                _IngSolicitudSDA.TxtSumaSolicitud.IsEnabled = false;
                _IngSolicitudSDA.DtFechaVencimiento.IsEnabled = false;

                if (ContraList != null)
                {
                    if (Habilitado)
                    {
                        ListMovimiento = new List<StructMoContrato>();
                        ListMovimiento = ContraList.Where(_Element => _Element.VF == "True").ToList();

                        if (ListMovimiento.Count == 1)
                        {
                            _IngSolicitudSDA.TxtNumFolio.Text = ListMovimiento[0].NumFolio;
                        }
                        else
                        {
                            System.Windows.Browser.HtmlPage.Window.Alert("Debe seleccionar una Solicitud");
                            return;
                        }
                    }
                }
                else
                {
                    string Mensaje = "No existen solicitudes";
                    System.Windows.Browser.HtmlPage.Window.Alert(Mensaje);
                }
            }
            catch
            {
                System.Windows.Browser.HtmlPage.Window.Alert("Error al leer Numero de Folio");
                return;
            }

            try
            {              
                _SrvLoadFront.LoadFrontDataAsync("Do");//modificar el 142
            }
            catch
            {
                System.Windows.Browser.HtmlPage.Window.Alert("Error al leer Formas de pago");
                return;
            }
        }

        private void _SrvLoadFront_LoadFrontDataCompleted(object sender, AdminOpciones.SrvLoadFront.LoadFrontDataCompletedEventArgs e)
        {
            #region Forma Pago
            try
            {
                string resultValue = e.Result.ToString();

                XDocument xdocLoadData = new XDocument(XDocument.Parse(resultValue));

               

                    var DataFormaDePago = from itemDataLoad in xdocLoadData.Descendants("DataFormaDePago")
                                          select new StructMonedaFormaPago
                                          {
                                              CodigoMoneda = int.Parse(itemDataLoad.Attribute("Moneda").Value.ToString()),
                                              Codigo = itemDataLoad.Attribute("FormaDePagoCod").Value.ToString(),
                                              Descripcion = itemDataLoad.Attribute("FormaDePagoDsc").Value.ToString(),
                                              Valor = double.Parse(itemDataLoad.Attribute("FormaDePagoValuta").Value.ToString())
                                          };
                    formaDePagoList = DataFormaDePago.ToList();
              
            }                                
            catch
            {
                System.Windows.Browser.HtmlPage.Window.Alert("Error al cargar Formas de pago en solicitud");
                return;
            }
            #endregion

            if (Modalidad.Count > 1)
            {
                Modalidad.Clear();
            }

            Modalidad.Add(new _Modalidad("ENTREGA FISICA", "E"));
            Modalidad.Add(new _Modalidad("COMPENSADO", "C"));

            _IngSolicitudSDA.DtFechaIngreso.IsEnabled = false;


            try
            {
                if (_IngSolicitudSDA.TxtNumFolio.Text == "")
                {
                    System.Windows.Browser.HtmlPage.Window.Alert("Debe seleccionar nuevamente la solicitud");
                    return;
                }
                else
                {
                    svc.Trae_SDAAsync(_IngSolicitudSDA.TxtNumFolio.Text);
                }
            }
            catch
            {
                System.Windows.Browser.HtmlPage.Window.Alert("Error al Traer solicitud");
                return;
            }
        }
        //13090
        void svc_Trae_SDACompleted(object sender, AdminOpciones.SrvDetalles.Trae_SDACompletedEventArgs e)
        {
            try
            {
                #region Validacion Cantera

                string _xmlResult = e.Result.ToString();
                string NumContrato = "";
                string FechaIngreso = "";
                string MontoSolicitud = "";
                string FechaVencSolicitud = "";
                string FormaPago = "";
                string ModalidadPago = "";
                string EstadoSolicitud = "";
                string NumSolicitud = "";

                XDocument xmlResult = new XDocument();
                xmlResult = XDocument.Parse(_xmlResult);

                IEnumerable<XElement> elements = xmlResult.Element("Result").Elements("Status").Elements("Item");
                foreach (XElement element in elements)
                {
                    NumContrato = element.Attribute("NUM_CONTRATO").Value.ToString() == "" ? "0" : element.Attribute("NUM_CONTRATO").Value.ToString();
                    FechaIngreso = element.Attribute("FECHA_INGRESO").Value.ToString();
                    FechaVencSolicitud = element.Attribute("FECHA_ACTIVACION").Value.ToString();
                    MontoSolicitud = element.Attribute("MONTO_SOLICITUD").Value.ToString();
                    FormaPago = element.Attribute("FORMA_PAGO").Value.ToString();
                    ModalidadPago = element.Attribute("TIPO_ANTICIPO").Value.ToString();
                    EstadoSolicitud = element.Attribute("ESTADO_SOLICITUD").Value.ToString();
                    NumSolicitud = element.Attribute("NUM_SOLICITUD").Value.ToString();
                }

                if (EstadoSolicitud != "V")
                {
                    System.Windows.Browser.HtmlPage.Window.Alert("Solicitud N°" + NumSolicitud + " de Contrato N°" + NumContrato + " no se encuentra vigente");
                    return;
                }
                else
                {
                    _IngSolicitudSDA.TxtNumContrato.Text = NumContrato;
                    _IngSolicitudSDA.DtFechaActivacion.Text = Convert.ToDateTime(FechaVencSolicitud).ToString("dd/MM/yyyy");
                    _IngSolicitudSDA.DtFechaIngreso.Text = Convert.ToDateTime(FechaIngreso).ToString("dd/MM/yyyy");
                    _IngSolicitudSDA.TxtMontoAnticipo.Text = MontoSolicitud;

                    #region Forma de Pago
                    for (int i = 0; i < formaDePagoList.Count; i++)
                    {

                        if (formaDePagoList[i].Codigo == FormaPago)
                        {
                            _IngSolicitudSDA.CmbFormpago.SelectedIndex = i;
                        }


                    }
                    #endregion
                    #region Tipo de Anticipo
                    for (int i = 0; i < Modalidad.Count; i++)
                    {

                        if (Modalidad[i].Identidicador == ModalidadPago)
                        {
                            _IngSolicitudSDA.CmbTipoAnticipo.SelectedIndex = i;
                        
                        }

                    }
                    #endregion

                    svc.ConsultaOperacionAsync(NumContrato);

                   
                }

                #endregion
            }
            catch
            {
                System.Windows.Browser.HtmlPage.Window.Alert("Error al traer solicitud");
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

      
        private void cmbTContraGotFocus(object sender, RoutedEventArgs e)
        {          
            //FormateaPantalla();
            //Listar_Detalle_Movimiento();
        }

        private void FormateaPantalla()
        {
            if (cmbTContra.SelectionBoxItem != null)
            {
                switch (cmbTContra.SelectionBoxItem.ToString())
                {
                    case "Leasing":
                        dgPersona.Columns[2].Header = "Número Leasing";
                        dgPersona.Columns[5].Header = "Número Bien";
                        dgPersona.Columns[10].Header = "Solicitud SDA";
                        dgPersona.Columns[13].Header = "Fecha Vencimiento";
                        break;

                    case "Solicitud":
                        dgPersona.Columns[2].Header = "Número Solicitud";
                        dgPersona.Columns[5].Header = "Estado";
                        dgPersona.Columns[10].Header = "Relación Leasing";
                        dgPersona.Columns[13].Header = "Fecha Activación";
                        break;
                }
            }
        }

    }
}
