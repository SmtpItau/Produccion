using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Linq;
using System.Windows.Controls;
using System.Windows.Input;
using System.Windows.Media.Imaging;
using System.Xml.Linq;
using AdminOpciones.Struct;
using AdminOpciones.Recursos;
using System.Windows.Browser;
using System.Windows;
using Liquid;

namespace AdminOpciones.Controls
{
    public partial class CondicionesGenerales : UserControl
    {
        AdminOpciones.SrvAcciones.WebAccionesSoapClient sva = wsGlobales.Acciones;
        AdminOpciones.SrvDetalles.WebDetallesSoapClient svc = wsGlobales.Detalles;

        public string XmlResultContra_;
        XDocument _xml = new XDocument();
        XDocument xmlResult = new XDocument();
        private List<StructCondicionesGenerales> _CondList;
        private ObservableCollection<StructCondicionesGenerales> CondList;
        private ObservableCollection<StructCondicionesGenerales> pCondlist;
        private bool estado_ = false;
        public string result_;
        private bool Habilitado = true;

        public CondicionesGenerales()
        {
            InitializeComponent();

            //IAF 24/11/2009 nueva forma de cargar cartera de clientes, debido ha que se queria filtrar aqui en condiciones generales.
            ctrCliente.isCondicionesGenerales = true;
            ctrCliente.Load();

            svc.CondicionesGeneralesCompleted += new System.EventHandler<AdminOpciones.SrvDetalles.CondicionesGeneralesCompletedEventArgs>(_svc_CondicionesGeneralesCompleted);
            sva.InsertCondicionesCompleted += new EventHandler<AdminOpciones.SrvAcciones.InsertCondicionesCompletedEventArgs>(sva_InsertCondicionesCompleted);
            this.dgCondiciones.MouseLeftButtonUp += new MouseButtonEventHandler(dgCondiciones_SelectionChanged);
        }       

        public class ListaCondiciones
        {
            public string rut { get; set; }
            public string codigo { get; set; }
            public string fecha { get; set; }
            public string fechaSupl { get; set; }
            public string fechaChk { get; set; }
            public string fechaChkSupl { get; set; }
            
            public override string ToString()
            {
                return string.Format("{0}|{1}|{2}|{3}|{4}|{5}", new object[] { rut, codigo, fecha, fechaSupl, fechaChk, fechaChkSupl });
            }
        }

        public class _Resultado_Estado
        {
            public string Result { get; set; }
        }

        void sva_InsertCondicionesCompleted(object sender, AdminOpciones.SrvAcciones.InsertCondicionesCompletedEventArgs e)
        {
            string _xmlResult = e.Result.ToString();
            xmlResult = XDocument.Parse(_xmlResult);
            List<_Resultado_Estado> _data = new List<_Resultado_Estado>();

            IEnumerable<XElement> elements = xmlResult.Element("Resultado").Elements("Data");
            foreach (XElement element in elements)
            {
                _Resultado_Estado _sData = new _Resultado_Estado();
                _sData.Result = element.FirstAttribute.Value.ToString();
                result_ = _sData.Result;
            }

            if (result_ != "-1")
            {
                string Mensaje = "Grabación de Condiciones Generales Realizada";
                System.Windows.Browser.HtmlPage.Window.Alert(Mensaje);
            }
            else
            {
                string Mensaje = "Error: No se pudo Realizar la Grabación";
                System.Windows.Browser.HtmlPage.Window.Alert(Mensaje);
            }
        }

        void _svc_CondicionesGeneralesCompleted(object sender, AdminOpciones.SrvDetalles.CondicionesGeneralesCompletedEventArgs e)
        {            
            XmlResultContra_ = e.Result;
            if (XmlResultContra_.Length > 0)
            {
                _ConvierteXMl(XmlResultContra_);
                if (CondList.Count > 0)
                {
                    _Ejecuta(true);                    
                }
            }
            else 
            {
                _Ejecuta(false);
            }
        }

        private void Procesar_Condiciones(object sender, RoutedEventArgs e)
        {
            if (Habilitado)
            {
                List<ListaCondiciones> ListaDatoCond = new List<ListaCondiciones>();
                foreach (StructCondicionesGenerales _Aux in _CondList)
                {
                    ListaCondiciones ListaDatos_ = new ListaCondiciones();

                    ListaDatos_.rut = _Aux.ClRut;
                    ListaDatos_.codigo = _Aux.ClCodigo;
                    ListaDatos_.fecha = _Aux.ClFechaFirma_Cond_Opc;
                    ListaDatos_.fechaSupl = _Aux.ClFechaFirma_Supl_Opc;

                    if (_Aux.Chk_Cond == "True")
                    {
                        ListaDatos_.fechaChk = "1";
                    }
                    else { ListaDatos_.fechaChk = "0"; }

                    if (_Aux.Chk_Supl == "True")
                    {
                        ListaDatos_.fechaChkSupl = "1";
                    }
                    else { ListaDatos_.fechaChkSupl = "0"; }

                    ListaDatoCond.Add(ListaDatos_);
                }

                ProcesarCondiciones(ListaDatoCond);
            }
        }

        void ProcesarCondiciones(List<ListaCondiciones> ListaCond_)
        {
            List<string> _valor = new List<string>();

            foreach (ListaCondiciones _Aux in ListaCond_)
            {
                ListaCondiciones ListaDatos_ = new ListaCondiciones();
                
                    ListaDatos_.rut = _Aux.rut;
                    ListaDatos_.codigo = _Aux.codigo;
                    ListaDatos_.fecha = _Aux.fecha;
                    ListaDatos_.fechaSupl = _Aux.fechaSupl;
                    ListaDatos_.fechaChk = _Aux.fechaChk;
                    ListaDatos_.fechaChkSupl = _Aux.fechaChkSupl;

                    _valor.Add(ListaDatos_.ToString());
            }

            sva.InsertCondicionesAsync(_valor.ToArray());
        }

        void _ConvierteXMl(string strXML_)
        {
            _xml = XDocument.Parse(strXML_);
            var condiciones_ = from xmlCondiciones_ in _xml.Descendants("Data")
                               select new StructCondicionesGenerales
                               {                                   
                                   ClRut = xmlCondiciones_.Attribute("ClRut").Value.ToString(),
                                   ClDV = xmlCondiciones_.Attribute("ClDV").Value.ToString(),
                                   ClNombre = xmlCondiciones_.Attribute("ClNombre").Value.ToString(),
                                   ClFechaFirma_Cond_Opc = xmlCondiciones_.Attribute("ClFechaFirma_Cond_Opc").Value.ToString(),
                                   ClFechaFirma_Cond_OpcChk = xmlCondiciones_.Attribute("ClFechaFirma_Cond_OpcChk").Value.ToString(),
                                   ClFechaFirma_Supl_Opc = xmlCondiciones_.Attribute("ClFechaFirma_Supl_Opc").Value.ToString(),
                                   ClFechaFirma_Supl_OpcChk = xmlCondiciones_.Attribute("ClFechaFirma_Supl_OpcChk").Value.ToString(),
                                   ClCodigo = xmlCondiciones_.Attribute("ClCodigo").Value.ToString()                                   
                               };
            CondList = new ObservableCollection<StructCondicionesGenerales>();
            pCondlist = new ObservableCollection<StructCondicionesGenerales>();
            _CondList = new List<StructCondicionesGenerales>(condiciones_.ToList<StructCondicionesGenerales>());
            foreach (StructCondicionesGenerales _Aux in _CondList)
            {
                CondList.Add(_Aux);
                pCondlist.Add(_Aux);
            }

            int _Row = 0;

            if (CondList.Count > 0)
            {
                for (_Row = 0; _Row < CondList.Count; _Row++)
                {
                    CondList[_Row].VF = "False";

                    if (Convert.ToInt32(CondList[_Row].ClFechaFirma_Cond_OpcChk) == 1)
                    {
                        CondList[_Row].Chk_Cond = "True";
                    }
                    else
                    { CondList[_Row].Chk_Cond = "False"; }

                    if (Convert.ToInt32(CondList[_Row].ClFechaFirma_Supl_OpcChk) == 1)
                    {
                        CondList[_Row].Chk_Supl = "True";
                    }
                    else
                    { CondList[_Row].Chk_Supl = "False"; }
                }
            }

        }

        private void Filtro_MouseLeftButtonUp(object sender, MouseButtonEventArgs e)
        {
            if (Habilitado)
            {
                svc.CondicionesGeneralesAsync();
            }
        }

        void _Ejecuta(bool result_) 
        {
            if (result_)
            {
                if (estado_)
                {
                    CondList.Clear();
                    foreach (StructCondicionesGenerales _aux in pCondlist)
                    {
                        CondList.Add(_aux);
                    }
                    ToolTipService.SetToolTip(Filtro, "Filtrar");
                    BitmapImage _Imagen = new BitmapImage();
                    _Imagen.UriSource = new Uri("../Images/player_play.png", UriKind.Relative);
                    Filtro.Source = _Imagen;
                    dgCondiciones.UpdateLayout();
                    UpdateLayout();
                    estado_ = false;

                    dgCondiciones.ItemsSource = CondList;
                    ctrCliente.autoCompleteBoxNombre.Text = string.Empty;
                    ctrCliente.autoCompleteBoxRut.Text = string.Empty;
                    ctrCliente.comboCodigoRut.SelectedIndex = -1;
                }
                else
                {
                    string rut_ = ctrCliente.autoCompleteBoxRut.Text != null ? ctrCliente.autoCompleteBoxRut.Text : "";                    
                    int _i = ctrCliente.comboCodigoRut.SelectedIndex;                    
                    string nombre_ = ctrCliente.autoCompleteBoxNombre.Text != null ? ctrCliente.autoCompleteBoxNombre.Text : "";
                    string dv_ = string.Empty;

                    if (_i > -1)
                        dv_ = ctrCliente.comboCodigoRut.SelectedItem.ToString();

                    if (rut_ != "" && nombre_ != "")
                    {
                        var _p = from _ps in CondList
                                 where _ps.ClRut.Equals(rut_) && _ps.ClCodigo.Equals(dv_)
                                 select _ps;

                        int _cont = _p.Count<StructCondicionesGenerales>();
                        if (_cont > 0)
                        {
                            _CondList.Clear();
                            _CondList = new List<StructCondicionesGenerales>(_p.ToList<StructCondicionesGenerales>());
                            CondList.Clear();
                            foreach (StructCondicionesGenerales _Aux in _CondList)
                            {
                                CondList.Add(_Aux);
                            }

                            dgCondiciones.ItemsSource = CondList;

                            ToolTipService.SetToolTip(Filtro, "Quitar Filtro");
                            BitmapImage _Imagen = new BitmapImage();
                            _Imagen.UriSource = new Uri("../Images/player_stop.png", UriKind.Relative);
                            this.Filtro.Source = _Imagen;
                            dgCondiciones.UpdateLayout();
                            this.UpdateLayout();
                            estado_ = true;
                        }
                    }
                    else 
                    {
                        dgCondiciones.ItemsSource = CondList;
                        string m_ = "Actualmente se esta desplegando toda la informacion ya que no existen filtros asociados";
                        System.Windows.Browser.HtmlPage.Window.Alert(m_);
                    }
                }
            }
        }

        private void Imprimir_Click(object sender, System.Windows.Input.MouseButtonEventArgs e)
        {
            if (Habilitado)
            {
                DeshabilitarControles();
                string _Nombre = "";
                _Nombre = globales._Usuario;

                List<StructCondicionesGenerales> _ListImp = PreparaImpresion();
                if (_ListImp.Count > 0)
                {
                    foreach (StructCondicionesGenerales _values in _ListImp)
                    {
                        List<KeyValuePair<string, string>> lst_ = new List<KeyValuePair<string, string>>();

                        // MAP Julio 22
                        lst_.Add(new KeyValuePair<string, string>("Rut", _values.ClRut));
                        lst_.Add(new KeyValuePair<string, string>("Codigo", _values.ClCodigo));
                        lst_.Add(new KeyValuePair<string, string>("RepName", "~/CrystalReportes/ContratoLegal_CondGeneral.rpt"));
                        lst_.Add(new KeyValuePair<string, string>("Tipo", "CondicionGeneral"));
                        lst_.Add(new KeyValuePair<string, string>("Usuario", _Nombre));
                        lst_.Add(new KeyValuePair<string, string>("RutRepCli01", "0"));
                        lst_.Add(new KeyValuePair<string, string>("RutRepCli02", "0"));
                        lst_.Add(new KeyValuePair<string, string>("RutRepBan01", "0"));
                        lst_.Add(new KeyValuePair<string, string>("RutRepBan02", "0"));

                        this.ProcessCommand(lst_.ToArray());
                    }
                }
                HabilitarControles();
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

        private List<StructCondicionesGenerales> PreparaImpresion()
        {
            List<StructCondicionesGenerales> _List = new List<StructCondicionesGenerales>();
            if (CondList != null)
            {
                if (CondList.Count > 0)
                {
                    foreach (StructCondicionesGenerales _Aux in CondList)
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
                return _List; ;
            }
        }

        private void dgCondiciones_CurrentCellChanged(object sender, EventArgs e) 
        {
 
        }

        private void dgCondiciones_SelectionChanged(object sender, MouseEventArgs e)
        {
            if (((DataGrid)sender).ItemsSource!= null && ((DataGrid)sender).CurrentColumn.DisplayIndex.Equals(0))
            {
                if (dgCondiciones.SelectedIndex >= 0)
                {
                    StructCondicionesGenerales _Condiciones = (StructCondicionesGenerales)dgCondiciones.SelectedItem;

                    CheckBox _chkControl = (CheckBox)dgCondiciones.Columns[0].GetCellContent(dgCondiciones.SelectedItem);
                    _chkControl.IsChecked = !_chkControl.IsChecked;
                    _Condiciones.VF = _chkControl.IsChecked.ToString();
                    //ContraList[_Row].Impreso = "S";
                    dgCondiciones.ItemsSource = CondList;
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

            ctrCliente.IsEnabled = true;
            dgCondiciones.IsEnabled = true;
        }

        private void DeshabilitarControles()
        {
            Habilitado = false;

            ctrCliente.IsEnabled = false;
            dgCondiciones.IsEnabled = false;
        }

        private void Key_Down_Event(object sender, KeyEventArgs e)
        {
            #region Copy uisng Ctrl-C

            if (e.Key == Key.C &&
                ((Keyboard.Modifiers & ModifierKeys.Control) == ModifierKeys.Control
                || (Keyboard.Modifiers & ModifierKeys.Apple) == ModifierKeys.Apple)
                )
            {
                string textData = "";
                DataGrid Data = sender as DataGrid;

                #region Head

                string _TextColumn = "";

                foreach (DataGridColumn _Column in Data.Columns)
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

                foreach (StructCondicionesGenerales _Item in (ObservableCollection<StructCondicionesGenerales>)Data.ItemsSource)
                {
                    textData += string.Format(
                                               "{0}\t{1}\t{2}\t{3}\t{4}\t{5}\t{6}\t{7}\n",                                               
                                               _Item.sClRut,
                                               _Item.sClDV,
                                               _Item.sClNombre,
                                               _Item.sClFechaFirma_Cond_Opc,
                                               _Item.sChk_Cond,
                                               _Item.sClFechaFirma_Supl_Opc,
                                               _Item.sChk_Supl,
                                               _Item.sClCodigo 
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
                    System.Windows.Browser.HtmlPage.Window.Alert("Sorry, this functionality is only avaliable in Internet Explorer.");
                    return;
                }

                #endregion

            }

            #endregion
        }

        private void chkCond_Click(object sender, RoutedEventArgs e)
        {            
            DateTime date;
            StructCondicionesGenerales rowDara;               
            CheckBox chk = ((CheckBox)sender);
            
            rowDara = chk.Tag as StructCondicionesGenerales;
            DateTime.TryParse(rowDara.sClFechaFirma_Cond_Opc, out date);
            if (date.CompareTo(new DateTime(1990, 1, 1)) <= 0)
            {
                chk.IsChecked = false; 
            }
        }

        private void chkSupl_Click(object sender, RoutedEventArgs e)
        {
            DateTime date;
            StructCondicionesGenerales rowDara;
            CheckBox chk = ((CheckBox)sender);
            
            rowDara = chk.Tag as StructCondicionesGenerales;
            DateTime.TryParse(rowDara.sClFechaFirma_Supl_Opc, out date);
            if (date.CompareTo(new DateTime(1990, 1, 1)) <= 0)
            {
                chk.IsChecked = false;
            }
        }

    }
}