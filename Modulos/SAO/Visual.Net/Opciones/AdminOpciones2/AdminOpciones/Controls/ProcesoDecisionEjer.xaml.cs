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

namespace AdminOpciones.Controls
{
    public partial class ProcesoDecisionEjer : UserControl
    {

        AdminOpciones.SrvAcciones.WebAccionesSoapClient sva = wsGlobales.Acciones; 
        private AdminOpciones.SrvDetalles.WebDetallesSoapClient svc = wsGlobales.Detalles;
        
        private List<StructProcesoDecisionEjer> _ContraList;
        private ObservableCollection<StructProcesoDecisionEjer> ContraList;
        private XDocument xmlContratos = new XDocument();
        private XDocument xmlResult = new XDocument();
        private XDocument xmlResultFecha = new XDocument();
        public string XmlResultFechaAntH;
        public string XmlResultContra;
        public string FechaProc;
        public string tag = "";
        public string Fecha = "";
        private bool _Estado = false;
        private bool Habilitado = true;

        public ProcesoDecisionEjer()
        {
            InitializeComponent();
            svc.FechaAntHCompleted += new EventHandler<AdminOpciones.SrvDetalles.FechaAntHCompletedEventArgs>(svc_FechaAntHCompleted);
            svc.DecisionEjercicioCompleted += new EventHandler<AdminOpciones.SrvDetalles.DecisionEjercicioCompletedEventArgs>(svc_DecisionEjercicioCompleted);
            sva.ActualizaEstadoDecisionEjCompleted += new EventHandler<AdminOpciones.SrvAcciones.ActualizaEstadoDecisionEjCompletedEventArgs>(sva_ActualizaEstadoDecisionEjCompleted);
            this.dgPersona.MouseLeftButtonUp += new MouseButtonEventHandler(dgPersona_SelectionChanged);
            // MAP 17 Septiembre No pasaba la fecha correctamente al sp asociado
            CalculaFechaAnt(Convert.ToDateTime(Convert.ToString(globales._FechaProceso)).ToString("yyyyMMdd"), Convert.ToDateTime(Convert.ToString(globales._FechaProceso)).ToString("yyyyMMdd"));
            LoadData();
        }

        private void LoadData()
        {
            svc.DecisionEjercicioAsync(Convert.ToDateTime(Convert.ToString(globales._FechaProceso)).ToString("yyyyMMdd"), Convert.ToDateTime(Convert.ToString(globales._FechaProceso)).ToString("yyyyMMdd"), 0, 0, globales._Usuario);
        }

        public class ListaDecisionEj
        {

            public string contrato { get; set; }
            public string numestruct { get; set; }
            public string cajfolio { get; set; }
            public string usuario { get; set; }
            public string estado { get; set; }

            public string vf { get; set; }

            public override string ToString()
            {
                return string.Format("{0}|{1}|{2}|{3}|{4}|{5}", new object[] { contrato, numestruct, cajfolio, usuario, estado, vf });
            }
        }

        public class _Resultados_Estado
        {
            public string Estado { get; set; }
            public string Mensaje { get; set; }

            public override string ToString()
            {
                return string.Format("?Estado={0}&Mensaje={1}", Estado, Mensaje);
            }
        }

        public class _FechaAnterior
        {
            public string Fecha { get; set; }
        }

        private void CalculaFechaAnt(string F1, string F2)
        {
            svc.FechaAntHAsync(F1, F2);
        }

        private void svc_FechaAntHCompleted(object sender, AdminOpciones.SrvDetalles.FechaAntHCompletedEventArgs e)
        {
            DateTime SumaDia = new DateTime();
            string _xmlResult = e.Result.ToString();
            xmlResult = XDocument.Parse(_xmlResult);
            List<_FechaAnterior> _data = new List<_FechaAnterior>();

            IEnumerable<XElement> elements = xmlResult.Element("FechaAntH").Elements("Data");
            foreach (XElement element in elements)
            {
                _FechaAnterior _sData = new _FechaAnterior();
                _sData.Fecha = element.FirstAttribute.Value.ToString();
                Fecha = _sData.Fecha;
            }

            SumaDia = Convert.ToDateTime(Fecha).AddDays(1);
            Dt_FechaDesde.Text = Convert.ToDateTime(SumaDia).ToString("dd-MM-yyyy");

        }

        private void svc_DecisionEjercicioCompleted(object sender, AdminOpciones.SrvDetalles.DecisionEjercicioCompletedEventArgs e)
        {
            XmlResultContra = e.Result;
            if (XmlResultContra.Length > 0)
            {
                ContratoEj(XmlResultContra);
                if (ContraList.Count > 0)
                {
                    dgPersona.ItemsSource = ContraList;
                }
            }
        }

        private void sva_ActualizaEstadoDecisionEjCompleted(object sender, AdminOpciones.SrvAcciones.ActualizaEstadoDecisionEjCompletedEventArgs e)
        {
            DeshabilitarControles();
            string _xmlResult = e.Result.ToString();
            xmlResult = XDocument.Parse(_xmlResult);
            List<_Resultados_Estado> _data = new List<_Resultados_Estado>();

            IEnumerable<XElement> elements = xmlResult.Element("Resultado").Elements("Data");
            foreach (XElement element in elements)
            {
                _Resultados_Estado _sData = new _Resultados_Estado();
                _sData.Estado = element.FirstAttribute.Value.ToString();
                _sData.Mensaje = element.LastAttribute.Value.ToString();

                _data.Add(_sData);
            }
            _gridresu.ItemsSource = _data;
            _pop.Show();
            LoadData();
        }

        private void ContratoEj(string strXMLContra)
        {
            xmlContratos = XDocument.Parse(strXMLContra);
            var GridDecision = from ContraEjXML in xmlContratos.Descendants("Data")
                               select new StructProcesoDecisionEjer
                               {
                                   VF = ContraEjXML.Attribute("VF").Value.ToString(),
                                   NumContrato = ContraEjXML.Attribute("NumContrato").Value.ToString(),
                                   FechaPagoEjer = ContraEjXML.Attribute("FechaPagoEjer").Value.ToString(),
                                   ModalidadDsc = ContraEjXML.Attribute("ModalidadDsc").Value.ToString(),
                                   CliRut = ContraEjXML.Attribute("CliRut").Value.ToString(),
                                   CliDv = ContraEjXML.Attribute("CliDv").Value.ToString(),
                                   CliCod = ContraEjXML.Attribute("CliCod").Value.ToString(),
                                   CliNom = ContraEjXML.Attribute("CliNom").Value.ToString(),
                                   NumComponente = ContraEjXML.Attribute("NumComponente").Value.ToString(),
                                   NumCajFolio = ContraEjXML.Attribute("NumCajFolio").Value.ToString(),
                                   PayOffTipCod = ContraEjXML.Attribute("PayOffTipCod").Value.ToString(),
                                   PayOffTipDsc = ContraEjXML.Attribute("PayOffTipDsc").Value.ToString(),
                                   CompraVentaOpcDsc = ContraEjXML.Attribute("CompraVentaOpcDsc").Value.ToString(),
                                   MdaRecibirDsc = ContraEjXML.Attribute("MdaRecibirDsc").Value.ToString(),
                                   FormaPagoRecibirDsc = ContraEjXML.Attribute("FormaPagoRecibirDsc").Value.ToString(),
                                   MontoRecibir = ContraEjXML.Attribute("MontoRecibir").Value.ToString(),
                                   MdaPagarDsc = ContraEjXML.Attribute("MdaPagarDsc").Value.ToString(),
                                   FormaPagoPagarDsc = ContraEjXML.Attribute("FormaPagoPagarDsc").Value.ToString(),
                                   MontoPagar = ContraEjXML.Attribute("MontoPagar").Value.ToString(),
                                   MTMImplicito = ContraEjXML.Attribute("MTMImplicito").Value.ToString(),
                                   EstadoEjercicioDsc = ContraEjXML.Attribute("EstadoEjercicioDsc").Value.ToString()
                               };

            ContraList = new ObservableCollection<StructProcesoDecisionEjer>();
            _ContraList = new List<StructProcesoDecisionEjer>(GridDecision.ToList<StructProcesoDecisionEjer>());

            foreach (StructProcesoDecisionEjer _Aux in _ContraList)
            {
                ContraList.Add(_Aux);
            }
        }

        private void Listar_Detalle_DecisionEje()
        {
            // AMP 17 Septiembre 2009 Formato de fecha no pasa correctamente los parametros se sacan los slash
            string _fDesde = Convert.ToDateTime(Convert.ToString(Dt_FechaDesde)).ToString("yyyyMMdd");
            string _fHasta = Convert.ToDateTime(Convert.ToString(Dt_FechaHasta)).ToString("yyyyMMdd");

            svc.DecisionEjercicioAsync(_fDesde, _fHasta, Convert.ToInt32(txtCliRut.Text), Convert.ToInt32(txtCliCod.Text), globales._Usuario);

        }

        private void Buscar_Click(object sender, RoutedEventArgs e)
        {
            Listar_Detalle_DecisionEje();
        }

        private void dgPersona_SelectionChanged(object sender, MouseEventArgs e)
        {

            int _Row;
            StructProcesoDecisionEjer _GridDecision = new StructProcesoDecisionEjer();
            CheckBox _chkControl;
            _Row = dgPersona.SelectedIndex;
            if (_Row >= 0)
            {
                _GridDecision = dgPersona.SelectedItem as StructProcesoDecisionEjer;
                _chkControl = dgPersona.Columns[0].GetCellContent(dgPersona.SelectedItem) as CheckBox;
                _chkControl.IsChecked = !_chkControl.IsChecked;
                _GridDecision.VF = _chkControl.IsChecked.ToString();
                //ContraList[_Row].VF = _chkControl.IsChecked.ToString();
            }
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

        private void NoEjercer_Click(object sender, RoutedEventArgs e)
        {
            tag = btn_NoEjercer.Tag.ToString();
            List<ListaDecisionEj> ListaDatoFix = Prepara(tag);
            ProcesarFijacion(ListaDatoFix);
        }

        // MAP 17 Septiembre se programa el nuevo boton
        private void Ejercer_Click(object sender, RoutedEventArgs e)
        {
            tag = btn_Ejercer.Tag.ToString();
            List<ListaDecisionEj> ListaDatoFix = Prepara(tag);
            ProcesarFijacion(ListaDatoFix);
        }

        private void Pendiente_Click(object sender, RoutedEventArgs e)
        {
            tag = btn_OpcPend.Tag.ToString();
            List<ListaDecisionEj> ListaDatoFix = Prepara(tag);
            ProcesarFijacion(ListaDatoFix);
        }

        private List<ListaDecisionEj> Prepara(string Tag)
        {
            List<ListaDecisionEj> _List = new List<ListaDecisionEj>();
            ObservableCollection<StructProcesoDecisionEjer> _ContraList = new ObservableCollection<StructProcesoDecisionEjer>();
            _ContraList = (ObservableCollection<StructProcesoDecisionEjer>)dgPersona.ItemsSource;

            foreach (StructProcesoDecisionEjer _Aux in ContraList)
            {
                ListaDecisionEj ListaDatos_ = new ListaDecisionEj();

                ListaDatos_.contrato = _Aux.NumContrato;
                ListaDatos_.numestruct = _Aux.NumComponente;
                ListaDatos_.cajfolio = _Aux.NumCajFolio;
                ListaDatos_.usuario = globales._Usuario;
                ListaDatos_.estado = Tag;
                ListaDatos_.vf = _Aux.VF;

                if (ListaDatos_.vf == "True")
                {
                    _List.Add(ListaDatos_);
                }

            }
            return _List;
        }

        private void ProcesarFijacion(List<ListaDecisionEj> Listafix_)
        {

            List<string> _valor = new List<string>();

            if (Listafix_.Count > 0)
            {
                foreach (ListaDecisionEj _Aux in Listafix_)
                {

                    ListaDecisionEj ListaDatos_ = new ListaDecisionEj();
                    ListaDatos_.contrato = _Aux.contrato;
                    ListaDatos_.numestruct = _Aux.numestruct;
                    ListaDatos_.cajfolio = _Aux.cajfolio;
                    ListaDatos_.usuario = _Aux.usuario;
                    ListaDatos_.estado = _Aux.estado;
                    ListaDatos_.vf = _Aux.vf;
                    _valor.Add(ListaDatos_.ToString());
                }

                sva.ActualizaEstadoDecisionEjAsync(_valor.ToArray());

            }

            else
            {
                string Mensaje = "No existen contratos seleccionados para cambiar Decision de Ejercicio";
                System.Windows.Browser.HtmlPage.Window.Alert(Mensaje);
                return;
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
            btn_cargar.IsEnabled = true;
            btn_NoEjercer.IsEnabled = true;
            btn_Ejercer.IsEnabled = true;
            btn_OpcPend.IsEnabled = true;
            dgPersona.IsEnabled = true;
        }

        private void DeshabilitarControles()
        {
            Habilitado = false;

            txtCliRut.IsEnabled = false;
            txtCliCod.IsEnabled = false;
            Dt_FechaDesde.IsEnabled = false;
            Dt_FechaHasta.IsEnabled = false;
            btn_cargar.IsEnabled = false;
            btn_NoEjercer.IsEnabled = false;
            btn_Ejercer.IsEnabled = false;
            btn_OpcPend.IsEnabled = false;
            dgPersona.IsEnabled = false;
        }

    }
}
