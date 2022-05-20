using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Linq;
using System.Windows.Browser;
using System.Windows.Controls;
using System.Windows.Input;
using System.Windows.Media.Imaging;
using System.Xml.Linq;
using AdminOpciones.Recursos;
using AdminOpciones.Struct;
using System.Windows;

namespace AdminOpciones.Controls
{
    public partial class ProcesoFijacion : UserControl
    {
        AdminOpciones.SrvAcciones.WebAccionesSoapClient sva = wsGlobales.Acciones;
        AdminOpciones.SrvDetalles.WebDetallesSoapClient svc = wsGlobales.Detalles;        

        private List<StructProcesoFijacion> _ContraFixList;
        private List<StructProcesoFijacion> ContraFixList;
        private List<StructProcesoFijacion> PContraFixList;
        private XDocument xmlContratos = new XDocument();
        private XDocument xmlResult = new XDocument();
        public string XmlResultContraFix;
        public string result_;
        public int EstadoMesa_ = 0;
        private int CountFijables = 0;

        public class ListaFijacion
        {

            public string contrato { get; set; }
            public string usuario { get; set; }
            public string numestruct { get; set; }
            public string numfijacion { get; set; }
            public string fechafijacion { get; set; }
            public string valorfixbench { get; set; }
            public string refijable { get; set; }
            public bool IsUpdate { get; set; }

            public override string ToString()
            {
                return string.Format(
                                      "{0}|{1}|{2}|{3}|{4}|{5}|{6}",
                                      new object[] { contrato, usuario, numestruct, numfijacion, fechafijacion, valorfixbench, refijable }
                                    );
            }
        }

        public class _Resultado_Estado
        {
            public string Result { get; set; }
        }

        public class _Resultado_Mesa
        {
            public string ResultMesa { get; set; }
        }

        public ProcesoFijacion()
        {
            InitializeComponent();
            svc.RetornaFixCompleted += new EventHandler<AdminOpciones.SrvDetalles.RetornaFixCompletedEventArgs>(svc_RetornaFixCompleted);
            svc.RetornaCierreMesaCompleted += new EventHandler<AdminOpciones.SrvDetalles.RetornaCierreMesaCompletedEventArgs>(svc_RetornaCierreMesaCompleted);
            sva.InsertFixCompleted += new EventHandler<AdminOpciones.SrvAcciones.InsertFixCompletedEventArgs>(sva_InsertFixCompleted);

            this.dgPersona.PreparingCellForEdit += new EventHandler<DataGridPreparingCellForEditEventArgs>(dgPersona_PreparingCellForEdit);
            svc.RetornaCierreMesaAsync(Convert.ToDateTime(Convert.ToString(globales._FechaProceso)).ToString());
            btn_preparar_Copy.IsEnabled = false;
        }

        private void dgPersona_PreparingCellForEdit(object sender, DataGridPreparingCellForEditEventArgs e)
        {
            int _Row;
            _Row = dgPersona.SelectedIndex;

            if (_Row >= 0)
            {
                bool _Value = (ContraFixList[_Row].FixBenchEsEditable == "N");

                if (e.Column.DisplayIndex == 21)
                {
                    try
                    {
                        TextBox _Text = (TextBox)dgPersona.Columns[21].GetCellContent(dgPersona.SelectedItem);
                        _Text.IsReadOnly = _Value;
                    }
                    catch
                    {
                    }
                }

                dgPersona.ItemsSource = ContraFixList;
            }
        }

        private void svc_RetornaFixCompleted(object sender, AdminOpciones.SrvDetalles.RetornaFixCompletedEventArgs e)
        {
            XmlResultContraFix = e.Result;
            if (XmlResultContraFix.Length > 0)
            {
                ContratoFIX(XmlResultContraFix);
                if (ContraFixList.Count > 0)
                {
                    FiltrarData();
                }
            }
        }

        private void svc_RetornaCierreMesaCompleted(object sender, AdminOpciones.SrvDetalles.RetornaCierreMesaCompletedEventArgs e)
        {
            string _fproc = Convert.ToDateTime(Convert.ToString(globales._FechaProceso)).ToString("yyyyMMdd");
            string _xmlResult = e.Result.ToString();
            xmlResult = XDocument.Parse(_xmlResult);
            List<_Resultado_Mesa> _data = new List<_Resultado_Mesa>();            
           
            IEnumerable<XElement> elements = xmlResult.Element("CierreMesa").Elements("Data");
            foreach (XElement element in elements)
            {

                _Resultado_Mesa _sData = new _Resultado_Mesa();
                _sData.ResultMesa = element.FirstAttribute.Value.ToString();
                EstadoMesa_ = Convert.ToInt32(_sData.ResultMesa);
            }


        }

        private void sva_InsertFixCompleted(object sender, AdminOpciones.SrvAcciones.InsertFixCompletedEventArgs e)
        {
            string _fContratoIni = Convert.ToDateTime(Convert.ToString(Dt_FechaDesde)).ToString("yyyyMMdd");
            string _fContratoFin = Convert.ToDateTime(Convert.ToString(Dt_FechaDesde_Copy)).ToString("yyyyMMdd");
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
                string Mensaje = "Fijación de Contratos Realizada";
                System.Windows.Browser.HtmlPage.Window.Alert(Mensaje);
            }

            else
            {
                string Mensaje = "Error: No se pudo Realizar la Fijación de Contratos";
                System.Windows.Browser.HtmlPage.Window.Alert(Mensaje);
            }

            svc.RetornaFixAsync(_fContratoIni, _fContratoFin, int.Parse(txtContrato.Text), globales._Usuario); //refresca la grilla al grabar fijación
        }

        private void ContratoFIX(string strXMLContraFix)
        {
            int row;
            xmlContratos = XDocument.Parse(strXMLContraFix);
            var FixContratos = from ContraFixXML in xmlContratos.Descendants("Data")
                               select new StructProcesoFijacion
                               {
                                   NumContrato = ContraFixXML.Attribute("NumContrato").Value.ToString(),
                                   FechaFijacion = DateTime.Parse(ContraFixXML.Attribute("FechaFijacion").Value.ToString()),
                                   FechaFijacionAux = DateTime.Parse(ContraFixXML.Attribute("FechaFijacion").Value.ToString()),
                                   OpcEstDsc = ContraFixXML.Attribute("OpcEstDsc").Value.ToString(),
                                   OpcEstCod = ContraFixXML.Attribute("OpcEstCod").Value.ToString(),
                                   CliRut = ContraFixXML.Attribute("CliRut").Value.ToString(),
                                   CliDv = ContraFixXML.Attribute("CliDv").Value.ToString(),
                                   CliCod = ContraFixXML.Attribute("CliCod").Value.ToString(),
                                   CliNom = ContraFixXML.Attribute("CliNom").Value.ToString(),
                                   NumComponente = ContraFixXML.Attribute("NumComponente").Value.ToString(),
                                   PayOffTipDsc = ContraFixXML.Attribute("PayOffTipDsc").Value.ToString(),
                                   CallPut = ContraFixXML.Attribute("CallPut").Value.ToString(),
                                   CompraVentaOpcDsc = ContraFixXML.Attribute("CompraVentaOpcDsc").Value.ToString(),
                                   FechaPagoEjer = ContraFixXML.Attribute("FechaPagoEjer").Value.ToString(),
                                   Mon1Dsc = ContraFixXML.Attribute("Mon1Dsc").Value.ToString(),
                                   ModalidadDsc = ContraFixXML.Attribute("ModalidadDsc").Value.ToString(),
                                   MdaCompensacionDsc = ContraFixXML.Attribute("MdaCompensacionDsc").Value.ToString(),
                                   Strike = ContraFixXML.Attribute("Strike").Value.ToString(),
                                   PesoFijacion = ContraFixXML.Attribute("PesoFijacion").Value.ToString(),
                                   FixBenchCompDsc = ContraFixXML.Attribute("FixBenchCompDsc").Value.ToString(),
                                   FixParBench = ContraFixXML.Attribute("FixParBench").Value.ToString(),
                                   FixBenchCompHora = ContraFixXML.Attribute("FixBenchCompHora").Value.ToString(),
                                   FixValorFijacion = ContraFixXML.Attribute("FixValorFijacion").Value.ToString(),
                                   FixBenchMdaCodValorDefValor = ContraFixXML.Attribute("FixBenchMdaCodValorDefValor").Value.ToString(),
                                   Refijable = ContraFixXML.Attribute("Refijable").Value.ToString(),
                                   FixBenchEsEditable = ContraFixXML.Attribute("FixBenchEsEditable").Value.ToString(),
                                   NumeroFijacion = ContraFixXML.Attribute("NumeroFijacion").Value.ToString()

                               };

            ContraFixList = new List<StructProcesoFijacion>();
            PContraFixList = new List<StructProcesoFijacion>();
            _ContraFixList = new List<StructProcesoFijacion>(FixContratos.ToList<StructProcesoFijacion>());
            DataGridTextColumn _texto = new DataGridTextColumn();
            foreach (StructProcesoFijacion _Aux in _ContraFixList)
            {
                ContraFixList.Add(_Aux);
                PContraFixList.Add(_Aux);
            }
            if (ContraFixList.Count > 0)
            {
                btn_preparar_Copy.IsEnabled = true;
            }
        }

        void Listar_Detalle_Fijacion()
        {
            string _fContratoIni = Convert.ToDateTime(Convert.ToString(Dt_FechaDesde)).ToString("yyyyMMdd");
            string _fContratoFin = Convert.ToDateTime(Convert.ToString(Dt_FechaDesde_Copy)).ToString("yyyyMMdd");

            if ((Convert.ToString(txtContrato.Text)) != "")
            {
                svc.RetornaFixAsync(_fContratoIni, _fContratoFin, int.Parse(txtContrato.Text), globales._Usuario);
            }
            else
            {
                return;
            }
        }

        private void Buscar_Click(object sender, RoutedEventArgs e)
        {
            Listar_Detalle_Fijacion();
        }

        private void Procesar_Fijacion(object sender, RoutedEventArgs e)
        {
            List<ListaFijacion> ListaDatoFix = new List<ListaFijacion>();
            foreach (StructProcesoFijacion _Aux in ContraFixList)
            {
                ListaFijacion ListaDatos_ = new ListaFijacion();

                ListaDatos_.contrato = _Aux.NumContrato;
                ListaDatos_.usuario = globales._Usuario;
                ListaDatos_.numestruct = _Aux.NumComponente;
                ListaDatos_.numfijacion = _Aux.NumeroFijacion;
                ListaDatos_.valorfixbench = _Aux.FixBenchMdaCodValorDefValor;
                ListaDatos_.fechafijacion = _Aux.FechaFijacion.ToString("yyyyMMdd");
                ListaDatos_.refijable = _Aux.Refijable;
                ListaDatos_.IsUpdate = (_Aux.FechaFijacion != _Aux.FechaFijacionAux);
                ListaDatoFix.Add(ListaDatos_);
            }

            ProcesarFijacion(ListaDatoFix);
        }

        private void ProcesarFijacion(List<ListaFijacion> Listafix_)
        {
            List<string> _valor = new List<string>();

            foreach (ListaFijacion _Aux in Listafix_)
            {

                ListaFijacion ListaDatos_ = new ListaFijacion();
                if (_Aux.refijable == "FIJABLE" || _Aux.IsUpdate)
                {
                    ListaDatos_.contrato = _Aux.contrato;
                    ListaDatos_.usuario = _Aux.usuario;
                    ListaDatos_.numestruct = _Aux.numestruct;
                    ListaDatos_.numfijacion = _Aux.numfijacion;
                    ListaDatos_.fechafijacion = _Aux.fechafijacion;
                    ListaDatos_.valorfixbench = _Aux.valorfixbench;
                    ListaDatos_.refijable = _Aux.refijable;
                    _valor.Add(ListaDatos_.ToString());
                    CountFijables++;
                }
            }

            //IAF Obs: 200 Dsc:Eliminar validacion de cierre de mesa.
            //if (EstadoMesa_ != 0)
            //{
            if (CountFijables != 0)
            {
                sva.InsertFixAsync(_valor.ToArray());
            }

            else
            {
                string Mensaje = "No Existen Contratos para Fijar.";
                System.Windows.Browser.HtmlPage.Window.Alert(Mensaje);
                return;
            }
            //}
            //else
            //{
            //    string Mensaje = "No Se ha realizado el cierre de Mesa";
            //    System.Windows.Browser.HtmlPage.Window.Alert(Mensaje);
            //    return;
            //}
        }

        private void FiltroFijacion_MouseLeftButtonUp(object sender, MouseButtonEventArgs e)
        {
            FiltrarData();
        }

        private void FiltrarData()
        {
            List<StructProcesoFijacion> __ContraFixList = new List<StructProcesoFijacion>();

            if (ContraFixList != null && ContraFixList.Count > 0)
            {
                __ContraFixList = ContraFixList.ToList();

                if (comboboxFiltro.SelectedIndex.Equals(1))
                {
                    __ContraFixList = ContraFixList.Where(_Element => _Element.Refijable.Equals("FIJABLE")).ToList<StructProcesoFijacion>();
                }
                else if (comboboxFiltro.SelectedIndex.Equals(2))
                {
                    __ContraFixList = ContraFixList.Where(_Element => _Element.Refijable.Equals("NO-FIJABLE")).ToList<StructProcesoFijacion>();
                }
            }

            dgPersona.ItemsSource = __ContraFixList;
        }

    }

}
