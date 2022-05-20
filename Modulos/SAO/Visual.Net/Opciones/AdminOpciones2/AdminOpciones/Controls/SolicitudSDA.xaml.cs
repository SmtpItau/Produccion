using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Documents;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Animation;
using System.Windows.Shapes;
using AdminOpciones.Valid;
using System.Xml.Linq;
using AdminOpciones.Struct;
using AdminOpciones.Recursos;

namespace AdminOpciones.Ejercer
{
    public delegate void Delegate();
    public delegate void SetData();
     
    public partial class SolicitudSDA : UserControl
    {
        //ASVG_20150225 En VS2010, no se puede instanciar el SoapClient ni acá ni en el constructor
        //ASVG_20150225 Genera error UriFormatException en el diseñador de XAML de DetalleCartera.xaml
        SrvLoadFront.LoadFrontSoapClient _SrvLoadFront; // = wsGlobales.LoadFront;//new AdminOpciones.SrvLoadFront.LoadFrontSoapClient();
        AdminOpciones.SrvAcciones.WebAccionesSoapClient sva; // = wsGlobales.Acciones;
        AdminOpciones.SrvDetalles.WebDetallesSoapClient svc; // = wsGlobales.Detalles;

        #region "Variables"
        public List<string> _carga = new List<string>();
        public event Delegate MaskCollapsed;
        public event SetData SetData;
        ValidAmount _VAmount = new ValidAmount();
        private List<StructMonedaFormaPago> formaDePagoList;
        private List<_Modalidad> Modalidad = new List<_Modalidad>();
        public DateTime ValFecActivacion;
        public string FechaEsFeriado;
        public DateTime FechaValSDA;
        #endregion

        public SolicitudSDA()
        {
            //Los Handler se declararán en el contexto del Async
            //sva.SaveSolicitudSDACompleted += new EventHandler<AdminOpciones.SrvAcciones.SaveSolicitudSDACompletedEventArgs>(sva_SaveSolicitudSDACompleted);
            //sva.ValidaSDACompleted += new EventHandler<AdminOpciones.SrvAcciones.ValidaSDACompletedEventArgs>(sva_ValidaSDACompleted);
            //sva.ModificaSolicitudSDACompleted += new EventHandler<AdminOpciones.SrvAcciones.ModificaSolicitudSDACompletedEventArgs>(sva_ModificaSolicitudSDACompleted);
            //svc.OpcionValFeriadosCompleted += new EventHandler<AdminOpciones.SrvDetalles.OpcionValFeriadosCompletedEventArgs>(svc_OpcionValFeriadosCompleted);
            //svc.OpcionValFeriadosAntCompleted += new EventHandler<AdminOpciones.SrvDetalles.OpcionValFeriadosAntCompletedEventArgs>(svc_OpcionValFeriadosAntCompleted);
            InitializeComponent();

            //_SrvLoadFront.LoadFrontDataCompleted += new EventHandler<AdminOpciones.SrvLoadFront.LoadFrontDataCompletedEventArgs>(_SrvLoadFront_LoadFrontDataCompleted);
            //_SrvLoadFront.LoadFrontDataAsync("Do");
        }

        /// <summary>
        /// Carga inicial de parámetros para los combos del control.
        /// </summary>
        public void LoadFrontData()
        {
            //Originalmente esto era parte del constructor
            _SrvLoadFront = wsGlobales.LoadFront;
            _SrvLoadFront.LoadFrontDataCompleted += new EventHandler<AdminOpciones.SrvLoadFront.LoadFrontDataCompletedEventArgs>(_SrvLoadFront_LoadFrontDataCompleted);
            _SrvLoadFront.LoadFrontDataAsync("Do");
        }

        private void event_btnCancelar_Click(object sender, RoutedEventArgs e)
        {
            //object alan = wsGlobales.LoadFront; //no da problemas
            //SrvLoadFront.LoadFrontSoapClient _SrvLoadFront = new AdminOpciones.SrvLoadFront.LoadFrontSoapClient(); //no da problemas

            MaskCollapsed();
            Limpia_objetos();
        }

        public void Load()
        {        
            this.DtFechaIngreso.IsEnabled = true;
            SetData();            
        }

        public void Limpia_objetos()
        {
            this.TxtNumContrato.Text = "";
            this.TxtMontoAnticipo.Text = "";
        }

        private void Event_btnAceptarGuardar_Click(object sender, RoutedEventArgs e)
        {
            if (TxtNumContrato.Text == "")
            {              
                System.Windows.Browser.HtmlPage.Window.Alert("Debe ingresar N° Contrato");
                return;
            }
            if (TxtMontoAnticipo.Text == "" || TxtMontoAnticipo.Text == "0")
            {
                System.Windows.Browser.HtmlPage.Window.Alert("Debe ingresar Monto de anticipo");
                return;
            }

            if (ValidaNumeros(TxtMontoAnticipo.Text).Equals(true))
            {
                System.Windows.Browser.HtmlPage.Window.Alert("Debe Ingresar solo Números en Monto de Anticipo");
                return;
            }

            if (ValidaNumeros(TxtNumContrato.Text).Equals(true))
            {
                System.Windows.Browser.HtmlPage.Window.Alert("Debe Ingresar solo Números en Numero Contrato");
                return;
            }
                                                           
            string Numcontrato = this.TxtNumContrato.Text;
            DateTime FecIngreso = this.DtFechaIngreso.SelectedDate.Value;
            DateTime FecActivacion = this.DtFechaActivacion.SelectedDate.Value;
            string NumFolio = this.TxtNumFolio.Text == "" ? "0" : this.TxtNumFolio.Text;

            if (FecActivacion <= FecIngreso)
            {
                System.Windows.Browser.HtmlPage.Window.Alert("Fecha de activación no pude ser menor o igual a la de ingreso");
                return;
            }

            //SOLICITUDSDA
            sva = wsGlobales.Acciones;
            sva.ValidaSDACompleted += new EventHandler<AdminOpciones.SrvAcciones.ValidaSDACompletedEventArgs>(sva_ValidaSDACompleted);
            sva.ValidaSDAAsync(Numcontrato, FecActivacion, NumFolio);
        }

        void sva_ValidaSDACompleted(object sender, AdminOpciones.SrvAcciones.ValidaSDACompletedEventArgs e)
        {
            string _TipoAnticipo = "";

            #region Validacion Cantera

            string _xmlResult = e.Result.ToString();
            string NumContrato = "";
            string FechaVcto = "";
            string MontoMon1 = "";
            string FechaVencSolicitud = "";
            string TotalSolicitud = "";
            string Fecha_Activacion = "";
            int Diasvec = 0;
            int Dias = 0;
            
            XDocument xmlResult = new XDocument();
            xmlResult = XDocument.Parse(_xmlResult);
            
            IEnumerable<XElement> elements = xmlResult.Element("Result").Elements("Status").Elements("Item");
            foreach (XElement element in elements)
            {
                NumContrato = element.Attribute("CaNumContrato").Value.ToString() == "" ? "0" : element.Attribute("CaNumContrato").Value.ToString();
                FechaVcto = element.Attribute("CaFechaVcto").Value.ToString();
                MontoMon1 = element.Attribute("CaMontoMon1").Value.ToString();
                FechaVencSolicitud = element.Attribute("FechaVencSolicitud").Value.ToString();
                TotalSolicitud = element.Attribute("TotalSolicitud").Value.ToString();
                Fecha_Activacion = element.Attribute("Fecha_Activacion").Value.ToString();
            }

            #endregion

            object selectedItem = CmbFormpago.SelectedItem;
            string _FormaPago = ((AdminOpciones.Struct.StructMonedaFormaPago)(this.CmbFormpago.SelectedItem)).Codigo.ToString();
           
            if (this.TxtNumFolio.Text == "")
            {
                _TipoAnticipo = ((AdminOpciones.Ejercer.SolicitudSDA._Modalidad)(this.CmbTipoAnticipo.SelectedItem)).Identidicador.ToString();
            }
            else
            {
                _TipoAnticipo = ((AdminOpciones.Ejercer.SolicitudSDA._Modalidad)(this.CmbTipoAnticipo.SelectedItem)).Identidicador.ToString();
            }

            string NumOP = this.TxtNumContrato.Text;
            DateTime FecIngreso = this.DtFechaIngreso.SelectedDate.Value;
            DateTime FecActivacion = this.DtFechaActivacion.SelectedDate.Value;
            string MontoAnticipo = this.TxtMontoAnticipo.Text;
            string NumFolio = this.TxtNumFolio.Text;

            if (NumContrato != NumOP)
            {
                System.Windows.Browser.HtmlPage.Window.Alert("Operación no esta Vigente en cartera");
                return;
            }

            if (Convert.ToDouble(MontoAnticipo) <= 0)
            {
                System.Windows.Browser.HtmlPage.Window.Alert("Monto no puede ser negativo o cero" );
                return;
            }

            if (_TipoAnticipo == "E") // Entrega Fisica
            {
                 Diasvec = 0;
                 Dias = 1 ;
            }
            else if (_TipoAnticipo == "C")//Compensacion
            {
                 Diasvec = 1;
                 Dias = 2;
            }

            if (Convert.ToDateTime(FechaVcto).AddDays(-Diasvec) <= FecActivacion)
            {
                System.Windows.Browser.HtmlPage.Window.Alert("Fecha de activación debe ser menor en " + Dias + " dias a fecha de vencimiento del contrato " + Convert.ToDateTime(FechaVcto).ToString("dd/MM/yyyy"));
                return;
            }
           
            double SumaTotSolicitud = Convert.ToDouble(MontoAnticipo) + Convert.ToDouble(TotalSolicitud);

            if (Convert.ToDouble(MontoMon1) < Convert.ToDouble(SumaTotSolicitud))
            {
                System.Windows.Browser.HtmlPage.Window.Alert("Suma de solicitudes supera nominal de operación que es " + MontoMon1 + " TotalSolicitud solicitudes es " + TotalSolicitud);
                this.TxtMontoAnticipo.Text = ((Convert.ToDouble(MontoMon1) - Convert.ToDouble(TotalSolicitud)).ToString()) ;
                return;
            }

            if (Convert.ToDouble(MontoMon1) < Convert.ToDouble(MontoAnticipo))
            {
                System.Windows.Browser.HtmlPage.Window.Alert("El Monto del Anticipo Debe ser menor o igual al Nominal " + MontoMon1);
                return;
            }

            if (Convert.ToDateTime(FechaVencSolicitud) == Convert.ToDateTime(FecActivacion))
            {
                System.Windows.Browser.HtmlPage.Window.Alert("Contrato N° " + NumContrato + " ya tiene fecha de activacion para el dia " + FecActivacion.ToString("yyyyMMdd"));
                return;
            }

            int DifFechas = (FecActivacion - ValFecActivacion).Days;
            if (DifFechas != 0)
            {              
                DifFechas =  (FecActivacion - Convert.ToDateTime(globales._FechaProceso)).Days;             
            }
            else
            {
                DifFechas = 1;
            }

            if (Convert.ToDateTime(FechaEsFeriado) != FechaValSDA && FecActivacion == Convert.ToDateTime(FechaEsFeriado))
            {
                System.Windows.Browser.HtmlPage.Window.Alert("No se puede Ingresar solicitud en T-1 o en dia Feriado");
                this.DtFechaActivacion.Text = Convert.ToDateTime(globales._FechaProceso).ToString("dd/MM/yyyy");
                return;
            }

            if (this.TxtNumFolio.Text == "")
            {
                if (Convert.ToDateTime(FecActivacion).AddDays(-DifFechas) == Convert.ToDateTime(globales._FechaProceso))
                {
                    System.Windows.Browser.HtmlPage.Window.Alert("No se puede Ingresar solicitud en T-1 o en dia Feriado");
                    this.DtFechaActivacion.Text = Convert.ToDateTime(globales._FechaProceso).ToString("dd/MM/yyyy");
                    return;
                }
                //SOLICITUDSDA
                sva = wsGlobales.Acciones;
                sva.SaveSolicitudSDACompleted += new EventHandler<AdminOpciones.SrvAcciones.SaveSolicitudSDACompletedEventArgs>(sva_SaveSolicitudSDACompleted);
                sva.SaveSolicitudSDAAsync(NumOP, FecIngreso, FecActivacion,
                                         MontoAnticipo, _FormaPago, _TipoAnticipo);
            }
            else
            {
                if (Convert.ToDateTime(Fecha_Activacion).AddDays(-1) == Convert.ToDateTime(globales._FechaProceso))
                {
                    System.Windows.Browser.HtmlPage.Window.Alert("No se puede modificar solicitud en T-1");
                    return;
                }

                if (Convert.ToDateTime(FecActivacion).AddDays(-DifFechas) == Convert.ToDateTime(globales._FechaProceso))
                {
                    System.Windows.Browser.HtmlPage.Window.Alert("No se puede Ingresar solicitud en T-1 o en dia Feriado");
                    this.DtFechaActivacion.Text = Convert.ToDateTime(globales._FechaProceso).ToString("dd/MM/yyyy");
                    return;
                }

                //SOLICITUDSDA
                sva = wsGlobales.Acciones;
                sva.ModificaSolicitudSDACompleted += new EventHandler<AdminOpciones.SrvAcciones.ModificaSolicitudSDACompletedEventArgs>(sva_ModificaSolicitudSDACompleted);
                sva.ModificaSolicitudSDAAsync(NumFolio, NumOP, FecIngreso, FecActivacion,
                                              MontoAnticipo, _FormaPago, _TipoAnticipo);
            }
        }

        void sva_SaveSolicitudSDACompleted(object sender, AdminOpciones.SrvAcciones.SaveSolicitudSDACompletedEventArgs e)
        {

            if (e.Result.ToString() == "SI")
            {
                System.Windows.Browser.HtmlPage.Window.Alert("Se grabo solicitud de forma correcta");

                TxtMontoAnticipo.Text = "";
                TxtNumContrato.Text = "";
                MaskCollapsed();
               
            }

            else
            {
                System.Windows.Browser.HtmlPage.Window.Alert("Ocurrio un error al intentar grabar solicitud");
            }

        }

        private void Event_BtnModificar_Click(object sender, RoutedEventArgs e)
        {
            string NumFolio = this.TxtNumFolio.Text;
            string Numcontrato = this.TxtNumContrato.Text;
            DateTime FecIngreso = this.DtFechaIngreso.SelectedDate.Value;
            DateTime FecActivacion = this.DtFechaActivacion.SelectedDate.Value;

            if (TxtNumContrato.Text == "")
            {
                System.Windows.Browser.HtmlPage.Window.Alert("Debe ingresar N° Contrato");
                return;
            }

            if (TxtMontoAnticipo.Text == "" ||TxtMontoAnticipo.Text == "0")
            {
                System.Windows.Browser.HtmlPage.Window.Alert("Debe ingresar Monto de anticipo");
                return;
            }

            if (ValidaNumeros(TxtMontoAnticipo.Text).Equals(true))
            {
                System.Windows.Browser.HtmlPage.Window.Alert("Debe Ingresar solo Números en Monto de Anticipo");
                return;
            }

            if (ValidaNumeros(TxtNumContrato.Text).Equals(true))
            {
                System.Windows.Browser.HtmlPage.Window.Alert("Debe Ingresar solo Números en Numero Contrato");
                return;
            }

            if (FecActivacion <= FecIngreso)
            {
                System.Windows.Browser.HtmlPage.Window.Alert("Fecha de activación no pude ser menor o igual a la de ingreso");
                return;
            }

            ValidaNumeros(TxtMontoAnticipo.Text);

            //SOLICITUDSDA
            sva = wsGlobales.Acciones;
            sva.ValidaSDACompleted += new EventHandler<AdminOpciones.SrvAcciones.ValidaSDACompletedEventArgs>(sva_ValidaSDACompleted);
            sva.ValidaSDAAsync(Numcontrato, FecActivacion, NumFolio);          
        }

        void sva_ModificaSolicitudSDACompleted(object sender, AdminOpciones.SrvAcciones.ModificaSolicitudSDACompletedEventArgs e)
        {

            if (e.Result.ToString() == "SI")
            {
                System.Windows.Browser.HtmlPage.Window.Alert("Se Modificó solicitud de forma correcta");

                TxtMontoAnticipo.Text = "";
                TxtNumContrato.Text = "";
                MaskCollapsed();
            }
            else
            {
                System.Windows.Browser.HtmlPage.Window.Alert("Ocurrió un error al intentar grabar solicitud");
            }
        }

        private void DtFechaActivacion_LostFocus(object sender, RoutedEventArgs e)
        {
            try
            {
                DateTime FecActivacion = this.DtFechaActivacion.SelectedDate.Value;
                //SOLICITUDSDA
                svc = wsGlobales.Detalles;
                svc.OpcionValFeriadosCompleted += new EventHandler<AdminOpciones.SrvDetalles.OpcionValFeriadosCompletedEventArgs>(svc_OpcionValFeriadosCompleted);
                svc.OpcionValFeriadosAsync(FecActivacion);
            }
            catch { }
        }

        //13090
        void svc_OpcionValFeriadosCompleted(object sender, AdminOpciones.SrvDetalles.OpcionValFeriadosCompletedEventArgs e)
        {
            string FechaVencSolicitud = "";
            string _xmlResult = e.Result.ToString();
            XDocument xmlResult = new XDocument();
            xmlResult = XDocument.Parse(_xmlResult);

            IEnumerable<XElement> elements = xmlResult.Element("Data").Elements("Vencimiento");
            foreach (XElement element in elements)
            {

                FechaVencSolicitud = element.Attribute("MoFechaVcto").Value.ToString();
                
            }

            DtFechaActivacion.Text = Convert.ToDateTime(FechaVencSolicitud).ToString("dd/MM/yyyy");
        }

        private void TxtNumFolio_KeyDown(object sender, KeyEventArgs e)
        {
           

        }

        private void TxtNumContrato_KeyDown(object sender, KeyEventArgs e)
        {         

            if (e.Key >= Key.D0 && e.Key <= Key.D9 || e.Key >= Key.NumPad0 && e.Key <= Key.NumPad9)
                e.Handled = false;
            else
                e.Handled = true;       
        }
        
        private void TxtMontoAnticipo_KeyDown(object sender, KeyEventArgs e)
        {
            ValidAmount _VAmount = new ValidAmount();
            if (TxtMontoAnticipo.Text != "")
            {         
                _VAmount.TextChange(TxtMontoAnticipo);
               
            }          
        }

        private bool ValidaNumeros(string Campo)
        {
            bool Result = false;
            try
            {
                decimal x;
                string y;
                y = Campo;
                x = Convert.ToDecimal(Campo);
            }
            catch
            {             
                Result = true;
            }
            return Result;
        }

        private void DtFechaActivacion_CalendarClosed(object sender, RoutedEventArgs e)
        {
            try
            {
                DateTime FecActivacion = this.DtFechaActivacion.SelectedDate.Value;
                ValFecActivacion = FecActivacion;
                //SOLICITUDSDA
                svc = wsGlobales.Detalles;
                svc.OpcionValFeriadosCompleted += new EventHandler<AdminOpciones.SrvDetalles.OpcionValFeriadosCompletedEventArgs>(svc_OpcionValFeriadosCompleted);
                svc.OpcionValFeriadosAsync(FecActivacion);

                FechaValSDA = Convert.ToDateTime(globales._FechaProceso).AddDays(+1);
                //SOLICITUDSDA
                svc.OpcionValFeriadosAntCompleted += new EventHandler<AdminOpciones.SrvDetalles.OpcionValFeriadosAntCompletedEventArgs>(svc_OpcionValFeriadosAntCompleted);
                svc.OpcionValFeriadosAntAsync(Convert.ToDateTime(globales._FechaProceso).AddDays(+1));
            }
            catch { }
        }

        private void _SrvLoadFront_LoadFrontDataCompleted(object sender, AdminOpciones.SrvLoadFront.LoadFrontDataCompletedEventArgs e)
        {
            try
            {
                string resultValue = e.Result.ToString();
                XDocument xdocLoadData = new XDocument(XDocument.Parse(resultValue));

                #region Forma Pago

                var DataFormaDePago = from itemDataLoad in xdocLoadData.Descendants("DataFormaDePago")
                                      select new StructMonedaFormaPago
                                      {
                                          CodigoMoneda = int.Parse(itemDataLoad.Attribute("Moneda").Value.ToString()),
                                          Codigo = itemDataLoad.Attribute("FormaDePagoCod").Value.ToString(),
                                          Descripcion = itemDataLoad.Attribute("FormaDePagoDsc").Value.ToString(),
                                          Valor = double.Parse(itemDataLoad.Attribute("FormaDePagoValuta").Value.ToString())
                                      };

                formaDePagoList = DataFormaDePago.ToList();

                CmbFormpago.ItemsSource = formaDePagoList;
                CmbFormpago.DisplayMemberPath = "Descripcion";
                CmbFormpago.SelectedIndex = 0;

                #endregion Forma Pago
            }

            catch
            {
                System.Windows.Browser.HtmlPage.Window.Alert("Error al leer formas de pago en solicitud");
                return;
            }

            try
            {
                Modalidad.Add(new _Modalidad("ENTREGA FISICA", "E"));
                Modalidad.Add(new _Modalidad("COMPENSADO", "C"));

                CmbTipoAnticipo.ItemsSource = Modalidad;

                CmbTipoAnticipo.DisplayMemberPath = "Descripcion";

                CmbTipoAnticipo.SelectedIndex = 0;

                DtFechaIngreso.IsEnabled = false;
            }
            catch
            {
                System.Windows.Browser.HtmlPage.Window.Alert("Error al cargar modalidad de pago");
                return;
            }
        }
        
        private void DtFechaActivacion_KeyDown(object sender, KeyEventArgs e)
        {
            if (e.Key >= Key.D0 && e.Key <= Key.D9 || e.Key >= Key.NumPad0 && e.Key <= Key.NumPad9)
                e.Handled = true;
            else
                e.Handled = true;       
        }
   
        void svc_OpcionValFeriadosAntCompleted(object sender, AdminOpciones.SrvDetalles.OpcionValFeriadosAntCompletedEventArgs e)
        {
            string _xmlResult = e.Result.ToString();
            XDocument xmlResult = new XDocument();
            xmlResult = XDocument.Parse(_xmlResult);

            IEnumerable<XElement> elements = xmlResult.Element("Data").Elements("Vencimiento");
            foreach (XElement element in elements)
            {
                FechaEsFeriado = element.Attribute("MoFechaVcto").Value.ToString();
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

    }
}
