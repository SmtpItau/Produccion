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
using AdminOpciones.Struct;
using AdminOpciones.Struct.Generic;
using AdminOpciones.OpcionesFX.Front;
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
//REVISAR
//using System.Threading;
//using System.Globalization;
using Liquid;
using AdminOpciones.Recursos;
using AdminOpciones.Struct; //Para Strip
using AdminOpciones.Delegados;
using HP = System.Windows.Browser.HtmlPage;

namespace AdminOpciones.OpcionesFX.Front
{
    public delegate void SendChangeTitle(string title, string usercontrolName);

    public partial class FontOpciones : UserControl
    {
        #region "Variables"

        public event SendChangeTitle event_SendChangeTitle;

        //private DateTime DateProccess = new DateTime();
        private DateTime FechaValorizacionCartera = new DateTime();

        public string UserControlName { get; set; }

        //private List<string> ListaOpcionesContrato = new List<string>();
        private List<StructCustomers> CustomersList;
        private List<StructCodigoDescripcion> BookList;
        private List<StructCodigoDescripcion> FinancialPortFolioList;
        private List<StructCodigoDescripcion> PortFolioRulesList;
        private List<StructCodigoDescripcion> SubPortFolioRulesList;
        private List<StructCodigoDescripcion> OpcionesEstructuraList;
        private List<StructCodigoDescripcion> payOffList;
        private List<StructMonedaFormaPago> formaDePagoList;
        private List<StructCodigoDescripcion> OptionStateList;
        private List<StructRelacionForward> ConsRelacionFwd;
        

        //PRD_7274 STRIP ASIATICO
        //era estática, para acceso desde Auxiliares.
        public List<StructStrip> StripList;
        public static StructStrip CreaStrip;
        public string FechaFinStrip = "";
        public int NumeroContratoStrip = 0;
        public bool IsLoadStripContrat = false;
        //campo
        private string xmlStrip;

        //PRD-3162
        private List<StructConfiguracionPortFolio> ConfiguracionPortFolioList;
        private List<StructFinancialPortFolio> FinancialPortFolioPrioridadList;

        //era private
        public StructCodigoDescripcion _opcionEstructuraSeleccionada;

        //Valorizacion Cartera
        DateTime FechaDeProceso = new DateTime();  // Se carga a traves de BD con la fecha actual de proceso y no se modifica;
        List<StructDetContrato> DetContratoList;
        List<StructEncContrato> EncContratoList;
        List<StructFixingDataContrato> FijacionesList;
        List<StructDetContrato> MtMGriegasTotalizador;
        DateTime _FechaValoracionCartera;
        double BSSpotValorizacion = double.NaN;
        double _BSSpotValorizacion = double.NaN;
        /// <summary>
        /// Contiene todas las curvas cargadas en Set de Precio
        /// </summary>
        public List<StructCurvaMoneda> CurvasMonedasList;
        private bool isFechaValorizacionMayor = true;
        private List<StructSmileATMRRFLY> SmileATMRRFLYList = new List<StructSmileATMRRFLY>();
        private List<StructSmileCallPut> SmileCallPutList = new List<StructSmileCallPut>();
        private List<StructSmileCallPut> SmileStrikesList = new List<StructSmileCallPut>();

        private List<StructSensibilidad> _ListCurvaCLP = new List<StructSensibilidad>();
        private List<StructSensibilidad> _ListCurvaLocal = new List<StructSensibilidad>();

        //todo esto era private, acceso desde Auxiliares.
        public List<StructSmileATMRRFLY> TopologiaVegaATMRRFLYPricingList;
        public List<StructSmileCallPut> TopologiaVegaCALLPUTListPricing;
        private List<StructSmileATMRRFLY> TopologiaVegaVolatibilidadesPricingList;
        private List<StructSmileCallPut> TopologiaVegaStrikesPricing;
        private List<StructSensibilidad> _ListCurvaCLPPricing = new List<StructSensibilidad>();
        private List<StructSensibilidad> _ListCurvaLocalPricing = new List<StructSensibilidad>();

        List<StructItemPuntosForward> CurvaFwUSD;

        private bool isTablaFixingLoadedFromValcartera = false;
        private bool isTablaFixingCreated = false;
        
        /// <summary>
        /// No encuentro dónde se usa esto...
        /// </summary>
        public double TopologiadelaVegaTotalizador = 0;

        private int grdValCarteraEncSelectedIndex = -1;
        private int setPreciosValCartera;
        private bool isTopologiaVegaClicked = false;
        private bool isCarteraLoaded = false;
        private bool isCarteraValorizada = false;
        private bool isEncOrDetCheck_Clicked = false;
        private bool isOpcionFromCartera = false;

        //----------------
        //era private
        public Icon RotateIcon = new Icon();
        public Icon RotateIconSetPriging = new Icon();

        private bool isLoadContract = false;
        private bool isPlazoChanged = false;
        private bool isdatePickerVencChanged = false;

        private bool isTextChanged = false;
        private bool isMTMTextChanged = false;

        private XDocument xmlCreate;
        //era private
        public bool EnableComponentes = false;


        public string Libro = "";
        public string CarteraFinanciera = "";
        public string CarteraNormativa = "";
        public string SubCarteraNormativa = "";

        // bandera para cargar tabla fixing.
        public bool Fixing = false;
        private List<StructFixingData> _DatosFixing = new List<StructFixingData>();


        // se carga desde SmileOpciones
        //revisar que se usa de todo esto.
        public List<StructFixingData> FixingDataList = new List<StructFixingData>();
        public List<StructFixingData> FixingDataListEntrada = new List<StructFixingData>();//PRD_12567
        public string FixingDataString = "";
        public string FixingDataStringSalida = "";//PRD_12567
        public string FixingDataStringEntrada = ""; //PRD_12567
        public int Town;

        public string XMLResult = "";
        public StructGriegas griegas;

        private DateTime fechaVencimiento;

        private string moneda1 = "USD";
        private string moneda2 = "CLP";
        public string paridad;// moneda2 + "/" + moneda1;

        #region PRD_12567 Nombres para configuración de curvas Forward a utilizar en set de Precios

        /// <summary>
        /// Variable global de pantalla con nombre de curva Swap doméstica: "CurvaSwapCLP"
        /// </summary>
        public string curvaDom = "CurvaSwapCLP";
        /// <summary>
        /// Variable global de pantalla con nombre de curva Swap foránea: "CurvaSwapCLP"
        /// </summary>
        public string curvaFor = "CurvaSwapUSDLocal";
        /// <summary>
        /// Variable global de pantalla con nombre de curva Forward doméstica: "CurvaFwCLP"
        /// </summary>
        public string curvaFwdDom = "CurvaFwCLP";
        /// <summary>
        /// Variable global de pantalla con nombre de curva Forward doméstica: "CurvaFwUSD"
        /// </summary>
        public string curvaFwdFor = "CurvaFwUSD";

        /// <summary>
        /// NO SE UTILIZA, idea de lista con nombres de las curvas, para PRD-12567 Forward Asiático Entrada Salida.
        /// </summary>
        List<string> nombreCurvas = new List<string>() { "CurvaSwapCLP", "CurvaSwapUSDLocal", "CurvaFwCLP", "CurvaFwUSD" };

        #endregion PRD_12567 Nombres para configuración de curvas Forward a utilizar en set de Precios

        public string codigoMon1 = "13"; //USD
        public string codigoMon2 = "999";//CLP
        public string afirme_cotizacion = "";

        public string call_put;
        public string compra_venta;
        public double nocional;
        public double NocionalStrangle;
        public double nocionalContraMonedaMonto = 0;
        public double spot;
        public double PuntosCosto;
        public double SpotContrato;
        public double PrimaContrato;
        public double ParidadPrima;
        public double Unwind;
        public double UnwindCosto;
        public double Distribucion;
        public double MtMContrato;
        public double ResultVenta;    //5843
        public double PorcStrike;//PRD_12567

        //era private
        public string BsSpot_BsFwd_AsianMomentos_flag = "BsFwd"; 

        public double strike;
        public double strike2;
        public double strike3;
        public double strike4;//PRD_20559

        public double delta1;
        public double delta2;
        public double delta3;
        private double _SpotCosto;
        private double __ObservedDollar;

        public double Strike_InterpVol;
        public int Plazo_InterpVol;

        public string TopologiaVegaPricingInput = "";

        //era private
        public bool isGuardarValid = true;

        /// <summary>
        /// String que corresponde a "strikes" o "delta" según se activen los strikes o los delta.
        /// Se utiliza para indicarle a las estructuras si los valores son entregados a través de strikes o delta.
        /// </summary>
        public string strikes_delta_flag = "strikes";

        private string opcionContrato = "";
        private int setPrecios_Pricing;
        public string _Transaccion = "CREACION"; // MAP
        private string MyPlazo = "";
        private DateTime MyFechaVencimiento = new DateTime();
        private DateTime MyFechaSetPrecio = new DateTime();

        private bool txtStrike1_Changed = false;
        public  bool IsClearData = false;
        private bool IsChangeFixing = false;
        private bool IsOpenCalendarExpiryDate = false;
        private bool IsCalculatePrima = false;

        //Validadores
        ValidAmount valtxtNocional = new ValidAmount();
        ValidAmount valtxtNocionalStrangle = new ValidAmount();
        ValidAmount valtxtStrike1 = new ValidAmount();
        ValidAmount valtxtStrike2 = new ValidAmount();
        ValidAmount valtxtStrike3 = new ValidAmount();
        ValidAmount valtxtStrike4 = new ValidAmount();
        ValidAmount valtxtDelta1 = new ValidAmount();
        ValidAmount valtxtDelta2 = new ValidAmount();
        ValidAmount valtxtDelta3 = new ValidAmount();
        ValidAmount valtxtSpotCosto = new ValidAmount();
        ValidAmount valtxtPuntosCosto = new ValidAmount();
        ValidAmount valtxtUnwind = new ValidAmount();
        ValidAmount valtxtUnwindCosto = new ValidAmount();
        ValidAmount valtxtParidadPrima = new ValidAmount();
        ValidAmount valtxtDistribucion = new ValidAmount();
        ValidAmount valtxtPrimaContrato = new ValidAmount();
        ValidAmount valtxtSpotValorizacion = new ValidAmount();
        ValidAmount valtxtMtMValorizacion = new ValidAmount();
        ValidAmount valtxtResultadoVta = new ValidAmount();  //5843

        TermValidate TenmValidator = new TermValidate();

        TermValidate valtxtInterpVol_Plazo = new TermValidate();
        ValidAmount valtxtInterpVol_Strike = new ValidAmount();

        private AdminOpciones.SrvDetalles.WebDetallesSoapClient svc = wsGlobales.Detalles;

        double MaxValueNocional;

        private bool TableClose { get; set; }
        private int FormaPagoUSD { get; set; }
        private int FormaPagoCLP { get; set; }

        public bool IsLoading { get; set; }
        private bool IsLoadedFrontData = false;
        private bool IsLoadedCustomers = false;
        private bool IsLoadedPortfolioAndBook = false;

        DateTime FechaSetdePrecios = new DateTime(1900, 1, 1);

        public string _TitleOriginal = "Ingreso Contrato";

        //STRIP, esto hay que comentarlo para que caigan las referencias y sacar el código muerto.
        public int idOperacionStripFixing = 0;

        #endregion
        //20190613.rchs.LCR Opciones
        public int NumeroFolio;
        public int NumeroContrato;

        Auxiliares a = new Auxiliares();
        public int ID_Contrato; //PRD_12567

        public FontOpciones()
        {
            //auto-generated
            InitializeComponent();

            __ObservedDollar = 0;

            StartInitFront();

            LoadFrontData("Do");
            LoadCustomers();
            LoadPortfolioAndBook();

            PutBlockTextBox(txtNocionalContraMoneda);
            paridad = moneda2 + "/" + moneda1;
            //IAF Obs: 170
            MaxValueNocional = 999999999;

            //Load PopUps

            //Tabla Fixing
            _TablaFixing.event_LoadDataTableFixingData += new LoadTablaFixingData(_TablaFixing_event_LoadDataTableFixingData);
            
            _TablaFixing.event_TablaFixingResult        += new AdminOpciones.OpcionesFX.Asiatica.ShowResults(_TablaFixing_event_TablaFixingResult);
            _TablaFixing.event_TablaFixingResultEntrada += new AdminOpciones.OpcionesFX.Asiatica.ShowResults(_TablaFixing_event_TablaFixingResultEntrada);//PRD_12567
            
            _TablaFixing.event_TablaFixingLoadedFromValCartera += new isTablaFixingLoadedFromValcartera(_TablaFixing_event_TablaFixingLoadedFromValCartera);
            
            _TablaFixing.grdTablaFixing.KeyDown += new KeyEventHandler(grdTablaFixing_KeyDown);
            
            _TablaFixing.event_TablaFixing_CalculaPeso          += new delegateCalculaPeso(_TablaFixing_event_TablaFixing_CalculaPeso);
            _TablaFixing.event_TablaFixing_CalculaPesoEntrada   += new delegateCalculaPeso(_TablaFixing_event_TablaFixing_CalculaPesoEntrada);

            _TablaFixing.event_ChangeDateFixing += new ChangeDateFixing(event_ChangeDateFixing);
            _TablaFixing.event_ShowFixing += new ShowFixing(_TablaFixing_event_ShowFixing);
            //13090
            svc.AnticipaSolicitudCompleted += new EventHandler<AdminOpciones.SrvDetalles.AnticipaSolicitudCompletedEventArgs>(svc_AnticipaSolicitudCompleted);
            _TablaFixing.Town = 0;
            
            //Guardar
            _Guardar.SetData += new AdminOpciones.OpcionesFX.Guardar.SetData(_Guardar_SetData);
            _Guardar.MaskCollapsed += new AdminOpciones.OpcionesFX.Guardar.Delegate(_Guardar_MaskCollapsed);
            _Guardar.Event_SendSave += new AdminOpciones.OpcionesFX.Guardar.Delegate(Event_SendSave);

            //Componentes
            _ComponentesTable.grdComponentes.KeyDown += new KeyEventHandler(grdComponentes_KeyDown);
            popUpComponentes.SetValue(Canvas.TopProperty, double.Parse("50"));
            popUpComponentes.SetValue(Canvas.LeftProperty, double.Parse("50"));

            //Topología Vega Pricing
            TopologiaVegaNew();

            _TopologiaVegaPricingControl.grdTopologiaVegaCALLPUTPricing.KeyDown += new KeyEventHandler(grdTopologiaVegaCALLPUTPricing_KeyDown);
            _TopologiaVegaPricingControl.grdTopologiaVegaRRFLYPricing.KeyDown += new KeyEventHandler(grdTopologiaVegaRRFLYPricing_KeyDown);
            _TopologiaVegaPricingControl.grdTopologiaVolatilidadesPricing.KeyDown += new KeyEventHandler(grdTopologiaVegaVolatilidadesPricing_KeyDown);
            _TopologiaVegaPricingControl.grdTopologiaVegaStrikesPricing.KeyDown += new KeyEventHandler(grdTopologiaVegaStrikesPricing_KeyDown);

            #region SetChange

            valtxtNocional.DecimalPlaces = 2;
            valtxtNocional.SetChange(txtNocional, 0);
            valtxtNocional.textchange = false;

            valtxtNocionalStrangle.DecimalPlaces = 0;
            valtxtNocionalStrangle.SetChange(txtNocionalStrangle, 0);
            valtxtNocionalStrangle.textchange = false;

            valtxtStrike1.DecimalPlaces = 2;
            valtxtStrike1.SetChange(txtStrike1, 0);
            valtxtStrike1.textchange = false;

            valtxtStrike2.DecimalPlaces = 2;
            valtxtStrike2.SetChange(txtStrike2, 0);
            valtxtStrike2.textchange = false;

            valtxtStrike3.DecimalPlaces = 2;
            valtxtStrike3.SetChange(txtStrike3, 0);
            valtxtStrike3.textchange = false;

            valtxtStrike4.DecimalPlaces = 2;
            valtxtStrike4.SetChange(txtStrike4, 0);
            valtxtStrike4.textchange = false;

            valtxtDelta1.DecimalPlaces = 2;
            valtxtDelta1.SetChange(txtDelta1, 0);
            valtxtDelta1.textchange = false;

            valtxtDelta2.DecimalPlaces = 2;
            valtxtDelta2.SetChange(txtDelta2, 0);
            valtxtDelta2.textchange = false;

            valtxtDelta3.DecimalPlaces = 2;
            valtxtDelta3.SetChange(txtDelta3, 0);
            valtxtDelta3.textchange = false;

            valtxtSpotCosto.DecimalPlaces = 4;
            valtxtSpotCosto.SetChange(txtSpotCosto, 0);
            valtxtSpotCosto.textchange = false;

            valtxtPuntosCosto.DecimalPlaces = 4;
            valtxtPuntosCosto.SetChange(txtPuntosCosto, 0);
            valtxtPuntosCosto.textchange = false;
            this.txtPuntosCosto.Text = "";

            valtxtSpotValorizacion.DecimalPlaces = 4;
            valtxtSpotValorizacion.SetChange(txtSpotValorizacion, 0);
            valtxtSpotValorizacion.textchange = false;

            valtxtUnwind.DecimalPlaces = 0;
            valtxtUnwind.SetChange(txtUnwind, 0);
            valtxtUnwind.textchange = false;

            valtxtUnwindCosto.DecimalPlaces = 0;
            valtxtUnwindCosto.SetChange(txtUnwind, 0);
            valtxtUnwindCosto.textchange = false;

            valtxtPrimaContrato.DecimalPlaces = 0;
            valtxtPrimaContrato.SetChange(txtPrimaContrato, 0);
            valtxtPrimaContrato.textchange = false;

            valtxtParidadPrima.DecimalPlaces = 4;
            valtxtParidadPrima.SetChange(txtDistribucion, 0);
            valtxtParidadPrima.textchange = false;

            valtxtDistribucion.DecimalPlaces = 0;
            valtxtDistribucion.SetChange(txtDistribucion, 0);
            valtxtDistribucion.textchange = false;

            valtxtMtMValorizacion.DecimalPlaces = 0;
            valtxtMtMValorizacion.SetChange(txtMtMContrato, 0);
            valtxtMtMValorizacion.textchange = false;

            // 5843
            valtxtResultadoVta.DecimalPlaces = 0;
            valtxtResultadoVta.SetChange(txtResultadoVta, 0);
            valtxtResultadoVta.textchange = false;

            valtxtInterpVol_Strike.DecimalPlaces = 4;
            valtxtInterpVol_Strike.SetChange(txtInterpVol_Strike, 0);
            valtxtInterpVol_Strike.textchange = false;
            txtInterpVol_Strike.Text = "";

            #endregion SetChange

            ReCreateDataGrid();
            IsLoading = false;
        }

        #region Auxiliares de Pantalla

        #region Auxiliares de Efectos Visuales de Pantalla

        private void StartInitFront() { StartLoading(); }
        private void StopInitFront()
        {
            if (IsLoadedFrontData && /*IsLoadedCustomers &&*/ IsLoadedPortfolioAndBook)
            {
                StopLoading();
            }
        }
        private void StartLoading() { a.StartLoading(this); }
        private void StopLoading() { a.StopLoading(this); }
        private void StartFixing() { a.StartFixing(this); }
        private void StopFixing() { a.StopFixing(this); }
        private void _Guardar_MaskCollapsed()
        {
            popUpGuardar.Close();
            this.Mask.Visibility = Visibility.Collapsed;
            this.IdBtnLimpiar.IsEnabled = true;
            this.radioEntregaFisica.IsEnabled = true;
            this.IdBtnGuardar.IsEnabled = true;
        }

        #endregion Auxiliares de Efectos de Pantalla

        private void StartLoading(Canvas canvas)
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

        private void StopLoading(Canvas canvas)
        {
            Canvas _TransparentMasnk = canvas.Children.First(x => x.GetValue(NameProperty).Equals(canvas.Name + "Mask")) as Canvas;

            canvas.Children.Remove(_TransparentMasnk);
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

        #region Auxiliares de Limpieza Valores de Pantalla

        /// <summary>
        /// Limpia la pantalla de ingreso de operaciones.
        /// </summary>
        private void ClearData() { a.ClearData(this); event_SendChangeTitle(_TitleOriginal, UserControlName); }
        /// <summary>
        /// Limpia los TextBox de Griegas, no se usa...
        /// </summary>
        private void ClearGriegas() { a.ClearGriegas(this); }
        /// <summary>
        /// Setea todos los valores de pantalla a double.NaN.ToString()
        /// Utilizar en caso de error no controlado.
        /// </summary>
        private void OutPutNaN() { a.OutPutNaN(this); }

        #endregion Auxiliares de Limpieza Valores de Pantalla

        /// <summary>
        /// Falta migrar a Auxiliares...
        /// </summary>
        private void Logica_Strikes_Delta()
        {
            Enable_RadioButtons_Solver();

            if ((!_opcionEstructuraSeleccionada.Codigo.Equals("-1") && !_opcionEstructuraSeleccionada.Codigo.Equals("0"))
                && this.txtDelta1 != null && this.txtDelta2 != null && this.txtDelta3 != null
                && this.txtStrike1 != null && this.txtStrike2 != null && this.txtStrike3 != null && this.txtStrike4 != null)
            {
                if (_opcionEstructuraSeleccionada.Codigo.Equals("6") || _opcionEstructuraSeleccionada.Codigo.Equals("13"))//PRD_12567
                {
                    #region Seteo Pantalla Estructura 6 Forward Sintético
                    this.txtStrike1.IsEnabled = true;
                    this.txtStrike2.IsEnabled = false;
                    this.txtStrike3.IsEnabled = false;
                    this.txtStrike4.IsEnabled = false;

                    this.unidadStrike1.Text = "CLP/USD";
                    this.unidadStrike2.Text = "";
                    this.unidadStrike3.Text = "";
                    this.unidadStrike4.Text = "";

                    if (_opcionEstructuraSeleccionada.Codigo.Equals("13"))
                    {
                        this.txtStrikeCallPut1.Text = "Spread";
                    }
                    else
                    {
                        this.txtStrikeCallPut1.Text = "Fwd";
                    }

                    this.txtStrikeCallPut2.Text = "";
                    this.txtStrikeCallPut3.Text = "";
                    this.txtStrikeCallPut4.Text = "";

                    this.txtDelta1.IsEnabled = false;
                    this.txtDelta2.IsEnabled = false;
                    this.txtDelta3.IsEnabled = false;

                    this.unidadDelta1.Text = "";
                    this.unidadDelta2.Text = "";
                    this.unidadDelta3.Text = "";

                    this.txtDeltaCallPut1.Text = "";
                    this.txtDeltaCallPut2.Text = "";
                    this.txtDeltaCallPut3.Text = "";

                    this.txtNocionalContraMoneda.IsEnabled = true;

                    if (((ComboBoxItem)comboPayOff.SelectedItem).Content.Equals("Vanilla"))
                    {
                        (this.comboBsFwdBsSpotAsianMomenos.Items[0] as ComboBoxItem).IsEnabled = true;
                        (this.comboBsFwdBsSpotAsianMomenos.Items[1] as ComboBoxItem).IsEnabled = true;
                        (this.comboBsFwdBsSpotAsianMomenos.Items[2] as ComboBoxItem).IsEnabled = false;
                    }
                    else
                    {
                        (this.comboBsFwdBsSpotAsianMomenos.Items[0] as ComboBoxItem).IsEnabled = false;
                        (this.comboBsFwdBsSpotAsianMomenos.Items[1] as ComboBoxItem).IsEnabled = false;
                        (this.comboBsFwdBsSpotAsianMomenos.Items[2] as ComboBoxItem).IsEnabled = true;
                    }

                    this.txtSpotCosto.IsEnabled = true;
                    #endregion
                }
                else if (_opcionEstructuraSeleccionada.Codigo.Equals("7"))
                {
                    #region Seteo Pantalla Estructura 7 Strangle
                    if (this.itemTabSrikes.IsSelected)
                    {
                        this.txtStrike1.IsEnabled = true;
                        this.txtStrike2.IsEnabled = true;
                        this.txtStrike3.IsEnabled = false;
                        this.txtStrike4.IsEnabled = false;

                        this.unidadStrike1.Text = "CLP/USD";
                        this.unidadStrike2.Text = "CLP/USD";
                        this.unidadStrike3.Text = "";
                        this.unidadStrike4.Text = "";

                        this.txtStrikeCallPut1.Text = "Call";
                        this.txtStrikeCallPut2.Text = "Put";
                        this.txtStrikeCallPut3.Text = "";
                        this.txtStrikeCallPut4.Text = "";

                        this.txtDelta1.IsEnabled = false;
                        this.txtDelta2.IsEnabled = false;
                        this.txtDelta3.IsEnabled = false;

                        this.txtDeltaCallPut1.Text = "Strangle";
                        this.txtDeltaCallPut2.Text = "";
                        this.txtDeltaCallPut3.Text = "";
                    }
                    else
                    {
                        this.txtStrike1.IsEnabled = false;
                        this.txtStrike2.IsEnabled = false;
                        this.txtStrike3.IsEnabled = false;
                        this.txtStrike4.IsEnabled = false;

                        this.txtStrikeCallPut1.Text = "Call";
                        this.txtStrikeCallPut2.Text = "Put";
                        this.txtStrikeCallPut3.Text = "";
                        this.txtStrikeCallPut4.Text = "";

                        this.txtDelta1.IsEnabled = true;
                        this.txtDelta2.IsEnabled = false;
                        this.txtDelta3.IsEnabled = false;

                        this.unidadDelta1.Text = "%";
                        this.unidadDelta2.Text = "%";
                        this.unidadDelta3.Text = "";

                        this.txtDeltaCallPut1.Text = "Strangle";
                        this.txtDeltaCallPut2.Text = "";
                        this.txtDeltaCallPut3.Text = "";
                    }

                    this.txtNocionalContraMoneda.IsEnabled = false;
                    (this.comboBsFwdBsSpotAsianMomenos.Items[0] as ComboBoxItem).IsEnabled = true;
                    (this.comboBsFwdBsSpotAsianMomenos.Items[1] as ComboBoxItem).IsEnabled = true;
                    (this.comboBsFwdBsSpotAsianMomenos.Items[2] as ComboBoxItem).IsEnabled = false;
                    this.comboBsFwdBsSpotAsianMomenos.SelectedIndex = 1;

                    this.txtSpotCosto.IsEnabled = true;
                    #endregion
                }
                else if (_opcionEstructuraSeleccionada.Codigo.Equals("1"))
                {
                    #region Seteo Pantalla Estructura 1 Straddle
                    if (this.itemTabSrikes.IsSelected)
                    {
                        this.txtStrike1.IsEnabled = true;
                        this.txtStrike2.IsEnabled = false;
                        this.txtStrike3.IsEnabled = false;
                        this.txtStrike4.IsEnabled = false;

                        this.unidadStrike1.Text = "CLP/USD";
                        this.unidadStrike2.Text = "";
                        this.unidadStrike3.Text = "";
                        this.unidadStrike4.Text = "";

                        this.txtStrikeCallPut1.Text = "Straddle";
                        this.txtStrikeCallPut2.Text = "";
                        this.txtStrikeCallPut3.Text = "";
                        this.txtStrikeCallPut4.Text = "";

                        this.txtDelta1.IsEnabled = false;
                        this.txtDelta2.IsEnabled = false;
                        this.txtDelta3.IsEnabled = false;

                        this.txtDeltaCallPut1.Text = "Straddle";
                        this.txtDeltaCallPut2.Text = "";
                        this.txtDeltaCallPut3.Text = "";
                    }
                    else
                    {
                        this.txtStrike1.IsEnabled = false;
                        this.txtStrike2.IsEnabled = false;
                        this.txtStrike3.IsEnabled = false;
                        this.txtStrike4.IsEnabled = false;

                        this.txtStrikeCallPut1.Text = "Straddle";
                        this.txtStrikeCallPut2.Text = "";
                        this.txtStrikeCallPut3.Text = "";
                        this.txtStrikeCallPut4.Text = "";

                        this.txtDelta1.IsEnabled = true;
                        this.txtDelta2.IsEnabled = false;
                        this.txtDelta3.IsEnabled = false;

                        this.unidadDelta1.Text = "%";
                        this.unidadDelta2.Text = "";
                        this.unidadDelta3.Text = "";

                        this.txtDeltaCallPut1.Text = "Straddle";
                        this.txtDeltaCallPut2.Text = "";
                        this.txtDeltaCallPut3.Text = "";
                    }

                    this.txtNocionalContraMoneda.IsEnabled = true;
                    (this.comboBsFwdBsSpotAsianMomenos.Items[0] as ComboBoxItem).IsEnabled = true;
                    (this.comboBsFwdBsSpotAsianMomenos.Items[1] as ComboBoxItem).IsEnabled = true;
                    (this.comboBsFwdBsSpotAsianMomenos.Items[2] as ComboBoxItem).IsEnabled = false;

                    this.txtSpotCosto.IsEnabled = true;
                    #endregion
                }
                else if (_opcionEstructuraSeleccionada.Codigo.Equals("2"))
                {
                    #region Seteo Pantalla Estructura 2 Collar (Risk Reversal)
                    if (this.itemTabSrikes.IsSelected)
                    {
                        this.txtStrike1.IsEnabled = true;
                        this.txtStrike2.IsEnabled = true;
                        this.txtStrike3.IsEnabled = false;
                        this.txtStrike4.IsEnabled = false;

                        this.unidadStrike1.Text = "CLP/USD";
                        this.unidadStrike2.Text = "CLP/USD";
                        this.unidadStrike3.Text = "";
                        this.unidadStrike4.Text = "";

                        this.txtStrikeCallPut1.Text = "Call";
                        this.txtStrikeCallPut2.Text = "Put";
                        this.txtStrikeCallPut3.Text = "";
                        this.txtStrikeCallPut4.Text = "";

                        this.txtDelta1.IsEnabled = false;
                        this.txtDelta2.IsEnabled = false;
                        this.txtDelta3.IsEnabled = false;

                        this.txtDeltaCallPut1.Text = "RR";
                        this.txtDeltaCallPut2.Text = "";
                        this.txtDeltaCallPut3.Text = "";
                    }
                    else
                    {
                        this.txtStrike1.IsEnabled = false;
                        this.txtStrike2.IsEnabled = false;
                        this.txtStrike3.IsEnabled = false;
                        this.txtStrike4.IsEnabled = false;

                        this.txtStrikeCallPut1.Text = "Call";
                        this.txtStrikeCallPut2.Text = "Put";
                        this.txtStrikeCallPut3.Text = "";
                        this.txtStrikeCallPut4.Text = "";

                        this.txtDelta1.IsEnabled = true;
                        this.txtDelta2.IsEnabled = false;
                        this.txtDelta3.IsEnabled = false;

                        this.unidadDelta1.Text = "%";
                        this.unidadDelta2.Text = "";
                        this.unidadDelta3.Text = "";

                        this.txtDeltaCallPut1.Text = "RR";
                        this.txtDeltaCallPut2.Text = "";
                        this.txtDeltaCallPut3.Text = "";
                    }

                    this.txtNocionalContraMoneda.IsEnabled = false;
                    (this.comboBsFwdBsSpotAsianMomenos.Items[0] as ComboBoxItem).IsEnabled = true;
                    (this.comboBsFwdBsSpotAsianMomenos.Items[1] as ComboBoxItem).IsEnabled = true;
                    (this.comboBsFwdBsSpotAsianMomenos.Items[2] as ComboBoxItem).IsEnabled = false;
                    this.comboBsFwdBsSpotAsianMomenos.SelectedIndex = 1;

                    this.txtSpotCosto.IsEnabled = true;
                    #endregion
                }
                else if (_opcionEstructuraSeleccionada.Codigo.Equals("3"))
                {
                    #region Seteo Pantalla Estructura 3 Butterfly
                    if (this.itemTabSrikes.IsSelected)
                    {
                        this.txtStrike1.IsEnabled = true;
                        this.txtStrike2.IsEnabled = true;
                        this.txtStrike3.IsEnabled = true;
                        this.txtStrike4.IsEnabled = true;

                        this.unidadStrike1.Text = "CLP/USD";
                        this.unidadStrike2.Text = "CLP/USD";
                        this.unidadStrike3.Text = "CLP/USD";
                        this.unidadStrike4.Text = "";

                        this.txtStrikeCallPut1.Text = "Call Strangle";
                        this.txtStrikeCallPut2.Text = "Put Strangle";
                        this.txtStrikeCallPut3.Text = "Straddle";
                        this.txtStrikeCallPut4.Text = "";

                        this.txtDelta1.IsEnabled = false;
                        this.txtDelta2.IsEnabled = false;
                        this.txtDelta3.IsEnabled = false;

                        this.txtDeltaCallPut1.Text = "BF";
                        this.txtDeltaCallPut2.Text = "";
                        this.txtDeltaCallPut3.Text = "";
                    }
                    else
                    {
                        this.txtStrike1.IsEnabled = false;
                        this.txtStrike2.IsEnabled = false;
                        this.txtStrike3.IsEnabled = false;
                        this.txtStrike4.IsEnabled = false;

                        this.txtStrikeCallPut1.Text = "Call Strangle";
                        this.txtStrikeCallPut2.Text = "Put Strangle";
                        this.txtStrikeCallPut3.Text = "Straddle";
                        this.txtStrikeCallPut4.Text = "";

                        this.txtDelta1.IsEnabled = true;
                        this.txtDelta2.IsEnabled = false;
                        this.txtDelta3.IsEnabled = false;

                        this.unidadDelta1.Text = "%";
                        this.unidadDelta2.Text = "%";
                        this.unidadDelta3.Text = "%";

                        this.txtDeltaCallPut1.Text = "BF";
                        this.txtDeltaCallPut2.Text = "";
                        this.txtDeltaCallPut3.Text = "";
                    }

                    this.txtNocionalContraMoneda.IsEnabled = false;
                    RemoveBlockTextBox(txtNocionalContraMoneda);
                    (this.comboBsFwdBsSpotAsianMomenos.Items[0] as ComboBoxItem).IsEnabled = true;
                    (this.comboBsFwdBsSpotAsianMomenos.Items[1] as ComboBoxItem).IsEnabled = true;
                    (this.comboBsFwdBsSpotAsianMomenos.Items[2] as ComboBoxItem).IsEnabled = false;
                    this.comboBsFwdBsSpotAsianMomenos.SelectedIndex = 1;

                    this.txtSpotCosto.IsEnabled = true;
                    #endregion
                }
                else if (_opcionEstructuraSeleccionada.Codigo.Equals("4") || _opcionEstructuraSeleccionada.Codigo.Equals("5"))
                {
                    #region Seteo Pantalla Estructura 4 & 5 Forward Utilidad/Pérdida Acotada
                    if (this.itemTabSrikes.IsSelected)
                    {
                        this.txtStrike1.IsEnabled = true;
                        this.txtStrike2.IsEnabled = true;
                        this.txtStrike3.IsEnabled = false;
                        this.txtStrike4.IsEnabled = false;

                        this.unidadStrike1.Text = "CLP/USD";
                        this.unidadStrike2.Text = "CLP/USD";
                        this.unidadStrike3.Text = "";
                        this.unidadStrike4.Text = "";

                        this.txtStrikeCallPut1.Text = "Fwd";
                        this.txtStrikeCallPut2.Text = "Cota";
                        this.txtStrikeCallPut3.Text = "";
                        this.txtStrikeCallPut4.Text = "";

                        this.txtDelta1.IsEnabled = false;
                        this.txtDelta2.IsEnabled = false;
                        this.txtDelta3.IsEnabled = false;

                        this.txtDeltaCallPut1.Text = "";
                        this.txtDeltaCallPut2.Text = "";
                        this.txtDeltaCallPut3.Text = "";
                    }
                    else
                    {
                        this.txtStrike1.IsEnabled = false;
                        this.txtStrike2.IsEnabled = false;
                        this.txtStrike3.IsEnabled = false;
                        this.txtStrike4.IsEnabled = false;

                        this.txtStrikeCallPut1.Text = "Fwd";
                        this.txtStrikeCallPut2.Text = "Cota";
                        this.txtStrikeCallPut3.Text = "";
                        this.txtStrikeCallPut4.Text = "";

                        this.txtDelta1.IsEnabled = false;
                        this.txtDelta2.IsEnabled = false;
                        this.txtDelta3.IsEnabled = false;

                        this.unidadDelta1.Text = "%";
                        this.unidadDelta2.Text = "%";
                        this.unidadDelta3.Text = "";

                        this.txtDeltaCallPut1.Text = "";
                        this.txtDeltaCallPut2.Text = "";
                        this.txtDeltaCallPut3.Text = "";
                    }

                    this.txtNocionalContraMoneda.IsEnabled = true; ;
                    (this.comboBsFwdBsSpotAsianMomenos.Items[0] as ComboBoxItem).IsEnabled = true;
                    (this.comboBsFwdBsSpotAsianMomenos.Items[1] as ComboBoxItem).IsEnabled = true;
                    (this.comboBsFwdBsSpotAsianMomenos.Items[2] as ComboBoxItem).IsEnabled = false;
                    this.comboBsFwdBsSpotAsianMomenos.SelectedIndex = 1;

                    this.txtSpotCosto.IsEnabled = true;
                    #endregion
                }
                // CALL-PUT SPREAD
                else if (_opcionEstructuraSeleccionada.Codigo.Equals("11") || _opcionEstructuraSeleccionada.Codigo.Equals("12"))
                {
                    #region Seteo Pantalla Estructura Call/Put Spread
                    if (this.itemTabSrikes.IsSelected)
                    {
                        this.txtStrike1.IsEnabled = true;
                        this.txtStrike2.IsEnabled = true;
                        this.txtStrike3.IsEnabled = false;
                        this.txtStrike4.IsEnabled = false;

                        this.unidadStrike1.Text = "CLP/USD";
                        this.unidadStrike2.Text = "CLP/USD";
                        this.unidadStrike3.Text = "";
                        this.unidadStrike4.Text = "";

                        this.txtDelta1.IsEnabled = false;
                        this.txtDelta2.IsEnabled = false;
                        this.txtDelta3.IsEnabled = false;

                        //Call Spread
                        if (_opcionEstructuraSeleccionada.Codigo.Equals("11"))
                        {
                            //Compra Call Spread
                            if (this.radioCompra.IsChecked == true)
                            {
                                this.txtStrikeCallPut1.Text = "Piso";
                                this.txtStrikeCallPut2.Text = "Techo";
                            }
                            //Venta Call Spread
                            else
                            {
                                this.txtStrikeCallPut1.Text = "Techo";
                                this.txtStrikeCallPut2.Text = "Piso";
                            }
                        }
                        //Put Spread
                        else
                        {
                            //Compra Put Spread
                            if (this.radioCompra.IsChecked == true)
                            {
                                this.txtStrikeCallPut1.Text = "Techo";
                                this.txtStrikeCallPut2.Text = "Piso";
                            }
                            //Venta Put Spread
                            else
                            {
                                this.txtStrikeCallPut1.Text = "Piso";
                                this.txtStrikeCallPut2.Text = "Techo";
                            }
                        }

                        this.txtStrikeCallPut3.Text = "";
                        this.txtStrikeCallPut4.Text = "";

                        this.txtDeltaCallPut1.Text = "";
                        this.txtDeltaCallPut2.Text = "";
                        this.txtDeltaCallPut3.Text = "";
                    }
                    else
                    {
                        this.txtStrike1.IsEnabled = false;
                        this.txtStrike2.IsEnabled = false;
                        this.txtStrike3.IsEnabled = false;
                        this.txtStrike4.IsEnabled = false;

                        this.txtDelta1.IsEnabled = false;
                        this.txtDelta2.IsEnabled = false;
                        this.txtDelta3.IsEnabled = false;

                        this.unidadDelta1.Text = "";
                        this.unidadDelta2.Text = "";
                        this.unidadDelta3.Text = "";

                        if (_opcionEstructuraSeleccionada.Codigo.Equals("11"))
                        {
                            this.txtStrikeCallPut1.Text = "Call";
                            this.txtStrikeCallPut2.Text = "Call";
                        }
                        else
                        {
                            this.txtStrikeCallPut1.Text = "Put";
                            this.txtStrikeCallPut2.Text = "Put";
                        }
                        this.txtStrikeCallPut3.Text = "";
                        this.txtStrikeCallPut4.Text = "";

                        this.txtDeltaCallPut1.Text = "";
                        this.txtDeltaCallPut2.Text = "";
                        this.txtDeltaCallPut3.Text = "";
                    }

                    this.txtNocionalContraMoneda.IsEnabled = false;
                    (this.comboBsFwdBsSpotAsianMomenos.Items[0] as ComboBoxItem).IsEnabled = true;
                    (this.comboBsFwdBsSpotAsianMomenos.Items[1] as ComboBoxItem).IsEnabled = true;
                    (this.comboBsFwdBsSpotAsianMomenos.Items[2] as ComboBoxItem).IsEnabled = false;

                    this.txtSpotCosto.IsEnabled = false;

                    #endregion
                }
                else if (_opcionEstructuraSeleccionada.Codigo.Equals("14"))
                {
                    #region Seteo Pantalla Estructura Call Spread Doble
                    if (this.itemTabSrikes.IsSelected)
                    {
                        this.txtStrike1.IsEnabled = true;
                        this.txtStrike2.IsEnabled = true;
                        this.txtStrike3.IsEnabled = true;
                        this.txtStrike4.IsEnabled = true;

                        this.unidadStrike1.Text = "CLP/USD";
                        this.unidadStrike2.Text = "CLP/USD";
                        this.unidadStrike3.Text = "CLP/USD";
                        this.unidadStrike4.Text = "CLP/USD";

                        this.txtDelta1.IsEnabled = false;
                        this.txtDelta2.IsEnabled = false;
                        this.txtDelta3.IsEnabled = false;

                        this.txtStrikeCallPut1.Text = "Strike1";
                        this.txtStrikeCallPut2.Text = "Strike2";
                        this.txtStrikeCallPut3.Text = "Strike3";
                        this.txtStrikeCallPut4.Text = "Strike4";
                    }
                    else
                    {
                        //No hay implementación de Deltas.
                    }

                    this.txtNocionalContraMoneda.IsEnabled = false;
                    (this.comboBsFwdBsSpotAsianMomenos.Items[0] as ComboBoxItem).IsEnabled = true;
                    (this.comboBsFwdBsSpotAsianMomenos.Items[1] as ComboBoxItem).IsEnabled = true;
                    (this.comboBsFwdBsSpotAsianMomenos.Items[2] as ComboBoxItem).IsEnabled = false;

                    this.txtSpotCosto.IsEnabled = false;

                    #endregion Seteo Pantalla Estructura Call Spread Doble
                }
            }
            else if (_opcionEstructuraSeleccionada.Codigo.Equals("-1") || _opcionEstructuraSeleccionada.Codigo.Equals("0")
                //PRD7274 Strip Asiático se parece a opción asiática
                || _opcionEstructuraSeleccionada.Codigo.Equals("9") || _opcionEstructuraSeleccionada.Codigo.Equals("10"))
            {
                if (this.itemTabSrikes.IsSelected)
                {
                    if (globales._Estado == "" || globales._Estado == "C")
                    {
                        this.txtStrike1.IsEnabled = true;
                    }
                    this.txtStrike2.IsEnabled = false;
                    this.txtStrike3.IsEnabled = false;
                    this.txtStrike4.IsEnabled = false;

                    this.unidadStrike1.Text = "CLP/USD";
                    this.unidadStrike2.Text = "";
                    this.unidadStrike3.Text = "";
                    this.unidadStrike4.Text = "";

                    if (_opcionEstructuraSeleccionada.Codigo.Equals("-1"))
                    {
                        this.txtStrikeCallPut1.Text = "Call";
                    }
                    else
                    {
                        this.txtStrikeCallPut1.Text = "Put";
                    }
                    this.txtStrikeCallPut2.Text = "";
                    this.txtStrikeCallPut3.Text = "";
                    this.txtStrikeCallPut4.Text = "";

                    this.txtDelta1.IsEnabled = false;
                    this.txtDelta2.IsEnabled = false;
                    this.txtDelta3.IsEnabled = false;

                    this.txtDeltaCallPut1.Text = "%";
                }
                else
                {
                    this.txtStrike1.IsEnabled = false;
                    this.txtStrike2.IsEnabled = false;
                    this.txtStrike3.IsEnabled = false;
                    this.txtStrike4.IsEnabled = false;

                    if (_opcionEstructuraSeleccionada.Codigo.Equals("-1"))
                    {
                        this.txtStrikeCallPut1.Text = "Call";
                    }
                    else
                    {
                        this.txtStrikeCallPut1.Text = "Put";
                    }

                    if (((ComboBoxItem)this.comboPayOff.SelectedItem).Content.Equals("Vanilla"))
                    {
                        this.txtDelta1.IsEnabled = true;
                        this.txtDelta2.IsEnabled = false;
                        this.txtDelta3.IsEnabled = false;

                        this.unidadDelta1.Text = "%";
                        this.unidadDelta2.Text = "";
                        this.unidadDelta3.Text = "";

                        this.txtDeltaCallPut1.Text = _opcionEstructuraSeleccionada.Descripcion;
                        this.txtDeltaCallPut2.Text = "";
                        this.txtDeltaCallPut3.Text = "";
                    }
                    else
                    {
                        this.txtDelta1.IsEnabled = false;
                        this.txtDelta2.IsEnabled = false;
                        this.txtDelta3.IsEnabled = false;

                        this.unidadDelta1.Text = "";
                        this.unidadDelta2.Text = "";
                        this.unidadDelta3.Text = "";

                        this.txtDeltaCallPut1.Text = "";
                        this.txtDeltaCallPut2.Text = "";
                        this.txtDeltaCallPut3.Text = "";
                    }
                }

                if (comboPayOff != null && comboPayOff.Items.Count > 0 && ((ComboBoxItem)this.comboPayOff.SelectedItem).Content.Equals("Vanilla"))
                {
                    this.txtNocionalContraMoneda.IsEnabled = true;

                    PutBlockTextBox(txtNocionalContraMoneda);

                    (this.comboBsFwdBsSpotAsianMomenos.Items[0] as ComboBoxItem).IsEnabled = true;
                    (this.comboBsFwdBsSpotAsianMomenos.Items[1] as ComboBoxItem).IsEnabled = true;
                    (this.comboBsFwdBsSpotAsianMomenos.Items[2] as ComboBoxItem).IsEnabled = false;

                    if (globales._Estado == "")
                    {
                        this.txtSpotCosto.IsEnabled = true;
                    }
                }
                else
                {
                    this.txtNocionalContraMoneda.IsEnabled = true;
                    (this.comboBsFwdBsSpotAsianMomenos.Items[0] as ComboBoxItem).IsEnabled = false;
                    (this.comboBsFwdBsSpotAsianMomenos.Items[1] as ComboBoxItem).IsEnabled = false;
                    (this.comboBsFwdBsSpotAsianMomenos.Items[2] as ComboBoxItem).IsEnabled = true;
                    this.comboBsFwdBsSpotAsianMomenos.SelectedIndex = 2;

                    if (globales._Estado == "")
                    {
                        this.txtSpotCosto.IsEnabled = true;
                    }
                }
            }
        }

        #endregion Auxiliares de Pantalla

        private void _TablaFixing_event_ShowFixing(bool value)
        {
            if (value)
            {
                StartFixing();
            }
            else
            {
                StopFixing();
                btnTablaFixing.IsEnabled = true;
                IsChangeFixing = false;
            }
        }

        private void TopologiaVegaNew()
        {
            this._TopologiaVegaPricingControl.grdTopologiaVegaCALLPUTPricing.ItemsSource = TopologiaVegaCALLPUTListPricing;
            this._TopologiaVegaPricingControl.grdTopologiaVegaRRFLYPricing.ItemsSource = TopologiaVegaATMRRFLYPricingList;
        }

        //cambio de scope
        void event_ChangeDateFixing(DateTime date)
        {
            this.DatePickerVencimiento.SelectedDate = date;
            this.fechaVencimiento = date;
            this.txtPlazo.Text = date.Subtract(FechaDeProceso).Days.ToString() + "d";
        }

        //cambio de scope
        void _TablaFixing_event_TablaFixing_CalculaPeso(string tipoPeso_flag)
        {
            try
            {
                if (tipoPeso_flag.Equals("Equiproporcional") && _TablaFixing.fixingdataList.Count > 0)
                {
                    int _N = _TablaFixing.fixingdataList.Count;
                    double _peso;
                    try
                    {
                        _peso = 1.0 / _N;
                        if (_peso.Equals(double.NaN))
                        {
                            _peso = 0;
                        }
                    }
                    catch
                    {
                        _peso = 0;
                    }
                    for (int i = 0; i < _N; i++)
                    {
                        _TablaFixing.fixingdataList[i].Peso = _peso;
                    }

                    this.FixingDataList = _TablaFixing.fixingdataList;
                    _TablaFixing.Cargar(_TablaFixing.fixingdataList, isTablaFixingLoadedFromValcartera);
                }

                if (tipoPeso_flag.Equals("Proporcional al Tiempo") && _TablaFixing.fixingdataList.Count > 0)
                {
                    int _N = _TablaFixing.fixingdataList.Count;
                    double Dias_Totales = _TablaFixing.datePikerFin.SelectedDate.Value.Subtract(_TablaFixing.datePikerInicio.SelectedDate.Value).Days;
                    double _peso;

                    try
                    {
                        _peso = (_TablaFixing.fixingdataList[0].Fecha.Subtract(_TablaFixing.datePikerInicio.SelectedDate.Value).Days / Dias_Totales);
                        if (_peso.Equals(double.NaN))
                        {
                            _peso = 0;
                        }
                    }
                    catch
                    {
                        _peso = 0;
                    }

                    _TablaFixing.fixingdataList[0].Peso = _peso;

                    for (int i = 1; i < _N; i++)
                    {
                        try
                        {
                            _peso = (_TablaFixing.fixingdataList[i].Fecha.Subtract(_TablaFixing.fixingdataList[(i - 1)].Fecha).Days / Dias_Totales);
                            if (_peso.Equals(double.NaN))
                            {
                                _peso = 0;
                            }
                        }
                        catch
                        {
                            _peso = 0;
                        }
                        _TablaFixing.fixingdataList[i].Peso = _peso;
                    }

                    this.FixingDataList = _TablaFixing.fixingdataList;
                    _TablaFixing.Cargar(_TablaFixing.fixingdataList, isTablaFixingLoadedFromValcartera);


                }
            }
            catch { }
        }

        //cambio de scope
        void _TablaFixing_event_TablaFixingLoadedFromValCartera(bool isTrue)
        {
            this.isTablaFixingLoadedFromValcartera = isTrue;
        }

        //cambio de scope
        void Event_SendSave()
        {
            event_btnRecargarCartera_Clicked(null, null);
            ClearData();
            this.radioOpcCall.IsChecked = true;
        }

        private void _Guardar_SetData()
        {
            _Guardar.CustomersList = this.CustomersList;
            _Guardar.BookList = this.BookList;
            _Guardar.FinancialPortFolioList = this.FinancialPortFolioList;
            _Guardar.PortFolioRulesList = this.PortFolioRulesList;
            _Guardar.SubPortFolioRulesList = this.SubPortFolioRulesList;
            // PRD-3162
            _Guardar.ConfiguracionPortFolioList = this.ConfiguracionPortFolioList;
            _Guardar.FinancialPortFolioPrioridadList = this.FinancialPortFolioPrioridadList;

            _Guardar.FormaDePagoList = this.formaDePagoList;
            _Guardar.xmlData = this.xmlCreate;
            _Guardar.Compensacion_EntregaFisica = radioCompensacion.IsChecked.Value ? "C" : "E";
            _Guardar.ModalidadPago = radioCompensacion.IsChecked.Value ? true : false;

            if (globales._Estado.Equals("E"))
            {
                _Guardar.Compensacion_EntregaFisica = radioCompensacionEjercicio.IsChecked.Value ? "C" : "E";
                _Guardar.ModalidadPago = radioCompensacionEjercicio.IsChecked.Value ? true : false;
            }

            _Guardar.MonedaNocional = int.Parse(this.codigoMon1);
            _Guardar.MonedaNocionalContraMoneda = int.Parse(this.codigoMon2);

            if (((ComboBoxItem)ComboUnidadPrima.SelectedItem).Content.Equals("CLP"))
            {
                this._Guardar.codigoMonPrima = int.Parse(this.codigoMon2);
                this._Guardar.CodigoMonedaPrima = int.Parse(this.codigoMon2);
            }
            else
            {
                this._Guardar.codigoMonPrima = int.Parse(this.codigoMon1);
                this._Guardar.CodigoMonedaPrima = int.Parse(this.codigoMon1);
            }
        }

        //cambio de scope
        void LoadSetPreciosSpot(DateTime FechaProceso, double Spot, string CurvaDom, string CurvaFor, int enumSetpricing)
        {
            PutLayer(this.PrincipalCanvas, "CARGANDO SET DE PRECIOS...");
            PutLayer(this.CanasTab2, "CARGANDO SET DE PRECIOS...");

            if (grdTopologiaVegaCALLPUT != null)
            {
                this.grdTopologiaVegaCALLPUT.ItemsSource = null;
            }
            if (grdTopologiaVegaRRFLY != null)
            {
                this.grdTopologiaVegaRRFLY.ItemsSource = null;
            }
            if (grdTotalizadorValCartera != null)
            {
                this.grdTotalizadorValCartera.ItemsSource = null;
            }
            if (MtMGriegasTotalizador != null)
            {
                this.MtMGriegasTotalizador = null;
            }
            if (grdSensibilidadCLP.ItemsSource != null)
            {
                grdSensibilidadCLP.ItemsSource = null;
            }
            if (grdSensibilidadLocal.ItemsSource != null)
            {
                grdSensibilidadLocal.ItemsSource = null;
            }

            if (txtPosicionOpciones != null)
                txtPosicionOpciones.Text = "";
            if (txtTotalDeltas != null)
                txtTotalDeltas.Text = "";
            ActualizarTotalizadorDeltas();

            string _idCurvasXML = "<CurvasMoneda >\n";
            _idCurvasXML += "<itemCurva ID='" + CurvaDom + "'/>\n";
            _idCurvasXML += "<itemCurva ID='" + CurvaFor + "'/>\n";
            _idCurvasXML += "</CurvasMoneda>";

            SrvValorizador.SrvValorizadorCarteraSoapClient SrvValorizador = wsGlobales.Valorizador;// new AdminOpciones.SrvValorizador.SrvValorizadorCarteraSoapClient();
            SrvValorizador.GetSetPreciosConSpotCompleted += new EventHandler<AdminOpciones.SrvValorizador.GetSetPreciosConSpotCompletedEventArgs>(SrvValorizador_GetSetPreciosConSpotCompleted);
            SrvValorizador.GetSetPreciosConSpotAsync(FechaProceso, Spot, paridad, "DO", _idCurvasXML, enumSetpricing);
        }

        //cambio de scope
        void SrvValorizador_GetSetPreciosConSpotCompleted(object sender, AdminOpciones.SrvValorizador.GetSetPreciosConSpotCompletedEventArgs e)
        {//OJO de aquí debe saltar al StopSetPricing o de lo contratio se está cayendo.
            bool Status;
            bool isFechaSetDePreciosFechaAnt = false;
            XDocument SetPreciosXML = new XDocument(XDocument.Parse(e.Result));

            Status = SetPreciosXML.Element("Data").Element("Status").Attribute("Value").Value.Equals("OK") ? true : false;
            isFechaSetDePreciosFechaAnt = SetPreciosXML.Element("Data").Element("Status").Attribute("FechaAnt").Value.Equals("1") ? true : false;

            //#region SpotBS

            //this.spot = Convert.ToDouble(SetPreciosXML.Element("Data").Element("Spot").Attribute("Value").Value);
            //this.BSSpotValorizacion = this.spot;
            //this.txtSpotCosto.Text = BSSpotValorizacion.ToString();
            //this.txtSpotValorizacion.Text = BSSpotValorizacion.ToString();
            //this._TablaFixing.spot = this.spot;
            //#endregion

            #region Fecha Set de Precios

            FechaSetdePrecios = DateTime.Parse(SetPreciosXML.Element("Data").Element("FechaSetPrecios").Attribute("Fecha").Value);
            this._TablaFixing.FechaSetPrecios = FechaSetdePrecios;

            #endregion

            ShowSmile(e.Result);
            ShowYield(e.Result);

            #region Puntos Fwd

            CurvaFwUSD = new List<StructItemPuntosForward>();

            StructItemPuntosForward _itemCurvaForward;

            foreach (XElement _itemCurva in SetPreciosXML.Element("Data").Element("PesosForward").Descendants("itemCurva"))
            {
                _itemCurvaForward = new StructItemPuntosForward();

                _itemCurvaForward.dias = int.Parse(_itemCurva.Attribute("Dias").Value);
                _itemCurvaForward.tenor = _itemCurva.Attribute("Tenor").Value;
                _itemCurvaForward.Puntos = double.Parse(_itemCurva.Attribute("Puntos").Value);
                CurvaFwUSD.Add(_itemCurvaForward);
            }

            this.grdCurvaFwUSD.ItemsSource = null;
            this.grdCurvaFwUSD.ItemsSource = CurvaFwUSD;

            #endregion

            if (isFechaSetDePreciosFechaAnt && Status)
            {
                this.DatePickerSetPrecios.SelectedDate = FechaSetdePrecios;
                System.Windows.Browser.HtmlPage.Window.Alert("No se encontro Set de Precios para la fecha de proceso " + FechaDeProceso.ToString("dd-MM-yyyy") + "\n Se cargo Set de Precios de fecha " + FechaSetdePrecios.ToString("dd-MM-yyyy") + " ");
            }

            if (!Status)
            {
                QuitLayer(PrincipalCanvas);
                QuitLayer(CanasTab2);
                PutLayer(this.PrincipalCanvas, "SET DE PRECIOS INCOMPLETO");
                PutLayer(this.CanasTab2, "SET DE PRECIOS INCOMPLETO");
            }
            else
            {
                QuitLayer(this.PrincipalCanvas);
                QuitLayer(this.CanasTab2);

                this.isTextChanged = true;
                this.Valorizar();
            }
        }

        private void ShowSmile(string e)
        {
            SmileATMRRFLYList = new List<StructSmileATMRRFLY>();
            SmileCallPutList = new List<StructSmileCallPut>();
            SmileStrikesList = new List<StructSmileCallPut>();

            XDocument SetPreciosXML = new XDocument();
            SetPreciosXML = XDocument.Parse(e);

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
            this.grdAtmRRFly.ItemsSource = null;
            this.grdAtmRRFly.ItemsSource = this.SmileATMRRFLYList;
            this.comboAtmRRFlyCallPut.SelectedIndex = 0;

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

            this.grdStrikes.ItemsSource = null;
            this.grdStrikes.ItemsSource = SmileStrikesList;

            #endregion

            #endregion
        }

        private void ShowYield(string e)
        {

            XDocument SetPreciosXML = new XDocument();
            SetPreciosXML = XDocument.Parse(e);

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

            if (comboCurvas.Items.Count == 0)
            {
                foreach (StructCurvaMoneda _curva in CurvasMonedasList)
                {
                    if (_curva.CodigoCurva != null)
                        this.comboCurvas.Items.Add(_curva.CodigoCurva);
                }
            }

            if (CurvasMonedasList.Count > 0 && CurvasMonedasList[0].CodigoCurva != null)
            {
                this.comboCurvas.IsEnabled = true;
                this.comboCurvas.SelectedIndex = 0;
                this.grdCurvas.ItemsSource = CurvasMonedasList.First(x => x.CodigoCurva.Equals(comboCurvas.SelectedItem)).CurvaMoneda;
            }
            else
            {
                this.comboCurvas.IsEnabled = false;
                this.comboCurvas.Items.Clear();
                this.grdCurvas.ItemsSource = null;
            }

            #endregion
        }

        //cambio de scope
        void LoadSetPrecios(DateTime FechaProceso, string CurvaDom, string CurvaFor, int enumSetpricing)
        {
            if (this.MaskSetPricing.Visibility != Visibility.Visible)
            {
                PutLayer(this.PrincipalCanvas, "CARGANDO SET DE PRECIOS...");
                PutLayer(this.CanasTab2, "CARGANDO SET DE PRECIOS...");
                a.StartSetPricing(this);

                if (grdTopologiaVegaCALLPUT != null)
                {
                    this.grdTopologiaVegaCALLPUT.ItemsSource = null;
                }
                if (grdTopologiaVegaRRFLY != null)
                {
                    this.grdTopologiaVegaRRFLY.ItemsSource = null;
                }
                if (grdTotalizadorValCartera != null)
                {
                    this.grdTotalizadorValCartera.ItemsSource = null;
                }
                if (MtMGriegasTotalizador != null)
                {
                    this.MtMGriegasTotalizador = null;
                }
                if (txtPosicionOpciones != null)
                {
                    txtPosicionOpciones.Text = "";
                }
                if (txtTotalDeltas != null)
                {
                    txtTotalDeltas.Text = "";
                }
                if (grdSensibilidadCLP.ItemsSource != null)
                {
                    grdSensibilidadCLP.ItemsSource = null;
                }
                if (grdSensibilidadLocal.ItemsSource != null)
                {
                    grdSensibilidadLocal.ItemsSource = null;
                }
                ActualizarTotalizadorDeltas();


                string _idCurvasXML = "<CurvasMoneda >\n";
                _idCurvasXML += "<itemCurva ID='" + CurvaDom + "'/>\n";
                _idCurvasXML += "<itemCurva ID='" + CurvaFor + "'/>\n";
                _idCurvasXML += "<itemCurva ID='" + curvaFwdDom + "'/>\n";//PRD_12567
                _idCurvasXML += "<itemCurva ID='" + curvaFwdFor + "'/>\n";//PRD_12567
                _idCurvasXML += "</CurvasMoneda>";

                SrvValorizador.SrvValorizadorCarteraSoapClient SrvValorizador = wsGlobales.Valorizador;//new AdminOpciones.SrvValorizador.SrvValorizadorCarteraSoapClient();
                SrvValorizador.GetSetPreciosCompleted += new EventHandler<AdminOpciones.SrvValorizador.GetSetPreciosCompletedEventArgs>(SrvValorizador_GetSetPreciosCompleted);
                SrvValorizador.GetSetPreciosAsync(FechaProceso, paridad, "DO", _idCurvasXML, enumSetpricing);
            }
        }

        //cambio de scope
        void SrvValorizador_GetSetPreciosCompleted(object sender, AdminOpciones.SrvValorizador.GetSetPreciosCompletedEventArgs e)
        {//OJO de aquí debe saltar al StopSetPricing o de lo contratio se está cayendo.
            bool Status;
            bool isFechaSetDePreciosFechaAnt = false;
            XDocument SetPreciosXML = new XDocument(XDocument.Parse(e.Result));

            //   if (SmileATMRRFLYList == null)
            SmileATMRRFLYList = new List<StructSmileATMRRFLY>();
            // else
            //     SmileATMRRFLYList.Clear();
            // if (SmileCallPutList == null)
            SmileCallPutList = new List<StructSmileCallPut>();
            //  else
            //      SmileCallPutList.Clear();
            //   if (SmileStrikesList == null)
            SmileStrikesList = new List<StructSmileCallPut>();
            //  else
            //      SmileStrikesList.Clear();

            isFechaSetDePreciosFechaAnt = SetPreciosXML.Element("Data").Element("Status").Attribute("FechaAnt").Value.Equals("1") ? true : false;


            #region Fecha Set de Precios

            this.FechaSetdePrecios = DateTime.Parse(SetPreciosXML.Element("Data").Element("FechaSetPrecios").Attribute("Fecha").Value);
            this._TablaFixing.FechaSetPrecios = this.FechaSetdePrecios;

            #endregion

            #region SpotBS

            this.spot = Convert.ToDouble(SetPreciosXML.Element("Data").Element("Spot").Attribute("Value").Value);
            this.BSSpotValorizacion = this.spot;
            _BSSpotValorizacion = this.spot;
            this.txtSpotCosto.Text = BSSpotValorizacion.ToString();
            this.txtSpotValorizacion.Text = BSSpotValorizacion.ToString();
            this._TablaFixing.spot = this.spot;

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
            this.grdAtmRRFly.ItemsSource = null;
            this.grdAtmRRFly.ItemsSource = this.SmileATMRRFLYList;
            this.comboAtmRRFlyCallPut.SelectedIndex = 0;

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

            this.grdStrikes.ItemsSource = null;
            this.grdStrikes.ItemsSource = SmileStrikesList;

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
//REVISAR if innecesario
                if (_CurvaElement.CodigoCurva != null)//PRD_12567
                {
                    CurvasMonedasList.Add(_CurvaElement);
                }
            }

            if (comboCurvas.Items.Count == 0)
            {
                foreach (StructCurvaMoneda _curva in CurvasMonedasList)
                {
                    if (_curva.CodigoCurva != null)
                        this.comboCurvas.Items.Add(_curva.CodigoCurva);
                }
            }

            //Las curvas guardadas quedan en la pantalla...
            if (CurvasMonedasList.Count > 0 && CurvasMonedasList[0].CodigoCurva != null)
            {
                this.comboCurvas.IsEnabled = true;
                this.comboCurvas.SelectedIndex = 0;
                this.grdCurvas.ItemsSource = CurvasMonedasList.First(x => x.CodigoCurva.Equals(comboCurvas.SelectedItem)).CurvaMoneda;
            }
            else
            {
                this.comboCurvas.IsEnabled = false;
                this.comboCurvas.Items.Clear();
                this.grdCurvas.ItemsSource = null;
            }

            #endregion

            #region Puntos Fwd

            CurvaFwUSD = new List<StructItemPuntosForward>();

            StructItemPuntosForward _itemCurvaForward;

            foreach (XElement _itemCurva in SetPreciosXML.Element("Data").Element("PesosForward").Descendants("itemCurva"))
            {
                _itemCurvaForward = new StructItemPuntosForward();

                _itemCurvaForward.dias = int.Parse(_itemCurva.Attribute("Dias").Value);
                _itemCurvaForward.tenor = _itemCurva.Attribute("Tenor").Value;
                _itemCurvaForward.Puntos = double.Parse(_itemCurva.Attribute("Puntos").Value);
                CurvaFwUSD.Add(_itemCurvaForward);
            }

            this.grdCurvaFwUSD.ItemsSource = null;
            this.grdCurvaFwUSD.ItemsSource = CurvaFwUSD;

            #endregion

            try
            {
                Status = SetPreciosXML.Element("Data").Element("Status").Attribute("Value").Value.Equals("OK") ? true : false;
            }
            catch
            {
                Status = false;
            }

            if (isFechaSetDePreciosFechaAnt && Status)
            {
                this.DatePickerSetPrecios.SelectedDate = FechaSetdePrecios;
                System.Windows.Browser.HtmlPage.Window.Alert("No se encontró Set de Precios para la fecha de proceso " + FechaDeProceso.ToString("dd-MM-yyyy") + "\n Se cargo Set de Precios de fecha " + FechaSetdePrecios.ToString("dd-MM-yyyy") + " ");
            }


            if (!Status)
            {
                QuitLayer(this.PrincipalCanvas);
                QuitLayer(this.CanasTab2);
                PutLayer(this.PrincipalCanvas, "SET DE PRECIOS INCOMPLETO");
                PutLayer(this.CanasTab2, "SET DE PRECIOS INCOMPLETO");
            }
            else
            {
                QuitLayer(this.PrincipalCanvas);
                QuitLayer(this.CanasTab2);
                this.isTextChanged = true;
                this.Valorizar();
            }

            a.StopSetPricing(this);

        }

        //cambio de scope
        void LoadFrontData(string moneda)
        {
            SrvLoadFront.LoadFrontSoapClient _SrvLoadFront = wsGlobales.LoadFront;//new AdminOpciones.SrvLoadFront.LoadFrontSoapClient();
            _SrvLoadFront.LoadFrontDataCompleted += new EventHandler<AdminOpciones.SrvLoadFront.LoadFrontDataCompletedEventArgs>(_SrvLoadFront_LoadFrontDataCompleted);
            _SrvLoadFront.LoadFrontDataAsync(moneda);
        }

        private void _SrvLoadFront_LoadFrontDataCompleted(object sender, AdminOpciones.SrvLoadFront.LoadFrontDataCompletedEventArgs e)
        {
            string resultValue = e.Result.ToString();
            IsLoadedFrontData = true;

            StopInitFront();

            XDocument xdocLoadData = new XDocument(XDocument.Parse(resultValue));

            #region Fecha Proceso

            var DataDateProccessVar = from itemDataLoad in xdocLoadData.Descendants("DateProccess")
                                      select itemDataLoad.Attribute("DateProccess");


            try
            {
                FechaDeProceso = DateTime.Parse(DataDateProccessVar.ToList()[0].Value.ToString());


                //DateProccess = FechaDeProceso;
                FechaValorizacionCartera = FechaDeProceso;

                this.datePiker_DateProccess.SelectedDate = FechaDeProceso;
                this.DatePickerSetPrecios.SelectedDate = FechaDeProceso;
                this.DatePickerCartera.SelectedDate = FechaDeProceso;
                this._TablaFixing.datePikerInicio.SelectedDate = FechaDeProceso;
                this._TablaFixing.datePikerInicioEntrada.SelectedDate = FechaDeProceso; //PRD_12567
                this._TablaFixing.fechaHoy = FechaDeProceso;
            }
            catch
            {

            }

            #endregion

            #region Estados

            try
            {
                var OptionStateVar = from itemOptionState in xdocLoadData.Descendants("OptionState")
                                     select new StructCodigoDescripcion
                                     {
                                         Codigo = itemOptionState.Attribute("OptionStateCod").Value.ToString(),
                                         Descripcion = itemOptionState.Attribute("OptionStateDsc").Value.ToString()
                                     };
                OptionStateList = new List<StructCodigoDescripcion>(OptionStateVar.ToList<StructCodigoDescripcion>());

                this.TreeEstadoOperacion.ChildrenLoaded = false;
                TreeEstadoOperacion.NodeCheckChanged += new TreeEventHandler(NodeStatus_NodeCheckChanged);
                Node RootNode = new Node("*", "Todos", true);
                this.TreeEstadoOperacion.BulkUpdateBegin();
                this.TreeEstadoOperacion.Nodes.Add(RootNode);
                foreach (StructCodigoDescripcion _itemState in OptionStateList)
                {
                    Node _newNode = new Node(_itemState.Codigo, _itemState.Descripcion, false);
                    this.TreeEstadoOperacion.GetChild("*").Nodes.Add(_newNode);
                }

                this.TreeEstadoOperacion.BulkUpdateEnd();
                this.TreeEstadoOperacion.ExpandAll();
                this.TreeEstadoOperacion.ChildrenLoaded = true;
                this.TreeEstadoOperacion.ApplyCheckChangesToChildren = true;
                TreeEstadoOperacion.Get("*").IsChecked = true;
                TreeEstadoOperacion.UpdateLayout();
            }
            catch { }

            #endregion

            #region Cartera
            getDetContratoFijaciones(FechaDeProceso, this.StatusString());
            #endregion

            #region Set de Precios

            LoadSetPrecios(FechaDeProceso, curvaDom, curvaFor, this.setPreciosValCartera);

            #endregion

            #region Estructuras

            try
            {

                var DataOpcionesEstructura = from itemDataLoad in xdocLoadData.Descendants("DataOpcionEstructura")
                                             select new StructCodigoDescripcion
                                             {
                                                 Codigo = itemDataLoad.Attribute("OpEstCod").Value.ToString(),
                                                 Descripcion = itemDataLoad.Attribute("OpEstDsc").Value.ToString()
                                             };

                OpcionesEstructuraList = new List<StructCodigoDescripcion>(DataOpcionesEstructura.ToList<StructCodigoDescripcion>());


                OpcionesEstructuraList.Remove(OpcionesEstructuraList.First(x => x.Codigo.Equals("0")));
                StructCodigoDescripcion _opcionCall = new StructCodigoDescripcion("-1", "Call");
                StructCodigoDescripcion _opcionPut = new StructCodigoDescripcion("0", "Put");
                OpcionesEstructuraList.Insert(0, _opcionCall);
                OpcionesEstructuraList.Insert(1, _opcionPut);

                List<string> OpcionesEstructuraStringList = new List<string>();

                foreach (StructCodigoDescripcion optionItem in OpcionesEstructuraList)
                {
                    OpcionesEstructuraStringList.Add(optionItem.Descripcion);
                }


                RadioButton radioButton;
                int i;
                for ( i = 0; i < OpcionesEstructuraList.Count; i++)
                {
                    radioButton = new RadioButton();
                    if (OpcionesEstructuraList[i].Descripcion != "Vanilla" && OpcionesEstructuraList[i].Descripcion != "Call" && OpcionesEstructuraList[i].Descripcion != "Put")
                    {
                        radioButton.Checked += new RoutedEventHandler(radioButton_Checked);
                        radioButton.Content = OpcionesEstructuraList[i].Descripcion;

                        this.stackOpciones.Children.Add(radioButton);

                    }
                }
                this.radioOpcCall.IsChecked = true;

            }
            catch (Exception eEstructuras)
            {
                System.Windows.Browser.HtmlPage.Window.Alert("eEstructuras" + eEstructuras.Message.ToString() + eEstructuras.StackTrace.ToString());
            }

            #endregion Estructuras

            #region PayOff

            try
            {
                var DataPayOff = from itemDataLoad in xdocLoadData.Descendants("DataOpcionPayOff")
                                 select new StructCodigoDescripcion
                                 {
                                     Codigo = itemDataLoad.Attribute("PayOffTipCod").Value.ToString(),
                                     Descripcion = itemDataLoad.Attribute("PayOffTipDsc").Value.ToString()
                                 };

                payOffList = new List<StructCodigoDescripcion>(DataPayOff.ToList<StructCodigoDescripcion>());
                List<ComboBoxItem> payOff0StringList = new List<ComboBoxItem>();
                foreach (StructCodigoDescripcion optionItem in DataPayOff)
                {
                    if (optionItem.Codigo.Equals("01") || optionItem.Codigo.Equals("02"))
                    {
                        ComboBoxItem newItem = new ComboBoxItem();
                        newItem.Content = optionItem.Descripcion;
                        payOff0StringList.Add(newItem);
                    }
                }
                this.comboPayOff.Items.Clear();
                this.comboPayOff.ItemsSource = payOff0StringList;
                this.comboPayOff.SelectedIndex = 0;
            }
            catch (Exception ePayOff)
            {
                System.Windows.Browser.HtmlPage.Window.Alert("ePayOff" + ePayOff.Message.ToString());
            }

            #endregion PayOff

            #region Forma Pago

            try
            {
                var DataFormaDePago = from itemDataLoad in xdocLoadData.Descendants("DataFormaDePago")
                                      select new StructMonedaFormaPago
                                      {
                                          CodigoMoneda = int.Parse(itemDataLoad.Attribute("Moneda").Value.ToString()),
                                          Codigo = itemDataLoad.Attribute("FormaDePagoCod").Value.ToString(),
                                          Descripcion = itemDataLoad.Attribute("FormaDePagoDsc").Value.ToString(),
                                          Valor = double.Parse(itemDataLoad.Attribute("FormaDePagoValuta").Value.ToString())
                                      };

                formaDePagoList = DataFormaDePago.ToList();
                List<string> formaDePagoStringList = new List<string>();
            }
            catch (Exception eFormaPago)
            {
                System.Windows.Browser.HtmlPage.Window.Alert("eFormaPago" + eFormaPago.Message.ToString());
            }


            #endregion Forma Pago

            #region Forma Pago Defecto

            try
            {
                // <DataFormaPagoDefecto ParMoneda='CLP/USD' Moneda1='13' Moneda2='999' FormaPagoMoneda1='13' FormaPagoMoneda2='5' /> 

                XElement _FormaPagoDefecto = xdocLoadData.Element("DataLoadFront").Element("DataFormaPagoDefecto");
                FormaPagoUSD = int.Parse(_FormaPagoDefecto.Attribute("FormaPagoMoneda1").Value);
                FormaPagoCLP = int.Parse(_FormaPagoDefecto.Attribute("FormaPagoMoneda2").Value);
            }
            catch (Exception eFormaPagoDefecto)
            {
                System.Windows.Browser.HtmlPage.Window.Alert("eFormaPagoDefecto" + eFormaPagoDefecto.Message.ToString());
            }

            #endregion Forma Pago Defecto

            #region Otros

            this.EnableDisableAsiatica(_opcionEstructuraSeleccionada);

            #endregion

        }

        //cambio de scope
        void NodeStatus_NodeCheckChanged(object sender, TreeEventArgs e)
        {
            if (this.TreeEstadoOperacion.ChildrenLoaded == true)
            {
                Node _node = sender as Node;
                List<Node> _nodesChecked = this.TreeEstadoOperacion.GetChild("*").Nodes.Where(n => n.IsChecked == true).ToList<Node>();

                if (this.TreeEstadoOperacion.GetChild("*").IsChecked == true)
                {
                    this.expaderEstadoOperacion.Header = "Todos";
                }
                else
                {
                    if (_nodesChecked.Count == 0)
                    {
                        this.expaderEstadoOperacion.Header = "Ninguno";
                    }
                    if (_nodesChecked.Count > 1)
                    {
                        this.expaderEstadoOperacion.Header = "Custom";
                    }

                    if (_nodesChecked.Count == 1)
                    {
                        this.expaderEstadoOperacion.Header = _nodesChecked[0].Title;
                    }
                }
            }
            //throw new NotImplementedException();
        }

        private void LoadCustomers()
        {
            SrvCustomers.SrvCustomersSoapClient _SrvCustomers = wsGlobales.Customers;// new AdminOpciones.SrvCustomers.SrvCustomersSoapClient();
            _SrvCustomers.getCustomersDataCompleted += new EventHandler<AdminOpciones.SrvCustomers.getCustomersDataCompletedEventArgs>(_SrvCustomers_getCustomersDataCompleted);
            _SrvCustomers.getCustomersDataAsync();
        }

        private void _SrvCustomers_getCustomersDataCompleted(object sender, AdminOpciones.SrvCustomers.getCustomersDataCompletedEventArgs e)
        {
            XDocument xdoc = new XDocument(XDocument.Parse(e.Result));
            var customersVarComplete = from Customer in xdoc.Descendants("Data")
                                       select new StructCustomers
                                       {
                                           Clrut = Customer.Attribute("Clrut").Value.ToString(),
                                           Cldv = Customer.Attribute("Cldv").Value.ToString(),
                                           Clcodigo = Customer.Attribute("Clcodigo").Value.ToString(),
                                           Clnombre = Customer.Attribute("Clnombre").Value.ToString()
                                       };
            CustomersList = new List<StructCustomers>(customersVarComplete.ToList<StructCustomers>());
            IsLoadedCustomers = true;
            IdBtnGuardar.IsEnabled = true;
            StopInitFront();
        }

        //era private, public para Auxiliares
        public void LoadPortfolioAndBook()
        {
            SrvPortfolioAndBook.LoadPortfolioSoapClient _SrvPorfolioAndBook = wsGlobales.Portfolio;// new AdminOpciones.SrvPortfolioAndBook.LoadPortfolioSoapClient();
            if (globales._Estado.Equals("M") || globales._Estado.Equals("N"))
            {
                _SrvPorfolioAndBook.getPortfolioAndBookAllCompleted += new EventHandler<AdminOpciones.SrvPortfolioAndBook.getPortfolioAndBookAllCompletedEventArgs>(_SrvPorfolioAndBook_getPortfolioAndBookAllCompleted);
                _SrvPorfolioAndBook.getPortfolioAndBookAllAsync();  // PRD-3162 
            }
            else
            {
                _SrvPorfolioAndBook.getPortfolioAndBookCompleted += new EventHandler<AdminOpciones.SrvPortfolioAndBook.getPortfolioAndBookCompletedEventArgs>(_SrvPorfolioAndBook_getPortfolioAndBookCompleted);
                _SrvPorfolioAndBook.getPortfolioAndBookAsync(globales._Usuario);  // PRD-3162 
            }

        }

        private void _SrvPorfolioAndBook_getPortfolioAndBookCompleted(object sender, AdminOpciones.SrvPortfolioAndBook.getPortfolioAndBookCompletedEventArgs e)
        {
            XDocument xdoc = new XDocument(XDocument.Parse(e.Result));

            var BookVar = from itemBook in xdoc.Descendants("BookData")
                          select new StructCodigoDescripcion
                          {
                              Codigo = itemBook.Attribute("Codigo").Value.ToString(),
                              Descripcion = itemBook.Attribute("Descripcion").Value.ToString()
                          };

            BookList = new List<StructCodigoDescripcion>(BookVar.ToList<StructCodigoDescripcion>());

            var BookStringsVar = from itemBook in BookList
                                 select itemBook.Descripcion;


            var FinancialPortFolioVar = from itemFinancialPortFolio in xdoc.Descendants("FinancialPortFolioData")
                                        select new StructCodigoDescripcion
                                        {
                                            Codigo = itemFinancialPortFolio.Attribute("Codigo").Value.ToString(),
                                            Descripcion = itemFinancialPortFolio.Attribute("Descripcion").Value.ToString()
                                        };

            FinancialPortFolioList = new List<StructCodigoDescripcion>(FinancialPortFolioVar.ToList<StructCodigoDescripcion>());

            var FinancialPortFolioStringsVar = from itemFinancialPortfolio in FinancialPortFolioList
                                               select itemFinancialPortfolio.Descripcion;


            var PortFolioRulesVar = from itemPortFolioRules in xdoc.Descendants("PortFolioRulesData")
                                    select new StructCodigoDescripcion
                                    {
                                        Codigo = itemPortFolioRules.Attribute("Codigo").Value.ToString(),
                                        Descripcion = itemPortFolioRules.Attribute("Descripcion").Value.ToString()
                                    };
            PortFolioRulesList = new List<StructCodigoDescripcion>(PortFolioRulesVar.ToList<StructCodigoDescripcion>());

            var PortFolioRulesStringsVar = from itemPortFolioRules in PortFolioRulesList
                                           select itemPortFolioRules.Descripcion;

            var SubPortFolioRulesVar = from itemSubPortFolioRules in xdoc.Descendants("SubPortFolioRulesData")
                                       select new StructCodigoDescripcion
                                       {
                                           Codigo = itemSubPortFolioRules.Attribute("Codigo").Value.ToString(),
                                           Descripcion = itemSubPortFolioRules.Attribute("Descripcion").Value.ToString()
                                       };
            SubPortFolioRulesList = new List<StructCodigoDescripcion>(SubPortFolioRulesVar.ToList<StructCodigoDescripcion>());

            var SubPortFolioRulesStringsVar = from itemSubPortFolioRules in SubPortFolioRulesList
                                              select itemSubPortFolioRules.Descripcion;

            //PRD-3162
            var ConfiguracionPortFolioVar = from itemConfiguracionPortFolio in xdoc.Descendants("ConfiguracionPortFolioData")
                                            select new StructConfiguracionPortFolio
                                            {
                                                Usuario = itemConfiguracionPortFolio.Attribute("Usuario").Value.ToString(),
                                                LibroCod = itemConfiguracionPortFolio.Attribute("LibroCod").Value.ToString(),
                                                LibroDesc = itemConfiguracionPortFolio.Attribute("LibroDsc").Value.ToString(),
                                                CartNormCod = itemConfiguracionPortFolio.Attribute("CarteraNormativaCod").Value.ToString(),
                                                CartNormDesc = itemConfiguracionPortFolio.Attribute("CarteraNormativaDsc").Value.ToString(),
                                                SubCartNormCod = itemConfiguracionPortFolio.Attribute("SubCarteraNormativaCod").Value.ToString(),
                                                SubCartNormDesc = itemConfiguracionPortFolio.Attribute("SubCarteraNormativaDsc").Value.ToString(),
                                                Prioridad = itemConfiguracionPortFolio.Attribute("Prioridad").Value.ToString()

                                            };

            ConfiguracionPortFolioList = new List<StructConfiguracionPortFolio>(ConfiguracionPortFolioVar.ToList<StructConfiguracionPortFolio>());

            var ConfiguracionPortFolioStringsVar = from itemConfiguracionPortfolio in ConfiguracionPortFolioList
                                                   select itemConfiguracionPortfolio.LibroDesc;

            var FinancialPortFolioPrioridadVar = from itemFinancialPortFolioPrioridad in xdoc.Descendants("FinancialPortFolioPrioridadData")
                                                 select new StructFinancialPortFolio
                                                 {
                                                     Codigo = itemFinancialPortFolioPrioridad.Attribute("Codigo").Value.ToString(),
                                                     Descripcion = itemFinancialPortFolioPrioridad.Attribute("Descripcion").Value.ToString(),
                                                     Prioridad = itemFinancialPortFolioPrioridad.Attribute("Prioridad").Value.ToString()
                                                 };

            FinancialPortFolioPrioridadList = new List<StructFinancialPortFolio>(FinancialPortFolioPrioridadVar.ToList<StructFinancialPortFolio>());

            var FinancialPortFolioPrioridadStringsVar = from itemFinancialPortFolioPrioridad in FinancialPortFolioPrioridadList
                                                        select itemFinancialPortFolioPrioridad.Descripcion;

            //PRD-3162
            IsLoadedPortfolioAndBook = true;
            StopInitFront();
        }

        //PRD-3162
        private void _SrvPorfolioAndBook_getPortfolioAndBookAllCompleted(object sender, AdminOpciones.SrvPortfolioAndBook.getPortfolioAndBookAllCompletedEventArgs e)
        {
            XDocument xdoc = new XDocument(XDocument.Parse(e.Result));

            var BookVar = from itemBook in xdoc.Descendants("BookData")
                          select new StructCodigoDescripcion
                          {
                              Codigo = itemBook.Attribute("Codigo").Value.ToString(),
                              Descripcion = itemBook.Attribute("Descripcion").Value.ToString()
                          };

            BookList = new List<StructCodigoDescripcion>(BookVar.ToList<StructCodigoDescripcion>());

            var BookStringsVar = from itemBook in BookList
                                 select itemBook.Descripcion;

            var FinancialPortFolioVar = from itemFinancialPortFolio in xdoc.Descendants("FinancialPortFolioData")
                                        select new StructCodigoDescripcion
                                        {
                                            Codigo = itemFinancialPortFolio.Attribute("Codigo").Value.ToString(),
                                            Descripcion = itemFinancialPortFolio.Attribute("Descripcion").Value.ToString()
                                        };

            FinancialPortFolioList = new List<StructCodigoDescripcion>(FinancialPortFolioVar.ToList<StructCodigoDescripcion>());

            var FinancialPortFolioStringsVar = from itemFinancialPortfolio in FinancialPortFolioList
                                               select itemFinancialPortfolio.Descripcion;


            var PortFolioRulesVar = from itemPortFolioRules in xdoc.Descendants("PortFolioRulesData")
                                    select new StructCodigoDescripcion
                                    {
                                        Codigo = itemPortFolioRules.Attribute("Codigo").Value.ToString(),
                                        Descripcion = itemPortFolioRules.Attribute("Descripcion").Value.ToString()
                                    };

            PortFolioRulesList = new List<StructCodigoDescripcion>(PortFolioRulesVar.ToList<StructCodigoDescripcion>());

            var PortFolioRulesStringsVar = from itemPortFolioRules in PortFolioRulesList
                                           select itemPortFolioRules.Descripcion;

            var SubPortFolioRulesVar = from itemSubPortFolioRules in xdoc.Descendants("SubPortFolioRulesData")
                                       select new StructCodigoDescripcion
                                       {
                                           Codigo = itemSubPortFolioRules.Attribute("Codigo").Value.ToString(),
                                           Descripcion = itemSubPortFolioRules.Attribute("Descripcion").Value.ToString()
                                       };

            SubPortFolioRulesList = new List<StructCodigoDescripcion>(SubPortFolioRulesVar.ToList<StructCodigoDescripcion>());

            var SubPortFolioRulesStringsVar = from itemSubPortFolioRules in SubPortFolioRulesList
                                              select itemSubPortFolioRules.Descripcion;

            //PRD-3162
            var ConfiguracionPortFolioVar = from itemConfiguracionPortFolio in xdoc.Descendants("ConfiguracionPortFolioData")
                                            select new StructConfiguracionPortFolio
                                            {
                                                Usuario = itemConfiguracionPortFolio.Attribute("Usuario").Value.ToString(),
                                                LibroCod = itemConfiguracionPortFolio.Attribute("LibroCod").Value.ToString(),
                                                LibroDesc = itemConfiguracionPortFolio.Attribute("LibroDsc").Value.ToString(),
                                                CartNormCod = itemConfiguracionPortFolio.Attribute("CarteraNormativaCod").Value.ToString(),
                                                CartNormDesc = itemConfiguracionPortFolio.Attribute("CarteraNormativaDsc").Value.ToString(),
                                                SubCartNormCod = itemConfiguracionPortFolio.Attribute("SubCarteraNormativaCod").Value.ToString(),
                                                SubCartNormDesc = itemConfiguracionPortFolio.Attribute("SubCarteraNormativaDsc").Value.ToString(),
                                                Prioridad = itemConfiguracionPortFolio.Attribute("Prioridad").Value.ToString()
                                            };

            ConfiguracionPortFolioList = new List<StructConfiguracionPortFolio>(ConfiguracionPortFolioVar.ToList<StructConfiguracionPortFolio>());

            var ConfiguracionPortFolioStringsVar = from itemConfiguracionPortfolio in ConfiguracionPortFolioList
                                                   select itemConfiguracionPortfolio.LibroDesc;

            //PRD-3162
            var FinancialPortFolioPrioridadVar = from itemFinancialPortFolioPrioridad in xdoc.Descendants("FinancialPortFolioPrioridadData")
                                                 select new StructFinancialPortFolio
                                                 {
                                                     Codigo = itemFinancialPortFolioPrioridad.Attribute("Codigo").Value.ToString(),
                                                     Descripcion = itemFinancialPortFolioPrioridad.Attribute("Descripcion").Value.ToString(),
                                                     Prioridad = itemFinancialPortFolioPrioridad.Attribute("Prioridad").Value.ToString()
                                                 };

            FinancialPortFolioPrioridadList = new List<StructFinancialPortFolio>(FinancialPortFolioPrioridadVar.ToList<StructFinancialPortFolio>());

            var FinancialPortFolioPrioridadStringsVar = from itemFinancialPortFolioPrioridad in FinancialPortFolioPrioridadList
                                                        select itemFinancialPortFolioPrioridad.Descripcion;

            //PRD-3162
            IsLoadedPortfolioAndBook = true;
            StopInitFront();
        }

        //PRD-3162
        //era private, public para Auxiliares
        public void _TablaFixing_event_TablaFixingResult(string strFixingValue)
        {
            try
            {
                List<StructFixingData> fixingdataList = strFixingValue.ToListStructFixingData(1);

                //MEJORAR URGENTE, ojo con la condición >0 v/s >=0, las fijaciones pueden incluir pesos en 0. EVALUAR CAMBIO.
                if (_opcionEstructuraSeleccionada.Codigo.Equals("13"))
                {
                    this._Guardar.FixingDataList = fixingdataList.Where(_Element => _Element.Peso > 0).ToList();//PRD_12567
                    this.FixingDataList = fixingdataList.Where(_Element => _Element.Peso > 0).ToList();//PRD_12567

                    this.FixingDataStringSalida = strFixingValue;

                    this.FixingDataString = FixingDataStringEntrada + FixingDataStringSalida;
                    string regex = "</FixingData><FixingData>";
                    string resultado = Regex.Replace(FixingDataString, regex, "");

                    this.FixingDataString = resultado;
                }
                else
                {
                    this._Guardar.FixingDataList = fixingdataList;
                    this.FixingDataList = fixingdataList;
                    this.FixingDataString = strFixingValue;
                }

                //esto tiene sentido?
                this.Town = this._TablaFixing.Town;
                this._TablaFixing.SetTown(this.Town);

                if (!IsClearData)
                {
                    Valorizar();//loop
                }
                isTablaFixingCreated = false;
            }
            catch { }

        }

        private void SetGriegasAndMtMValues(string GriegasAndMtMValues)
        {
            try
            {
                XDocument xmlResult = new XDocument(XDocument.Parse(GriegasAndMtMValues));
                ValidAmount _Value = new ValidAmount();

                XMLResult = GriegasAndMtMValues;

                double _Forward_Teo = 0;
                IEnumerable<XElement> _detContratoList;
                try
                {
                    _detContratoList = xmlResult.Descendants("detContrato");
                    _Forward_Teo = Math.Round(double.Parse(_detContratoList.ElementAt(0).Element("MtM").Attribute("MoFwd_teo").Value), 5);
                }
                catch { }

                if (_Forward_Teo > 0)
                {
                    bool _ChangePointForward = false;

                    if (this.txtForward.Text.Equals(""))
                    {
                        _ChangePointForward = true;
                    }
                    else if (!_Forward_Teo.Equals(double.Parse(this.txtForward.Text)))
                    {
                        _ChangePointForward = true;
                    }

                    if (_ChangePointForward)
                    {
                        _Value.DecimalPlaces = 4;
                        _Value.SetChange(this.txtPuntosCosto, (_Forward_Teo - this.spot));
                        this.PuntosCosto = Math.Round(double.Parse(txtPuntosCosto.Text), 4);
                    }
                }

                _Value.DecimalPlaces = 5;
                _Value.SetChange(this.txtForward, _Forward_Teo);

                RadioButton _radio = new RadioButton();

                #region switch codigo estructura
                double _Volatilidad = 0;
                switch (_opcionEstructuraSeleccionada.Codigo)
                {

                    case "8":
                        IEnumerable<XElement> _detContratoList_FwdAmerican;
                        _detContratoList_FwdAmerican = xmlResult.Descendants("detContrato");
                        try
                        {
                            _Volatilidad = double.Parse(_detContratoList_FwdAmerican.ElementAt(0).Element("MtM").Attribute("MoVol").Value);
                        }
                        catch { }
                        break;

                    case "-1":
                        IEnumerable<XElement> _detContratoList_Call;
                        _detContratoList_Call = xmlResult.Descendants("detContrato");
                        try
                        {
                            _Volatilidad = double.Parse(_detContratoList_Call.ElementAt(0).Element("MtM").Attribute("MoVol").Value);
                        }
                        catch { }
                        break;
                    case "0":
                        IEnumerable<XElement> _detContratoList_Put;
                        _detContratoList_Put = xmlResult.Descendants("detContrato");
                        try
                        {
                            _Volatilidad = double.Parse(_detContratoList_Put.ElementAt(0).Element("MtM").Attribute("MoVol").Value);
                        }
                        catch { }
                        break;
                    case "1":
                        IEnumerable<XElement> _detContratoList_Straddle;
                        _detContratoList_Straddle = xmlResult.Descendants("detContrato");

                        try
                        {
                            for (int _i = 0; _i < 2; _i++)
                            {
                                _Volatilidad += double.Parse(_detContratoList_Straddle.ElementAt(_i).Element("MtM").Attribute("MoVol").Value);
                            }
                        }
                        catch { }
                        _Volatilidad = _Volatilidad / 2.0;

                        break;
                    case "7":
                        IEnumerable<XElement> _detContratoList_Strangle;
                        _detContratoList_Strangle = xmlResult.Descendants("detContrato");

                        try
                        {
                            for (int _i = 0; _i < 2; _i++)
                            {
                                _Volatilidad += double.Parse(_detContratoList_Strangle.ElementAt(_i).Element("MtM").Attribute("MoVol").Value);
                            }
                        }
                        catch { }
                        _Volatilidad = _Volatilidad / 2.0;

                        break;


                    case "2":
                        IEnumerable<XElement> _detContratoList_RR;
                        _detContratoList_RR = xmlResult.Descendants("detContrato");

                        double rr_call, rr_put;
                        rr_call = 0;
                        rr_put = 0;

                        try
                        {
                            rr_call = double.Parse(_detContratoList_RR.ElementAt(0).Element("MtM").Attribute("MoVol").Value);
                            rr_put = double.Parse(_detContratoList_RR.ElementAt(1).Element("MtM").Attribute("MoVol").Value);
                        }
                        catch { }

                        _Volatilidad = rr_call - rr_put;

                        break;


                    case "3":
                        IEnumerable<XElement> _detContratoList_Butterfly;
                        _detContratoList_Butterfly = xmlResult.Descendants("detContrato");
                        double _vol_Strangle, _vol_Straddle;
                        _vol_Strangle = 0;
                        _vol_Straddle = 0;
                        try
                        {
                            for (int _i = 0; _i < 2; _i++)
                            {
                                _vol_Strangle += double.Parse(_detContratoList_Butterfly.ElementAt(_i).Element("MtM").Attribute("MoVol").Value);
                            }

                            for (int _i = 2; _i < 4; _i++)
                            {
                                _vol_Straddle += double.Parse(_detContratoList_Butterfly.ElementAt(_i).Element("MtM").Attribute("MoVol").Value);
                            }
                        }
                        catch { }
                        _Volatilidad = _vol_Strangle / 2.0 - _vol_Straddle / 2.0;

                        break;

                    case "4":
                        IEnumerable<XElement> _detContratoList_FUA;
                        _detContratoList_FUA = xmlResult.Descendants("detContrato");

                        double _cota_FUA = 0;

                        try
                        {
                            _cota_FUA = double.Parse(_detContratoList_FUA.ElementAt(2).Element("MtM").Attribute("MoVol").Value);
                        }
                        catch { }


                        _Volatilidad = _cota_FUA;

                        break;
                    case "5":
                        IEnumerable<XElement> _detContratoList_FPA;
                        _detContratoList_FPA = xmlResult.Descendants("detContrato");

                        double _cota_FPA = 0;

                        try
                        {
                            _cota_FPA = double.Parse(_detContratoList_FPA.ElementAt(2).Element("MtM").Attribute("MoVol").Value);
                        }
                        catch { }


                        _Volatilidad = _cota_FPA;

                        break;

                    case "6"://REVISAR que esté igual al original VSS
                        IEnumerable<XElement> _detContratoList_FS;
                        _detContratoList_FS = xmlResult.Descendants("detContrato");

                        try
                        {
                            _Volatilidad = double.Parse(_detContratoList_FS.ElementAt(0).Element("MtM").Attribute("MoVol").Value);
                        }
                        catch { }

                        break;
                    case "9":
                    case "10":
                        //el try es porque muchas veces se llama a la valorización sin tener la estructura lista
                        try
                        {
                            //volatilidades de strip se suman:
                            foreach (XElement detContrato in xmlResult.Descendants("detContrato"))
                            {
                                _Volatilidad += double.Parse(detContrato.Element("MtM").Attribute("MoVol").Value);
                            }
                        }
                        catch { }

                        break;
                    case "13"://PRD_12567 Forward Aistico Entrada Salida
                        IEnumerable<XElement> _detContratoList_ = xmlResult.Descendants("detContrato");//REVISAR no me gusta...
                        try
                        {
                            this.PorcStrike = double.Parse(_detContratoList_.ElementAt(0).Element("MtM").Attribute("MoPorcStrike").Value);
                            //TODO_20130221 
                            //_Forward_Teo = Math.Round(double.Parse(_detContratoList.ElementAt(0).Element("MtM").Attribute("MoFwd_teo").Value), 5);
                        }
                        catch { this.PorcStrike = 0; }
                        break;
                    case "14":
                        //el try es porque muchas veces se llama a la valorización sin tener la estructura lista
                        try
                        {
                            //volatilidades de strip se suman:
                            foreach (XElement detContrato in xmlResult.Descendants("detContrato"))
                            {
                                _Volatilidad += double.Parse(detContrato.Element("MtM").Attribute("MoVol").Value);
                            }
                        }
                        catch { }
                        break;
                }
                #endregion

                _Value.DecimalPlaces = 4;
                _Value.SetChange(txtVolatilidad, _Volatilidad);

                foreach (XElement _detContrato in xmlResult.Descendants("detContrato"))
                {
                    double _wfDom, _wfFor;
                    double TasaLocal, TasaForanea;

                    if (_opcionEstructuraSeleccionada.Codigo.Equals("8"))
                    {
                        TasaLocal = double.Parse(_detContrato.Element("MtM").Attribute("MoWf_mon1").Value.ToString());
                        TasaForanea = double.Parse(_detContrato.Element("MtM").Attribute("MoWf_mon2").Value.ToString());
                    }
                    else
                    {
                        _wfDom = double.Parse(_detContrato.Element("MtM").Attribute("MoWf_mon1").Value.ToString());
                        _wfFor = double.Parse(_detContrato.Element("MtM").Attribute("MoWf_mon2").Value.ToString());

                        _wfDom = _wfDom.Equals(double.NaN) ? 0 : _wfDom;
                        _wfFor = _wfFor.Equals(double.NaN) ? 0 : _wfFor;

                        TimeSpan plazo = fechaVencimiento.Subtract(this.datePiker_DateProccess.SelectedDate.Value);

                        TasaLocal = (Math.Log(_wfDom) * 365.0 / plazo.Days) * 100.0;
                        TasaForanea = (Math.Log(_wfFor) * 365.0 / plazo.Days) * 100.0;
                    }

                    _Value.DecimalPlaces = 4;
                    _Value.SetChange(this.txtTasaDom, TasaLocal);
                    _Value.DecimalPlaces = 4;
                    _Value.SetChange(this.txtTasaFor, TasaForanea);

                    break;
                }

                if (this._opcionEstructuraSeleccionada.Codigo.Equals("3") && this.checkBoxVegaWeighted.IsChecked.Value)
                {
                    this.NocionalStrangle = double.Parse(xmlResult.Element("Butterfly").Element("DataCompuesta").Element("Data").Element("Opcion").Element("detContrato").Element("Subyacente").Attribute("MoMontoMon1").Value);
                    this.txtNocionalStrangle.Text = NocionalStrangle.ToString("");
                    this.txtNocionalStrangle.Focus();
                    this.checkBoxVegaWeighted.Focus();

                }

                var griegasForwardSinteticoVar = from itemGriega in xmlResult.Descendants("GriegasMonto")
                                                 select new StructGriegas
                                                 {
                                                     DeltaSpot = double.Parse(itemGriega.Attribute("Delta").Value.ToString()),
                                                     DeltaForward = double.Parse(itemGriega.Attribute("DeltaForward").Value.ToString()),
                                                     Gamma = double.Parse(itemGriega.Attribute("Gamma").Value.ToString()),
                                                     Vega = double.Parse(itemGriega.Attribute("Vega").Value.ToString()),
                                                     RhoDom = double.Parse(itemGriega.Attribute("Rho").Value.ToString()),
                                                     RhoFor = double.Parse(itemGriega.Attribute("Rhof").Value.ToString()),
                                                     Theta = double.Parse(itemGriega.Attribute("Theta").Value.ToString()),
                                                     Charm = double.Parse(itemGriega.Attribute("Charm").Value.ToString()),
                                                     Vanna = double.Parse(itemGriega.Attribute("Vanna").Value.ToString()),
                                                     Volga = double.Parse(itemGriega.Attribute("Volga").Value.ToString())//,
                                                     //Zomma = double.Parse(itemGriega.Attribute("Zomma").Value.ToString()),
                                                     //Speed = double.Parse(itemGriega.Attribute("Speed").Value.ToString())
                                                 };

                var MTMVar = from itemGriega in xmlResult.Descendants("MtM")
                             select new List<double>
                     {
                          double.Parse(itemGriega.Attribute("MoVrDet").Value.ToString())
                     };

                double MtM = 0;
                for (int i = 0; i < MTMVar.ToList<List<double>>().Count; i++)
                {
                    MtM += MTMVar.ToList<List<double>>()[i][0];
                }

                this.MtMContrato = MtM;

                _Value.DecimalPlaces = 0;
                _Value.SetChange(this.txtMtMContrato, MtMContrato);

                //ASVG_20150420 Genera dependencia con la carga de cartera en pestaña de "Gestión Portfolio"
                //StructEncContrato _encContrato = this.EncContratoList[0];

                #region switch código estructura - SetChange Prima y MtM
                switch (_opcionEstructuraSeleccionada.Codigo)
                {
                    //Estructuras que no tienen Prima
                    case "4":   //Forward Utilidad Acotada
                    case "5":   //Forward Perdida Acotada
                    case "6":   //Forward Sintético
                    case "8":   //Forward Americano
                    case "13":  //Forward Asiatico Entrada Salida PRD_12567
                        _Value.DecimalPlaces = 4;
                        _Value.SetChange(this.txtParidadPrima, 0);
                        _Value.DecimalPlaces = 0;
                        _Value.SetChange(this.txtPrimaContrato, 0);
                        _Value.DecimalPlaces = 0;
                        _Value.SetChange(this.txtDistribucion, MtMContrato);
                        //5843
                        _Value.DecimalPlaces = 0;
                        _Value.SetChange(this.txtResultadoVta, ResultVenta);

                        break;

                    default:
                        if (this.ComboUnidadPrima.SelectedIndex == 0) //CLP
                        {
                            PrimaContrato = -MtM;

                            if (!PrimaContrato.Equals(double.NaN))
                            {
                                _Value.DecimalPlaces = 0;
                                _Value.SetChange(this.txtPrimaContrato, PrimaContrato);
                                _Value.DecimalPlaces = 0;
                                _Value.SetChange(this.txtDistribucion, (MtMContrato + PrimaContrato));
                            }
                            else
                            {
                                this.txtPrimaContrato.Text = "";
                                _Value.DecimalPlaces = 0;
                                _Value.SetChange(this.txtDistribucion, MtMContrato);
                            }
                        }
                        else //USD
                        {
                            if (!PrimaContrato.Equals(double.NaN))
                            {
                                _Value.DecimalPlaces = 2;
                                _Value.SetChange(this.txtPrimaContrato, PrimaContrato);
                            }
                            else
                            {
                                this.txtPrimaContrato.Text = "";
                            }
                            if (!ParidadPrima.Equals(double.NaN))
                            {
                                _Value.DecimalPlaces = 4;
                                _Value.SetChange(this.txtParidadPrima, ParidadPrima);
                                PrimaContrato = -MtM / ParidadPrima;
                            }
                            else
                            {
                                this.txtParidadPrima.Text = "";
                            }
                            _Value.DecimalPlaces = 0;
                            _Value.SetChange(this.txtDistribucion, 0);
                        }
                        break;
                }
                #endregion switch código estructura - SetChange Prima y MtM

                this.Unwind = MtM;
                this.UnwindCosto = MtM;
                _Value.DecimalPlaces = 0;
                _Value.SetChange(this.txtUnwind, Unwind);
                _Value.DecimalPlaces = 0;
                _Value.SetChange(this.txtUnwindCosto, UnwindCosto);

                // Unwind = double.Parse(this.txtUnwind.Text);

                //5843
                try
                {
                    //ASVG_20150420 REVISAR: N y/o U, ANTICIPA y/o ANULA
                    //if (_encContrato.CodEstructura.Equals(8) && _encContrato.Estado.Equals("N"))
                    if (_opcionEstructuraSeleccionada.Codigo.Equals("8") && this._Transaccion.Equals("ANTICIPA"))
                    {
                        txtResultadoVta.Text = "0";
                    }
                    else
                    {
                        _Value.DecimalPlaces = 0;
                        _Value.SetChange(this.txtResultadoVta, ResultVenta);
                    }
                }
                catch { }

                this.txtMtMContrato.Focus();
                this.txtUnwind.Focus();
                this.txtUnwindCosto.Focus();
                this.txtDistribucion.Focus();
                this.itemFrontOpciones.Focus();
                //this.MtMContrato = MtM;

                if (globales._Estado == "N")
                {
                    this.itemValCartera.IsEnabled = false;
                    this.itemSetdePrecios.IsEnabled = false;
                    this.itemTabDeltas.IsEnabled = false;
                    this.DatePickerSetPrecios.IsEnabled = false;
                    this.DatePickerVencimiento.IsEnabled = false;
                    this.datePiker_DateProccess.IsEnabled = false;

                    this.radioCompra.IsEnabled = false;
                    this.radioVenta.IsEnabled = false;

                    this.btnTablaFixing.IsEnabled = false;
                    this.btnComponentes.IsEnabled = false;
                    this.btnTopoLogiaVegaPricing.IsEnabled = false;

                    this.expanderOpciones.IsEnabled = false;

                    this.comboPayOff.IsEnabled = false;
                    this.comboBsFwdBsSpotAsianMomenos.IsEnabled = false;

                    this.txtNocional.IsEnabled = false;
                    this.txtStrike1.IsEnabled = false;
                    this.txtStrike2.IsEnabled = false;
                    this.txtStrike3.IsEnabled = false;
                    this.txtSpotCosto.IsEnabled = false;
                    this.txtPlazo.IsEnabled = false;
                    this.txtPuntosCosto.IsEnabled = false;

                    this.itemTabPrima.IsEnabled = false;
                    this.itemTabDistribucion.IsEnabled = false;

                    this.itemTabUnwind.IsSelected = true;
                }

                if (this.strikes_delta_flag.Equals("delta"))
                {
                    this.txtStrike1.Text = "";
                    this.txtStrike2.Text = "";
                    this.txtStrike3.Text = "";
                    this.txtDelta2.Text = "";
                    this.txtDelta3.Text = "";
                    List<double> _StrikesList = new List<double>();
                    string _strike;
                    foreach (XElement _detContrato in xmlResult.Descendants("detContrato"))
                    {
                        _strike = _detContrato.Element("Subyacente").Attribute("MoStrike").Value.Equals("Infinito") ? "Infinity" : _detContrato.Element("Subyacente").Attribute("MoStrike").Value;
                        _StrikesList.Add(double.Parse(_strike));
                    }

                    #region switch código estructura //if (this.strikes_delta_flag.Equals("delta"))
                    switch (_opcionEstructuraSeleccionada.Codigo)
                    {
                        case "-1"://Call
                        case "0"://Put      
                        case "1"://Straddle
                            _Value.DecimalPlaces = 2;
                            _Value.SetChange(this.txtStrike1, _StrikesList[0]);
                            this.strike = double.Parse(txtStrike1.Text);
                            break;

                        case "2": // Risk Reversal
                            _Value.DecimalPlaces = 2;
                            _Value.SetChange(this.txtStrike1, _StrikesList[0]);
                            this.strike = double.Parse(txtStrike1.Text);
                            _Value.DecimalPlaces = 2;
                            _Value.SetChange(this.txtStrike2, _StrikesList[1]);
                            this.strike2 = double.Parse(txtStrike2.Text);
                            break;

                        case "3": // Butterfly
                            _Value.DecimalPlaces = 2;
                            _Value.SetChange(this.txtStrike1, _StrikesList[0]);
                            _Value.DecimalPlaces = 2;
                            _Value.SetChange(this.txtStrike2, _StrikesList[1]);
                            _Value.DecimalPlaces = 2;
                            _Value.SetChange(this.txtStrike3, _StrikesList[2]);
                            this.strike = double.Parse(txtStrike1.Text);
                            this.strike2 = double.Parse(txtStrike2.Text);
                            this.strike3 = double.Parse(txtStrike3.Text);
                            break;

                        case "4": // FUA
                        case "5": // FPA
                            _Value.DecimalPlaces = 2;
                            _Value.SetChange(this.txtStrike1, _StrikesList[0]);
                            this.strike = double.Parse(txtStrike1.Text);
                            _Value.DecimalPlaces = 2;
                            _Value.SetChange(this.txtStrike2, _StrikesList[2]);
                            this.strike2 = double.Parse(txtStrike2.Text);
                            break;

                        case "6": // FS
                        case "13": //PRD_12567 FA Entrada Salida
                            _Value.DecimalPlaces = 2;
                            _Value.SetChange(this.txtStrike1, _StrikesList[0]);
                            this.strike = double.Parse(txtStrike1.Text);
                            break;

                        case "7": // Strangle
                            _Value.DecimalPlaces = 2;
                            _Value.SetChange(this.txtStrike1, _StrikesList[0]);
                            this.strike = double.Parse(txtStrike1.Text);
                            _Value.DecimalPlaces = 2;
                            _Value.SetChange(this.txtStrike2, _StrikesList[1]);
                            this.strike2 = double.Parse(txtStrike2.Text);
                            break;

                        case "14": //Call Spread Doble
                            _Value.DecimalPlaces = 2;
                            _Value.SetChange(this.txtStrike1, _StrikesList[0]);
                            _Value.DecimalPlaces = 2;
                            _Value.SetChange(this.txtStrike2, _StrikesList[1]);
                            _Value.DecimalPlaces = 2;
                            _Value.SetChange(this.txtStrike3, _StrikesList[2]);
                            _Value.DecimalPlaces = 2;
                            _Value.SetChange(this.txtStrike4, _StrikesList[3]);
                            this.strike = double.Parse(txtStrike1.Text);
                            this.strike2 = double.Parse(txtStrike2.Text);
                            this.strike3 = double.Parse(txtStrike3.Text);
                            this.strike4 = double.Parse(txtStrike4.Text);
                            break;
                    }
                    #endregion switch código estructura //if (this.strikes_delta_flag.Equals("delta"))
                }
                if (this.strikes_delta_flag.Equals("strikes") && ((ComboBoxItem)this.comboPayOff.SelectedItem).Content.Equals("Vanilla"))
                {
                    this.txtDelta1.Text = "";
                    this.txtDelta2.Text = "";
                    this.txtDelta3.Text = "";
                    List<double> _DeltaList = new List<double>();
                    double _Delta = 0;
                    foreach (XElement _detContrato in xmlResult.Descendants("detContrato"))
                    {
                        _DeltaList.Add(double.Parse(_detContrato.Element("Griegas").Attribute("MoDelta_fwd").Value.ToString()));
                        _Delta = double.Parse(_detContrato.Element("Griegas").Attribute("MoDelta_spot").Value.ToString());
                    }

                    //Seteo de Deltas en base a Strikes.
                    #region switch código estructura //if (this.strikes_delta_flag.Equals("strikes") && ((ComboBoxItem)this.comboPayOff.SelectedItem).Content.Equals("Vanilla"))
                    switch (_opcionEstructuraSeleccionada.Codigo)
                    {
                        case "8": // FWD Americano
                            this.delta1 = Math.Abs(_Delta / this.nocional);
                            _Value.DecimalPlaces = 2;
                            _Value.SetChange(this.txtDelta1, (this.delta1 * 100.0));

                            this.txtStrike2.Text = "";
                            strike2 = double.NaN;
                            this.txtStrike3.Text = "";
                            strike3 = double.NaN;
                            break;

                        case "-1": // Call
                        case "0":  // Put
                        case "9":  // Call Strip Asiático 
                        case "10": // Put Strip Asiático
                            this.delta1 = Math.Abs(_DeltaList[0] / this.nocional);
                            _Value.DecimalPlaces = 2;
                            _Value.SetChange(this.txtDelta1, (this.delta1 * 100.0));

                            this.txtStrike2.Text = "";
                            strike2 = double.NaN;
                            this.txtStrike3.Text = "";
                            strike3 = double.NaN;
                            break;

                        case "1":  //Straddle
                            this.delta1 = Math.Abs((_DeltaList[0] + _DeltaList[1]) / this.nocional);
                            _Value.DecimalPlaces = 2;
                            _Value.SetChange(this.txtDelta1, (this.delta1 * 100.0));

                            this.txtStrike2.Text = "";
                            strike2 = double.NaN;
                            this.txtStrike3.Text = "";
                            strike3 = double.NaN;
                            break;

                        case "2": // Risk Reversal
                        case "7": //Strangle
                            this.delta1 = Math.Abs(_DeltaList[0] / this.nocional);

                            _Value.DecimalPlaces = 2;
                            _Value.SetChange(this.txtDelta1, this.delta1 * 100.0);

                            this.txtStrike3.Text = "";
                            strike3 = double.NaN;
                            break;

                        case "4": //FUA
                        case "5": //FPA
                        case "6": //FS
                        case "13": //FA Entrada Salida PRD_12567
                            this.txtStrike3.Text = "";
                            strike3 = double.NaN;
                            break;

                        case "3"://Butterfly
                            this.delta1 = Math.Abs(_DeltaList[0] / this.nocional);
                            _Value.DecimalPlaces = 2;
                            _Value.SetChange(this.txtDelta1, this.delta1 * 100.0);
                            break;
                    }
                    #endregion switch código estructura //if (this.strikes_delta_flag.Equals("strikes") && ((ComboBoxItem)this.comboPayOff.SelectedItem).Content.Equals("Vanilla"))
                }
                if (this.strikes_delta_flag.Equals("strikes") && !((ComboBoxItem)this.comboPayOff.SelectedItem).Content.Equals("Vanilla"))
                {
                    this.txtDelta1.Text = "";
                    this.txtDelta2.Text = "";
                    this.txtDelta3.Text = "";

                    delta1 = double.NaN;
                    delta2 = double.NaN;
                    delta3 = double.NaN;
                }

                switch (_opcionEstructuraSeleccionada.Codigo)
                {
                    case "-1":  //Call
                    case "0":   //Put
                    case "1":   //Straddle
                    case "4":   //FUA
                    case "5":   //FPA
                    case "6":   //FS
                    case "8":   //Americano
                    case "9":   //Call Strip Asiático
                    case "10":  //Put Strip Asiático
                    case "14":  //Call Spread Doble
                        try
                        {
                            this.nocionalContraMonedaMonto = this.strike * nocional;
                            _Value.DecimalPlaces = 0;
                            _Value.SetChange(this.txtNocionalContraMoneda, nocionalContraMonedaMonto);
                        }
                        catch { }

                        break;
                    case "13"://Forward Asiatico Entrada Salida PRD_12567
                        try
                        {
                            //this.nocionalContraMonedaMonto = this. * nocional; //PRD_12567
                            _Value.DecimalPlaces = 0;
                            _Value.SetChange(this.txtNocionalContraMoneda, nocionalContraMonedaMonto);
                        }
                        catch { }

                        break;
                    default:

                        this.nocionalContraMonedaMonto = double.NaN;
                        this.txtNocionalContraMoneda.Text = "";

                        break;
                }


                List<StructGriegas> griegasList = new List<StructGriegas>(griegasForwardSinteticoVar.ToList<StructGriegas>());


                griegas = new StructGriegas(0, 0, 0, 0, 0, 0, 0, 0, 0, 0);

                if (griegasList.Count > 0)
                {
                    for (int i = 0; i < griegasList.Count; i++)
                    {
                        griegas.Charm += griegasList[i].Charm;

                        if (!BsSpot_BsFwd_AsianMomentos_flag.Equals("AsianMomentos"))
                        {
                            griegas.DeltaForward += griegasList[i].DeltaForward;
                        }
                        else
                        {
                            if (_opcionEstructuraSeleccionada.Codigo == "13")
                            {
                                griegas.DeltaForward += griegasList[i].DeltaForward; 
                                
                            }
                            else
                            {
                                griegas.DeltaForward = double.NaN;
                            }
                        }

                        griegas.DeltaSpot += griegasList[i].DeltaSpot;
                        griegas.Gamma += griegasList[i].Gamma;
                        griegas.RhoDom += griegasList[i].RhoDom;
                        griegas.RhoFor += griegasList[i].RhoFor;
                        griegas.Theta += griegasList[i].Theta;
                        griegas.Vanna += griegasList[i].Vanna;
                        griegas.Vega += griegasList[i].Vega;
                        griegas.Volga += griegasList[i].Volga;
                        //griegas.Zomma += griegasList[i].Zomma;
                    }
                }
                else
                {
                    griegas.Charm = double.NaN; ;
                    griegas.DeltaForward = double.NaN;
                    griegas.DeltaSpot = double.NaN;
                    griegas.Gamma = double.NaN;
                    griegas.RhoDom = double.NaN;
                    griegas.RhoFor = double.NaN;
                    griegas.Theta = double.NaN;
                    griegas.Vanna = double.NaN;
                    griegas.Vega = double.NaN;
                    griegas.Volga = double.NaN;
                }

                //Crear XML para Topologia Vega Pricing
                TopologiaVegaPricingInput = "<Data>\n";
                TopologiaVegaPricingInput += "<FechaValorizacion Fecha='" + datePiker_DateProccess.SelectedDate.Value + "' />\n";
                TopologiaVegaPricingInput += string.Format(
                                                            "<SpotValorizacion Spot='{0}' SpotSmile='{1}' />\n",
                                                            this.spot,
                                                            this.BSSpotValorizacion
                                                          );
                TopologiaVegaPricingInput += "<DetContrato>\n";
                int _ElementoEstructura;
                string _vinculacion = "";
                string _tipoPayoff = "";
                string _opcion = "";
                string _paridad = "";
                double _Nocional, _Strike, _Spot, _PuntosFwd;
                string _CVOpc = "";
                string _CurvaDom, _CurvaFor;
                //alanrevisar todo lo de esta variable es nuevo
                double _MTM;
                double _PorcStrike;//PRD_12567

                DateTime _FechaInicioOpc, _FechaVctoOpc;
                int _ElementosTotal = 0;
                foreach (XElement _detContrato in xmlResult.Descendants("detContrato"))
                {
                    _ElementoEstructura = int.Parse(_detContrato.Element("Estructura").Attribute("MoNumEstructura").Value);
                    _vinculacion = _detContrato.Element("Estructura").Attribute("MoVinculacion").Value;
                    _tipoPayoff = _detContrato.Element("DetallesOpcion").Attribute("MoTipoPayOff").Value;
                    _opcion = _detContrato.Element("DetallesOpcion").Attribute("MoCallPut").Value;
                    _paridad = _detContrato.Element("Subyacente").Attribute("MoParStrike").Value;
                    _Nocional = double.Parse(_detContrato.Element("Subyacente").Attribute("MoMontoMon1").Value);
                    _Strike = double.Parse(_detContrato.Element("Subyacente").Attribute("MoStrike").Value);
                    _Spot = double.Parse(_detContrato.Element("Proceso").Attribute("MoSpotDet").Value);

                    _PuntosFwd = !this.PuntosCosto.Equals(double.NaN) ? this.PuntosCosto : (double.Parse(_detContrato.Element("MtM").Attribute("MoFwd_teo").Value) - _Spot);


                    _CVOpc = _detContrato.Element("DetallesOpcion").Attribute("MoCVOpc").Value;
                    _CurvaDom = _detContrato.Element("Curvas").Attribute("MoCurveMon1").Value;
                    _CurvaFor = _detContrato.Element("Curvas").Attribute("MoCurveMon2").Value;
                    _FechaInicioOpc = DateTime.Parse(_detContrato.Element("DetallesOpcion").Attribute("MoFechaInicioOpc").Value);
                    _FechaVctoOpc = DateTime.Parse(_detContrato.Element("Vencimiento").Attribute("MoFechaVcto").Value);
                    _MTM = double.Parse(_detContrato.Element("MtM").Attribute("MoVrDet").Value);
                    XElement xe = _detContrato.Element("MoPorcStrike");
                    _PorcStrike = (xe == null) ? 0.0 : double.Parse(xe.Value);

                    //alanrevisar esto es viejo, no incluye mtm: TopologiaVegaPricingInput += "<itemDetContrato Checked='True' NumContrato='0' CodEstructura='" + (_opcionEstructuraSeleccionada.Codigo.Equals("-1") ? "0" : _opcionEstructuraSeleccionada.Codigo.ToString()) + "' NumEstructura='" + _ElementoEstructura + "' Vinculacion='" + _vinculacion + "' TipoPayOff='" + _tipoPayoff + "' CallPut='" + _opcion + "' ParStrike='" + _paridad + "' MontoMon1='" + _Nocional + "' CVOpc='" + _CVOpc + "' FechaInicioOpc='" + _FechaInicioOpc + "' FechaVcto='" + _FechaVctoOpc + "' Strike='" + _Strike + "' PuntosFwd='" + _PuntosFwd + "' SpotDet='" + _Spot + "' CurveMon1='" + _CurvaDom + "' CurveMon2='" + _CurvaFor + "' /> \n";
                    TopologiaVegaPricingInput += "<itemDetContrato Checked='True' NumContrato='0' CodEstructura='" + (_opcionEstructuraSeleccionada.Codigo.Equals("-1") ? "0" : _opcionEstructuraSeleccionada.Codigo.ToString()) + "' NumEstructura='" + _ElementoEstructura + "' Vinculacion='" + _vinculacion + "' TipoPayOff='" + _tipoPayoff + "' CallPut='" + _opcion + "' ParStrike='" + _paridad + "' MontoMon1='" + _Nocional + "' CVOpc='" + _CVOpc + "' FechaInicioOpc='" + _FechaInicioOpc + "' FechaVcto='" + _FechaVctoOpc + "' Strike='" + _Strike + "' PuntosFwd='" + _PuntosFwd + "' SpotDet='" + _Spot + "' CurveMon1='" + _CurvaDom + "' CurveMon2='" + _CurvaFor + "' PorcStrike='" + _PorcStrike + "' MTM='" + _MTM.ToString() + "' /> \n";

                    _ElementosTotal++;

                }
                TopologiaVegaPricingInput += "</DetContrato>\n";
                TopologiaVegaPricingInput += "<Fixing>\n";

                DateTime _FechaFix;
                double _valor, _peso, _volatilidad;
                int _plazo;

                int _numFix;
                int numEstruct = 1;

                foreach (XElement _elementoOpcion in xmlResult.Descendants("Opcion"))
                {
                    _numFix = 1;
                    foreach (XElement _fixing in _elementoOpcion.Descendants("FixingValues"))
                    {

                        _FechaFix = DateTime.Parse(_fixing.Attribute("Fecha").Value);
                        _valor = double.Parse(_fixing.Attribute("Valor").Value);
                        _peso = double.Parse(_fixing.Attribute("Peso").Value);
                        _volatilidad = double.Parse(_fixing.Attribute("Volatilidad").Value);
                        _plazo = int.Parse(_fixing.Attribute("Plazo").Value);

                        TopologiaVegaPricingInput += "<itemFixing NumContrato='0' NumEstructura='" + numEstruct + "' FixFecha='" + _FechaFix + "' FixNumero='" + _numFix + "' PesoFij='" + _peso + "' VolFij='" + _volatilidad + "' Fijacion='" + _valor + "' />\n";
                        _numFix++;
                    }

                    numEstruct++;

                }

                TopologiaVegaPricingInput += "</Fixing>\n";
                TopologiaVegaPricingInput += "</Data>\n";

                try
                {
                    //alanrevisar if nuevo, no el contenido... :S
                    if (!_opcionEstructuraSeleccionada.Codigo.Equals("8"))
                    {
                        TopologiaVegaPricing(TopologiaVegaPricingInput, MtM, "rrfly", setPrecios_Pricing); // Se calcula Topologia vega idioma RRFLY o CALLPUT
                        TopologiaVegaPricing(TopologiaVegaPricingInput, MtM, "callput", setPrecios_Pricing);// Se calcula Topologia vega idioma Opuesto
                        SensibilidadPricing(TopologiaVegaPricingInput, MtM, setPrecios_Pricing);
                    }
                }
                catch
                {
                    TopologiaVegaATMRRFLYPricingList = null;
                    TopologiaVegaCALLPUTListPricing = null;
                    //alanrevisar esto no lo cacho... cambio en la logica: btnTopoLogiaVegaPricing.IsEnabled = false;
                    btnTopoLogiaVegaPricing.IsEnabled = true;
                    //isTopoLogiaVegaPricing = false;
                }

                //ASVG determinar mejor posición dentro del código.
                //PRD_12567
                if (_opcionEstructuraSeleccionada.Codigo.Equals("13"))
                {
                    //MERORAR
                    _Strike = 0.0;
                    foreach (XElement _detContrato in xmlResult.Descendants("detContrato"))
                    {
                        _Strike = double.Parse(_detContrato.Element("Subyacente").Attribute("MoStrike").Value);
                    }
                    this.nocionalContraMonedaMonto = _Strike * nocional; //PRD_12567
                    _Value.DecimalPlaces = 0;
                    _Value.SetChange(this.txtNocionalContraMoneda, nocionalContraMonedaMonto);
                }

                ShowGriegas_Struct(griegas);

                EnableComponentes = true;

                GenerateXmlData(xmlResult, MtM, griegas);

            }
            catch
            {
                OutPutNaN();
            }
        }//SetGriegasAndMtMValues

        public void GenerateXmlData(XDocument xdoc, double MtM, StructGriegas griegas)
        {
            int TipoPayOff;
            string CallPut;
            string CompraVenta, Compensacion_EntregaFisica;
            double NocionalMonto;

            double _PrimaCosto = (-1.0 * MtM);

            if (((ComboBoxItem)this.comboPayOff.SelectedItem).Content.Equals("Vanilla"))
            {
                TipoPayOff = 1;
            }
            else
            {
                TipoPayOff = int.Parse(payOffList.Where(tipo => tipo.Descripcion == ((ComboBoxItem)this.comboPayOff.SelectedItem).Content.ToString()).ToList<StructCodigoDescripcion>()[0].Codigo);
            }

            CallPut = this.radioOpcCall.IsChecked.Value ? "Call" : this.radioOpcPut.IsChecked.Value ? "Put" : "";
            CompraVenta = this.radioCompra.IsChecked == true ? "C" : "V";

            NocionalMonto = double.Parse(this.txtNocional.Text);

            Compensacion_EntregaFisica = radioCompensacion.IsChecked.Value ? "C" : "E";
            int codEstructura = 0;

            if (!this._opcionEstructuraSeleccionada.Codigo.Equals("-1") && !this._opcionEstructuraSeleccionada.Codigo.Equals("0"))
            {
                codEstructura = int.Parse(OpcionesEstructuraList.Where(opcion => opcion.Descripcion == this.opcionContrato).ToList()[0].Codigo);
            }

            #region String Fixing Data
            string fixingData = "<fixingData>\n";
            for (int i = 0; i < FixingDataList.Count; i++)
            {
                fixingData += string.Format(
                                             "<Fijaciones NumEstructura='' FixFecha='{0}' FixNumero='' FixValor='{1}' FixPeso='{2}' FixVolatilidad='{3}' " +
                                             "FixBenchComparacion='' />\n",
                                             FixingDataList[i].sFecha,
                                             FixingDataList[i].Valor,
                                             FixingDataList[i].Peso,
                                             FixingDataList[i].Volatilidad
                                           );
            }
            fixingData += "</fixingData>";
            #endregion
            /*
            int codEstructura = 0;
            if (!this._opcionEstructuraSeleccionada.Codigo.Equals("-1") && !this._opcionEstructuraSeleccionada.Codigo.Equals("0"))
            {
                codEstructura = int.Parse(OpcionesEstructuraList.Where(opcion => opcion.Descripcion == this.opcionContrato).ToList()[0].Codigo);
            }
            */

            #region String EncContrato
            string encContrato = "<encContrato>\n";
            //ASVG_20140917 Mejor hubiese sido crear un nuevo tag.
            encContrato += string.Format(
                                          "<Contrato MoNumFolio='' MoTipoTransaccion='' MoNumContrato='' MoFechaContrato='{0}' MoEstado='{1}' MoGlosa='' MoRelacionaPAE='' MoRelacionaLeasing='' MoNumeroLeasing='' MoNumeroBien='' />\n", //Prd_16803
                                          this.datePiker_DateProccess.SelectedDate.Value.ToString("dd-MM-yyyy"),
                                          afirme_cotizacion
                                        );
            encContrato += "<Carteras MoCarteraFinanciera='' MoLibro='' MoCarNormativa='' MoSubCarNormativa='' />\n";
            encContrato += "<Contraparte MoRutCliente='' MoCodigo='' MoTipoContrapartida='' />\n";
            encContrato += "<Trader MoOperador='' />\n";
            encContrato += string.Format(
                                          "<Estructura MoCodEstructura='{0}' MoCVEstructura='{1}' />\n",
                                          codEstructura,
                                          CompraVenta
                                        );
            encContrato += "<Producto MoSistema='' />\n";
            encContrato += string.Format(
                                          "<Resultados MoMonPrimaTrf='{0}' MoPrimaTrf='' MoPrimaTrfML='' MoMonPrimaCosto='{1}' MoPrimaCosto='{2}' " +
                                          "MoPrimaCostoML='{3}' MoResultadoVentasML='{4}' MoCodMonPagPrima='' MoPrimaInicial='' MoPrimaInicialML='' MofPagoPrima='' " +
                                          "MoMonCarryPrima='' MoCarryPrima='' MoParM2Spot='' MoParMdaPrima='' MoFechaPagoPrima='' />\n",
                                          codigoMon2,
                                          codigoMon2,
                                          _PrimaCosto,
                                          _PrimaCosto,
                                          ResultVenta
                                        );
            encContrato += string.Format("<Proceso MoFecValorizacion='{0}' />\n", this.datePiker_DateProccess.SelectedDate.Value.ToString("dd-MM-yyyy"));
            encContrato += string.Format(
                                          "<MtM MoMon_vr='{0}' MoVr='{1}' MoVr_Costo='' UnWind='{2}' UnWindCosto='{3}' MoFormPagoUnwind='{4}' />\n",
                                          codigoMon2,
                                          MtM,
                                          Unwind,
                                          UnwindCosto,
                                          0
                                        );
            encContrato += string.Format(
                                          "<Griegas MoMondelta='' MoMon_gamma='' MoMon_vega='' MoMon_vanna='' MoMon_volga='' MoMon_theta='' MoMon_rho='' " +
                                          "MoMon_rhof='' MoMon_charm='' MoMon_zomma='' MoMon_speed='' MoPrimaBSSpotCont='' MoDeltaSpotCont='{0}' " +
                                          "MoDeltaForwardCont='{1}' MoGammaCont='{2}' MoVegaCont='{3}' MoVannaCont='{4}' MoVolgaCont='{5}' MoThetaCont='{6}' " +
                                          "MoRhoDomCont='{7}' MoRhoForCont='{8}' MoCharmCont='{9}'   />\n",
                                          griegas.DeltaSpot,
                                          griegas.DeltaForward,
                                          griegas.Gamma,
                                          griegas.Vega,
                                          griegas.Vanna,
                                          griegas.Volga,
                                          griegas.Theta,
                                          griegas.RhoDom,
                                          griegas.RhoFor,
                                          griegas.Charm
                                        );
            if (globales._Estado.Equals("E"))
            {
                encContrato += string.Format(
                                              "<Ejercer Nocional='{0}' Versus='{1}' ModalidadPago='{2}' />",
                                              double.Parse(txtEjercerMP.Text),
                                              double.Parse(txtEjercerMS.Text),
                                              (radioEntregaFisicaEjercicio.IsChecked.Value ? "E" : "C")
                                            );
            }
            else
            {
                encContrato += string.Format(
                                              "<Ejercer Nocional='{0}' Versus='{1}' ModalidadPago='{2}' />",
                                              0,
                                              0,
                                              ""
                                            );
            }
            encContrato += "</encContrato>";
            #endregion

            xmlCreate = new XDocument();
            XElement xmlBase = new XElement("Datos");
            XElement _encContrato = new XElement("encContrato");
            _encContrato = XElement.Parse(encContrato);
            xmlBase.Add(_encContrato);

            foreach (XElement _Item in xdoc.Descendants("detContrato"))
            {
                xmlBase.Add(_Item);
            }

            xmlCreate.Add(xmlBase);

            foreach (XElement _Item in xmlCreate.Descendants("detContrato"))
            {
                _Item.Element("Subyacente").Attribute("MoCodMon1").Value = codigoMon1.ToString();
                _Item.Element("Subyacente").Attribute("MoCodMon2").Value = codigoMon2.ToString();
               
                //PRD_13575
                if ((_opcionEstructuraSeleccionada.Codigo.Equals("4") || _opcionEstructuraSeleccionada.Codigo.Equals("5")) && Compensacion_EntregaFisica.Equals("E")
                    && _Item.Element("Estructura").Attribute("MoNumEstructura").Value.Equals("3"))
                
                     _Item.Element("Subyacente").Attribute("MoModalidad").Value = "C";
                else

                _Item.Element("Subyacente").Attribute("MoModalidad").Value = Compensacion_EntregaFisica;
            }
        }

        private void ShowGriegas_Struct(StructGriegas Griegas)
        {
            this.txtDeltaSpot.Text = Griegas.sDeltaSpot.ToString();
            this.txtDeltaFwd.Text = Griegas.sDeltaForward;
            this.txtGamma.Text = Griegas.sGamma.ToString();
            this.txtVega.Text = Griegas.sVega.ToString();
            this.txtRhoDom.Text = Griegas.sRhoDom.ToString();
            this.txtRhoFor.Text = Griegas.sRhoFor.ToString();
            this.txtTheta.Text = Griegas.sTheta.ToString();
            this.txtCharm.Text = Griegas.sCharm.ToString();
            this.txtVanna.Text = Griegas.sVanna.ToString();
            this.txtVolga.Text = Griegas.sVolga.ToString();
        }

        private string ToXML(bool isgreek)
        {
            string _XML = "";
            string _Gennus = "";

            if (radioCompra.IsChecked.Value)
            {
                _Gennus = "PUT";
            }
            else
            {
                _Gennus = "CALL";
            }

            double _MTM = 0;
            try
            {
                _MTM = double.Parse(txtMtMContrato.Text);
            }
            catch
            {
            }

            _XML += "<Pricing>\n";
            _XML += "\t<Tickets>\n";
            _XML += string.Format(
                                   "\t\t<Ticket OperationNumber='{0}' StructureID='{1}' Notional='{2}' Strike='{3}' ExpiryDate='{4}' Position='{5}' " +
                                   "Exercize='{6}' Gennus='{7}' StructureType='{8}' MTM='{9}' />\n",
                                   0,
                                   0,
                                   nocional,
                                   this.txtStrike1.Text,
                                   fechaVencimiento.ToString("dd/MM/yyyy"),
                                   "V",
                                   "A",
                                   _Gennus,
                                   _opcionEstructuraSeleccionada.Codigo,
                                   _MTM
                                 );
            _XML += "\t</Tickets>\n";
            _XML += string.Format(
                                   "\t<Data SetPrice='{0}' ValuatorDate='{1}' IsGreek='{2}' >\n",
                                   comboSetPrecios.SelectedIndex.Equals(0) ? 0 : 2,
                                   this.datePiker_DateProccess.SelectedDate.Value,
                                   isgreek ? "Y" : "N"
                                 );

            _XML += string.Format("\t\t<Spot Value='{0}' />\n", spot);
            _XML += string.Format("\t\t<Yields Value='{0},{1}'>\n", curvaDom, curvaFor);

            _XML += string.Format("\t\t\t<Foreign YieldName='{0}' Type='FOREIGN'>\n", curvaFor);
            _XML += "\t\t\t</Foreign>\n";

            _XML += string.Format("\t\t\t<Domestic YieldName='{0}' Type='DOMESTIC'>\n", curvaDom);
            _XML += "\t\t\t</Domestic>\n";

            _XML += "\t\t</Yields>\n";
            _XML += "\t</Data>\n";
            _XML += "</Pricing>\n";

            return _XML;
        }

        public void Valorizar()
        {
            double _Spot_Valorizacion = 0;

            try
            {
                _Spot_Valorizacion = double.Parse(txtSpotValorizacion.Text);
            }
            catch { }

            try
            {
                if ( SePuedeValorizar() )
                {
                    //isdatePickerVencChanged = false;
                    //isPlazoChanged = false;

                    #region Algoritmo que controla la valorización

                    if ((!_opcionEstructuraSeleccionada.Codigo.Equals("-1") && !_opcionEstructuraSeleccionada.Codigo.Equals("0")))
                    {
                        #region TagXML DataStrikesDelta
                        string strikes_delta_values_xml = a.genera_XML_strikes_deltas(this);
                        #endregion TagXML DataStrikesDelta
                        
                        //Estructuras
                        switch (_opcionEstructuraSeleccionada.Codigo) //valorizando...
                        {
                            case "8":
                                #region Valorización Estructura 8 "Forward Americano"
                                if ((!this.datePiker_DateProccess.SelectedDate.Value.Equals(new DateTime(0001, 01, 01)) && this.datePiker_DateProccess.Text != "" && this.datePiker_DateProccess.SelectedDate.Value != new DateTime(0001, 01, 01))
                                    && this.txtPlazo.Text != ""
                                    && this.txtNocional.Text != "" && !nocional.Equals(double.NaN)
                                    && this.txtStrike1.Text != "" && !strike.Equals(double.NaN) && !strike.Equals(double.PositiveInfinity) && !strike.Equals(double.NegativeInfinity)
                                    && !this.strike.Equals(double.NegativeInfinity) && !this.strike.Equals(double.PositiveInfinity)
                                    && ((((ComboBoxItem)this.comboPayOff.SelectedItem).Content.Equals("Asiaticas") && this.FixingDataList.Count > 0) || (((ComboBoxItem)this.comboPayOff.SelectedItem).Content.Equals("Vanilla"))))
                                {
                                    // Valorizador Forward Americano
                                    if (this.isTextChanged)
                                    {

                                        StartLoading(this.PrincipalCanvas);
                                        isGuardarValid = true;
                                        Estructura_ForwardAmericano();
                                    }
                                    else if (this.txtMtMContrato.Text != "" && isMTMTextChanged == true && this.itemTabSrikes.IsSelected)
                                    {
                                        Variando_Valorizar(); // Esto Falta
                                    }
                                }
                                #endregion
                                break;
                            case "6":
                                #region Valorización Estructura 6 "Forward Sintético"
                                if ((!this.datePiker_DateProccess.SelectedDate.Value.Equals(new DateTime(0001, 01, 01)) && this.datePiker_DateProccess.Text != "" && this.datePiker_DateProccess.SelectedDate.Value != new DateTime(0001, 01, 01))
                                    && this.txtPlazo.Text != ""
                                    && this.txtNocional.Text != "" && !nocional.Equals(double.NaN)
                                    && this.txtStrike1.Text != "" && !strike.Equals(double.NaN) && !strike.Equals(double.PositiveInfinity) && !strike.Equals(double.NegativeInfinity)
                                    && !this.strike.Equals(double.NegativeInfinity) && !this.strike.Equals(double.PositiveInfinity)
                                    && ((((ComboBoxItem)this.comboPayOff.SelectedItem).Content.Equals("Asiaticas") && this.FixingDataList.Count > 0) || (((ComboBoxItem)this.comboPayOff.SelectedItem).Content.Equals("Vanilla"))))
                                {
                                    if (this.isTextChanged)
                                    {
                                        StartLoading(this.PrincipalCanvas);
                                        isGuardarValid = true;
                                        Estructura_Forward_Sintetico(((ComboBoxItem)this.comboPayOff.SelectedItem).Content.ToString(), FixingDataString, this.opcionContrato, ((ComboBoxItem)this.comboPayOff.SelectedItem).Content.ToString(), PuntosCosto, this.datePiker_DateProccess.SelectedDate.Value, fechaVencimiento, call_put, paridad, compra_venta, nocional, spot, strikes_delta_values_xml, curvaDom, curvaFor, 0);
                                    }
                                    else if (this.txtMtMContrato.Text != "" && isMTMTextChanged == true && this.itemTabSrikes.IsSelected)
                                    {
                                        Variando_Valorizar();
                                    }
                                }
                                #endregion
                                break;
                            case "1":
                                #region Valorización Estructura 1 "Straddle"
                                if (isTextChanged.Equals(true) && (!this.datePiker_DateProccess.SelectedDate.Value.Equals(new DateTime(0001, 01, 01)) && this.datePiker_DateProccess.Text != "" && this.datePiker_DateProccess.SelectedDate.Value != new DateTime(0001, 01, 01))
                                    && this.txtPlazo.Text != ""
                                    && this.txtNocional.Text != ""
                                    && this.txtSpotCosto.Text != ""
                                    && ((this.txtStrike1.Text != "" && this.itemTabSrikes.IsSelected) || (this.txtDelta1.Text != "" && this.itemTabDeltas.IsSelected))
                                    && (!strike.Equals(double.NaN) && !strike.Equals(double.PositiveInfinity) && !strike.Equals(double.NegativeInfinity)
                                    || !delta1.Equals(double.NaN) && !delta1.Equals(double.PositiveInfinity) && !delta1.Equals(double.NegativeInfinity))
                                    && !nocional.Equals(double.NaN)
                                    && (((ComboBoxItem)this.comboPayOff.SelectedItem).Content.Equals("Vanilla")))
                                {
                                    StartLoading(this.PrincipalCanvas);
                                    isGuardarValid = true;
                                    Estructura_Straddle(((ComboBoxItem)this.comboPayOff.SelectedItem).Content.ToString(), FixingDataString, this.opcionContrato, ((ComboBoxItem)this.comboPayOff.SelectedItem).Content.ToString(), PuntosCosto, datePiker_DateProccess.SelectedDate.Value, this.fechaVencimiento, call_put, paridad, compra_venta, nocional, spot, strikes_delta_values_xml, curvaDom, curvaFor, 0);
                                }
                                #endregion
                                break;
                            case "7":
                                #region Valorización Estructura 7 "Strangle"
                                if (isTextChanged.Equals(true) && (!this.datePiker_DateProccess.SelectedDate.Value.Equals(new DateTime(0001, 01, 01)) && this.datePiker_DateProccess.Text != "" && this.datePiker_DateProccess.SelectedDate.Value != new DateTime(0001, 01, 01))
                                    && this.txtPlazo.Text != ""
                                    && this.txtNocional.Text != ""
                                    && this.txtSpotCosto.Text != ""
                                    && ((this.txtStrike1.Text != "" && this.txtStrike2.Text != "" && this.itemTabSrikes.IsSelected) || (this.txtDelta1.Text != "" && this.itemTabDeltas.IsSelected))

                                    && ((!strike.Equals(double.NaN) && !strike.Equals(double.PositiveInfinity) && !strike.Equals(double.NegativeInfinity)
                                    && !strike2.Equals(double.NaN) && !strike2.Equals(double.PositiveInfinity) && !strike2.Equals(double.NegativeInfinity))
                                    || !delta1.Equals(double.NaN) && !delta1.Equals(double.PositiveInfinity) && !delta1.Equals(double.NegativeInfinity))


                                    && !nocional.Equals(double.NaN)
                                    && (((ComboBoxItem)this.comboPayOff.SelectedItem).Content.Equals("Vanilla")))
                                {
                                    StartLoading(this.PrincipalCanvas);
                                    isGuardarValid = true;
                                    Estructura_Strangle(((ComboBoxItem)this.comboPayOff.SelectedItem).Content.ToString(), FixingDataString, this.opcionContrato, ((ComboBoxItem)this.comboPayOff.SelectedItem).Content.ToString(), PuntosCosto, this.datePiker_DateProccess.SelectedDate.Value, fechaVencimiento, call_put, paridad, compra_venta, nocional, spot, strikes_delta_values_xml, curvaDom, curvaFor, 0);
                                }
                                #endregion
                                break;
                            case "3":
                                #region Valorización Estructura 3 "Butterfly"
                                if (isTextChanged.Equals(true) && (!this.datePiker_DateProccess.SelectedDate.Value.Equals(new DateTime(0001, 01, 01)) && this.datePiker_DateProccess.Text != "" && this.datePiker_DateProccess.SelectedDate.Value != new DateTime(0001, 01, 01))
                                    && this.txtPlazo.Text != ""
                                    && this.txtNocional.Text != ""
                                    && this.txtNocionalStrangle.Text != ""
                                    && this.txtSpotCosto.Text != ""
                                    && ((this.txtStrike1.Text != "" && this.txtStrike2.Text != "" && this.txtStrike3.Text != "" && this.itemTabSrikes.IsSelected) || (this.txtDelta1.Text != "" && this.itemTabDeltas.IsSelected))
                                    && ((tabStrikesDelta.SelectedIndex == 0 && !strike.Equals(double.NaN) && !strike.Equals(double.PositiveInfinity) && !strike.Equals(double.NegativeInfinity)
                                    && !strike2.Equals(double.NaN) && !strike2.Equals(double.PositiveInfinity) && !strike2.Equals(double.NegativeInfinity)
                                    && !strike3.Equals(double.NaN) && !strike3.Equals(double.PositiveInfinity) && !strike3.Equals(double.NegativeInfinity))
                                    || (tabStrikesDelta.SelectedIndex == 1 && !delta1.Equals(double.NaN) && !delta1.Equals(double.PositiveInfinity) && !delta1.Equals(double.NegativeInfinity)))

                                    && !nocional.Equals(double.NaN)
                                    && (((ComboBoxItem)this.comboPayOff.SelectedItem).Content.Equals("Vanilla")))
                                {
                                    StartLoading(this.PrincipalCanvas);
                                    isGuardarValid = true;
                                    Estructura_Butterfly(((ComboBoxItem)this.comboPayOff.SelectedItem).Content.ToString(), FixingDataString, this.opcionContrato, ((ComboBoxItem)this.comboPayOff.SelectedItem).Content.ToString(), PuntosCosto, this.datePiker_DateProccess.SelectedDate.Value, fechaVencimiento, call_put, paridad, compra_venta, nocional, spot, strikes_delta_values_xml, curvaDom, curvaFor, 0);
                                }
                                #endregion
                                break;
                            case "2":
                                #region Valorización Estructura 2 "Collar (Risk Reversal)"
                                if ((!this.datePiker_DateProccess.SelectedDate.Value.Equals(new DateTime(0001, 01, 01)) && this.datePiker_DateProccess.Text != "" && this.datePiker_DateProccess.SelectedDate.Value != new DateTime(0001, 01, 01))
                                    && this.txtPlazo.Text != ""
                                    && this.txtNocional.Text != ""
                                    && this.txtSpotCosto.Text != ""
                                    && ((this.txtStrike1.Text != "" && this.txtStrike2.Text != "" && this.itemTabSrikes.IsSelected) || (this.txtDelta1.Text != "" && this.itemTabDeltas.IsSelected))
                                    && ((!strike.Equals(double.NaN) && !strike.Equals(double.PositiveInfinity) && !strike.Equals(double.NegativeInfinity)
                                    && !strike2.Equals(double.NaN) && !strike2.Equals(double.PositiveInfinity) && !strike2.Equals(double.NegativeInfinity))
                                    || !delta1.Equals(double.NaN) && !delta1.Equals(double.PositiveInfinity) && !delta1.Equals(double.NegativeInfinity))
                                    && !nocional.Equals(double.NaN)
                                    && (((ComboBoxItem)this.comboPayOff.SelectedItem).Content.Equals("Vanilla")))
                                {
                                    if (this.isTextChanged)
                                    {
                                        StartLoading(this.PrincipalCanvas);

                                        isGuardarValid = true;
                                        Estructura_RiskReversal(((ComboBoxItem)this.comboPayOff.SelectedItem).Content.ToString(), FixingDataString, this.opcionContrato, ((ComboBoxItem)this.comboPayOff.SelectedItem).Content.ToString(), PuntosCosto, this.datePiker_DateProccess.SelectedDate.Value, fechaVencimiento, call_put, paridad, compra_venta, nocional, spot, strikes_delta_values_xml, curvaDom, curvaFor, 0);
                                    }
                                    else if (this.txtMtMContrato.Text != "" && isMTMTextChanged == true && this.itemTabSrikes.IsSelected)
                                    {
                                        Variando_Valorizar();
                                    }

                                }
                                #endregion
                                break;
                            case "4":
                                #region Valorización Estructura 4 "Forward Utilidad Acotada"
                                if ((!this.datePiker_DateProccess.SelectedDate.Value.Equals(new DateTime(0001, 01, 01)) && this.datePiker_DateProccess.Text != "" && this.datePiker_DateProccess.SelectedDate.Value != new DateTime(0001, 01, 01))
                                    && this.txtPlazo.Text != ""
                                    && this.txtNocional.Text != ""
                                    && this.txtStrike1.Text != "" //Strike_Fwd
                                    && this.txtStrike2.Text != "" //Strike_Cota
                                    && !strike.Equals(double.NaN) && !strike.Equals(double.PositiveInfinity) && !strike.Equals(double.NegativeInfinity)
                                    && !strike2.Equals(double.NaN) && !strike2.Equals(double.PositiveInfinity) && !strike2.Equals(double.NegativeInfinity)
                                    && !nocional.Equals(double.NaN)
                                    && (this.txtStrike1.Text != "" && this.itemTabSrikes.IsSelected)
                                    && (((ComboBoxItem)this.comboPayOff.SelectedItem).Content.Equals("Vanilla")))
                                {
                                    if (radioCompra.IsChecked.Value && strike < strike2 || radioVenta.IsChecked.Value && strike > strike2)
                                    {
                                        if (this.isTextChanged)
                                        {
                                            StartLoading(this.PrincipalCanvas);
                                            isGuardarValid = true;
                                            Estructura_ForwardGananciaAcotada(((ComboBoxItem)this.comboPayOff.SelectedItem).Content.ToString(), FixingDataString, this.opcionContrato, ((ComboBoxItem)this.comboPayOff.SelectedItem).Content.ToString(), PuntosCosto, this.datePiker_DateProccess.SelectedDate.Value, fechaVencimiento, call_put, paridad, compra_venta, nocional, spot, strikes_delta_values_xml, curvaDom, curvaFor, 0);
                                        }
                                        else if (this.txtMtMContrato.Text != "" && isMTMTextChanged == true && this.itemTabSrikes.IsSelected)
                                        {
                                            Variando_Valorizar();
                                        }
                                    }
                                    else
                                    {
                                        this.txtStrike2.Text = "";
                                        strike2 = double.NaN;

                                        System.Windows.Browser.HtmlPage.Window.Alert("Cota incorrecta");
                                    }


                                }
                                #endregion
                                break;
                            case "5":
                                #region Valorización Estructura 5 "Forward Perdida Acotada"
                                if ((!this.datePiker_DateProccess.SelectedDate.Value.Equals(new DateTime(0001, 01, 01)) && this.datePiker_DateProccess.Text != "" && this.datePiker_DateProccess.SelectedDate.Value != new DateTime(0001, 01, 01))
                                    && this.txtPlazo.Text != ""
                                    && this.txtNocional.Text != ""
                                    && this.txtStrike1.Text != "" //Strike_Fwd
                                    && this.txtStrike2.Text != "" //Strike_Cota                                    
                                    && (this.txtStrike1.Text != "" && this.itemTabSrikes.IsSelected)
                                    && !strike.Equals(double.NaN) && !strike.Equals(double.PositiveInfinity) && !strike.Equals(double.NegativeInfinity)
                                    && !strike2.Equals(double.NaN) && !strike2.Equals(double.PositiveInfinity) && !strike2.Equals(double.NegativeInfinity)
                                    && !nocional.Equals(double.NaN)
                                    && (((ComboBoxItem)this.comboPayOff.SelectedItem).Content.Equals("Vanilla")))
                                {
                                    if (radioCompra.IsChecked.Value && strike > strike2 || radioVenta.IsChecked.Value && strike < strike2)
                                    {
                                        if (this.isTextChanged)
                                        {

                                            StartLoading(this.PrincipalCanvas);
                                            isGuardarValid = true;
                                            Estructura_ForwardPerdidaAcotada(((ComboBoxItem)this.comboPayOff.SelectedItem).Content.ToString(), FixingDataString, this.opcionContrato, ((ComboBoxItem)this.comboPayOff.SelectedItem).Content.ToString(), PuntosCosto, this.datePiker_DateProccess.SelectedDate.Value, fechaVencimiento, call_put, paridad, compra_venta, nocional, spot, strikes_delta_values_xml, curvaDom, curvaFor, 0);
                                        }
                                        else if (this.txtMtMContrato.Text != "" && isMTMTextChanged == true && this.itemTabSrikes.IsSelected)
                                        {
                                            Variando_Valorizar();
                                        }
                                    }
                                    else
                                    {
                                        this.txtStrike2.Text = "";
                                        strike2 = double.NaN;

                                        System.Windows.Browser.HtmlPage.Window.Alert("Cota incorrecta");
                                    }



                                }
                                #endregion
                                break;
                            case "9":
                            case "10":
                                #region Valorización Estructura 9 & 10 "Strip Asiático Call/Put"
                                if (((ComboBoxItem)this.comboPayOff.SelectedItem).Content.Equals("Asiaticas") && FixingDataList.Count != 0 && StripList != null && StripList.Count > 0)
                                {
                                    if ((!this.datePiker_DateProccess.SelectedDate.Value.Equals(new DateTime(0001, 01, 01)) && this.datePiker_DateProccess.Text != "") //falta check fecha vencimiento
                                            && this.txtPlazo.Text != ""
                                            && this.txtNocional.Text != ""
                                            && this.txtSpotCosto.Text != ""
                                            && this.txtStrike1.Text != "" && this.itemTabSrikes.IsSelected
                                            && !strike.Equals(double.NaN) && !strike.Equals(double.PositiveInfinity) && !strike.Equals(double.NegativeInfinity)
                                            && !nocional.Equals(double.NaN)
                                        //&& (this.call_put.Equals("c") || this.call_put.Equals("p"))
                                        )
                                    {
                                        if (FixingDataList[FixingDataList.Count - 1].Fecha.CompareTo(this.datePiker_DateProccess.SelectedDate.Value) >= 0)
                                        {

                                            if (this.isTextChanged)
                                            {
                                                double _delta_strike = 0;
                                                if (strikes_delta_flag.Equals("strikes"))
                                                {
                                                    _delta_strike = this.strike;
                                                }

                                                StartLoading(this.PrincipalCanvas);
                                                isGuardarValid = true;

                                                this.xmlStrip = XMLStripAsiatico(StripList);

                                                Estructura_StripAsiatico(((ComboBoxItem)this.comboPayOff.SelectedItem).Content.ToString(), FixingDataString, this.opcionContrato, ((ComboBoxItem)this.comboPayOff.SelectedItem).Content.ToString(), PuntosCosto, this.datePiker_DateProccess.SelectedDate.Value, fechaVencimiento, this.call_put, paridad, compra_venta, nocional, spot, strikes_delta_values_xml, curvaDom, curvaFor, 0, xmlStrip);
                                            }
                                            else if (this.txtMtMContrato.Text != "" && isMTMTextChanged == true && this.itemTabSrikes.IsSelected)
                                            {
                                                Variando_Valorizar();
                                            }
                                        }
                                        else
                                        {
                                            //this.itemFrontOpciones.Focus();
                                            TablaFixingIncorrecta();
                                            System.Windows.Browser.HtmlPage.Window.Alert("Tabla fixing incorrecta");
                                        }
                                    }
                                }
                                #endregion
                                break;
                            case "11":
                            case "12":
                                #region Valorización Estructura 11 & 12 "Call/Put Spread"
                                if ((!this.datePiker_DateProccess.SelectedDate.Value.Equals(new DateTime(0001, 01, 01)) && this.datePiker_DateProccess.Text != "" && this.datePiker_DateProccess.SelectedDate.Value != new DateTime(0001, 01, 01))
                                    && this.txtPlazo.Text != ""
                                    && this.txtNocional.Text != ""
                                    && this.txtStrike1.Text != "" //Call o Put
                                    && this.txtStrike2.Text != "" //Call o Put
                                    && !strike.Equals(double.NaN) && !strike.Equals(double.PositiveInfinity) && !strike.Equals(double.NegativeInfinity)
                                    && !strike2.Equals(double.NaN) && !strike2.Equals(double.PositiveInfinity) && !strike2.Equals(double.NegativeInfinity)
                                    && !nocional.Equals(double.NaN)
                                    && (this.txtStrike1.Text != "" && this.itemTabSrikes.IsSelected)
                                    && (((ComboBoxItem)this.comboPayOff.SelectedItem).Content.Equals("Vanilla")))
                                {
                                    //Validacion del Strike 1 siempre > que Strike 2
                                    bool ValorizaSpread = false;

                                    if (_opcionEstructuraSeleccionada.Codigo == "11")
                                    {
                                        if (radioCompra.IsChecked == true && strike < strike2)
                                        {
                                            ValorizaSpread = true;
                                        }
                                        else
                                        {
                                            if (radioVenta.IsChecked == true && strike > strike2)
                                            {
                                                ValorizaSpread = true;
                                            }
                                        }
                                    }
                                    else
                                    {
                                        if (radioCompra.IsChecked == true && strike > strike2)
                                        {
                                            ValorizaSpread = true;
                                        }
                                        else
                                        {
                                            if (radioVenta.IsChecked == true && strike < strike2)
                                            {
                                                ValorizaSpread = true;
                                            }
                                        }
                                    }

                                    if (ValorizaSpread == true)
                                    {
                                        if (this.isTextChanged)
                                        {
                                            StartLoading(this.PrincipalCanvas);
                                            isGuardarValid = true;
                                            string TipoSpread = _opcionEstructuraSeleccionada.Codigo;//REVISAR impacto, se elimina variable de clase "TipoSpread", no se usa en niun lado.
                                            Estructura_CallPutSpread(((ComboBoxItem)this.comboPayOff.SelectedItem).Content.ToString(), FixingDataString, this.opcionContrato, ((ComboBoxItem)this.comboPayOff.SelectedItem).Content.ToString(), PuntosCosto, this.datePiker_DateProccess.SelectedDate.Value, fechaVencimiento, call_put, paridad, compra_venta, nocional, spot, strikes_delta_values_xml, curvaDom, curvaFor, 0, TipoSpread);
                                        }
                                        else if (this.txtMtMContrato.Text != "" && isMTMTextChanged == true && this.itemTabSrikes.IsSelected)
                                        {
                                            Variando_Valorizar();
                                        }
                                    }
                                    else
                                    {
                                        this.txtStrike2.Text = "";
                                        strike2 = double.NaN;

                                        //System.Windows.Browser.HtmlPage.Window.Alert("Strike 2 incorrecto");
                                    }


                                }
                                #endregion
                                break;
                                //REVISAR si es que no está repetido con el case 6.
                            case "13"://PRD_12567
                                #region Valorización Estructura 13 "Forward Asiatico Entrada Salida"
                                 if ((!this.datePiker_DateProccess.SelectedDate.Value.Equals(new DateTime(0001, 01, 01)) && this.datePiker_DateProccess.Text != "" && this.datePiker_DateProccess.SelectedDate.Value != new DateTime(0001, 01, 01))
                                    && this.txtPlazo.Text != ""
                                    && this.txtNocional.Text != "" && !nocional.Equals(double.NaN)
                                    && this.txtStrike1.Text != "" && !strike.Equals(double.NaN) && !strike.Equals(double.PositiveInfinity) && !strike.Equals(double.NegativeInfinity)
                                    && !this.strike.Equals(double.NegativeInfinity) && !this.strike.Equals(double.PositiveInfinity)
                                    && ((((ComboBoxItem)this.comboPayOff.SelectedItem).Content.Equals("Asiaticas") && this.FixingDataList.Count > 0) || (((ComboBoxItem)this.comboPayOff.SelectedItem).Content.Equals("Vanilla"))))
                                {
                                    if (this.isTextChanged)
                                    {
                                        StartLoading(this.PrincipalCanvas);
                                        isGuardarValid = true;

                                        #region Genera String de Curvas
                                        
                                        //string _CurvasDataXML = "<CurvasMoneda>\n";

                                        //for (int i = 0; i < CurvasMonedasList.Count; i++) // Para Cambiar Curva se debe Cambiar variables 
                                        //{
                                        //    _CurvasDataXML += "<" + CurvasMonedasList[i].CodigoCurva + ">\n"; // Para Cambiar Curva se debe Cambiar CurvasMonedasList por CurvasMonedasListFwd 
                                        //    for (int z = 0; z < CurvasMonedasList[i].CurvaMoneda.Count; z++)  // (curvaDomFwd = "CurvaFwCLP";  curvaForFwd = "CurvaFwUSD");
                                        //    {
                                        //        _CurvasDataXML += string.Format(
                                        //                                         "<itemCurva ValorAsk='{0}' ValorBid='{1}' Dias='{2}' CodigoCurva='{3}' FechaGeneracion='{4}'  />\n",
                                        //                                         CurvasMonedasList[i].CurvaMoneda[z].Ask,
                                        //                                         CurvasMonedasList[i].CurvaMoneda[z].Bid,
                                        //                                         CurvasMonedasList[i].CurvaMoneda[z].dias,
                                        //                                         CurvasMonedasList[i].CodigoCurva,
                                        //                                         CurvasMonedasList[i].FechaGeneracion.ToString("dd/MM/yyyy")
                                        //                                       );
                                        //    }
                                        //    _CurvasDataXML += "</" + CurvasMonedasList[i].CodigoCurva + ">\n";
                                        //}
                                        //_CurvasDataXML += "</CurvasMoneda>\n";

                                        #endregion Genera String de Curvas

                                        Estructura_Forward_AsiaticoEntradaSalida(((ComboBoxItem)this.comboPayOff.SelectedItem).Content.ToString(), FixingDataString, this.opcionContrato, ((ComboBoxItem)this.comboPayOff.SelectedItem).Content.ToString(), PuntosCosto, this.datePiker_DateProccess.SelectedDate.Value, fechaVencimiento, call_put, paridad, compra_venta, nocional, spot, strikes_delta_values_xml, curvaDom, curvaFor, 0);
                                    }
                                    else if (this.txtMtMContrato.Text != "" && isMTMTextChanged == true && this.itemTabSrikes.IsSelected)
                                    {
                                        Variando_Valorizar();
                                    }
                                }
                                #endregion
                                break;
                            case "14":
                                #region Valorización Estructura 14 "Call Spread Doble"
                                if ((!this.datePiker_DateProccess.SelectedDate.Value.Equals(new DateTime(0001, 01, 01)) && this.datePiker_DateProccess.Text != "" && this.datePiker_DateProccess.SelectedDate.Value != new DateTime(0001, 01, 01))
                                    && this.txtPlazo.Text != ""
                                    && this.txtNocional.Text != ""
                                    && this.txtStrike1.Text != ""
                                    && this.txtStrike2.Text != ""
                                    && this.txtStrike3.Text != ""
                                    && this.txtStrike4.Text != ""
                                    && !strike.Equals(double.NaN)  && !strike.Equals(double.PositiveInfinity)  && !strike.Equals(double.NegativeInfinity)
                                    && !strike2.Equals(double.NaN) && !strike2.Equals(double.PositiveInfinity) && !strike2.Equals(double.NegativeInfinity)
                                    && !strike3.Equals(double.NaN) && !strike3.Equals(double.PositiveInfinity) && !strike3.Equals(double.NegativeInfinity)
                                    && !strike4.Equals(double.NaN) && !strike4.Equals(double.PositiveInfinity) && !strike4.Equals(double.NegativeInfinity)
                                    && !nocional.Equals(double.NaN)
                                    && this.itemTabSrikes.IsSelected
                                    && (((ComboBoxItem)this.comboPayOff.SelectedItem).Content.Equals("Vanilla"))
                                    && this.radioCompra.IsChecked == false
                                    && this.radioVenta.IsChecked == true
                                    && this.radioCompensacion.IsChecked == true
                                    && this.radioEntregaFisica.IsChecked == false
                                    )
                                {
                                    //Validacion de:
                                    //Strike1 < Strike2 < Strike3 < Strike4
                                    //Strike4 - Strike3 <= Strike2 - Strike1
                                    bool ValorizaSpread = false;

                                    //falta validar que el strike sea lo mismo que el txtStrike...
                                    ValorizaSpread = ValidaStrikes_CallSpreadDoble(strike, strike2, strike3, strike4);
                                    /*
                                     * Mejorar control del error e informar a usuario.
                                     * else
                                     * {
                                     *  this.txtStrike2.Text = "";
                                     *  strike2 = double.NaN;
                                     *  System.Windows.Browser.HtmlPage.Window.Alert("Strike 2 incorrecto");
                                     * }
                                     * */

                                    if (ValorizaSpread == true)
                                    {
                                        if (this.isTextChanged)
                                        {
                                            StartLoading(this.PrincipalCanvas);
                                            isGuardarValid = true;
                                            Estructura_CallSpreadDoble(((ComboBoxItem)this.comboPayOff.SelectedItem).Content.ToString(), FixingDataString, this.opcionContrato, ((ComboBoxItem)this.comboPayOff.SelectedItem).Content.ToString(), PuntosCosto, this.datePiker_DateProccess.SelectedDate.Value, fechaVencimiento, call_put, paridad, compra_venta, nocional, spot, strikes_delta_values_xml, curvaDom, curvaFor, 0);
                                        }
                                        else if (this.txtMtMContrato.Text != "" && isMTMTextChanged == true)
                                        {
                                            Variando_Valorizar();
                                        }
                                    }
                                    else
                                    {
                                        System.Windows.Browser.HtmlPage.Window.Alert("Strikes fuera de rango.");
                                    }
                                }
                                #endregion Valorización Estructura 14 "Call Spread Doble"
                                break;
                        }
                    }
                    else if (((ComboBoxItem)this.comboPayOff.SelectedItem).Content.Equals("Vanilla"))
                    {
                        #region Valorización "Vanilla"
                        if ((!this.datePiker_DateProccess.SelectedDate.Value.Equals(new DateTime(0001, 01, 01)) && this.datePiker_DateProccess.Text != "" && this.datePiker_DateProccess.SelectedDate.Value != new DateTime(0001, 01, 01))
                                   && this.txtPlazo.Text != ""
                                   && this.txtNocional.Text != ""
                                   && this.txtSpotCosto.Text != ""
                                   && ((this.txtStrike1.Text != "" && this.itemTabSrikes.IsSelected) || (this.txtDelta1.Text != "" && this.itemTabDeltas.IsSelected))
                                    && (!strike.Equals(double.NaN) && !strike.Equals(double.PositiveInfinity) && !strike.Equals(double.NegativeInfinity)
                                    || !delta1.Equals(double.NaN) && !delta1.Equals(double.PositiveInfinity) && !delta1.Equals(double.NegativeInfinity))
                                    && !nocional.Equals(double.NaN)
                                   && (((ComboBoxItem)this.comboPayOff.SelectedItem).Content.Equals("Vanilla")))
                        {
                            if (this.isTextChanged)
                            {
                                double _delta_strike = 0;
                                if (strikes_delta_flag.Equals("strikes"))
                                {
                                    _delta_strike = this.strike;
                                }
                                else
                                {
                                    _delta_strike = this.delta1;
                                }
                                StartLoading(this.PrincipalCanvas);
                                isGuardarValid = true;
                                Opcion_CallPutVanilla(this.strikes_delta_flag, paridad, this.call_put, this.compra_venta, this.nocional, this.spot, _Spot_Valorizacion, _delta_strike, this.datePiker_DateProccess.SelectedDate.Value, this.fechaVencimiento, this.curvaDom, this.curvaFor, 1, ((ComboBoxItem)this.comboPayOff.SelectedItem).Content.ToString(), "Individual");
                            }
                            else if (this.txtMtMContrato.Text != "" && isMTMTextChanged == true && this.itemTabSrikes.IsSelected)
                            {
                                Variando_Valorizar();

                            }
                        }
                        #endregion
                    }
                    else if (((ComboBoxItem)this.comboPayOff.SelectedItem).Content.Equals("Asiaticas") && FixingDataList.Count != 0)
                    {
                        #region Valorización "Asiática"
                        if ((!this.datePiker_DateProccess.SelectedDate.Value.Equals(new DateTime(0001, 01, 01)) && this.datePiker_DateProccess.Text != ""
                            && this.datePiker_DateProccess.SelectedDate.Value != new DateTime(0001, 01, 01))
                                   && this.txtPlazo.Text != ""
                                   && this.txtNocional.Text != ""
                                   && this.txtSpotCosto.Text != ""
                                   && this.txtStrike1.Text != "" && this.itemTabSrikes.IsSelected
                                    && !strike.Equals(double.NaN) && !strike.Equals(double.PositiveInfinity) && !strike.Equals(double.NegativeInfinity)
                                    && !nocional.Equals(double.NaN)
                                   && ((ComboBoxItem)this.comboPayOff.SelectedItem).Content.Equals("Asiaticas"))
                        {
                            if (FixingDataList[FixingDataList.Count - 1].Fecha.CompareTo(this.datePiker_DateProccess.SelectedDate.Value) >= 0)
                            {

                                if (this.isTextChanged)
                                {
                                    double _delta_strike = 0;
                                    if (strikes_delta_flag.Equals("strikes"))
                                    {
                                        _delta_strike = this.strike;
                                    }

                                    StartLoading(this.PrincipalCanvas);
                                    isGuardarValid = true;
                                    Opcion_CallPutAsiatica(paridad, this.call_put, this.compra_venta, this.nocional, this.spot, _Spot_Valorizacion, this.strike, this.datePiker_DateProccess.SelectedDate.Value, this.fechaVencimiento, this.curvaDom, this.curvaFor, 1, ((ComboBoxItem)this.comboPayOff.SelectedItem).Content.ToString(), "Individual", this.FixingDataString);
                                }
                                else if (this.txtMtMContrato.Text != "" && isMTMTextChanged == true && this.itemTabSrikes.IsSelected)
                                {
                                    Variando_Valorizar();
                                }
                            }
                            else
                            {
                                //this.itemFrontOpciones.Focus();
                                TablaFixingIncorrecta();
                                // System.Windows.Browser.HtmlPage.Window.Alert("Tabla fixing incorrecta");
                            }
                        }
                        #endregion
                    }
                    #endregion Algoritmo que controla la valorización
                    isLoadContract = false;
                    this.itemTabResultadoVenta.IsEnabled = true; //5843
                }
            }
            catch
            {
                //System.Windows.Browser.HtmlPage.Window.Alert("Catch"); 
            }

            isTextChanged = false;
            isMTMTextChanged = false;

        }

        /// <summary>
        /// Indica si están las condiciones básicas de pantalla para valorizar.
        /// </summary>
        /// <returns>Un Booleano con el resultado</returns>
        private bool SePuedeValorizar()
        {
            /*
             * OJO al modificar esta funcion:
             * .-Recordar que el orden de las evaluaciones impacta en el resultado
             * .-Recordar que al evaluar todo junto, el optimizador no necesariamente evalúa todas las condiciones
             * */

            bool valorizarOK = false;

            bool ChangedOK = false;
            bool BsFwdOK = false;
            bool BsSpotOK = false;
            bool AsianMomentosOK = false;

            #region Condiciones de Valorizacion
            try
            {
                ChangedOK =
                (
                    this.isMTMTextChanged
                    || this.isTextChanged
                    || this.isLoadContract
                );
            }
            catch { ChangedOK = false; }

            try
            {
                BsFwdOK =
                (
                    ((ComboBoxItem)this.comboPayOff.SelectedItem).Content.Equals("Vanilla")
                    && this.BsSpot_BsFwd_AsianMomentos_flag.Equals("BsFwd")
                    && !this.txtPuntosCosto.Text.Equals("")
                    && !this.PuntosCosto.Equals(double.NaN) //esto se metió adentro del paréntesis.
                );
            }
            catch { BsFwdOK = false; }

            try
            {
                BsSpotOK =
                (
                    ((ComboBoxItem)this.comboPayOff.SelectedItem).Content.Equals("Vanilla")
                    && this.BsSpot_BsFwd_AsianMomentos_flag.Equals("BsSpot")
                );
            }
            catch { BsSpotOK = false; }

            try
            {
                AsianMomentosOK =
                (
                    ((ComboBoxItem)this.comboPayOff.SelectedItem).Content.Equals("Asiaticas")
                    && this.BsSpot_BsFwd_AsianMomentos_flag.Equals("AsianMomentos")
                );
            }
            catch { AsianMomentosOK = false; }

            try
            {
                valorizarOK =
                (
                    ChangedOK
                    && (BsFwdOK || BsSpotOK || AsianMomentosOK)
                    && this.txtSpotCosto.Text != ""
                    && (this.txtStrike1.Text != "" || this.txtDelta1.Text != "")
                    && this.datePiker_DateProccess.SelectedDate.Value != null
                    && !this.txtSpotCosto.Text.Equals("")
                    && !this.txtPlazo.Text.Equals("")
                    && !this.txtNocional.Text.Equals("")
                    && this.comboSubyacente.SelectedIndex >= 0
                );
            }
            catch { valorizarOK = false; }

            #endregion Condiciones de Valorizacion

            return valorizarOK;
        }

        private void RefreshSetPricing()
        {
            if (grdTopologiaVegaCALLPUT != null)
            {
                this.grdTopologiaVegaCALLPUT.ItemsSource = null;
            }
            if (grdTopologiaVegaRRFLY != null)
            {
                this.grdTopologiaVegaRRFLY.ItemsSource = null;
            }
            if (grdTotalizadorValCartera != null)
            {
                this.grdTotalizadorValCartera.ItemsSource = null;
            }
            if (MtMGriegasTotalizador != null)
            {
                this.MtMGriegasTotalizador = null;
            }
            if (txtPosicionOpciones != null)
            {
                txtPosicionOpciones.Text = "";
            }
            if (txtTotalDeltas != null)
            {
                txtTotalDeltas.Text = "";
            }
            if (grdSensibilidadCLP.ItemsSource != null)
            {
                grdSensibilidadCLP.ItemsSource = null;
            }
            if (grdSensibilidadLocal.ItemsSource != null)
            {
                grdSensibilidadLocal.ItemsSource = null;
            }
            ActualizarTotalizadorDeltas();


            string _idCurvasXML = "<CurvasMoneda >\n";
            _idCurvasXML += "<itemCurva ID='" + curvaDom + "'/>\n";
            _idCurvasXML += "<itemCurva ID='" + curvaFor + "'/>\n";
            _idCurvasXML += "<itemCurva ID='" + curvaFwdDom + "'/>\n";
            _idCurvasXML += "<itemCurva ID='" + curvaFwdFor + "'/>\n";
            _idCurvasXML += "</CurvasMoneda>";
            //REVISAR OJO este caso, setea distinto el evento Completed: GetSetPreciosSinSpotCompleted
            SrvValorizador.SrvValorizadorCarteraSoapClient SrvValorizador = wsGlobales.Valorizador;//new AdminOpciones.SrvValorizador.SrvValorizadorCarteraSoapClient();
            SrvValorizador.GetSetPreciosConSpotCompleted += new EventHandler<AdminOpciones.SrvValorizador.GetSetPreciosConSpotCompletedEventArgs>(SrvValorizador_GetSetPreciosSinSpotCompleted);
            SrvValorizador.GetSetPreciosConSpotAsync(this.DatePickerSetPrecios.SelectedDate.Value, BSSpotValorizacion, paridad, "DO", _idCurvasXML, setPreciosValCartera);
        }

        void SrvValorizador_GetSetPreciosSinSpotCompleted(object sender, AdminOpciones.SrvValorizador.GetSetPreciosConSpotCompletedEventArgs e)
        {//OJO de aquí debe saltar al StopSetPricing o de lo contratio se está cayendo.
            bool Status;
            bool isFechaSetDePreciosFechaAnt = false;
            XDocument SetPreciosXML = new XDocument(XDocument.Parse(e.Result));

            Status = SetPreciosXML.Element("Data").Element("Status").Attribute("Value").Value.Equals("OK") ? true : false;
            isFechaSetDePreciosFechaAnt = SetPreciosXML.Element("Data").Element("Status").Attribute("FechaAnt").Value.Equals("1") ? true : false;

            ShowSmile(e.Result);
            ShowYield(e.Result);

            #region Puntos Fwd

            CurvaFwUSD = new List<StructItemPuntosForward>();

            StructItemPuntosForward _itemCurvaForward;

            foreach (XElement _itemCurva in SetPreciosXML.Element("Data").Element("PesosForward").Descendants("itemCurva"))
            {
                _itemCurvaForward = new StructItemPuntosForward();

                _itemCurvaForward.dias = int.Parse(_itemCurva.Attribute("Dias").Value);
                _itemCurvaForward.tenor = _itemCurva.Attribute("Tenor").Value;
                _itemCurvaForward.Puntos = double.Parse(_itemCurva.Attribute("Puntos").Value);
                CurvaFwUSD.Add(_itemCurvaForward);
            }

            this.grdCurvaFwUSD.ItemsSource = null;
            this.grdCurvaFwUSD.ItemsSource = CurvaFwUSD;

            #endregion
        }

        private void TablaFixingIncorrecta()
        {
            OutPutNaN();
        }

        private void RemoveBlockTextBox(TextBox textBox) { a.RemoveBlockTextBox(textBox); }

        private void PutBlockTextBox(TextBox textBox) { a.PutBlockTextBox(textBox); }

        void _TablaFixing_event_LoadDataTableFixingData()
        {
            _TablaFixing.paridad = this.paridad;
            _TablaFixing.nominal = this.nocional;
            _TablaFixing.call_put = this.call_put;
            _TablaFixing.compra_venta = this.compra_venta;
            _TablaFixing.spot = this.spot;
            _TablaFixing.strike = this.strike;
            _TablaFixing.curvaDom = this.curvaDom;
            _TablaFixing.curvaFor = this.curvaFor;
            _TablaFixing.fechaHoy = this.datePiker_DateProccess.SelectedDate.Value;
            _TablaFixing.enumSetPrecio = this.setPrecios_Pricing;
        }

        /// <summary>
        /// Maneja los eventos del radioButton selector de estructura (Call,Put, estructuras...)
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        void radioButton_Checked(object sender, RoutedEventArgs e)
        {
            try
            {
                btnStrip.IsEnabled = false;
                this.expanderOpciones.Header = ((RadioButton)sender).Content;
                this.expanderOpciones.IsExpanded = false;
                string _opcionSeleccionada = ((RadioButton)sender).Content.ToString();
                if (_opcionSeleccionada.Equals("Call") || _opcionSeleccionada.Equals("Put"))
                {
                    this.opcionContrato = _opcionSeleccionada.Equals("Call") ? "Call" : "Put";
                    this.call_put = _opcionSeleccionada.Equals("Call") ? "c" : "p";

                    if (radioCompra.IsChecked.Value)
                    {
                        if (radioOpcCall.IsChecked.Value)
                            this.txtGlosaPricing.Text = "Call USD Put CLP";
                        if (radioOpcPut.IsChecked.Value)
                            this.txtGlosaPricing.Text = "Put USD Call CLP";
                    }

                    if (radioVenta.IsChecked.Value)
                    {
                        if (radioOpcCall.IsChecked.Value)
                            this.txtGlosaPricing.Text = "Put USD Call CLP";
                        if (radioOpcPut.IsChecked.Value)
                            this.txtGlosaPricing.Text = "Call USD Put CLP";
                    }
                    this._Guardar.txtGlosa.Text = this.txtGlosaPricing.Text;
                }
                else
                {
                    this.opcionContrato = _opcionSeleccionada;
                    this.call_put = "";//es una estructura
                }
            }
            catch (Exception e1) { System.Windows.Browser.HtmlPage.Window.Alert(e1.Message.ToString() + e1.StackTrace.ToString()); }

            try
            {
                //al modificar la OpcionEstructuraList queda con el primer elemento seteado a la estructura modificada.
                //esto hace que se desarme la lista, ya que tiene un elemento repetido
                //si es distinto de Call, se cae.
                _opcionEstructuraSeleccionada = OpcionesEstructuraList.First(x => x.Descripcion.Equals(opcionContrato));
            }
            catch
            {
                _opcionEstructuraSeleccionada = OpcionesEstructuraList.First();
            }

            //A continuación, seguidilla de if-elseif para seteo de glosa.
            //REVISAR posibilidad de moverlo al switch de más abajo
            #region Forwards Acotados
            if (_opcionEstructuraSeleccionada.Codigo.Equals("4") || _opcionEstructuraSeleccionada.Codigo.Equals("5")) // FUA | FPA
            {
                if (_opcionEstructuraSeleccionada.Codigo.Equals("4"))
                {
                    this.txtGlosaPricing.Text = "Cliente " + (this.compra_venta.Equals("compra") ? "vende" : "compra") + " " + "Forward Perdida Acotada";
                    this._Guardar.txtGlosa.Text = this.txtGlosaPricing.Text;
                }
                else
                {
                    this.txtGlosaPricing.Text = "Cliente " + (this.compra_venta.Equals("compra") ? "vende" : "compra") + " " + "Forward Utilidad Acotada";
                    this._Guardar.txtGlosa.Text = this.txtGlosaPricing.Text;
                }
            }
            #endregion Forwards Acotados

            #region Strip Asiático Call
            else if (_opcionEstructuraSeleccionada.Codigo.Equals("9")) //Strip Asiático Call
            {
                this.txtGlosaPricing.Text = "Cliente " + (this.compra_venta.Equals("compra") ? "vende" : "compra") + " " + "Strip Asiático Call";
                this._Guardar.txtGlosa.Text = this.txtGlosaPricing.Text;
                //normalmente las estructuras no llevan marca de call o put.
                btnStrip.IsEnabled = true;
                this.call_put = "c";
            }
            #endregion Strip Asiático Call

            #region Strip Asiático Put
            else if (_opcionEstructuraSeleccionada.Codigo.Equals("10")) //Strip Asiático Put
            {
                this.txtGlosaPricing.Text = "Cliente " + (this.compra_venta.Equals("compra") ? "vende" : "compra") + " " + "Strip Asiático Put";
                this._Guardar.txtGlosa.Text = this.txtGlosaPricing.Text;
                //normalmente las estructuras no llevan marca de call o put.
                btnStrip.IsEnabled = true;
                this.call_put = "p";
            }
            #endregion Strip Asiático Put

            #region Call - Put Spread
            else if (_opcionEstructuraSeleccionada.Codigo.Equals("11")) //Call Spread
            {
                this.txtGlosaPricing.Text = "Cliente " + (this.compra_venta.Equals("compra") ? "vende" : "compra") + " " + "Call Spread";
                this._Guardar.txtGlosa.Text = this.txtGlosaPricing.Text;
                //normalmente las estructuras no llevan marca de call o put.
                this.call_put = "c";
            }
            else if (_opcionEstructuraSeleccionada.Codigo.Equals("12")) //Put Spread
            {
                this.txtGlosaPricing.Text = "Cliente " + (this.compra_venta.Equals("compra") ? "vende" : "compra") + " " + "Put Spread";
                this._Guardar.txtGlosa.Text = this.txtGlosaPricing.Text;
                //normalmente las estructuras no llevan marca de call o put.
                this.call_put = "p";
            }
            #endregion

            #region Call Spread Doble
            else if (_opcionEstructuraSeleccionada.Codigo.Equals("14")) //Call Spread Doble
            {
                this.txtGlosaPricing.Text = "Cliente " + (this.compra_venta.Equals("compra") ? "vende" : "compra") + " " + ((RadioButton)sender).Content.ToString();
                this._Guardar.txtGlosa.Text = this.txtGlosaPricing.Text;
                //normalmente las estructuras no llevan marca de call o put.
                //debería ser únicamente venta Call
                this.call_put = "c";
            }
            #endregion Call Spread Doble

            #region Forward Americano
            else if (_opcionEstructuraSeleccionada.Codigo.Equals("8"))
            {
                //ASVG_20110223 Claudia Avendaño dice: Compra => Exportador
                if (!radioCompra.IsChecked.Value)
                {
                    this.txtGlosaPricing.Text = "Forward Americano Importador";
                }
                else
                {
                    this.txtGlosaPricing.Text = "Forward Americano Exportador";
                }
                this._Guardar.txtGlosa.Text = this.txtGlosaPricing.Text;
            }
            #endregion Forward Americano

            #region Call & Put
            else if (!_opcionEstructuraSeleccionada.Codigo.Equals("-1") && !_opcionEstructuraSeleccionada.Codigo.Equals("0")) // !Call & !Put
            {
                this.txtGlosaPricing.Text = "";
                this._Guardar.txtGlosa.Text = this.txtGlosaPricing.Text;
            }
            #endregion Call & Put

            #region Butterfly
            if (_opcionEstructuraSeleccionada.Codigo.Equals("3"))
            {
                this.checkBoxVegaWeighted.Visibility = Visibility.Visible;
                this.checkBoxVegaWeighted.IsChecked = false;

                this.txtNocional1_Flag.Text = "Nocional Straddle";
                this.txtNocionalContraMoneda.Visibility = Visibility.Collapsed;
                this.NocionalContraMoneda_flag.Visibility = Visibility.Collapsed;
                this.txtMonedaNocionalContraMoneda.Text = "USD";
                this.txtNocionalStrangle.Visibility = Visibility.Visible;
                this.NocionalStrangle_flag.Visibility = Visibility.Visible;
            }
            #endregion Butterfly

            else
            {
                this.checkBoxVegaWeighted.Visibility = Visibility.Collapsed;

                this.txtNocional1_Flag.Text = "Nocional";
                this.txtNocionalContraMoneda.Visibility = Visibility.Visible;
                this.NocionalContraMoneda_flag.Visibility = Visibility.Visible;
                this.txtMonedaNocionalContraMoneda.Text = "CLP";
                this.txtNocionalStrangle.Visibility = Visibility.Collapsed;
                this.NocionalStrangle_flag.Visibility = Visibility.Collapsed;
            }

            Logica_Strikes_Delta();
            ClearData();
            comboPayOff.IsEnabled = true;
            comboEjercicio.SelectedIndex = 0;
            comboBsFwdBsSpotAsianMomenos.IsEnabled = true;
            comboBsFwdBsSpotAsianMomenos.Visibility = Visibility.Visible;
            btnTopoLogiaVegaPricing.IsEnabled = true;
            btnSensibilidadPricing.IsEnabled = true;
            btnSensibilidadPricing.Content = "Sensibilidad";
            checkboxSensitivity.Visibility = Visibility.Collapsed;
            #region Opciones Estructura
            switch (_opcionEstructuraSeleccionada.Codigo)
            {
                #region Call-Put
                case "-1"://Call                                 
                case "0"://Put
                    //ASVG La primera vez que se carga la pantalla, el código de estructura es -1 y el combo no tiene selección.
                    if ( comboPayOff.SelectedItem == null || ((ComboBoxItem)comboPayOff.SelectedItem).Content.Equals("Vanilla") )
                    {
                        this.comboBsFwdBsSpotAsianMomenos.SelectedIndex = 0;
                        _TablaFixing.TabEntrada.Visibility = Visibility.Collapsed;//PRD_12567
                        this.radioCompensacion.IsChecked = true;
                        this.radioEntregaFisica.IsEnabled = true;
                    }
                    else
                    {
                        this.comboBsFwdBsSpotAsianMomenos.SelectedIndex = 2;
                    }
                    this.tabStrikesDelta.SelectedIndex = 0;
                    break;
                #endregion
                #region Straddle
                case "1"://Straddle
                    this.comboBsFwdBsSpotAsianMomenos.SelectedIndex = 1;
                    tabStrikesDelta.SelectedIndex = 1;
                    this.radioCompensacion.IsChecked = true;
                    this.radioEntregaFisica.IsEnabled = false;
                    break;
                #endregion
                #region Collar (Risk Reversal)
                case "2":// RR Collar (Risk Reversal)
                    this.comboBsFwdBsSpotAsianMomenos.SelectedIndex = 1;
                    tabStrikesDelta.SelectedIndex = 0;
                    this.radioCompensacion.IsChecked = true;
                    this.radioEntregaFisica.IsEnabled = true;
                    break;
                #endregion
                #region Butterfly
                case "3": //BF Butterfly
                    this.comboBsFwdBsSpotAsianMomenos.SelectedIndex = 1;
                    tabStrikesDelta.SelectedIndex = 1;
                    this.radioCompensacion.IsChecked = true;
                    this.radioEntregaFisica.IsEnabled = false;
                    break;
                #endregion
                #region Forward Utilidad Acotada
                case "4"://FUA Forward Utilidad Acotada
                    this.comboBsFwdBsSpotAsianMomenos.SelectedIndex = 1;
                    tabStrikesDelta.SelectedIndex = 0;
                    if (globales._NumContrato == 0)
                    {
                        this.radioCompensacion.IsChecked = true;
                        this.radioEntregaFisica.IsEnabled = true;
                    }
                    break;
                #endregion
                #region Forward Perdida Acotada
                case "5"://FPA Forward Perdida Acotada
                    this.comboBsFwdBsSpotAsianMomenos.SelectedIndex = 1;
                    tabStrikesDelta.SelectedIndex = 0;

                    if (globales._NumContrato == 0)
                    {
                        this.radioCompensacion.IsChecked = true;
                        this.radioEntregaFisica.IsEnabled = true;
                    }
                    break;
                #endregion
                #region Forward Asiático
                case "6": //FS Forward Asiático
                    if (((ComboBoxItem)comboPayOff.SelectedItem).Content.Equals("Vanilla"))
                    {
                        this.comboBsFwdBsSpotAsianMomenos.SelectedIndex = 1;
                    }
                    else
                    {
                        this.comboBsFwdBsSpotAsianMomenos.SelectedIndex = 2;
                    }

                    tabStrikesDelta.SelectedIndex = 0;
                    _TablaFixing.TabEntrada.Visibility = Visibility.Collapsed;//PRD_12567
                    this.radioCompensacion.IsChecked = true;
                    this.radioEntregaFisica.IsEnabled = false;

                    break;
                #endregion
                #region Strangle
                case "7": //Strangle
                    this.comboBsFwdBsSpotAsianMomenos.SelectedIndex = 1;
                    tabStrikesDelta.SelectedIndex = 1;
                    this.radioCompensacion.IsChecked = true;
                    this.radioEntregaFisica.IsEnabled = false;
                    break;
                #endregion
                #region ForwardAmericano
                case "8": //ForwardAmericano
                    txtStrikeCallPut1.Text = "Fwd";
                    txtStrikeCallPut2.Text = "";
                    txtStrikeCallPut3.Text = "";
                    txtStrikeCallPut4.Text = "";

                    txtDeltaCallPut1.Text = "Fwd";
                    txtDeltaCallPut2.Text = "";
                    txtDeltaCallPut3.Text = "";

                    radioEntregaFisica.IsEnabled = true;
                    comboPayOff.SelectedIndex = 0;
                    comboPayOff.IsEnabled = false;
                    comboEjercicio.SelectedIndex = 2;
                    comboBsFwdBsSpotAsianMomenos.Visibility = Visibility.Collapsed;
                    btnTopoLogiaVegaPricing.IsEnabled = false;
                    btnSensibilidadPricing.IsEnabled = false;
                    btnSensibilidadPricing.Content = "  Sensibilidad";
                    checkboxSensitivity.Visibility = Visibility.Visible;

                    this.radioCompensacion.IsChecked = true;
                    this.radioEntregaFisica.IsEnabled = true;
                    break;
                #endregion
                #region Strip Asiático Call
                case "9": //Strip Asiático Call
                    (this.comboBsFwdBsSpotAsianMomenos.Items[0] as ComboBoxItem).IsEnabled = false;
                    (this.comboBsFwdBsSpotAsianMomenos.Items[1] as ComboBoxItem).IsEnabled = false;
                    (this.comboBsFwdBsSpotAsianMomenos.Items[2] as ComboBoxItem).IsEnabled = true;
                    this.comboBsFwdBsSpotAsianMomenos.SelectedIndex = 2;
                    this.comboBsFwdBsSpotAsianMomenos.IsEnabled = false;
                    tabStrikesDelta.SelectedIndex = 0;
                    this.txtStrikeCallPut1.Text = "Call";
                    this.txtStrikeCallPut2.Text = "";
                    this.txtStrikeCallPut3.Text = "";
                    this.txtStrikeCallPut4.Text = "";
                    //Fix 28-01-2012
                    this.txtStrike2.IsEnabled = false;
                    this.txtStrike3.IsEnabled = false;
                    this.txtStrike4.IsEnabled = false;
                    
                    this.unidadStrike2.Text = "";
                    this.unidadStrike3.Text = "";
                    this.unidadStrike4.Text = "";

                    _TablaFixing.TabEntrada.Visibility = Visibility.Collapsed;//PRD_12567

                    this.radioCompensacion.IsChecked = true;
                    this.radioEntregaFisica.IsEnabled = false;

                    break;
                #endregion
                #region Strip Asiático Put
                case "10"://Strip Asiático Put

                    (this.comboBsFwdBsSpotAsianMomenos.Items[0] as ComboBoxItem).IsEnabled = false;
                    (this.comboBsFwdBsSpotAsianMomenos.Items[1] as ComboBoxItem).IsEnabled = false;
                    (this.comboBsFwdBsSpotAsianMomenos.Items[2] as ComboBoxItem).IsEnabled = true;
                    this.comboBsFwdBsSpotAsianMomenos.SelectedIndex = 2;
                    this.comboBsFwdBsSpotAsianMomenos.IsEnabled = false;
                    tabStrikesDelta.SelectedIndex = 0;
                    this.txtStrikeCallPut1.Text = "Put";
                    //Fix 28-01-2012
                    this.txtStrike2.IsEnabled = false;
                    this.txtStrike3.IsEnabled = false;
                    this.txtStrike4.IsEnabled = false;
                    this.unidadStrike2.Text = "";
                    this.unidadStrike3.Text = "";
                    this.unidadStrike4.Text = "";
                    this.txtStrikeCallPut2.Text = "";
                    this.txtStrikeCallPut3.Text = "";
                    this.txtStrikeCallPut4.Text = "";

                    this.radioCompensacion.IsChecked = true;
                    this.radioEntregaFisica.IsEnabled = false;
                    _TablaFixing.TabEntrada.Visibility = Visibility.Collapsed;//PRD_12567

                    break;
                #endregion
                #region Call Spread
                case "11": //Call Spread

                    this.txtStrike1.IsEnabled = true;
                    this.unidadStrike1.Text = "CLP/USD";

                    if (this.compra_venta.Equals("compra"))
                    {
                        this.txtStrikeCallPut1.Text = "Piso";
                        this.txtStrikeCallPut2.Text = "Techo";
                    }
                    else
                    {
                        this.txtStrikeCallPut1.Text = "Techo";
                        this.txtStrikeCallPut2.Text = "Piso";
                    }

                    this.txtStrike2.IsEnabled = true;
                    this.unidadStrike2.Text = "CLP/USD";

                    this.txtStrike3.IsEnabled = false;
                    this.txtStrikeCallPut3.Text = "";
                    this.unidadStrike3.Text = "";

                    this.txtStrike4.IsEnabled = false;
                    this.txtStrikeCallPut4.Text = "";
                    this.unidadStrike4.Text = "";

                    this.txtDelta1.IsEnabled = false;
                    this.txtDelta2.IsEnabled = false;
                    this.txtDelta3.IsEnabled = false;

                    this.txtDeltaCallPut1.Text = "";
                    this.txtDeltaCallPut2.Text = "";
                    this.txtDeltaCallPut3.Text = "";

                    this.radioEntregaFisica.IsEnabled = true;
                    this.radioCompensacion.IsChecked = true;
                    this.radioEntregaFisica.IsEnabled = false;

                    break;
                #endregion
                #region Put Spread
                case "12": //Put Spread

                    this.txtStrike1.IsEnabled = true;
                    this.unidadStrike1.Text = "CLP/USD";

                    if (this.compra_venta.Equals("compra"))
                    {
                        this.txtStrikeCallPut1.Text = "Techo";
                        this.txtStrikeCallPut2.Text = "Piso";
                    }
                    else
                    {
                        this.txtStrikeCallPut1.Text = "Piso";
                        this.txtStrikeCallPut2.Text = "Techo";
                    }

                    this.txtStrike2.IsEnabled = true;
                    this.unidadStrike2.Text = "CLP/USD";

                    this.txtStrike3.IsEnabled = false;
                    this.txtStrikeCallPut3.Text = "";
                    this.unidadStrike3.Text = "";

                    this.txtStrike4.IsEnabled = false;
                    this.txtStrikeCallPut4.Text = "";
                    this.unidadStrike4.Text = "";

                    this.txtDelta1.IsEnabled = false;
                    this.txtDelta2.IsEnabled = false;
                    this.txtDelta3.IsEnabled = false;

                    this.txtDeltaCallPut1.Text = "";
                    this.txtDeltaCallPut2.Text = "";
                    this.txtDeltaCallPut3.Text = "";

                    this.radioCompensacion.IsChecked = true;
                    this.radioEntregaFisica.IsEnabled = false;

                    break;
                #endregion
                #region Forward Asiático Entrada Salida
                case "13": //FS Forward Asiático Entrada Salida
                    if (((ComboBoxItem)comboPayOff.SelectedItem).Content.Equals("Vanilla"))
                    {
                        this.comboBsFwdBsSpotAsianMomenos.SelectedIndex = 1;
                    }
                    else
                    {
                        _TablaFixing.TabEntrada.Visibility = Visibility.Visible;//PRD_12567
                        this.comboBsFwdBsSpotAsianMomenos.SelectedIndex = 2;
                    }
                    txtStrikeCallPut1.Text = "Spread";
                    tabStrikesDelta.SelectedIndex = 0;
                    this.radioCompensacion.IsChecked = true;
                    this.radioEntregaFisica.IsEnabled = false;

                    break;
                #endregion
                #region Call Spread Doble
                case "14": //Call Spread doble

                    this.txtStrike1.IsEnabled = true;
                    this.txtStrike2.IsEnabled = true;
                    this.txtStrike3.IsEnabled = true;
                    this.txtStrike4.IsEnabled = true;

                    this.unidadStrike1.Text = "CLP/USD";
                    this.unidadStrike2.Text = "CLP/USD";
                    this.unidadStrike3.Text = "CLP/USD";
                    this.unidadStrike4.Text = "CLP/USD";

                    this.txtStrikeCallPut1.Text = "Strike1";
                    this.txtStrikeCallPut2.Text = "Strike2";
                    this.txtStrikeCallPut3.Text = "Strike3";
                    this.txtStrikeCallPut4.Text = "Strike4";

                    this.txtDelta1.IsEnabled = false;
                    this.txtDelta2.IsEnabled = false;
                    this.txtDelta3.IsEnabled = false;

                    this.txtDeltaCallPut1.Text = "";
                    this.txtDeltaCallPut2.Text = "";
                    this.txtDeltaCallPut3.Text = "";

                    this.radioEntregaFisica.IsEnabled = false;
                    this.radioCompensacion.IsEnabled = false;
                    this.radioCompensacion.IsChecked = true;

                    this.radioCompra.IsEnabled = false;
                    this.radioCompra.IsChecked = false;
                    this.radioVenta.IsEnabled = true;
                    this.radioVenta.IsChecked = true;

                    break;
                #endregion
            }
            #endregion
            EnableDisableAsiatica(_opcionEstructuraSeleccionada);
            this.EnableComponentes = false;

            Valorizar();
        }

        /// <summary>
        /// Determina tipo de fijación y configura la pantalla.
        /// </summary>
        /// <param name="opcion"></param>
        private void EnableDisableAsiatica(StructCodigoDescripcion opcion)
        {
            if (payOffList != null && this.payOffList.Count > 0)
            {
                //Habilitar Vanilla & Asiatica
                if (opcion.Codigo.Equals("-1") || opcion.Codigo.Equals("0"))
                {
                    //Habilitar Asiatica               
                    ((ComboBoxItem)((this.comboPayOff.Items.ToList()).Where(x => ((ComboBoxItem)x).Content.Equals("Vanilla")).ToList())[0]).IsEnabled = true;
                    ((ComboBoxItem)((this.comboPayOff.Items.ToList()).Where(x => ((ComboBoxItem)x).Content.Equals("Asiaticas")).ToList())[0]).IsEnabled = true;
                    this.comboPayOff.SelectedIndex = 0;
                }
                //Habilitar solamente Asiatica
                else if (opcion.Codigo.Equals("9") || opcion.Codigo.Equals("10") || opcion.Codigo.Equals("6") || opcion.Codigo.Equals("13"))//PRD_12567
                {
                    ((ComboBoxItem)((this.comboPayOff.Items.ToList()).Where(x => ((ComboBoxItem)x).Content.Equals("Vanilla")).ToList())[0]).IsEnabled = false;
                    ((ComboBoxItem)((this.comboPayOff.Items.ToList()).Where(x => ((ComboBoxItem)x).Content.Equals("Asiaticas")).ToList())[0]).IsEnabled = true;
                    this.comboPayOff.SelectedIndex = 1;
                }
                //Habilitar solamente Vanilla
                else
                {
                    ((ComboBoxItem)((this.comboPayOff.Items.ToList()).Where(x => ((ComboBoxItem)x).Content.Equals("Vanilla")).ToList())[0]).IsEnabled = true;
                    ((ComboBoxItem)((this.comboPayOff.Items.ToList()).Where(x => ((ComboBoxItem)x).Content.Equals("Asiaticas")).ToList())[0]).IsEnabled = false;
                    this.comboPayOff.SelectedIndex = 0;
                }
            }
        }

        private void event_datePiker_DateProccess_SelectedChange(object sender, SelectionChangedEventArgs e)
        {
            ClearData();
            //this.DateProccess = this.datePiker_DateProccess.SelectedDate.Value;
            this._TablaFixing.datePikerInicio.SelectedDate = this.datePiker_DateProccess.SelectedDate.Value;
        }

        private void compraChecked(object sender, RoutedEventArgs e)
        {
            this.compra_venta = "compra";
            if (radioOpcCall != null)
            {
                //PAE
                ValidaPae();

                this.radioOpcCall.Content = "Call";// +this.moneda1 + "/ Put " + moneda2;
                this.radioOpcPut.Content = "Put";// + this.moneda1 + "/ Call " + moneda2;
                if (radioOpcCall.IsChecked.Value || radioOpcPut.IsChecked.Value)
                {
                    this.expanderOpciones.Header = radioOpcCall.IsChecked.Value ? this.radioOpcCall.Content.ToString() : this.radioOpcPut.Content.ToString();
                }
                if (radioOpcCall.IsChecked.Value)
                    this.txtGlosaPricing.Text = "Call USD Put CLP";
                if (radioOpcPut.IsChecked.Value)
                    this.txtGlosaPricing.Text = "Put USD Call CLP";
            }

            if (txtGlosaPricing != null)
            {
                #region Forward Acotado
                if (_opcionEstructuraSeleccionada.Codigo.Equals("4") || _opcionEstructuraSeleccionada.Codigo.Equals("5"))
                {
                    if (_opcionEstructuraSeleccionada.Codigo.Equals("4"))
                    {
                        this.txtGlosaPricing.Text = "Cliente " + (this.compra_venta.Equals("compra") ? "vende" : "compra") + " " + "Forward Perdida Acotada";
                        this._Guardar.txtGlosa.Text = this.txtGlosaPricing.Text;
                    }
                    else
                    {
                        this.txtGlosaPricing.Text = "Cliente " + (this.compra_venta.Equals("compra") ? "vende" : "compra") + " " + "Forward Utilidad Acotada";
                        this._Guardar.txtGlosa.Text = this.txtGlosaPricing.Text;
                    }
                }
                #endregion Forward Acotado

                #region Forward Americano
                else if (_opcionEstructuraSeleccionada.Codigo.Equals("8"))
                {
                    //ASVG_20110223 Claudia Avendaño dice: Compra => Exportador
                    if (!radioCompra.IsChecked.Value)
                    {
                        this.txtGlosaPricing.Text = "Forward Americano Importador";
                    }
                    else
                    {
                        this.txtGlosaPricing.Text = "Forward Americano Exportador";
                    }
                    this._Guardar.txtGlosa.Text = this.txtGlosaPricing.Text;
                }
                #endregion Forward Americano

                #region Strip Asiático
                else if (_opcionEstructuraSeleccionada.Codigo.Equals("9") || _opcionEstructuraSeleccionada.Codigo.Equals("10"))
                {
                    if (_opcionEstructuraSeleccionada.Codigo.Equals("9"))
                    {
                        this.txtGlosaPricing.Text = "Cliente " + (this.compra_venta.Equals("compra") ? "vende" : "compra") + " " + "Strip Asiático Call";
                    }
                    else
                    {
                        this.txtGlosaPricing.Text = "Cliente " + (this.compra_venta.Equals("compra") ? "vende" : "compra") + " " + "Strip Asiático Put";
                    }
                    this._Guardar.txtGlosa.Text = this.txtGlosaPricing.Text;
                }
                #endregion Strip Asiático

                #region Call-Put Spread

                else if (_opcionEstructuraSeleccionada.Codigo.Equals("11") ||
                         _opcionEstructuraSeleccionada.Codigo.Equals("12"))
                {
                    if (_opcionEstructuraSeleccionada.Codigo.Equals("11"))
                    {
                        this.txtGlosaPricing.Text = "Cliente " + (this.compra_venta.Equals("compra") ? "vende" : "compra") + " " + "Call Spread";
                        //Compra Call Spread
                        this.txtStrikeCallPut1.Text = "Piso";
                        this.txtStrikeCallPut2.Text = "Techo";
                        this.txtStrike1.Text = "";
                        this.txtStrike2.Text = "";
                    }
                    else
                    {
                        this.txtGlosaPricing.Text = "Cliente " + (this.compra_venta.Equals("compra") ? "vende" : "compra") + " " + "Put Spread";
                        //Compra Put Spread
                        this.txtStrikeCallPut1.Text = "Techo";
                        this.txtStrikeCallPut2.Text = "Piso";
                        this.txtStrike1.Text = "";
                        this.txtStrike2.Text = "";
                    }
                    this._Guardar.txtGlosa.Text = this.txtGlosaPricing.Text;
                }
                #endregion

                else if (opcionContrato != "Call" && opcionContrato != "Put")
                {
                    this.txtGlosaPricing.Text = "";
                    this._Guardar.txtGlosa.Text = this.txtGlosaPricing.Text;
                }
            }

            this.isTextChanged = true;
            Valorizar();
        }

        private void ventaChecked(object sender, RoutedEventArgs e)
        {
            this.compra_venta = "venta";

            //PAE
            ValidaPae();

            this.radioOpcCall.Content = "Call";// +this.moneda2 + "/ Put " + moneda1;
            this.radioOpcPut.Content = "Put";// +this.moneda2 + "/ Call " + moneda1;
            if (radioOpcCall.IsChecked.Value || radioOpcPut.IsChecked.Value)
            {
                this.expanderOpciones.Header = radioOpcCall.IsChecked.Value ? this.radioOpcCall.Content.ToString() : this.radioOpcPut.Content.ToString();
            }
            if (radioOpcCall.IsChecked.Value)
                this.txtGlosaPricing.Text = "Put USD Call CLP";
            if (radioOpcPut.IsChecked.Value)
                this.txtGlosaPricing.Text = "Call USD Put CLP";

            if (_opcionEstructuraSeleccionada.Codigo.Equals("4") || _opcionEstructuraSeleccionada.Codigo.Equals("5"))
            {
                if (_opcionEstructuraSeleccionada.Codigo.Equals("4"))
                {
                    this.txtGlosaPricing.Text = "Cliente " + (this.compra_venta.Equals("compra") ? "venta" : "compra") + " " + "Forward Perdida Acotada";
                    this._Guardar.txtGlosa.Text = this.txtGlosaPricing.Text;
                }
                else
                {
                    this.txtGlosaPricing.Text = "Cliente " + (this.compra_venta.Equals("compra") ? "venta" : "compra") + " " + "Forward Utilidad Acotada";
                    this._Guardar.txtGlosa.Text = this.txtGlosaPricing.Text;
                }
            }
            else if (_opcionEstructuraSeleccionada.Codigo.Equals("8"))
            {
                //ASVG_20110223 Claudia Avendaño dice: Compra => Exportador
                if (!radioCompra.IsChecked.Value)
                {
                    this.txtGlosaPricing.Text = "Forward Americano Importador";
                }
                else
                {
                    this.txtGlosaPricing.Text = "Forward Americano Exportador";
                }
                this._Guardar.txtGlosa.Text = this.txtGlosaPricing.Text;
            }
            else if (_opcionEstructuraSeleccionada.Codigo.Equals("9") || _opcionEstructuraSeleccionada.Codigo.Equals("10"))
            {
                if (_opcionEstructuraSeleccionada.Codigo.Equals("9"))
                {
                    this.txtGlosaPricing.Text = "Cliente " + (this.compra_venta.Equals("compra") ? "vende" : "compra") + " " + "Strip Asiático Call";
                }
                else
                {
                    this.txtGlosaPricing.Text = "Cliente " + (this.compra_venta.Equals("compra") ? "vende" : "compra") + " " + "Strip Asiático Put";
                }
                this._Guardar.txtGlosa.Text = this.txtGlosaPricing.Text;
            }

            #region Call - Put Spread

            else if (_opcionEstructuraSeleccionada.Codigo.Equals("11") ||
                     _opcionEstructuraSeleccionada.Codigo.Equals("12"))
            {
                if (_opcionEstructuraSeleccionada.Codigo.Equals("11"))
                {
                    this.txtGlosaPricing.Text = "Cliente " + (this.compra_venta.Equals("compra") ? "vende" : "compra") + " " + "Call Spread";
                    //Venta Call Spread
                    this.txtStrikeCallPut1.Text = "Techo";
                    this.txtStrikeCallPut2.Text = "Piso";
                    this.txtStrike1.Text = "";
                    this.txtStrike2.Text = "";
                }
                else
                {
                    this.txtGlosaPricing.Text = "Cliente " + (this.compra_venta.Equals("compra") ? "vende" : "compra") + " " + "Put Spread";
                    //Venta Put Spread
                    this.txtStrikeCallPut1.Text = "Piso";
                    this.txtStrikeCallPut2.Text = "Techo";
                    this.txtStrike1.Text = "";
                    this.txtStrike2.Text = "";
                }
                this._Guardar.txtGlosa.Text = this.txtGlosaPricing.Text;
            }

            #endregion

            else if (!_opcionEstructuraSeleccionada.Codigo.Equals("-1") && !_opcionEstructuraSeleccionada.Codigo.Equals("0"))
            {
                this.txtGlosaPricing.Text = "";
                this._Guardar.txtGlosa.Text = this.txtGlosaPricing.Text;
            }

            this.isTextChanged = true;
            Valorizar();
        }

        private void event_tabStrikesDelta_SelectedChange(object sender, SelectionChangedEventArgs e)
        {
            if (OpcionesEstructuraList != null)
                Logica_Strikes_Delta();

            if (tabStrikesDelta != null && this.tabStrikesDelta.SelectedIndex == 0)
            {
                this.strikes_delta_flag = "strikes";
            }
            else if (tabStrikesDelta != null)
            {
                this.strikes_delta_flag = "delta";
            }
        }

        private void btnGuardarXml_Clecked(object sender, RoutedEventArgs e)
        {
            // PREVIENE LA APERTURA DE LA VENTANA SI NO HAY CLIENTES CARGADOS        
            if (!IsLoadedCustomers) {
                HP.Window.Alert("Cargando clientes, favor espere unos segundos y reintente...");
                return;
            }
            //////////////////////////////////////////////////////////////////////////
             
            bool _SaveStatus = false;

            _Guardar.isLineaPuntual = checkboxLineaPuntual.IsChecked.Value;

            if (comboPayOff.SelectedIndex.Equals(0))
            {
                _SaveStatus = true;
            }
            else if (comboPayOff.SelectedIndex.Equals(1))
            {
                //Revisar
                //if (_TablaFixing.IsValidPeso())
                //{
                    _SaveStatus = true;
                //}
            }
            else
            {
                System.Windows.Browser.HtmlPage.Window.Alert("La suma de los pesos en los fixing no es igual a 1.");
            }

            if (_SaveStatus)
            {
                LoadTableClose();
            }

            if (_opcionEstructuraSeleccionada.Codigo.Equals("8") && this.compra_venta.Equals("venta") && radioCompensacion.IsEnabled.Equals(true)) //Prd_16803
            {
                _Guardar.NocionalFwd = Convert.ToDouble(this.txtNocional.Text);             
            }
        }

        private void event_btnTablaFixing_Click(object sender, RoutedEventArgs e)
        {
            // Valida PLazo Strip 7274
            int daysDiff = ((TimeSpan)(fechaVencimiento - FechaDeProceso)).Days;

            if ((daysDiff + 5) >= 1105 &&
                (_opcionEstructuraSeleccionada.Codigo.Equals("9") ||
                 _opcionEstructuraSeleccionada.Codigo.Equals("10")))
            {
                System.Windows.Browser.HtmlPage.Window.Alert("No se puede realizar strip superior a 3 años.");
                txtPlazo.Text = "";
            }

            if (!IsChangeFixing)
            {
                if (checkboxAsociadoStrip.IsChecked == true)
                {
                    System.Windows.Browser.HtmlPage.Window.Alert("Strip definido, no se puede cambiar Fixing");
                }
                else
                {
                    //REVISAR
                    //PRD_12567 MEJORAR URGENTE
                    #region Genera Fixing Forward Asitico Entrada Salida

                    if (_opcionEstructuraSeleccionada.Codigo.Equals("13") && this.txtPlazo.Text != "")
                    {
                      
                        this.FixingDataList = _TablaFixing.fixingdataList;
                        this.FixingDataListEntrada = _TablaFixing.fixingdataListEntrada;

                        if (Fixing == true)
                        {
                            _DatosFixing = FixingDataList;
                            Fixing = false;
                        }
                        else
                        {
                            _TablaFixing.Cargar(_TablaFixing.fixingdataList, isTablaFixingLoadedFromValcartera);

                            _TablaFixing.CargarEntrada(_TablaFixing.fixingdataListEntrada, isTablaFixingLoadedFromValcartera);


                            popUpTablaFixing.Show();
                            //PrincipalCanvas.Children.Add(popUpTablaFixing);
                        }

                    }
                    else
                    {
                        if (_opcionEstructuraSeleccionada.Codigo.Equals("13"))
                        {
                            System.Windows.Browser.HtmlPage.Window.Alert("Debe ingresar Fecha Vencimiento y Strike ");
                        }
                    }
                    #endregion Genera Fixing Forward Asitico Entrada Salida

                    if (_opcionEstructuraSeleccionada.Codigo != "13")//PRD_12567
                    {
                        _TablaFixing.TabEntrada.Visibility = Visibility.Collapsed;//PRD_12567
                        if (this.txtPlazo.Text != "" && this.txtStrike1.Text != "")
                        {
                            this.FixingDataList = _TablaFixing.fixingdataList;

                            if (Fixing == true)
                            {
                                _DatosFixing = FixingDataList;
                                Fixing = false;
                            }
                            else
                            {
                                _TablaFixing.Cargar(_TablaFixing.fixingdataList, isTablaFixingLoadedFromValcartera);
                                popUpTablaFixing.Show();
                                //PrincipalCanvas.Children.Add(popUpTablaFixing);
                            }
                        }
                        else
                        {
                            System.Windows.Browser.HtmlPage.Window.Alert("Debe ingresar Fecha Vencimiento y Strike");
                        }
                    }
                }
            }
        }

        private void event_ComboPayoff_SelectionChange(object sender, SelectionChangedEventArgs e)
        {
            if (((ComboBoxItem)this.comboPayOff.SelectedItem).Content.ToString().Equals("Asiaticas"))
            {
                this._TablaFixing.isAsiatica = true;
                this.radioCompensacion.IsChecked = true;
                this.radioEntregaFisica.IsEnabled = false;

                IsClearData = true;
                this.comboBsFwdBsSpotAsianMomenos.SelectedIndex = 2;
                IsClearData = false;
                this._Guardar.isAsiatica = true;
                this.btnTablaFixing.Visibility = Visibility.Visible;
                if (isTablaFixingLoadedFromValcartera == false && !this.datePiker_DateProccess.Text.Equals("") && !this.DatePickerVencimiento.Text.Equals("") && !this.txtSpotCosto.Text.Equals("") && !this.txtStrike1.Text.Equals(""))
                {
                    try
                    {
                        _TablaFixing.isEditing = true;
                        _TablaFixing.datePikerInicio.SelectedDate = this.datePiker_DateProccess.SelectedDate.Value;
                        _TablaFixing.datePikerFin.SelectedDate = this.DatePickerVencimiento.SelectedDate.Value;
                        _TablaFixing.isEditing = false;

                        this._TablaFixing.Crear();
                    }
                    catch { }
                }
            }
            else
            {
                this._TablaFixing.isAsiatica = false;
                if (_opcionEstructuraSeleccionada.Codigo.Equals("-1") || _opcionEstructuraSeleccionada.Codigo.Equals("0") || _opcionEstructuraSeleccionada.Codigo.Equals("2"))
                {
                    this.radioCompensacion.IsChecked = true;
                    this.radioEntregaFisica.IsEnabled = true;
                }
                else
                {
                    this.radioCompensacion.IsChecked = true;

                    if ((_opcionEstructuraSeleccionada.Codigo == "4") || (_opcionEstructuraSeleccionada.Codigo == "5"))
                    {
                        this.radioEntregaFisica.IsEnabled = true;
                    }
                    else
                    {
                        this.radioEntregaFisica.IsEnabled = false;
                    }
                }

                IsClearData = true;
                this.comboBsFwdBsSpotAsianMomenos.SelectedIndex = 0;
                IsClearData = false;
                this._Guardar.isAsiatica = false;
                this.btnTablaFixing.Visibility = Visibility.Collapsed;
            }
            Logica_Strikes_Delta();
            ClearData();
        }

        private void InterpVol_Strike()
        {
            this.valtxtInterpVol_Strike.LostFocus(txtInterpVol_Strike);
            try
            {
                Strike_InterpVol = double.Parse(txtInterpVol_Strike.Text);

                if (txtInterpVol_Plazo.Text != "" && !Plazo_InterpVol.Equals(double.NaN))
                {
                    InterpVol(DatePickerSetPrecios.SelectedDate.Value, Plazo_InterpVol, this.paridad, this.BSSpotValorizacion, Strike_InterpVol, this.curvaDom, this.curvaFor, this.setPreciosValCartera);
                }
            }
            catch
            {
                txtInterpVol_Strike.Text = "";
                Strike_InterpVol = double.NaN;
            }
        }

        #region DecimalText

        private void event_KeyDown_DecimalText(object sender, KeyEventArgs e)
        {
            TextBox TexBoxAux = ((TextBox)sender);
            isOpcionFromCartera = false;
            ValidAmount _Value = new ValidAmount();
            //5843
            if (e.Key != Key.Enter && e.Key != Key.Tab)
            {
                if (TexBoxAux.Name != "txtMtMContrato" && TexBoxAux.Name != "txtDistribucion" && TexBoxAux.Name != "txtPrimaContrato" && TexBoxAux.Name != "txtUnwind" && TexBoxAux.Name != "txtUnwindCosto" && TexBoxAux.Name != "txtParidadPrima" && TexBoxAux.Name != "txtResultadoVta")
                {
                    isTextChanged = true;
                }
                if (TexBoxAux.Name == "txtMtMContrato")
                {
                    isMTMTextChanged = true;
                }
                if (TexBoxAux.Name == "txtStrike1")
                {
                    txtStrike1_Changed = true;
                }
            }

            try
            {
                if (e.Key == Key.Enter)
                {
                    #region Key Enter

                    string str = TexBoxAux.Text;
                    ValidAmount _VAmount = new ValidAmount();
                    if (str != "")
                    {
                        //this.isTextChanged = true;

                        //5843
                        if (TexBoxAux.Name != "txtMtMContrato" && TexBoxAux.Name != "txtDistribucion" && TexBoxAux.Name != "txtPrimaContrato" && TexBoxAux.Name != "txtUnwind" && TexBoxAux.Name != "txtParidadPrima" && TexBoxAux.Name != "txtResultadoVta")
                        {
                            isTextChanged = true;
                        }
                        if (TexBoxAux.Name == "txtMtMContrato")
                        {
                            isMTMTextChanged = true;
                        }

                        switch (TexBoxAux.Name)
                        {
                            case "txtNocional":
                                #region txtNocional
                                valtxtNocional.KeyDown(txtNocional);
                                if (double.Parse(txtNocional.Text) > 0 && double.Parse(txtNocional.Text) <= MaxValueNocional)
                                {
                                    this.nocional = double.Parse(this.txtNocional.Text);
                                    if ((_opcionEstructuraSeleccionada.Codigo.Equals("-1") || _opcionEstructuraSeleccionada.Codigo.Equals("0") || _opcionEstructuraSeleccionada.Codigo.Equals("4") || _opcionEstructuraSeleccionada.Codigo.Equals("5")) && this.txtStrike1.Text != "")
                                    {
                                        _Value.DecimalPlaces = 0;
                                        _Value.SetChange(this.txtNocionalContraMoneda, (this.strike * this.nocional));
                                        nocionalContraMonedaMonto = (this.strike * this.nocional);
                                    }
                                    else if ((_opcionEstructuraSeleccionada.Codigo.Equals("6") || _opcionEstructuraSeleccionada.Codigo.Equals("13")) && this.txtStrike1.Text != "")//PRD_12567
                                    {
                                        _Value.DecimalPlaces = 0;
                                        _Value.SetChange(this.txtNocionalContraMoneda, (this.strike * this.nocional));
                                        nocionalContraMonedaMonto = (this.nocional * this.strike);
                                    }

                                    this.EnableComponentes = false;
                                    if (!_opcionEstructuraSeleccionada.Codigo.Equals("3"))
                                    {
                                        if (tabStrikesDelta.SelectedIndex == 0)
                                        {
                                            this.txtStrike1.Focus();
                                        }
                                        else
                                        {
                                            this.txtDelta1.Focus();
                                        }
                                    }
                                    else
                                    {
                                        if (!this.checkBoxVegaWeighted.IsChecked.Value)
                                        {
                                            this.txtNocionalStrangle.Text = this.txtNocional.Text;
                                            this.NocionalStrangle = this.nocional;

                                            if (tabStrikesDelta.SelectedIndex == 0)
                                            {
                                                this.txtNocionalStrangle.Focus();
                                                this.txtStrike1.Focus();
                                            }
                                            else
                                            {
                                                this.txtNocionalStrangle.Focus();
                                                this.txtDelta1.Focus();
                                            }


                                        }
                                        else
                                        {

                                            this.txtNocionalStrangle.Focus();
                                        }
                                    }

                                    Valorizar();
                                }
                                else
                                {
                                    this.txtNocional.Text = "";
                                    this.nocional = 0;
                                    this.txtNocional.Focus();

                                }
                                #endregion
                                break;

                            case "txtEjercerMP":
                                #region Monto Ejercer
                                valtxtNocional.KeyDown(txtEjercerMP);
                                if (double.Parse(txtEjercerMP.Text) > double.Parse(txtNocional.Text))
                                {
                                    this.valtxtNocional.SetChange(txtEjercerMP, double.Parse(txtNocional.Text));
                                }
                                CalcularEjercer();
                                #endregion
                                break;

                            case "txtNocionalStrangle":
                                #region txtNocionalStrangle
                                bool _IstxtNocionalStrangleValid = true;
                                //if (this.txtNocional.Text != "" && double.Parse(txtNocional.Text) > double.Parse(txtNocionalStrangle.Text))
                                if (double.Parse(txtNocionalStrangle.Text) < 0)
                                {
                                    _IstxtNocionalStrangleValid = false;
                                }
                                if (_IstxtNocionalStrangleValid)
                                {

                                    this.valtxtNocionalStrangle.KeyDown(txtNocionalStrangle);
                                    this.NocionalStrangle = double.Parse(this.txtNocionalStrangle.Text);
                                    this.txtStrike1.Focus();
                                    Valorizar();
                                }
                                else
                                {
                                    this.txtNocionalStrangle.Text = "";
                                    NocionalStrangle = 0;
                                    txtNocionalStrangle.Focus();
                                }
                                #endregion
                                break;

                            case "txtStrike1":
                                #region txtStrike1
                                valtxtStrike1.KeyDown(txtStrike1);

                                bool _IstxtStrike1Valid = true;

                                if ((_opcionEstructuraSeleccionada.Codigo.Equals("-1") || _opcionEstructuraSeleccionada.Codigo.Equals("0") || _opcionEstructuraSeleccionada.Codigo.Equals("1") || _opcionEstructuraSeleccionada.Codigo.Equals("6")) && double.Parse(this.txtStrike1.Text) <= 0)//PRD_12567
                                {
                                    _IstxtStrike1Valid = false;
                                }

                                if (_opcionEstructuraSeleccionada.Codigo.Equals("2") && this.txtStrike2.Text != "")
                                {
                                    if (double.Parse(txtStrike1.Text) <= 0)
                                    {
                                        _IstxtStrike1Valid = false;
                                    }

                                    if (double.Parse(this.txtStrike2.Text) >= double.Parse(txtStrike1.Text))
                                    {
                                        _IstxtStrike1Valid = false;
                                    }
                                }

                                if (_opcionEstructuraSeleccionada.Codigo.Equals("4") && this.txtStrike2.Text != "")
                                {
                                    if (double.Parse(txtStrike1.Text) <= 0)
                                    {
                                        _IstxtStrike1Valid = false;
                                    }
                                    if (double.Parse(this.txtStrike2.Text) <= double.Parse(txtStrike1.Text) && radioCompra.IsChecked.Value == true)
                                    {
                                        _IstxtStrike1Valid = false;
                                    }

                                    if (double.Parse(this.txtStrike2.Text) >= double.Parse(txtStrike1.Text) && radioVenta.IsChecked.Value == true)
                                    {
                                        _IstxtStrike1Valid = false;
                                    }
                                }

                                if (_opcionEstructuraSeleccionada.Codigo.Equals("5") && this.txtStrike2.Text != "")
                                {
                                    if (double.Parse(txtStrike1.Text) <= 0)
                                    {
                                        _IstxtStrike1Valid = false;
                                    }

                                    if (double.Parse(this.txtStrike2.Text) >= double.Parse(txtStrike1.Text) && radioCompra.IsChecked.Value == true)
                                    {
                                        _IstxtStrike1Valid = false;
                                    }

                                    if (double.Parse(this.txtStrike2.Text) <= double.Parse(txtStrike1.Text) && radioVenta.IsChecked.Value == true)
                                    {
                                        _IstxtStrike1Valid = false;
                                    }
                                }

                                if (_opcionEstructuraSeleccionada.Codigo.Equals("7"))
                                {
                                    if (double.Parse(txtStrike1.Text) <= 0)
                                    {
                                        _IstxtStrike1Valid = false;
                                    }

                                    if (this.txtStrike2.Text != "" && double.Parse(this.txtStrike2.Text) >= double.Parse(txtStrike1.Text))
                                    {
                                        _IstxtStrike1Valid = false;
                                    }
                                }

                                if (_opcionEstructuraSeleccionada.Codigo.Equals("3"))
                                {
                                    if (double.Parse(txtStrike1.Text) <= 0)
                                    {
                                        _IstxtStrike1Valid = false;
                                    }

                                    if (this.txtStrike2.Text != "" && double.Parse(this.txtStrike2.Text) >= double.Parse(txtStrike1.Text))
                                    {
                                        _IstxtStrike1Valid = false;
                                    }

                                    if (this.txtStrike3.Text != "" && double.Parse(this.txtStrike3.Text) >= double.Parse(txtStrike1.Text))
                                    {
                                        _IstxtStrike1Valid = false;
                                    }
                                }

                                if (_opcionEstructuraSeleccionada.Codigo.Equals("14"))
                                {
                                    _IstxtStrike1Valid = ValidaTxtStrike_CallSpreadDoble(this.txtStrike1, this.txtStrike2, this.txtStrike3, this.txtStrike4);
                                }

                                if (_IstxtStrike1Valid)
                                {

                                    this.strike = double.Parse(this.txtStrike1.Text);

                                    if (_opcionEstructuraSeleccionada.Codigo.Equals("-1") || _opcionEstructuraSeleccionada.Codigo.Equals("0"))
                                    {
                                        _Value.DecimalPlaces = 0;
                                        _Value.SetChange(this.txtNocionalContraMoneda, (this.strike * this.nocional));
                                        nocionalContraMonedaMonto = (this.strike * this.nocional);

                                        if (BsSpot_BsFwd_AsianMomentos_flag.Equals("BsFwd"))
                                        {
                                            this.txtPuntosCosto.Focus();
                                        }
                                    }
                                    if ((_opcionEstructuraSeleccionada.Codigo.Equals("4") || _opcionEstructuraSeleccionada.Codigo.Equals("5")) && this.txtNocional.Text != "")
                                    {
                                        _Value.DecimalPlaces = 0;
                                        _Value.SetChange(this.txtNocionalContraMoneda, (this.strike * this.nocional));
                                        nocionalContraMonedaMonto = (this.strike * this.nocional);
                                        this.txtStrike2.Focus();
                                    }
                                    if (_opcionEstructuraSeleccionada.Codigo.Equals("6") && this.txtNocional.Text != "")
                                    {
                                        _Value.DecimalPlaces = 0;
                                        _Value.SetChange(this.txtNocionalContraMoneda, (this.strike * this.nocional));
                                        nocionalContraMonedaMonto = (this.strike * this.nocional);
                                    }
                                    if (_opcionEstructuraSeleccionada.Codigo.Equals("13") && this.txtNocional.Text != "")//PRD_12567 calculo nocional contramoneda, repetido
                                    {
                                        _Value.DecimalPlaces = 0;
                                        _Value.SetChange(this.txtNocionalContraMoneda, (this.spot * this.nocional));
                                        nocionalContraMonedaMonto = (this.spot * this.nocional);
                                    }
                                    if (_opcionEstructuraSeleccionada.Codigo.Equals("2") || _opcionEstructuraSeleccionada.Codigo.Equals("7") || _opcionEstructuraSeleccionada.Codigo.Equals("3") || _opcionEstructuraSeleccionada.Codigo.Equals("14"))
                                    {
                                        this.txtStrike2.Focus();
                                    }

                                    bool _newFixingTable = false;

                                    if (((ComboBoxItem)this.comboPayOff.SelectedItem).Content.Equals("Asiaticas"))// && isTablaFixingLoadedFromValcartera.Equals(false))
                                    {
                                        if (txtStrike1_Changed && !this.datePiker_DateProccess.Text.Equals("") && !this.txtSpotCosto.Text.Equals("") && !this.txtStrike1.Text.Equals(""))
                                        {
                                            try
                                            {
                                                _TablaFixing.isEditing = true;
                                                if (_TablaFixing.datePikerInicio.SelectedDate == null)
                                                    _TablaFixing.datePikerInicio.SelectedDate = this.datePiker_DateProccess.SelectedDate.Value;
                                                if (_TablaFixing.datePikerFin.SelectedDate == null)
                                                    _TablaFixing.datePikerFin.SelectedDate = this.DatePickerVencimiento.SelectedDate.Value;
                                                _TablaFixing.isEditing = false;

                                                this._TablaFixing.Crear();
                                                if (_opcionEstructuraSeleccionada.Codigo.Equals("13"))
                                                {
                                                    _TablaFixing.isEditing = true;
                                                    if (_TablaFixing.datePikerInicioEntrada.SelectedDate == null)
                                                        _TablaFixing.datePikerInicioEntrada.SelectedDate = this.datePiker_DateProccess.SelectedDate.Value;
                                                    if (_TablaFixing.datePikerFinEntrada.SelectedDate == null)
                                                        _TablaFixing.datePikerFinEntrada.SelectedDate = this.DatePickerVencimiento.SelectedDate.Value;
                                                    _TablaFixing.isEditing = false;
                                                    
                                                    this._TablaFixing.CrearEntrada();
                                                }

                                                _newFixingTable = true;
                                            }
                                            catch { }
                                        }
                                    }
                                    if (((ComboBoxItem)this.comboPayOff.SelectedItem).Content.Equals("Vanilla") || _newFixingTable == false)
                                    {
                                        Valorizar();
                                    }
                                    txtStrike1_Changed = false;
                                }
                                else
                                {
                                    txtStrike1.Text = "";
                                    strike = 0;
                                    this.txtStrike1.Focus();

                                }
                                #endregion
                                break;

                            case "txtStrike2":
                                #region txtStrike2

                                bool _IstxtStrike2Valid = true;

                                if (_opcionEstructuraSeleccionada.Codigo.Equals("2") && this.txtStrike1.Text != "")
                                {
                                    if (double.Parse(txtStrike2.Text) <= 0)
                                    {
                                        _IstxtStrike2Valid = false;
                                    }
                                    if (double.Parse(this.txtStrike2.Text) >= double.Parse(txtStrike1.Text))
                                    {
                                        _IstxtStrike2Valid = false;
                                    }
                                }

                                if (_opcionEstructuraSeleccionada.Codigo.Equals("4") && this.txtStrike1.Text != "")
                                {
                                    if (double.Parse(txtStrike2.Text) <= 0)
                                    {
                                        _IstxtStrike2Valid = false;
                                    }

                                    if (double.Parse(this.txtStrike2.Text) <= double.Parse(txtStrike1.Text) && radioCompra.IsChecked.Value == true)
                                    {
                                        _IstxtStrike2Valid = false;
                                    }

                                    if (double.Parse(this.txtStrike2.Text) >= double.Parse(txtStrike1.Text) && radioVenta.IsChecked.Value == true)
                                    {
                                        _IstxtStrike2Valid = false;
                                    }
                                }

                                if (_opcionEstructuraSeleccionada.Codigo.Equals("5") && this.txtStrike1.Text != "")
                                {
                                    if (double.Parse(txtStrike2.Text) <= 0)
                                    {
                                        _IstxtStrike2Valid = false;
                                    }
                                    if (double.Parse(this.txtStrike2.Text) >= double.Parse(txtStrike1.Text) && radioCompra.IsChecked.Value == true)
                                    {
                                        _IstxtStrike2Valid = false;
                                    }

                                    if (double.Parse(this.txtStrike2.Text) <= double.Parse(txtStrike1.Text) && radioVenta.IsChecked.Value == true)
                                    {
                                        _IstxtStrike2Valid = false;
                                    }
                                }

                                if (_opcionEstructuraSeleccionada.Codigo.Equals("7"))
                                {
                                    if (double.Parse(txtStrike2.Text) <= 0)
                                    {
                                        _IstxtStrike2Valid = false;
                                    }
                                    if (this.txtStrike1.Text != "" && double.Parse(this.txtStrike2.Text) >= double.Parse(txtStrike1.Text))
                                    {
                                        _IstxtStrike2Valid = false;
                                    }
                                }

                                if (_opcionEstructuraSeleccionada.Codigo.Equals("3"))
                                {
                                    if (double.Parse(txtStrike2.Text) <= 0)
                                    {
                                        _IstxtStrike2Valid = false;
                                    }

                                    if (this.txtStrike1.Text != "" && double.Parse(this.txtStrike2.Text) >= double.Parse(txtStrike1.Text))
                                    {
                                        _IstxtStrike2Valid = false;
                                    }

                                    if (this.txtStrike3.Text != "" && double.Parse(this.txtStrike3.Text) <= double.Parse(txtStrike2.Text))
                                    {
                                        _IstxtStrike2Valid = false;
                                    }
                                }

                                if (_opcionEstructuraSeleccionada.Codigo.Equals("14"))
                                {
                                        _IstxtStrike2Valid = ValidaTxtStrike_CallSpreadDoble(this.txtStrike1, this.txtStrike2, this.txtStrike3, this.txtStrike4);
                                }

                                #region Call - Put Spread

                                if (_opcionEstructuraSeleccionada.Codigo.Equals("11") ||
                                    _opcionEstructuraSeleccionada.Codigo.Equals("12"))
                                {
                                    if (double.Parse(txtStrike2.Text) <= 0)
                                    {
                                        _IstxtStrike2Valid = false;
                                    }
                                    //Validar CAll Spread: Compra -> Strike 1 < Strike 2
                                    //                     Venta  -> Strike 1 > Strike 2
                                    if (_opcionEstructuraSeleccionada.Codigo.Equals("11"))
                                    {
                                        if (this.txtStrike1.Text == "")
                                        {
                                            _IstxtStrike2Valid = false;
                                        }
                                        else
                                        {
                                            if (radioCompra.IsChecked == true &&
                                                double.Parse(this.txtStrike2.Text) <=
                                                double.Parse(txtStrike1.Text))
                                            {
                                                _IstxtStrike2Valid = false;
                                            }
                                            else
                                            {
                                                if (radioVenta.IsChecked == true &&
                                                double.Parse(this.txtStrike2.Text) >=
                                                double.Parse(txtStrike1.Text))
                                                {
                                                    _IstxtStrike2Valid = false;
                                                }
                                            }
                                        }
                                    }
                                    //Validar PUT Spread:  Compra -> Strike 1 > Strike 2
                                    //                     Venta  -> Strike 1 < Strike 2
                                    else
                                    {
                                        if (radioCompra.IsChecked == true &&
                                            double.Parse(this.txtStrike2.Text) >=
                                            double.Parse(txtStrike1.Text))
                                        {
                                            _IstxtStrike2Valid = false;
                                        }
                                        else
                                        {
                                            if (radioVenta.IsChecked == true &&
                                            double.Parse(this.txtStrike2.Text) <=
                                            double.Parse(txtStrike1.Text))
                                            {
                                                _IstxtStrike2Valid = false;
                                            }
                                        }
                                    }
                                }

                                #endregion

                                if (_IstxtStrike2Valid)
                                {
                                    valtxtStrike2.KeyDown(txtStrike2);
                                    this.strike2 = double.Parse(this.txtStrike2.Text);
                                    Valorizar();

                                    if (_opcionEstructuraSeleccionada.Codigo.Equals("3") || _opcionEstructuraSeleccionada.Codigo.Equals("14"))
                                    {
                                        this.txtStrike3.Focus();
                                    }
                                }
                                else
                                {
                                    this.txtStrike2.Text = "";
                                    strike2 = 0;
                                    this.txtStrike2.Focus();
                                }
                                #endregion
                                break;

                            case "txtStrike3":
                                #region txtStrike3
                                valtxtStrike3.LostFocus(txtStrike3);

                                bool _IstxtStrike3Valid = true;


                                if (_opcionEstructuraSeleccionada.Codigo.Equals("3"))
                                {
                                    if (this.txtStrike1.Text != "" && double.Parse(this.txtStrike3.Text) >= double.Parse(txtStrike1.Text))
                                    {
                                        _IstxtStrike3Valid = false;
                                    }

                                    if (this.txtStrike2.Text != "" && double.Parse(this.txtStrike3.Text) <= double.Parse(txtStrike2.Text))
                                    {
                                        _IstxtStrike3Valid = false;
                                    }
                                }

                                if (_opcionEstructuraSeleccionada.Codigo.Equals("14"))
                                {
                                    _IstxtStrike3Valid = ValidaTxtStrike_CallSpreadDoble(this.txtStrike1, this.txtStrike2, this.txtStrike3, this.txtStrike4);
                                }

                                if (_IstxtStrike3Valid)
                                {
                                    valtxtStrike3.KeyDown(txtStrike3);
                                    this.strike3 = double.Parse(this.txtStrike3.Text);
                                    Valorizar();
                                    if (_opcionEstructuraSeleccionada.Codigo.Equals("14"))
                                    {
                                        this.txtStrike4.Focus();
                                    }
                                }
                                else
                                {
                                    this.txtStrike3.Text = "";
                                    strike3 = 0;
                                    txtStrike3.Focus();
                                }
                                #endregion
                                break;

                            case "txtStrike4":
                                #region txtStrike4
                                valtxtStrike4.LostFocus(txtStrike4);

                                bool _IstxtStrike4Valid = ValidaTxtStrike_CallSpreadDoble(this.txtStrike1, this.txtStrike2, this.txtStrike3, this.txtStrike4);

                                if (_IstxtStrike4Valid)
                                {
                                    valtxtStrike4.KeyDown(txtStrike4);
                                    this.strike4 = double.Parse(this.txtStrike4.Text);
                                    Valorizar();
                                }
                                else
                                {
                                    this.txtStrike4.Text = "";
                                    strike4 = 0;
                                    txtStrike4.Focus();
                                }
                                #endregion txtStrike4
                                break;

                            case "txtDelta1":
                                #region txtDelta1
                                valtxtDelta1.KeyDown(txtDelta1);
                                bool isDelta1Valid = true;
                                if (txtDelta1.Text != "" && (double.Parse(txtDelta1.Text) < 0 || double.Parse(txtDelta1.Text) > 100))
                                {
                                    isDelta1Valid = false;
                                }
                                if (isDelta1Valid)
                                {
                                    this.delta1 = double.Parse(this.txtDelta1.Text) / 100.0;
                                    Valorizar();
                                }
                                else
                                {
                                    this.txtDelta1.Text = "";
                                    this.delta1 = 0;
                                    this.txtDelta1.Focus();
                                }
                                if (BsSpot_BsFwd_AsianMomentos_flag.Equals("BsFwd"))
                                {
                                    this.txtPuntosCosto.Focus();
                                }
                                #endregion
                                break;

                            case "txtDelta2":
                                #region txtDelta2
                                valtxtDelta2.KeyDown(txtDelta2);
                                this.delta2 = double.Parse(this.txtDelta2.Text) / 100.0;
                                #endregion
                                break;

                            case "txtDelta3":
                                #region txtDelta3
                                valtxtDelta3.KeyDown(txtDelta3);
                                this.delta3 = double.Parse(this.txtDelta3.Text) / 100.0;
                                #endregion
                                break;

                            case "txtSpotCosto":
                                #region txtSpotCosto

                                if (double.Parse(txtSpotCosto.Text) > 0)
                                {
                                    valtxtSpotCosto.KeyDown(txtSpotCosto);
                                    this.spot = double.Parse(this.txtSpotCosto.Text);
                                    Valorizar();
                                }

                                #endregion
                                break;

                            case "txtPuntosCosto":
                                #region txtPuntosCosto
                                valtxtPuntosCosto.KeyDown(this.txtPuntosCosto);
                                this.PuntosCosto = double.Parse(this.txtPuntosCosto.Text);

                                Valorizar();
                                #endregion
                                break;

                            case "txtUnwind":
                                #region txtUnwind
                                valtxtUnwind.KeyDown(this.txtUnwind);
                                try
                                {
                                    Unwind = double.Parse(txtUnwind.Text);
                                    itemTabUnwind.Focus();
                                }
                                catch
                                {
                                    txtUnwind.Text = "";
                                    Unwind = double.NaN;
                                }
                                #endregion
                                break;

                            case "txtUnwindCosto":
                                #region txtUnwindCosto
                                valtxtUnwindCosto.KeyDown(this.txtUnwindCosto);
                                try
                                {
                                    Unwind = double.Parse(txtUnwindCosto.Text);
                                    itemTabUnwind.Focus();
                                }
                                catch
                                {
                                    txtUnwindCosto.Text = "";
                                    UnwindCosto = double.NaN;
                                }
                                #endregion
                                break;

                            case "txtParidadPrima":
                                #region txtParidadPrima

                                if (double.Parse(txtParidadPrima.Text) >= 0)
                                {
                                    valtxtParidadPrima.KeyDown(txtParidadPrima);
                                    try
                                    {
                                        ParidadPrima = double.Parse(txtParidadPrima.Text);
                                        itemTabPrima.Focus();
                                    }
                                    catch
                                    {
                                        txtParidadPrima.Text = "";
                                        ParidadPrima = double.NaN;
                                    }
                                }
                                #endregion
                                break;

                            case "txtPrimaContrato":
                                #region txtPrimaContrato
                                valtxtPrimaContrato.KeyDown(this.txtPrimaContrato);

                                try
                                {
                                    itemTabPrima.Focus();
                                    PrimaContrato = double.Parse(txtPrimaContrato.Text);

                                }
                                catch
                                {
                                    txtPrimaContrato.Text = "";
                                    PrimaContrato = double.NaN;
                                }

                                #endregion
                                break;

                            case "txtSpotValorizacion":
                                #region txtSpotValorizacion
                                if (double.Parse(txtSpotValorizacion.Text) > 0)
                                {
                                    valtxtSpotValorizacion.KeyDown(this.txtSpotValorizacion);
                                    BSSpotValorizacion = double.Parse(this.txtSpotValorizacion.Text);

                                    this.btnCatgarSpot.Focus();
                                }

                                //CargarSetdePrecios();
                                #endregion
                                break;

                            case "txtDistribucion":
                                #region txtDistribucion
                                valtxtDistribucion.KeyDown(txtDistribucion);
                                Distribucion = double.Parse(txtDistribucion.Text);
                                itemTabDistribucion.Focus();
                                #endregion
                                break;

                            case "txtMtMContrato":
                                #region txtMtMContrato
                                this.valtxtMtMValorizacion.KeyDown(this.txtMtMContrato);
                                this.MtMContrato = double.Parse(txtMtMContrato.Text);
                                Enable_RadioButtons_Solver();
                                Valorizar();
                                #endregion
                                break;

                            case "txtInterpVol_Strike":
                                #region txtInterpVol_Strike
                                this.valtxtInterpVol_Strike.KeyDown(txtInterpVol_Strike);
                                try
                                {
                                    Strike_InterpVol = double.Parse(txtInterpVol_Strike.Text);

                                    if (e.Key == Key.Enter && txtInterpVol_Plazo.Text == "")
                                    {
                                        txtInterpVol_Plazo.Focus();
                                    }
                                    else if (e.Key == Key.Enter && txtInterpVol_Plazo.Text != "")
                                    {
                                        this.txtInterpVol_Volatilidad.Focus();
                                    }
                                }
                                catch
                                {
                                    txtInterpVol_Strike.Text = "";
                                    Strike_InterpVol = double.NaN;
                                }
                                #endregion
                                break;

                            //5843
                            case "txtResultadoVta":
                                #region txtResultadoVta}
                                valtxtResultadoVta.KeyDown(this.txtResultadoVta);
                                try
                                {
                                    ResultVenta = double.Parse(txtResultadoVta.Text);
                                    itemTabResultadoVenta.Focus();
                                }
                                catch
                                {
                                    txtResultadoVta.Text = "";
                                    ResultVenta = double.NaN;
                                }
                                #endregion
                                break;
                        }
                    }
                    #endregion
                }
                else
                {
                    if (_opcionEstructuraSeleccionada.Codigo.Equals("3"))
                    {
                        switch (TexBoxAux.Name)
                        {
                            case "txtNocionalStrangle":
                                #region txtNocionalStrangle
                                this.checkBoxVegaWeighted.IsChecked = false;
                                #endregion
                                break;
                        }
                    }

                }
            }
            catch { };

        }

        private void event_GotFocus_DecimalText(object sender, RoutedEventArgs e)
        {
            TextBox TexBoxAux = ((TextBox)sender);
            string str = TexBoxAux.Text;

            ValidAmount _VAmount = new ValidAmount();

            if (str != "")
            {
                switch (TexBoxAux.Name)
                {
                    case "txtNocional":
                        #region txtNocional
                        valtxtNocional.GotFocus(txtNocional);
                        #endregion
                        break;

                    case "txtEjercerMP":
                        #region Monto Ejercer
                        valtxtNocional.GotFocus(txtEjercerMP);
                        #endregion
                        break;

                    case "txtNocionalContraMoneda":
                        #region txtNocionalContraMoneda
                        if (itemTabDeltas.IsSelected)
                        {
                            txtDelta1.Focus();
                        }
                        else
                        {
                            txtStrike1.Focus();
                        }
                        #endregion
                        break;

                    case "txtNocionalStrangle":
                        #region txtNocionalStrangle
                        this.valtxtNocionalStrangle.GotFocus(txtNocionalStrangle);
                        #endregion
                        break;

                    case "txtStrike1":
                        #region txtStrike1
                        valtxtStrike1.GotFocus(txtStrike1);
                        if (this._Transaccion == "ANTICIPA")
                        {
                            this.txtStrike1.IsEnabled = false;
                        }
                        #endregion
                        break;

                    case "txtStrike2":
                        #region txtStrike2
                        valtxtStrike2.GotFocus(txtStrike2);
                        if (this._Transaccion == "ANTICIPA")
                        {
                            this.txtStrike2.IsEnabled = false;
                        }
                        #endregion
                        break;

                    case "txtStrike3":
                        #region txtStrike3
                        valtxtStrike3.GotFocus(txtStrike3);
                        if (this._Transaccion == "ANTICIPA")
                        {
                            this.txtStrike3.IsEnabled = false;
                        }
                        #endregion
                        break;

                    case "txtStrike4":
                        #region txtStrike4
                        valtxtStrike4.GotFocus(txtStrike4);
                        if (this._Transaccion == "ANTICIPA")
                        {
                            this.txtStrike4.IsEnabled = false;
                        }
                        #endregion
                        break;

                    case "txtDelta1":
                        #region txtDelta1
                        valtxtDelta1.GotFocus(txtDelta1);
                        #endregion
                        break;

                    case "txtDelta2":
                        #region txtDelta2
                        valtxtDelta2.GotFocus(txtDelta2);
                        #endregion
                        break;

                    case "txtDelta3":
                        #region txtDelta3
                        valtxtDelta3.GotFocus(txtDelta3);
                        #endregion
                        break;

                    case "txtSpotCosto":
                        #region txtSpotCosto
                        valtxtSpotCosto.GotFocus(txtSpotCosto);
                        if (this._Transaccion == "ANTICIPA")
                        {
                            this.txtSpotCosto.IsEnabled = false;
                        }
                        _SpotCosto = double.Parse(txtSpotCosto.Text);
                        #endregion
                        break;

                    case "txtPuntosCosto":
                        #region txtPuntosCosto
                        valtxtPuntosCosto.GotFocus(this.txtPuntosCosto);
                        if (this._Transaccion == "ANTICIPA")
                        {
                            this.txtPuntosCosto.IsEnabled = false;
                        }
                        #endregion
                        break;

                    case "txtUnwind":
                        #region txtUnwind
                        valtxtUnwind.GotFocus(this.txtUnwind);
                        #endregion
                        break;

                    case "txtUnwindCosto":
                        #region txtUnwindCosto
                        valtxtUnwindCosto.GotFocus(this.txtUnwindCosto);
                        #endregion
                        break;

                    case "txtParidadPrima":
                        #region txtParidadPrima
                        valtxtParidadPrima.GotFocus(txtParidadPrima);
                        #endregion
                        break;

                    case "txtPrimaContrato":
                        #region txtPrimaContrato
                        valtxtPrimaContrato.GotFocus(this.txtPrimaContrato);
                        #endregion
                        break;

                    case "txtDistribucion":
                        #region txtDistribucion
                        valtxtDistribucion.GotFocus(txtDistribucion);
                        #endregion
                        break;

                    case "txtSpotValorizacion":
                        #region txtSpotValorizacion
                        valtxtSpotValorizacion.GotFocus(this.txtSpotValorizacion);
                        #endregion
                        break;

                    case "txtMtMContrato":
                        #region txtMtMContrato
                        valtxtMtMValorizacion.GotFocus(this.txtMtMContrato);
                        #endregion
                        break;

                    case "txtInterpVol_Strike":
                        #region txtInterpVol_Strike
                        this.valtxtInterpVol_Strike.GotFocus(txtInterpVol_Strike);
                        #endregion
                        break;
                }
            }
        }

        private void event_TextChanged_DecimalText(object sender, TextChangedEventArgs e)
        {
            TextBox TexBoxAux = ((TextBox)sender);
            string str = TexBoxAux.Text;
            ValidAmount _VAmount = new ValidAmount();

            if (str != "")
            {
                switch (TexBoxAux.Name)
                {
                    case "txtNocional":
                        #region txtNocional
                        valtxtNocional.TextChange(txtNocional);
                        #endregion
                        break;

                    case "txtEjercerMP":
                        #region Monto Ejercicio
                        valtxtNocional.TextChange(txtEjercerMP);
                        #endregion
                        break;

                    case "txtNocionalStrangle":
                        #region txtNocionalStrangle
                        this.valtxtNocionalStrangle.TextChange(txtNocionalStrangle);
                        #endregion
                        break;

                    case "txtStrike1":
                        #region txtStrike1
                        valtxtStrike1.TextChange(txtStrike1);
                        if (this._Transaccion == "ANTICIPA")
                        {
                            this.txtStrike1.IsEnabled = false;
                        }
                        #endregion
                        break;

                    case "txtStrike2":
                        #region txtStrike2
                        valtxtStrike2.TextChange(txtStrike2);
                        if (this._Transaccion == "ANTICIPA")
                        {
                            this.txtStrike2.IsEnabled = false;
                        }
                        #endregion
                        break;

                    case "txtStrike3":
                        #region txtStrike3
                        valtxtStrike3.TextChange(txtStrike3);
                        if (this._Transaccion == "ANTICIPA")
                        {
                            this.txtStrike1.IsEnabled = false;
                        }
                        #endregion
                        break;

                    case "txtStrike4":
                        #region txtStrike4
                        valtxtStrike4.TextChange(txtStrike4);
                        if (this._Transaccion == "ANTICIPA")
                        {
                            this.txtStrike4.IsEnabled = false;
                        }
                        #endregion
                        break;

                    case "txtDelta1":
                        #region txtDelta1
                        valtxtDelta1.TextChange(txtDelta1);
                        #endregion
                        break;

                    case "txtDelta2":
                        #region txtDelta2
                        valtxtDelta2.TextChange(txtDelta2);
                        #endregion
                        break;

                    case "txtDelta3":
                        #region txtDelta3
                        valtxtDelta3.TextChange(txtDelta3);
                        #endregion
                        break;

                    case "txtSpotCosto":
                        #region txtSpotCosto
                        valtxtSpotCosto.TextChange(txtSpotCosto);
                        if (this._Transaccion == "ANTICIPA")
                        {
                            this.txtSpotCosto.IsEnabled = false;
                        }
                        #endregion
                        break;

                    case "txtPuntosCosto":
                        #region txtPuntosCosto
                        valtxtPuntosCosto.TextChange(this.txtPuntosCosto);
                        #endregion
                        break;

                    case "txtUnwind":
                        #region txtUnwind
                        valtxtUnwind.TextChange(this.txtUnwind);
                        #endregion
                        break;

                    case "txtUnwindCosto":
                        #region txtUnwindCosto
                        valtxtUnwindCosto.TextChange(this.txtUnwindCosto);
                        #endregion
                        break;

                    case "txtParidadPrima":
                        #region txtParidadPrima
                        valtxtParidadPrima.TextChange(txtParidadPrima);
                        #endregion
                        break;

                    case "txtPrimaContrato":
                        #region txtPrimaContrato
                        if (!IsCalculatePrima)
                        {
                            if (ComboUnidadPrima.SelectedIndex.Equals(1))
                            {
                                valtxtPrimaContrato.DecimalPlaces = 2;
                            }
                            else
                            {
                                valtxtPrimaContrato.DecimalPlaces = 0;
                            }
                            valtxtPrimaContrato.TextChange(this.txtPrimaContrato);
                        }
                        IsCalculatePrima = false;
                        #endregion
                        break;

                    case "txtDistribucion":
                        #region txtDistribucion
                        valtxtDistribucion.TextChange(txtDistribucion);
                        #endregion
                        break;

                    case "txtSpotValorizacion":
                        #region txtSpotValorizacion
                        valtxtSpotValorizacion.TextChange(this.txtSpotValorizacion);
                        this.txtSpotCosto.Text = txtSpotValorizacion.Text;
                        this.spot = BSSpotValorizacion;
                        isTextChanged = true;
                        #endregion
                        break;

                    case "txtMtMContrato":
                        #region txtMtMContrato
                        valtxtMtMValorizacion.TextChange(this.txtMtMContrato);
                        Enable_RadioButtons_Solver();
                        #endregion
                        break;

                    case "txtInterpVol_Strike":
                        #region txtInterpVol_Strike
                        this.valtxtInterpVol_Strike.TextChange(txtInterpVol_Strike);
                        #endregion
                        break;
                    //5843
                    case "txtResultadoVta":
                        #region txtResultadoVta
                        valtxtResultadoVta.TextChange(this.txtResultadoVta);
                        #endregion
                        break;
                }
            }
        }

        //REVISAR deben faltar condiciones
        //4
        private void event_LostFocus_DecimalText(object sender, RoutedEventArgs e)
        {
            TextBox TexBoxAux = ((TextBox)sender);
            string str = TexBoxAux.Text;
            ValidAmount _Value = new ValidAmount();

            if (str != "")
            {
                switch (TexBoxAux.Name)
                {
                    case "txtNocional":
                        #region txtNocional

                        valtxtNocional.LostFocus(txtNocional);
                        if (double.Parse(txtNocional.Text) > 0 && double.Parse(txtNocional.Text) <= MaxValueNocional)
                        {

                            this.nocional = double.Parse(this.txtNocional.Text);
                            if ((_opcionEstructuraSeleccionada.Codigo.Equals("-1") || _opcionEstructuraSeleccionada.Codigo.Equals("0") || _opcionEstructuraSeleccionada.Codigo.Equals("4") || _opcionEstructuraSeleccionada.Codigo.Equals("5")) && this.txtStrike1.Text != "")
                            {
                                _Value.DecimalPlaces = 0;
                                _Value.SetChange(this.txtNocionalContraMoneda, (this.strike * this.nocional));
                                nocionalContraMonedaMonto = (this.strike * this.nocional);
                            }
                            else if ((_opcionEstructuraSeleccionada.Codigo.Equals("6") || _opcionEstructuraSeleccionada.Codigo.Equals("13")) && this.txtStrike1.Text != "")//PRD_12567
                            {
                                _Value.DecimalPlaces = 0;
                                _Value.SetChange(this.txtNocionalContraMoneda, (this.strike * this.nocional));
                                nocionalContraMonedaMonto = (this.nocional * this.strike);
                            }
                            else
                            {
                                nocionalContraMonedaMonto = 0;
                                _Value.DecimalPlaces = 0;
                                _Value.SetChange(this.txtNocionalContraMoneda, nocionalContraMonedaMonto);
                            }
                            if (_opcionEstructuraSeleccionada.Codigo.Equals("3") && !this.checkBoxVegaWeighted.IsChecked.Value)
                            {
                                this.NocionalStrangle = this.nocional;
                                _Value.DecimalPlaces = 0;
                                _Value.SetChange(this.txtNocionalContraMoneda, this.nocional);


                            }

                            Valorizar();
                        }
                        else
                        {
                            this.txtNocional.Text = "";
                            nocional = 0;
                            txtNocional.Focus();
                            System.Windows.Browser.HtmlPage.Window.Alert(string.Format("El monto ingresado supera el valor máximo ({0}).", MaxValueNocional.ToString("#,##0")));
                        }

                        #endregion
                        break;

                    case "txtEjercerMP":
                        #region Monto Ejercer
                        valtxtNocional.LostFocus(txtEjercerMP);
                        if (double.Parse(txtEjercerMP.Text) > double.Parse(txtNocional.Text))
                        {
                            this.valtxtNocional.SetChange(txtEjercerMP, double.Parse(txtNocional.Text));
                            CalcularEjercer();
                            System.Windows.Browser.HtmlPage.Window.Alert("El monto ingresado supera el nocional.");
                        }
                        else
                        {
                            CalcularEjercer();
                        }
                        #endregion
                        break;

                    case "txtNocionalStrangle":
                        #region txtNocionalStrangle
                        bool _IstxtNocionalStrangleValid = true;
                        if (double.Parse(txtNocionalStrangle.Text) < 0)
                        {
                            _IstxtNocionalStrangleValid = false;
                        }
                        if (_IstxtNocionalStrangleValid)
                        {

                            this.valtxtNocionalStrangle.LostFocus(txtNocionalStrangle);
                            this.NocionalStrangle = double.Parse(this.txtNocionalStrangle.Text);
                            //this.txtStrike1.Focus();
                            Valorizar();
                        }
                        else
                        {
                            txtNocionalStrangle.Text = "";
                            NocionalStrangle = 0;
                            this.txtNocionalStrangle.Focus();
                        }
                        #endregion
                        break;

                    case "txtStrike1":
                        #region txtStrike1
                        valtxtStrike1.LostFocus(txtStrike1);

                        bool _IstxtStrike1Valid = true;

                        //ASVG_20110309 se agrega validación para Forward Americano código 8
                        if (
                            (_opcionEstructuraSeleccionada.Codigo.Equals("-1")
                             || _opcionEstructuraSeleccionada.Codigo.Equals("0")
                             || _opcionEstructuraSeleccionada.Codigo.Equals("1")
                             || _opcionEstructuraSeleccionada.Codigo.Equals("6")
                             || _opcionEstructuraSeleccionada.Codigo.Equals("8")
                            )
                            && double.Parse(this.txtStrike1.Text) <= 0
                           )
                        {
                            _IstxtStrike1Valid = false;
                        }

                        if (_opcionEstructuraSeleccionada.Codigo.Equals("2") && this.txtStrike2.Text != "")
                        {
                            if (double.Parse(txtStrike1.Text) <= 0)
                            {
                                _IstxtStrike1Valid = false;
                            }
                            if (double.Parse(this.txtStrike2.Text) >= double.Parse(txtStrike1.Text))
                            {
                                _IstxtStrike1Valid = false;
                            }
                        }

                        if (_opcionEstructuraSeleccionada.Codigo.Equals("4") && this.txtStrike2.Text != "")
                        {
                            if (double.Parse(txtStrike1.Text) <= 0)
                            {
                                _IstxtStrike1Valid = false;
                            }
                            if (double.Parse(this.txtStrike2.Text) <= double.Parse(txtStrike1.Text) && radioCompra.IsChecked.Value == true)
                            {
                                _IstxtStrike1Valid = false;
                            }
                            if (double.Parse(this.txtStrike2.Text) >= double.Parse(txtStrike1.Text) && radioVenta.IsChecked.Value == true)
                            {
                                _IstxtStrike1Valid = false;
                            }
                        }

                        if (_opcionEstructuraSeleccionada.Codigo.Equals("5") && this.txtStrike2.Text != "")
                        {
                            if (double.Parse(txtStrike1.Text) <= 0)
                            {
                                _IstxtStrike1Valid = false;
                            }
                            if (double.Parse(this.txtStrike2.Text) >= double.Parse(txtStrike1.Text) && radioCompra.IsChecked.Value == true)
                            {
                                _IstxtStrike1Valid = false;
                            }
                            if (double.Parse(this.txtStrike2.Text) <= double.Parse(txtStrike1.Text) && radioVenta.IsChecked.Value == true)
                            {
                                _IstxtStrike1Valid = false;
                            }
                        }

                        if (_opcionEstructuraSeleccionada.Codigo.Equals("7"))
                        {
                            if (double.Parse(txtStrike1.Text) <= 0)
                            {
                                _IstxtStrike1Valid = false;
                            }
                            if (this.txtStrike2.Text != "" && double.Parse(this.txtStrike2.Text) >= double.Parse(txtStrike1.Text))
                            {
                                _IstxtStrike1Valid = false;
                            }
                        }

                        if (_opcionEstructuraSeleccionada.Codigo.Equals("3"))
                        {
                            if (double.Parse(txtStrike1.Text) <= 0)
                            {
                                _IstxtStrike1Valid = false;
                            }
                            if (this.txtStrike2.Text != "" && double.Parse(this.txtStrike2.Text) >= double.Parse(txtStrike1.Text))
                            {
                                _IstxtStrike1Valid = false;
                            }
                            if (this.txtStrike3.Text != "" && double.Parse(this.txtStrike3.Text) >= double.Parse(txtStrike1.Text))
                            {
                                _IstxtStrike1Valid = false;
                            }
                        }

                        #region Call - Put Spread

                        if (_opcionEstructuraSeleccionada.Codigo.Equals("11") ||
                            _opcionEstructuraSeleccionada.Codigo.Equals("12"))
                        {
                            if (double.Parse(txtStrike1.Text) <= 0)
                            {
                                _IstxtStrike1Valid = false;
                            }

                            //Validar CAll Spread: Compra -> Strike 1 < Strike 2
                            //                     Venta  -> Strike 1 > Strike 2
                            if (_opcionEstructuraSeleccionada.Codigo.Equals("11"))
                            {
                                if (this.txtStrike2.Text != "")
                                {
                                    if (radioCompra.IsChecked == true &&
                                        double.Parse(this.txtStrike2.Text) <=
                                        double.Parse(txtStrike1.Text))
                                    {
                                        _IstxtStrike1Valid = false;
                                    }
                                    else
                                    {
                                        if (radioVenta.IsChecked == true &&
                                        double.Parse(this.txtStrike2.Text) >=
                                        double.Parse(txtStrike1.Text))
                                        {
                                            _IstxtStrike1Valid = false;
                                        }
                                    }
                                }

                            }
                            //Validar PUT Spread:  Compra -> Strike 1 > Strike 2
                            //                     Venta  -> Strike 1 < Strike 2
                            else
                            {
                                if (this.txtStrike2.Text != "")
                                {
                                    if (radioCompra.IsChecked == true &&
                                        double.Parse(this.txtStrike2.Text) >=
                                        double.Parse(txtStrike1.Text))
                                    {
                                        _IstxtStrike1Valid = false;
                                    }
                                    else
                                    {
                                        if (radioVenta.IsChecked == true &&
                                        double.Parse(this.txtStrike2.Text) <=
                                        double.Parse(txtStrike1.Text))
                                        {
                                            _IstxtStrike1Valid = false;
                                        }
                                    }
                                }
                            }
                        }

                        #endregion

                        #region Call Spread Doble

                        if (_opcionEstructuraSeleccionada.Codigo.Equals("14"))
                        {
                            _IstxtStrike1Valid = ValidaTxtStrike_CallSpreadDoble(this.txtStrike1, this.txtStrike2, this.txtStrike3, this.txtStrike4);
                        }

                        #endregion Call Spread Doble

                        if (_IstxtStrike1Valid)
                        {
                            this.strike = double.Parse(this.txtStrike1.Text);
                            //alanrevisar ojo se agrego el caso 8 al if.
                            // falta 7
                            if ((_opcionEstructuraSeleccionada.Codigo.Equals("-1") ||
                                 _opcionEstructuraSeleccionada.Codigo.Equals("0") ||
                                 _opcionEstructuraSeleccionada.Codigo.Equals("1") ||
                                 _opcionEstructuraSeleccionada.Codigo.Equals("4") ||
                                 _opcionEstructuraSeleccionada.Codigo.Equals("5") ||
                                 _opcionEstructuraSeleccionada.Codigo.Equals("6") ||
                                 _opcionEstructuraSeleccionada.Codigo.Equals("8")
                                 )
                                && this.txtNocional.Text != "")
                            {//ASVG esto mata el nocional
                                nocionalContraMonedaMonto = (this.strike * this.nocional);
                                _Value.DecimalPlaces = 0;
                                _Value.SetChange(this.txtNocionalContraMoneda, this.nocionalContraMonedaMonto);
                            }
                            else if (_opcionEstructuraSeleccionada.Codigo.Equals("13") && this.txtNocional.Text != "") //PRD_12567 calculo nocional contramoneda, repetido
                            {
                                nocionalContraMonedaMonto = (this.spot * this.nocional);
                            }
                            else
                            {
                                nocionalContraMonedaMonto = 0;
                                _Value.DecimalPlaces = 0;
                                _Value.SetChange(this.txtNocionalContraMoneda, this.nocionalContraMonedaMonto);
                            }

                            bool _newFixingTable = false;

                            if (((ComboBoxItem)this.comboPayOff.SelectedItem).Content.Equals("Asiaticas"))// && isTablaFixingLoadedFromValcartera.Equals(false))
                            {
                                if (txtStrike1_Changed && !this.datePiker_DateProccess.Text.Equals("") && !this.txtSpotCosto.Text.Equals("") && !this.txtStrike1.Text.Equals(""))
                                {
                                    try
                                    {
                                        _TablaFixing.isEditing = true;
                                        _TablaFixing.datePikerInicio.SelectedDate = this.datePiker_DateProccess.SelectedDate.Value;
                                        _TablaFixing.datePikerFin.SelectedDate = this.DatePickerVencimiento.SelectedDate.Value;
                                        this._TablaFixing.datePikerFinEntrada.SelectedDate = this.DatePickerVencimiento.SelectedDate.Value; //PRD_12567
                                        _TablaFixing.isEditing = false;

                                        this._TablaFixing.Crear();
                                        _newFixingTable = true;
                                    }
                                    catch { }
                                }
                            }
                            if (((ComboBoxItem)this.comboPayOff.SelectedItem).Content.Equals("Vanilla") || _newFixingTable == false)
                            {
                                Valorizar();
                            }
                            txtStrike1_Changed = false;
                        }
                        else
                        {
                            txtStrike1.Text = "";
                            this.strike = 0;
                            this.txtNocionalContraMoneda.Text = "";
                            nocionalContraMonedaMonto = 0;

                            txtStrike1.Focus();
                        }
                        #endregion
                        break;

                    case "txtStrike2":
                        #region txtStrike2
                        valtxtStrike2.LostFocus(txtStrike2);

                        bool _IstxtStrike2Valid = true;

                        if (_opcionEstructuraSeleccionada.Codigo.Equals("2") && this.txtStrike1.Text != "")
                        {
                            if (double.Parse(txtStrike2.Text) <= 0)
                            {
                                _IstxtStrike2Valid = false;
                            }
                            if (double.Parse(this.txtStrike2.Text) >= double.Parse(txtStrike1.Text))
                            {
                                _IstxtStrike2Valid = false;
                            }
                        }

                        if (_opcionEstructuraSeleccionada.Codigo.Equals("4") && this.txtStrike1.Text != "")
                        {
                            if (double.Parse(txtStrike2.Text) <= 0)
                            {
                                _IstxtStrike2Valid = false;
                            }

                            if (double.Parse(this.txtStrike2.Text) <= double.Parse(txtStrike1.Text) && radioCompra.IsChecked.Value == true)
                            {
                                _IstxtStrike2Valid = false;
                            }

                            if (double.Parse(this.txtStrike2.Text) >= double.Parse(txtStrike1.Text) && radioVenta.IsChecked.Value == true)
                            {
                                _IstxtStrike2Valid = false;
                            }
                        }

                        if (_opcionEstructuraSeleccionada.Codigo.Equals("5") && this.txtStrike1.Text != "")
                        {
                            if (double.Parse(txtStrike2.Text) <= 0)
                            {
                                _IstxtStrike2Valid = false;
                            }
                            if (double.Parse(this.txtStrike2.Text) >= double.Parse(txtStrike1.Text) && radioCompra.IsChecked.Value == true)
                            {
                                _IstxtStrike2Valid = false;
                            }

                            if (double.Parse(this.txtStrike2.Text) <= double.Parse(txtStrike1.Text) && radioVenta.IsChecked.Value == true)
                            {
                                _IstxtStrike2Valid = false;
                            }
                        }

                        if (_opcionEstructuraSeleccionada.Codigo.Equals("7"))
                        {
                            if (double.Parse(txtStrike2.Text) <= 0)
                            {
                                _IstxtStrike2Valid = false;
                            }
                            if (this.txtStrike1.Text != "" && double.Parse(this.txtStrike2.Text) >= double.Parse(txtStrike1.Text))
                            {
                                _IstxtStrike2Valid = false;
                            }

                        }

                        if (_opcionEstructuraSeleccionada.Codigo.Equals("3"))
                        {
                            if (double.Parse(txtStrike2.Text) <= 0)
                            {
                                _IstxtStrike2Valid = false;
                            }

                            if (this.txtStrike1.Text != "" && double.Parse(this.txtStrike2.Text) >= double.Parse(txtStrike1.Text))
                            {
                                _IstxtStrike2Valid = false;
                            }

                            if (this.txtStrike3.Text != "" && double.Parse(this.txtStrike3.Text) <= double.Parse(txtStrike2.Text))
                            {
                                _IstxtStrike2Valid = false;
                            }
                        }

                        #region Call - Put Spread

                        if (_opcionEstructuraSeleccionada.Codigo.Equals("11") ||
                            _opcionEstructuraSeleccionada.Codigo.Equals("12"))
                        {
                            if (double.Parse(txtStrike2.Text) <= 0)
                            {
                                _IstxtStrike2Valid = false;
                            }
                            //Validar CAll Spread: Compra -> Strike 1 < Strike 2
                            //                     Venta  -> Strike 1 > Strike 2
                            if (_opcionEstructuraSeleccionada.Codigo.Equals("11"))
                            {
                                if (double.Parse(txtStrike1.Text) <= 0)
                                {
                                    _IstxtStrike2Valid = false;
                                }
                                else
                                {
                                    if (radioCompra.IsChecked == true &&
                                        double.Parse(this.txtStrike2.Text) <=
                                        double.Parse(txtStrike1.Text))
                                    {
                                        _IstxtStrike2Valid = false;
                                    }
                                    else
                                    {
                                        if (radioVenta.IsChecked == true &&
                                        double.Parse(this.txtStrike2.Text) >=
                                        double.Parse(txtStrike1.Text))
                                        {
                                            _IstxtStrike2Valid = false;
                                        }
                                    }
                                }
                            }
                            //Validar PUT Spread:  Compra -> Strike 1 > Strike 2
                            //                     Venta  -> Strike 1 < Strike 2
                            else
                            {
                                if (radioCompra.IsChecked == true &&
                                    double.Parse(this.txtStrike2.Text) >=
                                    double.Parse(txtStrike1.Text))
                                {
                                    _IstxtStrike2Valid = false;
                                }
                                else
                                {
                                    if (radioVenta.IsChecked == true &&
                                    double.Parse(this.txtStrike2.Text) <=
                                    double.Parse(txtStrike1.Text))
                                    {
                                        _IstxtStrike2Valid = false;
                                    }
                                }
                            }
                        }

                        #endregion

                        #region Call Spread Doble
                        if (_opcionEstructuraSeleccionada.Codigo.Equals("14"))
                        {
                            _IstxtStrike2Valid = ValidaTxtStrike_CallSpreadDoble(this.txtStrike1, this.txtStrike2, this.txtStrike3, this.txtStrike4);
                        }
                        #endregion Call Spread Doble

                        if (_IstxtStrike2Valid)
                        {
                            this.strike2 = double.Parse(this.txtStrike2.Text);
                            Valorizar();
                        }
                        else
                        {
                            txtStrike2.Text = "";
                            this.strike2 = 0;
                            txtStrike2.Focus();
                        }
                        #endregion
                        break;

                    case "txtStrike3":
                        #region txtStrike3
                        valtxtStrike3.LostFocus(txtStrike3);

                        bool _IstxtStrike3Valid = true;


                        if (_opcionEstructuraSeleccionada.Codigo.Equals("3"))
                        {
                            if (this.txtStrike1.Text != "" && double.Parse(this.txtStrike3.Text) >= double.Parse(txtStrike1.Text))
                            {
                                _IstxtStrike3Valid = false;
                            }

                            if (this.txtStrike2.Text != "" && double.Parse(this.txtStrike3.Text) <= double.Parse(txtStrike2.Text))
                            {
                                _IstxtStrike3Valid = false;
                            }
                        }
                        
                        #region Call Spread Doble
                        if (_opcionEstructuraSeleccionada.Codigo.Equals("14"))
                        {
                            _IstxtStrike3Valid = ValidaTxtStrike_CallSpreadDoble(this.txtStrike1, this.txtStrike2, this.txtStrike3, this.txtStrike4);
                        }
                        #endregion Call Spread Doble

                        if (_IstxtStrike3Valid)
                        {
                            this.strike3 = double.Parse(this.txtStrike3.Text);
                            Valorizar();
                        }
                        else
                        {
                            txtStrike3.Text = "";
                            this.strike3 = 0;
                            txtStrike3.Focus();
                        }

                        #endregion
                        break;

                    case "txtStrike4":
                        #region txtStrike4
                        valtxtStrike4.LostFocus(txtStrike4);

                        bool _IstxtStrike4Valid = true;

                        #region Call Spread Doble
                        if (_opcionEstructuraSeleccionada.Codigo.Equals("14"))
                        {
                            _IstxtStrike4Valid = ValidaTxtStrike_CallSpreadDoble(this.txtStrike1, this.txtStrike2, this.txtStrike3, this.txtStrike4);
                        }
                        #endregion Call Spread Doble

                        if (_IstxtStrike4Valid)
                        {
                            this.strike4 = double.Parse(this.txtStrike4.Text);
                            Valorizar();
                            txtNocional.Focus();
                        }
                        else
                        {
                            txtStrike4.Text = "";
                            this.strike4 = 0;
                            txtStrike4.Focus();
                        }

                        #endregion txtStrike4
                        break;

                    case "txtDelta1":
                        #region txtDelta1
                        valtxtDelta1.LostFocus(txtDelta1);
                        bool isDelta1Valid = true;
                        if (txtDelta1.Text != "" && (double.Parse(txtDelta1.Text) < 0 || double.Parse(txtDelta1.Text) > 100))
                        {
                            isDelta1Valid = false;
                        }
                        if (isDelta1Valid)
                        {
                            this.delta1 = double.Parse(this.txtDelta1.Text) / 100.0;
                            Valorizar();
                        }
                        else
                        {
                            this.txtDelta1.Text = "";
                            this.delta1 = 0;
                            this.txtDelta1.Focus();
                        }
                        #endregion
                        break;

                    case "txtDelta2":
                        #region txtDelta2
                        valtxtDelta2.LostFocus(txtDelta2);
                        this.delta2 = double.Parse(this.txtDelta2.Text) / 100.0;
                        Valorizar();
                        #endregion
                        break;

                    case "txtDelta3":
                        #region txtDelta3
                        valtxtDelta3.LostFocus(txtDelta3);
                        this.delta3 = double.Parse(this.txtDelta3.Text) / 100.0;
                        Valorizar();
                        #endregion
                        break;

                    case "txtSpotCosto":
                        #region txtSpotCosto
                        //BSSpotValorizacion

                        double _SpotPricing = double.Parse(txtSpotCosto.Text);

                        if (_SpotPricing < 0)
                        {
                            System.Windows.Browser.HtmlPage.Window.Alert("No se puede ingresar spot negativa");
                            _Value.DecimalPlaces = 4;
                            _Value.SetChange(this.txtSpotCosto, BSSpotValorizacion);
                        }


                        valtxtSpotCosto.LostFocus(txtSpotCosto);
                        this.spot = double.Parse(this.txtSpotCosto.Text);
                        if (ComboUnidadPrima.SelectedIndex.Equals(1))
                        {
                            if (double.Parse(txtSpotCosto.Text) != _SpotCosto)
                            {
                                ParidadPrima = double.Parse(txtSpotCosto.Text);
                                _Value.DecimalPlaces = 4;
                                _Value.SetChange(txtParidadPrima, ParidadPrima);
                                PrimaContrato = (double.Parse(txtDistribucion.Text) - MtMContrato) / ParidadPrima;
                                _Value.DecimalPlaces = 4;
                                _Value.SetChange(txtParidadPrima, ParidadPrima);
                                _Value.DecimalPlaces = 2;
                                _Value.SetChange(txtPrimaContrato, PrimaContrato);
                                IsCalculatePrima = true;
                            }
                        }

                        Valorizar();
                        #endregion
                        break;

                    case "txtPuntosCosto":
                        #region txtPuntosCosto
                        valtxtPuntosCosto.LostFocus(this.txtPuntosCosto);
                        this.PuntosCosto = double.Parse(this.txtPuntosCosto.Text);
                        Valorizar();
                        #endregion
                        break;

                    case "txtUnwind":
                        #region txtUnwind
                        valtxtUnwind.LostFocus(this.txtUnwind);

                        double _UnWind = double.Parse(this.txtUnwind.Text);

                        if ((MtMContrato > 0 && _UnWind < 0) || (MtMContrato < 0 && _UnWind > 0))
                        {
                            System.Windows.Browser.HtmlPage.Window.Alert("Verificar UnWind.");
                        }

                        try
                        {
                            Unwind = double.Parse(txtUnwind.Text);
                        }
                        catch
                        {
                            txtUnwind.Text = "";
                            Unwind = double.NaN;
                        }
                        #endregion
                        break;

                    case "txtUnwindCosto":
                        #region txtUnwindCosto
                        valtxtUnwindCosto.LostFocus(this.txtUnwindCosto);

                        double _UnWindCosto = double.Parse(this.txtUnwindCosto.Text);

                        if ((MtMContrato > 0 && _UnWindCosto < 0) || (MtMContrato < 0 && _UnWindCosto > 0))
                        {
                            System.Windows.Browser.HtmlPage.Window.Alert("Verificar UnWind Costo.");
                        }

                        try
                        {
                            UnwindCosto = double.Parse(txtUnwindCosto.Text);
                        }
                        catch
                        {
                            txtUnwindCosto.Text = "";
                            UnwindCosto = double.NaN;
                        }
                        #endregion
                        break;

                    case "txtPrimaContrato":
                        #region txtPrimaContrato
                        valtxtPrimaContrato.LostFocus(this.txtPrimaContrato);
                        try
                        {
                            PrimaContrato = double.Parse(this.txtPrimaContrato.Text);
                            bool _StructOption = false;
                            _opcionEstructuraSeleccionada = OpcionesEstructuraList.First(x => x.Descripcion.Equals(opcionContrato));
                            string _OptionID = _opcionEstructuraSeleccionada.Codigo;

                            if (_OptionID.Equals("-1") || _OptionID.Equals("0") || _OptionID.Equals("1") || _OptionID.Equals("7"))
                            {
                                _StructOption = true;
                            }

                            if (((MtMContrato > 0 && PrimaContrato > 0) || (MtMContrato < 0 && PrimaContrato < 0)) && _StructOption)
                            {
                                System.Windows.Browser.HtmlPage.Window.Alert("Verificar prima.");
                            }

                            if (((ComboBoxItem)ComboUnidadPrima.SelectedItem).Content.Equals("CLP"))
                            {
                                if (txtPrimaContrato.Text != "" && !PrimaContrato.Equals(double.NaN))
                                {
                                    this._Guardar.primaInicial = PrimaContrato;
                                    this._Guardar.primaInicialML = PrimaContrato;
                                    this._Guardar.paridadPrima = 1;
                                }

                                if (txtPrimaContrato.Text != "" && txtMtMContrato.Text != "")
                                {
                                    try
                                    {
                                        Distribucion = PrimaContrato + MtMContrato;
                                        _Value.DecimalPlaces = 0;
                                        _Value.SetChange(this.txtDistribucion, Distribucion);
                                    }
                                    catch
                                    {
                                        txtDistribucion.Text = "";
                                        Distribucion = double.NaN;
                                    }
                                }
                                else
                                {
                                    txtDistribucion.Text = "";
                                    Distribucion = double.NaN;
                                }
                            }

                            if (((ComboBoxItem)ComboUnidadPrima.SelectedItem).Content.Equals("USD"))
                            {
                                if (txtPrimaContrato.Text != "" && !PrimaContrato.Equals(double.NaN) && txtParidadPrima.Text != "" && !ParidadPrima.Equals(double.NaN))
                                {
                                    this._Guardar.primaInicial = PrimaContrato;
                                    this._Guardar.primaInicialML = PrimaContrato * ParidadPrima;
                                    this._Guardar.paridadPrima = ParidadPrima;
                                }

                                if (txtMtMContrato.Text != "" && txtParidadPrima.Text != "" && txtPrimaContrato.Text != "")
                                {
                                    try
                                    {
                                        _Value.DecimalPlaces = 0;
                                        _Value.SetChange(this.txtDistribucion, ((PrimaContrato * ParidadPrima) + MtMContrato));
                                    }
                                    catch
                                    {
                                        txtDistribucion.Text = "";
                                        Distribucion = double.NaN;
                                    }
                                }
                                else
                                {
                                    txtDistribucion.Text = "";
                                    Distribucion = double.NaN;
                                }
                            }
                        }
                        catch
                        {
                            txtPrimaContrato.Text = "";
                            PrimaContrato = double.NaN;
                        }

                        #endregion
                        break;

                    case "txtParidadPrima":
                        #region txtParidadPrima
                        double _ParidadPrima = double.Parse(txtParidadPrima.Text);

                        if (_ParidadPrima < 0)
                        {
                            System.Windows.Browser.HtmlPage.Window.Alert("No se puede ingresar una paridad negativa");
                            _Value.DecimalPlaces = 4;
                            _Value.SetChange(this.txtParidadPrima, double.Parse(txtSpotCosto.Text));
                        }

                        valtxtParidadPrima.LostFocus(txtParidadPrima);
                        try
                        {
                            ParidadPrima = double.Parse(txtParidadPrima.Text);


                            if (((ComboBoxItem)ComboUnidadPrima.SelectedItem).Content.Equals("USD"))
                            {
                                if (txtPrimaContrato.Text != "" && !PrimaContrato.Equals(double.NaN) && txtParidadPrima.Text != "" && !ParidadPrima.Equals(double.NaN))
                                {

                                    this._Guardar.primaInicial = PrimaContrato;
                                    this._Guardar.primaInicialML = PrimaContrato * ParidadPrima;
                                    this._Guardar.paridadPrima = ParidadPrima;
                                }

                                if (txtMtMContrato.Text != "" && txtParidadPrima.Text != "" && txtPrimaContrato.Text != "")
                                {
                                    try
                                    {
                                        _Value.DecimalPlaces = 0;
                                        _Value.SetChange(this.txtDistribucion, ((PrimaContrato * ParidadPrima) + MtMContrato));

                                    }
                                    catch
                                    {
                                        txtDistribucion.Text = "";
                                        Distribucion = double.NaN;
                                    }
                                }
                                else
                                {
                                    txtDistribucion.Text = "";
                                    Distribucion = double.NaN;

                                }


                            }
                        }
                        catch
                        {
                            txtParidadPrima.Text = "";
                            ParidadPrima = double.NaN;
                        }

                        #endregion
                        break;
                    case "txtSpotValorizacion":
                        #region txtSpotValorizacion
                        //if (SmileATMRRFLYList != null && CurvaFwUSD != null && CurvasMonedasList != null && (SmileATMRRFLYList.Count == 0 || SmileCallPutList.Count == 0 || SmileStrikesList.Count == 0 || CurvasMonedasList[0].CodigoCurva == null || CurvasMonedasList[1].CodigoCurva == null || CurvaFwUSD.Count == 0 || this.txtSpotValorizacion.Text == ""))
                        //{
                        //    PutLayer(this.PrincipalCanvas, "Set de Precios incompleto");
                        //    PutLayer(this.CanasTab2, "Set de Precios incompleto");
                        //}
                        //else
                        //{
                        //    QuitLayer(this.PrincipalCanvas);
                        //    QuitLayer(this.CanasTab2);
                        //}
                        double _SpotValorizacion = double.Parse(txtSpotValorizacion.Text);

                        if (_SpotValorizacion < 0)
                        {
                            System.Windows.Browser.HtmlPage.Window.Alert("No se puede ingresar spot negativa");
                            _Value.DecimalPlaces = 4;
                            _Value.SetChange(this.txtSpotValorizacion, _BSSpotValorizacion);
                            BSSpotValorizacion = _BSSpotValorizacion;
                        }

                        valtxtSpotValorizacion.LostFocus(this.txtSpotValorizacion);
                        BSSpotValorizacion = double.Parse(this.txtSpotValorizacion.Text);
                        this.txtSpotCosto.Text = txtSpotValorizacion.Text;
                        this.spot = BSSpotValorizacion;
                        _BSSpotValorizacion = BSSpotValorizacion;

                        LoadSetPreciosSpot(DatePickerSetPrecios.SelectedDate.Value, BSSpotValorizacion, curvaDom, curvaFor, setPreciosValCartera);

                        isTextChanged = true;
                        Valorizar();
                        InterpVol_Strike();
                        #endregion
                        break;

                    case "txtDistribucion":
                        #region txtDistribucion
                        valtxtDistribucion.LostFocus(txtDistribucion);
                        Distribucion = double.Parse(txtDistribucion.Text);
                        if (ComboUnidadPrima.SelectedIndex.Equals(0))
                        {
                            PrimaContrato = double.Parse(txtDistribucion.Text) - MtMContrato;
                            _Value.DecimalPlaces = 0;
                            _Value.SetChange(txtPrimaContrato, PrimaContrato);
                        }
                        else if (ComboUnidadPrima.SelectedIndex.Equals(1))
                        {
                            if (txtParidadPrima.Text.Equals(""))
                            {
                                ParidadPrima = double.Parse(txtSpotCosto.Text);
                                _Value.DecimalPlaces = 4;
                                _Value.SetChange(txtParidadPrima, ParidadPrima);
                            }
                            else if (double.Parse(txtParidadPrima.Text).Equals(0))
                            {
                                ParidadPrima = double.Parse(txtSpotCosto.Text);
                                _Value.DecimalPlaces = 4;
                                _Value.SetChange(txtParidadPrima, ParidadPrima);
                            }
                            else
                            {
                                ParidadPrima = double.Parse(txtParidadPrima.Text);
                            }
                            PrimaContrato = (double.Parse(txtDistribucion.Text) - MtMContrato) / ParidadPrima;
                            _Value.DecimalPlaces = 4;
                            _Value.SetChange(txtParidadPrima, ParidadPrima);
                            _Value.DecimalPlaces = 2;
                            _Value.SetChange(txtPrimaContrato, PrimaContrato);
                        }
                        #endregion
                        break;

                    case "txtMtMContrato":
                        #region txtMtMContrato
                        valtxtMtMValorizacion.LostFocus(this.txtMtMContrato);
                        this.MtMContrato = double.Parse(txtMtMContrato.Text);
                        Valorizar();
                        #endregion
                        break;

                    case "txtInterpVol_Strike":
                        #region txtInterpVol_Strike
                        InterpVol_Strike();
                        #endregion
                        break;

                    //5843
                    case "txtResultadoVta":
                        #region txtResultadoVta
                        valtxtResultadoVta.LostFocus(this.txtResultadoVta);
                        ResultVenta = double.Parse(txtResultadoVta.Text);
                        this._Guardar.ResultVenta = ResultVenta;
                        #endregion
                        break;
                }
            }
            else
            {
                switch (TexBoxAux.Name)
                {
                    case "txtSpotValorizacion":
                        #region txtSpotValorizacion
                        PutLayer(this.PrincipalCanvas, "SET DE PRECIOS INCOMPLETO");
                        PutLayer(this.CanasTab2, "SET DE PRECIOS INCOMPLETO");
                        #endregion
                        break;

                    case "txtInterpVol_Strike":
                        #region txtInterpVol_Strike
                        if (txtInterpVol_Strike.Text == "")
                        {
                            Strike_InterpVol = double.NaN;
                            this.txtInterpVol_Volatilidad.Text = "";
                        }
                        #endregion
                        break;

                    case "txtPrimaContrato":
                        #region txtPrimaContrato
                        PrimaContrato = 0;
                        if (((ComboBoxItem)ComboUnidadPrima.SelectedItem).Content.Equals("USD"))
                        {
                            this._Guardar.primaInicial = PrimaContrato;
                            this._Guardar.primaInicialML = PrimaContrato * ParidadPrima;
                        }
                        else
                        {
                            this._Guardar.primaInicial = PrimaContrato;
                            this._Guardar.primaInicialML = PrimaContrato;
                        }
                        #endregion
                        break;

                    //IAF 30-10-2009 (Cod. 148) [COMENTADO] 
                    case "txtParidadPrima":
                        #region txtParidadPrima

                        ParidadPrima = 0;
                        if (((ComboBoxItem)ComboUnidadPrima.SelectedItem).Content.Equals("USD"))
                        {
                            this._Guardar.primaInicial = PrimaContrato;
                            this._Guardar.primaInicialML = PrimaContrato * ParidadPrima;
                        }
                        else
                        {
                            this._Guardar.primaInicial = PrimaContrato;
                            this._Guardar.primaInicialML = PrimaContrato;
                        }

                        #endregion
                        break;
                }
            }
        }

        #endregion DecimalText

        #region IntegerText

        //REVISAR
        private void event_LostFocus_IntegerText(object sender, RoutedEventArgs e)
        {
            TextBox _txtPlazo = sender as TextBox;

            switch (_txtPlazo.Name)
            {
                case "txtPlazo":
                    #region txtPlazo
                    if (MyPlazo != txtPlazo.Text)
                    {
                        isPlazoChanged = true;
                        TenmValidator.LostFocus(sender as TextBox);

                        if (TenmValidator.IsValid && !this.datePiker_DateProccess.SelectedDate.Value.Equals(new DateTime(01, 01, 0001)))
                        {
                            int _plazoNumero = int.Parse(this.txtPlazo.Text.Substring(0, txtPlazo.Text.Length - 1));
                            string letra = txtPlazo.Text.Substring(txtPlazo.Text.Length - 1, 1).ToUpper();

                            fechaVencimiento = new DateTime();
                            if (letra.Equals("D"))
                            {
                                fechaVencimiento = datePiker_DateProccess.SelectedDate.Value.AddDays(_plazoNumero);
                            }
                            else if (letra.Equals("W"))
                            {
                                fechaVencimiento = datePiker_DateProccess.SelectedDate.Value.AddDays(7 * _plazoNumero);
                            }
                            else if (letra.Equals("M"))
                            {
                                fechaVencimiento = datePiker_DateProccess.SelectedDate.Value.AddMonths(_plazoNumero);
                            }
                            else if (letra.Equals("Y"))
                            {
                                fechaVencimiento = datePiker_DateProccess.SelectedDate.Value.AddYears(_plazoNumero);
                            }

                            // Valida PLazo Strip 7274
                            int daysDiff = ((TimeSpan)(fechaVencimiento - FechaDeProceso)).Days;
                            int aproxima = 5;

                            if ((daysDiff + aproxima) >= 1100
								&& (_opcionEstructuraSeleccionada.Codigo.Equals("9") || _opcionEstructuraSeleccionada.Codigo.Equals("10"))
								)
							{
                                System.Windows.Browser.HtmlPage.Window.Alert("No se puede realizar strip superior a 3 años.");
                                txtPlazo.Text = "";
                                txtPlazo.Focus();
                            }
                            else
                            {
                                this.DatePickerVencimiento.SelectedDate = fechaVencimiento;

                                //STRIP ASIATICO checkbox = True Strip y fixing ya creados, se deben borrar.
                                if (checkboxAsociadoStrip.IsChecked == true)
                                {
                                    ClearStrip();
                                    ClearData();
                                    System.Windows.Browser.HtmlPage.Window.Alert("Se ha modificado la fecha de vencimiento, deberá volver a crear un contrato Strip Asiático.");
                                }

                                Eventos_Cambio_Plazo();
                                #region old Eventos_Cambio_Plazo
                                /*
                                if (((ComboBoxItem)this.comboPayOff.SelectedItem).Content.Equals("Vanilla"))
                                {
                                    isTextChanged = true;
                                    this.txtPuntosCosto.Text = "";
                                    this.PuntosCosto = double.NaN;
                                    Valorizar();
                                }

                                if (isOpcionFromCartera == false && !BsSpot_BsFwd_AsianMomentos_flag.Equals("AsianMomentos") && datePiker_DateProccess.SelectedDate != null)
                                {
                                    SetPuntosForward(datePiker_DateProccess.SelectedDate.Value, fechaVencimiento, this.spot, this.curvaDom, this.curvaFor, this.setPrecios_Pricing);
                                }

                                if (isTablaFixingLoadedFromValcartera == false)
                                {
                                    _TablaFixing.isEditing = true;
                                    this._TablaFixing.datePikerInicio.SelectedDate = datePiker_DateProccess.SelectedDate.Value;
                                    this._TablaFixing.datePikerFin.SelectedDate = fechaVencimiento;
                                    _TablaFixing.isEditing = false;
                                }

                                if (!((ComboBoxItem)this.comboPayOff.SelectedItem).Content.Equals("Vanilla"))
                                {
                                    CrearFixing();

                                    //PRD_12567
                                    if (_opcionEstructuraSeleccionada.Codigo.Equals("13"))
                                    {
                                        _TablaFixing.TabEntrada.Visibility = Visibility.Visible;
                                        CrearFixingEntrada();
                                    }
                                }
                                else
                                {
                                    btnTablaFixing.IsEnabled = true;
                                    IsChangeFixing = false;
                                }

                                isPlazoChanged = false;
                                isdatePickerVencChanged = false;
                                 * */
                                #endregion old Eventos_Cambio_Plazo
                            }
                        }
                    }
                    else
                    {
                        btnTablaFixing.IsEnabled = true;
                        IsChangeFixing = false;
                    }
                    #endregion
                    break;

                case "txtInterpVol_Plazo":
                    #region txtInterpVol_Plazo
                    valtxtInterpVol_Plazo.LostFocus(sender as TextBox);
                    if (this.valtxtInterpVol_Plazo.IsValid && this.DatePickerSetPrecios.SelectedDate != null && !this.DatePickerSetPrecios.SelectedDate.Value.Equals(new DateTime(01, 01, 0001)))
                    {
                        int _plazoInterpVol_Numero = int.Parse(this.txtInterpVol_Plazo.Text.Substring(0, txtInterpVol_Plazo.Text.Length - 1));

                        string _letra = txtInterpVol_Plazo.Text.Substring(txtInterpVol_Plazo.Text.Length - 1, 1).ToUpper();
                        //this.plazo = 0
                        DateTime _fechaVencInterpVol = new DateTime();
                        if (_letra.Equals("D"))
                        {
                            //ClearData();
                            _fechaVencInterpVol = this.DatePickerSetPrecios.SelectedDate.Value.AddDays(_plazoInterpVol_Numero);
                        }
                        else if (_letra.Equals("W"))
                        {
                            //ClearData();
                            _fechaVencInterpVol = DatePickerSetPrecios.SelectedDate.Value.AddDays(7 * _plazoInterpVol_Numero);
                        }
                        else if (_letra.Equals("M"))
                        {
                            // ClearData();
                            _fechaVencInterpVol = DatePickerSetPrecios.SelectedDate.Value.AddMonths(_plazoInterpVol_Numero);
                        }
                        else if (_letra.Equals("Y"))
                        {
                            //ClearData();
                            _fechaVencInterpVol = DatePickerSetPrecios.SelectedDate.Value.AddYears(_plazoInterpVol_Numero);
                        }

                        Plazo_InterpVol = _fechaVencInterpVol.Subtract(DatePickerSetPrecios.SelectedDate.Value).Days;

                        if (txtInterpVol_Strike.Text != "" && !Strike_InterpVol.Equals(double.NaN))
                        {
                            InterpVol(DatePickerSetPrecios.SelectedDate.Value, Plazo_InterpVol, this.paridad, this.BSSpotValorizacion, Strike_InterpVol, this.curvaDom, this.curvaFor, this.setPreciosValCartera);
                        }
                    }
                    #endregion
                    break;
            }

        }

        /// <summary>
        /// Gatilla todos los eventos necesarios por cambio de plazo de contrato.
        /// </summary>
        private void Eventos_Cambio_Plazo()
        {
            if (((ComboBoxItem)this.comboPayOff.SelectedItem).Content.Equals("Vanilla"))
            {
                isTextChanged = true;
                this.txtPuntosCosto.Text = "";
                this.PuntosCosto = double.NaN;
                Valorizar();
            }

            if (isOpcionFromCartera == false && !BsSpot_BsFwd_AsianMomentos_flag.Equals("AsianMomentos") && datePiker_DateProccess.SelectedDate != null)
            {
                SetPuntosForward(datePiker_DateProccess.SelectedDate.Value, fechaVencimiento, this.spot, this.curvaDom, this.curvaFor, this.setPrecios_Pricing);
            }

            if (isTablaFixingLoadedFromValcartera == false)
            {
                _TablaFixing.isEditing = true;
                this._TablaFixing.datePikerInicio.SelectedDate = datePiker_DateProccess.SelectedDate.Value;
                this._TablaFixing.datePikerFin.SelectedDate = fechaVencimiento;
                _TablaFixing.isEditing = false;
            }

            if (!((ComboBoxItem)this.comboPayOff.SelectedItem).Content.Equals("Vanilla"))
            {
                CrearFixing();

                //PRD_12567
                if (_opcionEstructuraSeleccionada.Codigo.Equals("13"))
                {
                    _TablaFixing.TabEntrada.Visibility = Visibility.Visible;
                    CrearFixingEntrada();
                }
            }
            else
            {
                btnTablaFixing.IsEnabled = true;
                IsChangeFixing = false;
            }

            isdatePickerVencChanged = false;
            isPlazoChanged = false;
        }

        private void CrearFixing()
        {
            try
            {
                _TablaFixing.isEditing = true;
                _TablaFixing.datePikerInicio.SelectedDate = this.datePiker_DateProccess.SelectedDate.Value;
                _TablaFixing.datePikerFin.SelectedDate = this.DatePickerVencimiento.SelectedDate.Value;
                _TablaFixing.datePikerFinEntrada.SelectedDate = this.DatePickerVencimiento.SelectedDate.Value;//PRD_12567
                _TablaFixing.isEditing = false;

                if (MyPlazo != txtPlazo.Text)
                {
                    this._TablaFixing.comboFrecuencia.SelectedIndex = 0; //Diario
                    this._TablaFixing.Town = 2;
                    this._TablaFixing.AcualizarPesos = false;
                    this._TablaFixing.comboTipoPeso.SelectedIndex = 1; //Equiproporcional;
                    this._TablaFixing.AcualizarPesos = true;
                }

                isTextChanged = true;

                this._TablaFixing.Crear();
            }
            catch { }
        }

        private void DatePickerVencimiento_KeyUp(object sender, KeyEventArgs e)
        {
            //falta validación fecha Ok.
            //DatePicker _dpVencimiento = sender as DatePicker;

            if( e.Key.Equals(Key.Enter) || e.Key.Equals(Key.Tab) )
            {
                this.txtNocional.Focus();
            }
        }

        private void event_KeyDown_IntegerText(object sender, KeyEventArgs e)
        {
            TextBox _txtBox = sender as TextBox;

            switch (_txtBox.Name)
            {
                case "txtPlazo":
                    #region txtPlazo
                    TenmValidator.KeyDown(sender as TextBox);
                    isTextChanged = true;

                    if (e.Key.Equals(Key.Enter) && TenmValidator.IsValid)
                    {
                        isTablaFixingLoadedFromValcartera = false;

                        this.txtNocional.Focus();
                    }
                    #endregion
                    break;

                case "txtInterpVol_Plazo":
                    #region txtInterpVol_Plazo
                    valtxtInterpVol_Plazo.KeyDown(_txtBox);

                    if (e.Key.Equals(Key.Enter) && valtxtInterpVol_Plazo.IsValid && txtInterpVol_Strike.Text == "")
                    {
                        txtInterpVol_Strike.Focus();
                    }
                    else if (e.Key.Equals(Key.Enter) && txtInterpVol_Strike.Text != "")
                    {
                        this.txtInterpVol_Volatilidad.Focus();
                    }
                    #endregion
                    break;
            }
        }

        private void event_GotFocus_IntegerText(object sender, RoutedEventArgs e)
        {
            TextBox _txtPlazo = sender as TextBox;

            switch (_txtPlazo.Name)
            {
                case "txtPlazo":
                    #region txtPlazo
                    MyPlazo = txtPlazo.Text;
                    IsChangeFixing = true;
                    btnTablaFixing.IsEnabled = false;
                    TenmValidator.GotFocus(sender as TextBox);
                    #endregion
                    break;

                case "txtInterpVol_Plazo":
                    #region txtInterpVol_Plazo
                    valtxtInterpVol_Plazo.GotFocus(_txtPlazo);
                    #endregion
                    break;

            }

        }

        private void event_TextChanged_IntegerText(object sender, RoutedEventArgs e)
        {
            TextBox _txtPlazo = sender as TextBox;

            switch (_txtPlazo.Name)
            {
                case "txtPlazo":
                    TenmValidator.TextChange(sender as TextBox);
                    break;

                case "txtInterpVol_Plazo":
                    valtxtInterpVol_Plazo.TextChange(_txtPlazo);
                    break;
            }
        }

        #endregion IntegerText

        private void event_radioEntregaFisicaChecked(object sender, RoutedEventArgs e)
        {
            if (_Guardar != null)
            {
                _Guardar.Compensacion_EntregaFisica = radioEntregaFisica.IsChecked.Value ? "E" : "C"; //radioCompensacion.IsChecked.Value ? "C" : "E";
                _Guardar.CanvasCompensacion.Visibility = Visibility.Collapsed;
                _Guardar.CanvasEntregaFisia.Visibility = Visibility.Visible;
                //_Guardar.CanvasCompensacion.Visibility = Visibility.Collapsed;
            }
            Valorizar();
        }

        private void event_radioCompensacionChecked(object sender, RoutedEventArgs e)
        {
            _Guardar.Compensacion_EntregaFisica = radioCompensacion.IsChecked.Value ? "C" : "E";
            _Guardar.CanvasEntregaFisia.Visibility = Visibility.Collapsed;
            _Guardar.CanvasCompensacion.Visibility = Visibility.Visible;
        }

        private void ShowEjercer()
        {
            StructEncContrato _encContrato = this.EncContratoList[0];
            if (Recursos.globales._Estado.Equals("E"))
            {
                radioCompra.IsEnabled = false;
                radioVenta.IsEnabled = false;
                txtPlazo.IsEnabled = false;
                DatePickerVencimiento.IsEnabled = false;
                expanderOpciones.IsEnabled = false;
                radioEntregaFisica.IsEnabled = false;
                radioCompensacion.IsEnabled = false;
                txtNocional.IsEnabled = false;
                tabStrikesDelta.IsEnabled = false;
                txtUnwind.IsEnabled = false;
                txtUnwindCosto.IsEnabled = false;
                txtPrimaContrato.IsEnabled = false;
                ComboUnidadPrima.IsEnabled = false;
                txtParidadPrima.IsEnabled = false;
                txtDistribucion.IsEnabled = false;
                txtMtMContrato.IsEnabled = false;
                txtSpotCosto.IsEnabled = false;

                itemTabEjercicio.IsSelected = true;

                //ASVG_20110303 this.txtEjercerMP.Text en blanco se cae...
                //el evento radioCompensacionEjercicio_checked se gatilla con el radioEntregaFisicaEjercicio.IsChecked = true;

                svc.AnticipaSolicitudAsync(globales._NumContrato.ToString(), globales._FechaProceso);


                try
                {
                    if (_encContrato.CodEstructura.Equals(8))
                    {
                        txtResultadoVta.Text = "0";

                    }
                }
                catch { }

                //valtxtNocional.SetChange(txtEjercerMP, double.Parse(this.txtNocional.Text));

                //if (radioEntregaFisica.IsChecked.Value)
                //{
                //    radioEntregaFisicaEjercicio.IsChecked = true;
                //    radioCompensacionEjercicio.IsChecked = false;
                //}
                //else
                //{
                //    radioCompensacionEjercicio.IsChecked = true;
                //    radioEntregaFisicaEjercicio.IsChecked = false;
                //}

                //CalcularEjercer();
            }
        }

        private void CalcularEjercer()
        {
            if (globales._Estado.Equals("E") && radioEntregaFisicaEjercicio != null)
            {
                //ASVG_20110303 this.txtEjercerMP.Text en blanco se cae...
                //el evento radioCompensacionEjercicio_checked se gatilla con el radioEntregaFisicaEjercicio.IsChecked = true;
                if ("" != this.txtEjercerMP.Text && "" != this.txtStrike1.Text)
                {
                    if (radioEntregaFisicaEjercicio.IsChecked.Value)
                    {
                        double _EntregaFisica = double.Parse(this.txtEjercerMP.Text) * double.Parse(this.txtStrike1.Text);
                        valtxtNocional.SetChange(txtEjercerMS, _EntregaFisica);
                    }
                    else
                    {
                        double _Compensacion = double.Parse(this.txtEjercerMP.Text) * (__ObservedDollar - double.Parse(this.txtStrike1.Text)) * (radioCompra.IsChecked.Value ? 1.0 : -1.0);
                        valtxtNocional.SetChange(txtEjercerMS, _Compensacion);
                    }
                }
            }
        }

        private void event_btnComponentes_Click(object sender, RoutedEventArgs e)
        {
            if (EnableComponentes)
            {
                popUpComponentes.Show();

                StructComponentes _Componentes = new StructComponentes();

                string _Structure = xmlCreate.Element("Datos").Element("encContrato").Element("Estructura").Attribute("MoCodEstructura").Value;

                //double _primaCosto = double.Parse(xmlCreate.Element("Datos").Element("encContrato").Element("Resultados").Attribute("MoPrimaCosto").Value.ToString());

                foreach (XElement _detContrato in xmlCreate.Descendants("detContrato"))
                {
                    if (_Structure.Equals("8"))
                    {
                        _Componentes.Producto.Add("Forward Americano");
                    }
                    else
                    {
                        _Componentes.Producto.Add(_detContrato.Element("DetallesOpcion").Attribute("MoCallPut").Value.ToString());
                    }
                    _Componentes.CompraVenta.Add(_detContrato.Element("DetallesOpcion").Attribute("MoCVOpc").Value.ToString());
                    _Componentes.FechaVal.Add((DateTime.Parse(_detContrato.Element("DetallesOpcion").Attribute("MoFechaInicioOpc").Value.ToString())).ToString("dd-MM-yyyy"));
                    _Componentes.FechaVcto.Add((DateTime.Parse(_detContrato.Element("Vencimiento").Attribute("MoFechaVcto").Value.ToString())).ToString("dd-MM-yyyy"));
                    _Componentes.Nominal.Add(double.Parse(_detContrato.Element("Subyacente").Attribute("MoMontoMon1").Value.ToString()).ToString("#,##0.00"));
                    _Componentes.Strike.Add(double.Parse(_detContrato.Element("Subyacente").Attribute("MoStrike").Value.ToString()).ToString("#,##0.00"));

                    //_Componentes.DeltaFwdPorcentage.Add("0%"); Calculado despues de las griegas
                    //double _nocional = double.Parse(_detContrato.Element("Subyacente").Attribute("MoMontoMon1").Value.ToString();

                    double _wfDom, _wfFor;
                    double TasaLocal, TasaForanea;
                    double _MtM;

                    _wfDom = double.Parse(_detContrato.Element("MtM").Attribute("MoWf_mon1").Value.ToString());
                    _wfFor = double.Parse(_detContrato.Element("MtM").Attribute("MoWf_mon2").Value.ToString());
                    _MtM = double.Parse(_detContrato.Element("MtM").Attribute("MoVrDet").Value.ToString());
                    _Componentes.MtM.Add(_MtM.ToString("#,##0"));
                    //forward americano no tiene prima
                    if (_Structure.Equals("8"))
                    {
                        _Componentes.Prima.Add(0.ToString("#,##0"));
                    }
                    else
                    {
                        _Componentes.Prima.Add((-1 * _MtM).ToString("#,##0"));
                    }

                    _wfDom = _wfDom.Equals(double.NaN) ? 0 : _wfDom;
                    _wfFor = _wfFor.Equals(double.NaN) ? 0 : _wfFor;

                    TimeSpan plazo = fechaVencimiento.Subtract(this.datePiker_DateProccess.SelectedDate.Value);

                    TasaLocal = (Math.Log(_wfDom) * 365.0 / plazo.Days) * 100.0;
                    TasaForanea = (Math.Log(_wfFor) * 365.0 / plazo.Days) * 100.0;

                    _Componentes.Spot.Add(double.Parse(_detContrato.Element("Proceso").Attribute("MoSpotDet").Value.ToString()).ToString("#,##0.0000"));
                    _Componentes.PuntosFwd.Add(double.Parse(_detContrato.Element("MtM").Attribute("MoFwd_teo").Value.ToString()).ToString("#,##0.0000"));
                    _Componentes.Volatilidad.Add(double.Parse(_detContrato.Element("MtM").Attribute("MoVol").Value.ToString()).ToString("#,##0.00") + " %");
                    _Componentes.TasaLocal.Add(TasaLocal.ToString("#,##0.00") + " %");
                    _Componentes.TasaForanea.Add(TasaForanea.ToString("#,##0.00") + " %");

                    //Griegas

                    string _tipoPayOff = _detContrato.Element("DetallesOpcion").Attribute("MoTipoPayOff").Value.ToString();

                    double _deltaFwd = 0;

                    if (_tipoPayOff.Equals("02")) //Asiatica
                    {
                        _Componentes.DeltaSpot.Add(double.Parse(_detContrato.Element("Griegas").Attribute("MoDelta_spot_num").Value.ToString()).ToString("#,##0.0000"));
                        _deltaFwd = double.Parse(_detContrato.Element("Griegas").Attribute("MoDelta_fwd_num").Value.ToString());
                        _Componentes.DeltaForward.Add(_deltaFwd.ToString("#,##0.0000"));
                        _Componentes.Gamma.Add(double.Parse(_detContrato.Element("Griegas").Attribute("MoGamma_spot_num").Value.ToString()).ToString("#,##0"));
                        _Componentes.Vega.Add(double.Parse(_detContrato.Element("Griegas").Attribute("MoVega_num").Value.ToString()).ToString("#,##0"));
                        _Componentes.RhoDom.Add(double.Parse(_detContrato.Element("Griegas").Attribute("MoRho_num").Value.ToString()).ToString("#,##0"));
                        _Componentes.RhoFor.Add(double.Parse(_detContrato.Element("Griegas").Attribute("MoRhof_num").Value.ToString()).ToString("#,##0"));
                        _Componentes.Theta.Add(double.Parse(_detContrato.Element("Griegas").Attribute("MoTheta_num").Value.ToString()).ToString("#,##0"));
                        _Componentes.Charm.Add(double.Parse(_detContrato.Element("Griegas").Attribute("MoCharm_spot_num").Value.ToString()).ToString("#,##0"));
                        _Componentes.Vanna.Add(double.Parse(_detContrato.Element("Griegas").Attribute("MoVanna_spot_num").Value.ToString()).ToString("#,##0"));
                        _Componentes.Volga.Add(double.Parse(_detContrato.Element("Griegas").Attribute("MoVolga_num").Value.ToString()).ToString("#,##0"));
                        //_Componentes.Zomma.Add(double.Parse(_detContrato.Element("Griegas").Attribute("MoZomma_spot_num").Value.ToString()).ToString("#,##0"));
                        //_Componentes.Speed.Add(double.Parse(_detContrato.Element("Griegas").Attribute("MoSpeed_spot_num").Value.ToString()).ToString("#,##0"));
                    }
                    else if (_tipoPayOff.Equals("01")) //Vanilla
                    {
                        _Componentes.DeltaSpot.Add(double.Parse(_detContrato.Element("Griegas").Attribute("MoDelta_spot").Value.ToString()).ToString("#,##0"));

                        _deltaFwd = double.Parse(_detContrato.Element("Griegas").Attribute("MoDelta_fwd").Value.ToString());
                        _Componentes.DeltaForward.Add(_deltaFwd.ToString("#,##0"));
                        _Componentes.Gamma.Add(double.Parse(_detContrato.Element("Griegas").Attribute("MoGamma_spot").Value.ToString()).ToString("#,##0"));
                        _Componentes.Vega.Add(double.Parse(_detContrato.Element("Griegas").Attribute("MoVega").Value.ToString()).ToString("#,##0"));
                        _Componentes.RhoDom.Add(double.Parse(_detContrato.Element("Griegas").Attribute("MoRho").Value.ToString()).ToString("#,##0"));
                        _Componentes.RhoFor.Add(double.Parse(_detContrato.Element("Griegas").Attribute("MoRhof").Value.ToString()).ToString("#,##0"));
                        _Componentes.Theta.Add(double.Parse(_detContrato.Element("Griegas").Attribute("MoTheta").Value.ToString()).ToString("#,##0"));
                        _Componentes.Charm.Add(double.Parse(_detContrato.Element("Griegas").Attribute("MoCharm_spot").Value.ToString()).ToString("#,##0"));
                        _Componentes.Vanna.Add(double.Parse(_detContrato.Element("Griegas").Attribute("MoVanna_spot").Value.ToString()).ToString("#,##0"));
                        _Componentes.Volga.Add(double.Parse(_detContrato.Element("Griegas").Attribute("MoVolga").Value.ToString()).ToString("#,##0"));
                        //_Componentes.Zomma.Add(double.Parse(_detContrato.Element("Griegas").Attribute("MoZomma_spot").Value.ToString()).ToString("#,##0"));
                        //_Componentes.Speed.Add(double.Parse(_detContrato.Element("Griegas").Attribute("MoSpeed_spot").Value.ToString()).ToString("#,##0"));
                    }

                    double _nocional = double.Parse(_detContrato.Element("Subyacente").Attribute("MoMontoMon1").Value.ToString());
                    double _DeltaFwdPorcentage = (_deltaFwd / _nocional) * 100;
                    _Componentes.DeltaFwdPorcentage.Add(_DeltaFwdPorcentage.ToString("#,##0") + " %");
                }

                this._ComponentesTable.grdComponentes.Columns.Clear();

                for (int i = 0; i < _Componentes.Count(); i++)
                {
                    DataGridTextColumn _newColumn = new DataGridTextColumn();
                    if (i != 0)
                    {
                        _newColumn.Header = "Componente " + i;
                    }
                    else
                    {
                        _newColumn.Header = "";
                    }

                    _newColumn.Binding = new System.Windows.Data.Binding("Componente" + i);
                    this._ComponentesTable.grdComponentes.Columns.Add(_newColumn);
                }

                DataGridRow _newRow = new DataGridRow();

                List<ItemComponentes> _itemComponenteList = new List<ItemComponentes>();

                ItemComponentes _item0 = new ItemComponentes();
                ItemComponentes _item1 = new ItemComponentes();
                ItemComponentes _item2 = new ItemComponentes();
                ItemComponentes _item3 = new ItemComponentes();
                ItemComponentes _item4 = new ItemComponentes();
                ItemComponentes _item5 = new ItemComponentes();
                ItemComponentes _item6 = new ItemComponentes();
                ItemComponentes _item7 = new ItemComponentes();
                ItemComponentes _item8 = new ItemComponentes();
                ItemComponentes _item9 = new ItemComponentes();
                ItemComponentes _item10 = new ItemComponentes();
                ItemComponentes _item11 = new ItemComponentes();
                ItemComponentes _item12 = new ItemComponentes();
                ItemComponentes _item13 = new ItemComponentes();
                ItemComponentes _item14 = new ItemComponentes();
                ItemComponentes _item15 = new ItemComponentes();
                ItemComponentes _item16 = new ItemComponentes();
                ItemComponentes _item17 = new ItemComponentes();
                ItemComponentes _item18 = new ItemComponentes();
                ItemComponentes _item19 = new ItemComponentes();
                ItemComponentes _item20 = new ItemComponentes();
                ItemComponentes _item21 = new ItemComponentes();
                ItemComponentes _item22 = new ItemComponentes();
                ItemComponentes _item23 = new ItemComponentes();
                //ItemComponentes _item24 = new ItemComponentes();
                //ItemComponentes _item25 = new ItemComponentes();

                _itemComponenteList.Add(_item0);
                _itemComponenteList.Add(_item1);
                _itemComponenteList.Add(_item2);
                _itemComponenteList.Add(_item3);
                _itemComponenteList.Add(_item4);
                _itemComponenteList.Add(_item5);
                _itemComponenteList.Add(_item6);
                _itemComponenteList.Add(_item7);
                _itemComponenteList.Add(_item8);
                _itemComponenteList.Add(_item9);
                _itemComponenteList.Add(_item10);
                _itemComponenteList.Add(_item11);
                _itemComponenteList.Add(_item12);
                _itemComponenteList.Add(_item13);
                _itemComponenteList.Add(_item14);
                _itemComponenteList.Add(_item15);
                _itemComponenteList.Add(_item16);
                _itemComponenteList.Add(_item17);
                _itemComponenteList.Add(_item18);
                _itemComponenteList.Add(_item19);
                _itemComponenteList.Add(_item20);
                _itemComponenteList.Add(_item21);
                _itemComponenteList.Add(_item22);
                _itemComponenteList.Add(_item23);
                //_itemComponenteList.Add(_item24);
                //_itemComponenteList.Add(_item25);

                //ASVG_20111206 cantidad fija de componentes, mejorar.
                for (int i = 0; i < _Componentes.Count(); i++)
                {
                    switch (i)
                    {
                        case 0:
                            _item0.Componente0 = _Componentes.Producto[i];
                            _item1.Componente0 = _Componentes.CompraVenta[i];
                            _item2.Componente0 = _Componentes.FechaVal[i];
                            _item3.Componente0 = _Componentes.FechaVcto[i];
                            _item4.Componente0 = _Componentes.Nominal[i];
                            _item5.Componente0 = _Componentes.Strike[i];
                            _item6.Componente0 = _Componentes.Prima[i];
                            _item7.Componente0 = _Componentes.DeltaFwdPorcentage[i];
                            _item8.Componente0 = _Componentes.Spot[i];
                            _item9.Componente0 = _Componentes.PuntosFwd[i];
                            _item10.Componente0 = _Componentes.Volatilidad[i];
                            _item11.Componente0 = _Componentes.TasaLocal[i];
                            _item12.Componente0 = _Componentes.TasaForanea[i];
                            _item13.Componente0 = _Componentes.MtM[i];
                            _item14.Componente0 = _Componentes.DeltaSpot[i];
                            _item15.Componente0 = _Componentes.DeltaForward[i];
                            _item16.Componente0 = _Componentes.Gamma[i];
                            _item17.Componente0 = _Componentes.Vega[i];
                            _item18.Componente0 = _Componentes.RhoDom[i];
                            _item19.Componente0 = _Componentes.RhoFor[i];
                            _item20.Componente0 = _Componentes.Theta[i];
                            _item21.Componente0 = _Componentes.Charm[i];
                            _item22.Componente0 = _Componentes.Vanna[i];
                            _item23.Componente0 = _Componentes.Volga[i];
                            //_item24.Componente0 = _Componentes.Zomma[i];
                            //_item25.Componente0 = _Componentes.Speed[i];
                            break;
                        case 1:
                            _item0.Componente1 = _Componentes.Producto[i];
                            _item1.Componente1 = _Componentes.CompraVenta[i];
                            _item2.Componente1 = _Componentes.FechaVal[i];
                            _item3.Componente1 = _Componentes.FechaVcto[i];
                            _item4.Componente1 = _Componentes.Nominal[i];
                            _item5.Componente1 = _Componentes.Strike[i];
                            _item6.Componente1 = _Componentes.Prima[i];
                            _item7.Componente1 = _Componentes.DeltaFwdPorcentage[i];
                            _item8.Componente1 = _Componentes.Spot[i];
                            _item9.Componente1 = _Componentes.PuntosFwd[i];
                            _item10.Componente1 = _Componentes.Volatilidad[i];
                            _item11.Componente1 = _Componentes.TasaLocal[i];
                            _item12.Componente1 = _Componentes.TasaForanea[i];
                            _item13.Componente1 = _Componentes.MtM[i];
                            _item14.Componente1 = _Componentes.DeltaSpot[i];
                            _item15.Componente1 = _Componentes.DeltaForward[i];
                            _item16.Componente1 = _Componentes.Gamma[i];
                            _item17.Componente1 = _Componentes.Vega[i];
                            _item18.Componente1 = _Componentes.RhoDom[i];
                            _item19.Componente1 = _Componentes.RhoFor[i];
                            _item20.Componente1 = _Componentes.Theta[i];
                            _item21.Componente1 = _Componentes.Charm[i];
                            _item22.Componente1 = _Componentes.Vanna[i];
                            _item23.Componente1 = _Componentes.Volga[i];
                            //_item23.Componente1 = _Componentes.Zomma[i];
                            //_item24.Componente1 = _Componentes.Speed[i];
                            break;
                        case 2:
                            _item0.Componente2 = _Componentes.Producto[i];
                            _item1.Componente2 = _Componentes.CompraVenta[i];
                            _item2.Componente2 = _Componentes.FechaVal[i];
                            _item3.Componente2 = _Componentes.FechaVcto[i];
                            _item4.Componente2 = _Componentes.Nominal[i];
                            _item5.Componente2 = _Componentes.Strike[i];
                            _item6.Componente2 = _Componentes.Prima[i];
                            _item7.Componente2 = _Componentes.DeltaFwdPorcentage[i];
                            _item8.Componente2 = _Componentes.Spot[i];
                            _item9.Componente2 = _Componentes.PuntosFwd[i];
                            _item10.Componente2 = _Componentes.Volatilidad[i];
                            _item11.Componente2 = _Componentes.TasaLocal[i];
                            _item12.Componente2 = _Componentes.TasaForanea[i];
                            _item13.Componente2 = _Componentes.MtM[i];
                            _item14.Componente2 = _Componentes.DeltaSpot[i];
                            _item15.Componente2 = _Componentes.DeltaForward[i];
                            _item16.Componente2 = _Componentes.Gamma[i];
                            _item17.Componente2 = _Componentes.Vega[i];
                            _item18.Componente2 = _Componentes.RhoDom[i];
                            _item19.Componente2 = _Componentes.RhoFor[i];
                            _item20.Componente2 = _Componentes.Theta[i];
                            _item21.Componente2 = _Componentes.Charm[i];
                            _item22.Componente2 = _Componentes.Vanna[i];
                            _item23.Componente2 = _Componentes.Volga[i];
                            //_item23.Componente2 = _Componentes.Zomma[i];
                            //_item24.Componente2 = _Componentes.Speed[i];
                            break;
                        case 3:
                            _item0.Componente3 = _Componentes.Producto[i];
                            _item1.Componente3 = _Componentes.CompraVenta[i];
                            _item2.Componente3 = _Componentes.FechaVal[i];
                            _item3.Componente3 = _Componentes.FechaVcto[i];
                            _item4.Componente3 = _Componentes.Nominal[i];
                            _item5.Componente3 = _Componentes.Strike[i];
                            _item6.Componente3 = _Componentes.Prima[i];
                            _item7.Componente3 = _Componentes.DeltaFwdPorcentage[i];
                            _item8.Componente3 = _Componentes.Spot[i];
                            _item9.Componente3 = _Componentes.PuntosFwd[i];
                            _item10.Componente3 = _Componentes.Volatilidad[i];
                            _item11.Componente3 = _Componentes.TasaLocal[i];
                            _item12.Componente3 = _Componentes.TasaForanea[i];
                            _item13.Componente3 = _Componentes.MtM[i];
                            _item14.Componente3 = _Componentes.DeltaSpot[i];
                            _item15.Componente3 = _Componentes.DeltaForward[i];
                            _item16.Componente3 = _Componentes.Gamma[i];
                            _item17.Componente3 = _Componentes.Vega[i];
                            _item18.Componente3 = _Componentes.RhoDom[i];
                            _item19.Componente3 = _Componentes.RhoFor[i];
                            _item20.Componente3 = _Componentes.Theta[i];
                            _item21.Componente3 = _Componentes.Charm[i];
                            _item22.Componente3 = _Componentes.Vanna[i];
                            _item23.Componente3 = _Componentes.Volga[i];
                            //_item23.Componente3 = _Componentes.Zomma[i];
                            //_item24.Componente3 = _Componentes.Speed[i];
                            break;
                        case 4:
                            _item0.Componente4 = _Componentes.Producto[i];
                            _item1.Componente4 = _Componentes.CompraVenta[i];
                            _item2.Componente4 = _Componentes.FechaVal[i];
                            _item3.Componente4 = _Componentes.FechaVcto[i];
                            _item4.Componente4 = _Componentes.Nominal[i];
                            _item5.Componente4 = _Componentes.Strike[i];
                            _item6.Componente4 = _Componentes.Prima[i];
                            _item7.Componente4 = _Componentes.DeltaFwdPorcentage[i];
                            _item8.Componente4 = _Componentes.Spot[i];
                            _item9.Componente4 = _Componentes.PuntosFwd[i];
                            _item10.Componente4 = _Componentes.Volatilidad[i];
                            _item11.Componente4 = _Componentes.TasaLocal[i];
                            _item12.Componente4 = _Componentes.TasaForanea[i];
                            _item13.Componente4 = _Componentes.MtM[i];
                            _item14.Componente4 = _Componentes.DeltaSpot[i];
                            _item15.Componente4 = _Componentes.DeltaForward[i];
                            _item16.Componente4 = _Componentes.Gamma[i];
                            _item17.Componente4 = _Componentes.Vega[i];
                            _item18.Componente4 = _Componentes.RhoDom[i];
                            _item19.Componente4 = _Componentes.RhoFor[i];
                            _item20.Componente4 = _Componentes.Theta[i];
                            _item21.Componente4 = _Componentes.Charm[i];
                            _item22.Componente4 = _Componentes.Vanna[i];
                            _item23.Componente4 = _Componentes.Volga[i];
                            //_item23.Componente4 = _Componentes.Zomma[i];
                            //_item24.Componente4 = _Componentes.Speed[i];
                            break;
                        case 5:
                            _item0.Componente5 = _Componentes.Producto[i];
                            _item1.Componente5 = _Componentes.CompraVenta[i];
                            _item2.Componente5 = _Componentes.FechaVal[i];
                            _item3.Componente5 = _Componentes.FechaVcto[i];
                            _item4.Componente5 = _Componentes.Nominal[i];
                            _item5.Componente5 = _Componentes.Strike[i];
                            _item6.Componente5 = _Componentes.Prima[i];
                            _item7.Componente5 = _Componentes.DeltaFwdPorcentage[i];
                            _item8.Componente5 = _Componentes.Spot[i];
                            _item9.Componente5 = _Componentes.PuntosFwd[i];
                            _item10.Componente5 = _Componentes.Volatilidad[i];
                            _item11.Componente5 = _Componentes.TasaLocal[i];
                            _item12.Componente5 = _Componentes.TasaForanea[i];
                            _item13.Componente5 = _Componentes.MtM[i];
                            _item14.Componente5 = _Componentes.DeltaSpot[i];
                            _item15.Componente5 = _Componentes.DeltaForward[i];
                            _item16.Componente5 = _Componentes.Gamma[i];
                            _item17.Componente5 = _Componentes.Vega[i];
                            _item18.Componente5 = _Componentes.RhoDom[i];
                            _item19.Componente5 = _Componentes.RhoFor[i];
                            _item20.Componente5 = _Componentes.Theta[i];
                            _item21.Componente5 = _Componentes.Charm[i];
                            _item22.Componente5 = _Componentes.Vanna[i];
                            _item23.Componente5 = _Componentes.Volga[i];
                            //_item23.Componente5 = _Componentes.Zomma[i];
                            //_item24.Componente5 = _Componentes.Speed[i];
                            break;
                    }
                }

                if (this._ComponentesTable.grdComponentes.FrozenColumnCount != 1)
                {
                    this._ComponentesTable.grdComponentes.FrozenColumnCount = 1;
                }

                this._ComponentesTable.grdComponentes.IsReadOnly = true;
                this._ComponentesTable.grdComponentes.ItemsSource = null;
                this._ComponentesTable.grdComponentes.ItemsSource = _itemComponenteList;
            }
        }

        private void event_FechaSetPrecio_SelectedDateChanged(object sender, SelectionChangedEventArgs e)
        {
            DatePicker _calendar = (sender as DatePicker);
            if (_calendar.SelectedDate != null && _calendar.SelectedDate.Value.CompareTo(this.FechaDeProceso) <= 0)
            {
                _FechaValoracionCartera = _calendar.SelectedDate.Value;
                LoadSetPrecios(DatePickerSetPrecios.SelectedDate.Value, curvaDom, curvaFor, setPreciosValCartera);
                isFechaValorizacionMayor = false;
            }
            else
            {
                if (isFechaValorizacionMayor.Equals(false))
                {
                    isFechaValorizacionMayor = true;
                    _calendar.SelectedDate = _FechaValoracionCartera;
                }
            }

            //this.txtFechaValCartera.Text = _FechaValoracionCartera.ToString("dd-MM-yyyy");
        }

        private void event_btnCargarContratoData_Clicked(object sender, RoutedEventArgs e)
        {
            //CargarSetdePrecios();
            LoadSetPrecios(DatePickerSetPrecios.SelectedDate.Value, curvaDom, curvaFor, setPreciosValCartera);
            //getDetContratoFijaciones(DatePickerSetPrecios.SelectedDate.Value, StatusString());
        }

        private void getDetContratoFijaciones(DateTime fechaContrato, string Estado)
        {
            PutLayer(CanvasPrincipalValorizadorCartera, "CARGANDO OPERACIONES...");

            if (this._Transaccion == "ANULA")
            {
                Estado = "'U'";
            }
            if (this._Transaccion == "ANTICIPA")
            {
                Estado = "'N'";

                this.itemValCartera.IsEnabled = false;
                this.itemSetdePrecios.IsEnabled = false;
                this.itemTabDeltas.IsEnabled = false;
                this.DatePickerSetPrecios.IsEnabled = false;
                this.DatePickerVencimiento.IsEnabled = false;
                this.datePiker_DateProccess.IsEnabled = false;

                this.radioCompra.IsEnabled = false;
                this.radioVenta.IsEnabled = false;

                this.btnTablaFixing.IsEnabled = false;
                this.btnComponentes.IsEnabled = false;
                this.btnTopoLogiaVegaPricing.IsEnabled = false;

                this.expanderOpciones.IsEnabled = false;

                this.comboPayOff.IsEnabled = false;
                this.comboBsFwdBsSpotAsianMomenos.IsEnabled = false;

                this.txtNocional.IsEnabled = false;
                this.txtSpotValorizacion.IsEnabled = false;
                this.txtStrike1.IsEnabled = false;
                this.txtStrike2.IsEnabled = false;
                this.txtStrike3.IsEnabled = false;
                this.txtSpotCosto.IsEnabled = false;
                this.txtPlazo.IsEnabled = false;
                this.txtPuntosCosto.IsEnabled = false;
                this.txtNocionalStrangle.IsEnabled = false;

                this.itemTabPrima.IsEnabled = false;
                this.itemTabDistribucion.IsEnabled = false;

                this.itemTabUnwind.IsSelected = true;
                this.checkBoxVegaWeighted.IsEnabled = false;
            }


            SrvValorizador.SrvValorizadorCarteraSoapClient _SrvValorizador = wsGlobales.Valorizador;//new AdminOpciones.SrvValorizador.SrvValorizadorCarteraSoapClient();
            _SrvValorizador.getDetContratoFixingCompleted += new EventHandler<AdminOpciones.SrvValorizador.getDetContratoFixingCompletedEventArgs>(_SrvValorizador_getDetContratoFixingCompleted);
            _SrvValorizador.getDetContratoFixingAsync(fechaContrato, Estado, FechaDeProceso);
        }

        private void _SrvValorizador_getDetContratoFixingCompleted(object sender, AdminOpciones.SrvValorizador.getDetContratoFixingCompletedEventArgs e)
        {
            string _EncContrato = e.Result;

            XDocument xdoc = new XDocument();
            xdoc = XDocument.Parse(_EncContrato);

            EncContratoList = new List<StructEncContrato>();
            DetContratoList = new List<StructDetContrato>();
            FijacionesList = new List<StructFixingDataContrato>();

            StructEncContrato _itemEncContratoStruct;
            StructDetContrato _itemDetContratoStruct;
            StructFixingDataContrato _itemFixingData;

            int _idDet = 0;
            int _idEnc = 0;

            string _Filtro = CheckImage.Visibility == Visibility.Visible ? "Todas" : "Ninguna";

            #region Carga Contratos Contratos

            foreach (XElement itemEncContrato in xdoc.Descendants("Opcion"))
            {
                _idEnc++;

                #region Inicializa Variable de Contrato

                _itemEncContratoStruct = new StructEncContrato();
                _itemEncContratoStruct.Encabezado_Checked += new delegate_Checked(_itemEncContratoStruct_Encabezado_Checked);

                #endregion

                #region Setea encabezados

                _itemEncContratoStruct.Estado = itemEncContrato.Element("itemEncContrato").Attribute("Estado").Value;

                try
                {
                    try
                    {
                        _itemEncContratoStruct.Estado = _itemEncContratoStruct.Estado.Equals("") ? " " : _itemEncContratoStruct.Estado;
                        _itemEncContratoStruct.GlosaEstado = OptionStateList.First(x => x.Codigo.Equals(_itemEncContratoStruct.Estado)).Descripcion;
                    }
                    catch { }
                }
                catch { }

                _itemEncContratoStruct.ID = _idEnc;
                _itemEncContratoStruct.Checked = _Filtro.Equals("Todas") ? true : false;
                _itemEncContratoStruct.NumContrato = int.Parse(itemEncContrato.Element("itemEncContrato").Attribute("NumContrato").Value);
                _itemEncContratoStruct.NumFolio = int.Parse(itemEncContrato.Element("itemEncContrato").Attribute("NumFolio").Value);
                _itemEncContratoStruct.CodEstructura = int.Parse(itemEncContrato.Element("itemEncContrato").Attribute("CodEstructura").Value);
                _itemEncContratoStruct.Opcion = itemEncContrato.Element("itemEncContrato").Attribute("Opcion").Value;
                _itemEncContratoStruct.CVEstructura = itemEncContrato.Element("itemEncContrato").Attribute("CVEstructura").Value;
                _itemEncContratoStruct.FechaContrato = DateTime.Parse(itemEncContrato.Element("itemEncContrato").Attribute("FechaContrato").Value);
                _itemEncContratoStruct.FecValorizacion = DateTime.Parse(itemEncContrato.Element("itemEncContrato").Attribute("FecValorizacion").Value);
                _itemEncContratoStruct.CarteraFinanciera = int.Parse(itemEncContrato.Element("itemEncContrato").Attribute("CarteraFinanciera").Value);
                _itemEncContratoStruct.FinancialPortfolio = itemEncContrato.Element("itemEncContrato").Attribute("FinancialPortfolio").Value;
                _itemEncContratoStruct.Libro = int.Parse(itemEncContrato.Element("itemEncContrato").Attribute("Libro").Value);
                _itemEncContratoStruct.Book = itemEncContrato.Element("itemEncContrato").Attribute("Book").Value;
                _itemEncContratoStruct.CarNormativa = itemEncContrato.Element("itemEncContrato").Attribute("CarNormativa").Value;
                _itemEncContratoStruct.PortfolioRules = itemEncContrato.Element("itemEncContrato").Attribute("PortfolioRules").Value;
                _itemEncContratoStruct.SubCarNormativa = int.Parse(itemEncContrato.Element("itemEncContrato").Attribute("SubCarNormativa").Value);
                _itemEncContratoStruct.SubPortfolioRules = itemEncContrato.Element("itemEncContrato").Attribute("SubPortfolioRules").Value;
                _itemEncContratoStruct.RutCliente = int.Parse(itemEncContrato.Element("itemEncContrato").Attribute("RutCliente").Value);
                _itemEncContratoStruct.Codigo = int.Parse(itemEncContrato.Element("itemEncContrato").Attribute("Codigo").Value);
                _itemEncContratoStruct.NombreCliente = itemEncContrato.Element("itemEncContrato").Attribute("NombreCliente").Value;
                _itemEncContratoStruct.TipoContrapartida = itemEncContrato.Element("itemEncContrato").Attribute("TipoContrapartida").Value;
                _itemEncContratoStruct.Glosa = itemEncContrato.Element("itemEncContrato").Attribute("Glosa").Value;
                _itemEncContratoStruct.TipoTransaccion = itemEncContrato.Element("itemEncContrato").Attribute("TipoTransaccion").Value;
                //PRD_10449 ASVG_20111222
                _itemEncContratoStruct.RelacionaPAE = int.Parse(itemEncContrato.Element("itemEncContrato").Attribute("RelacionaPAE").Value);

                #region Carga de Prima

                #region Código de Moneda

                _itemEncContratoStruct.CodMonPagPrima = int.Parse(itemEncContrato.Element("itemEncContrato").Attribute("CaCodMonPagPrima").Value);

                #endregion

                #region Prima inicial MO

                if (itemEncContrato.Element("itemEncContrato").Attribute("PrimaInicial").Value != "")
                {
                    _itemEncContratoStruct.PrimaInicial = double.Parse(itemEncContrato.Element("itemEncContrato").Attribute("PrimaInicial").Value);
                }
                else
                {
                    _itemEncContratoStruct.PrimaInicial = double.NaN;
                }

                #endregion

                #region Paridad Prima Inicial

                if (itemEncContrato.Element("itemEncContrato").Attribute("ParMdaPrima").Value != "")
                {
                    _itemEncContratoStruct.ParMdaPrima = double.Parse(itemEncContrato.Element("itemEncContrato").Attribute("ParMdaPrima").Value);
                }
                else
                {
                    _itemEncContratoStruct.ParMdaPrima = double.NaN;
                }

                #endregion

                #region Prima Inicial CLP

                if (itemEncContrato.Element("itemEncContrato").Attribute("PrimaInicialML").Value != "")
                {
                    _itemEncContratoStruct.PrimaInicialML = double.Parse(itemEncContrato.Element("itemEncContrato").Attribute("PrimaInicialML").Value);
                }
                else
                {
                    _itemEncContratoStruct.PrimaInicialML = double.NaN;
                }

                #endregion

                //5843
                #region Resultado Venta

                if (itemEncContrato.Element("itemEncContrato").Attribute("ResultadoVta").Value != "")
                {
                    _itemEncContratoStruct.ResultadoVta = double.Parse(itemEncContrato.Element("itemEncContrato").Attribute("ResultadoVta").Value);
                }
                else
                {
                    _itemEncContratoStruct.ResultadoVta = double.NaN;
                }

                #endregion

                #region Forma de Pago Prima

                _itemEncContratoStruct.fPagoPrima = int.Parse(itemEncContrato.Element("itemEncContrato").Attribute("CafPagoPrima").Value);
                try
                {
                    _itemEncContratoStruct.FormaPagoPrima = this.formaDePagoList.First(x => x.Codigo.Equals(_itemEncContratoStruct.fPagoPrima.ToString())).Descripcion;
                }
                catch
                {
                    _itemEncContratoStruct.FormaPagoPrima = "NO DISPONIBLE " + _itemEncContratoStruct.fPagoPrima.ToString();
                }

                #endregion

                #endregion Carga de Prima

                #endregion Setea encabezados

                #region Carga Detalle

                foreach (XElement itemdetContrato in itemEncContrato.Descendants("itemDetContrato"))
                {
                    _itemDetContratoStruct = new StructDetContrato();
                    _itemDetContratoStruct.Detalle_Checked_detContrato += new delegate_Checked_DetContrato(_itemDetContratoStruct_Detalle_Checked_detContrato);

                    _idDet++;

                    _itemDetContratoStruct.ID = _idDet;
                    _itemDetContratoStruct.Checked = _Filtro.Equals("Todas") ? true : false;
                    _itemDetContratoStruct.NumContrato = int.Parse(itemdetContrato.Attribute("NumContrato").Value);
                    _itemDetContratoStruct.CodEstructura = int.Parse(itemdetContrato.Attribute("CodEstructura").Value);
                    _itemDetContratoStruct.NumEstructura = int.Parse(itemdetContrato.Attribute("NumEstructura").Value);
                    _itemDetContratoStruct.Vinculacion = itemdetContrato.Attribute("Vinculacion").Value;
                    _itemDetContratoStruct.TipoPayOff = itemdetContrato.Attribute("TipoPayOff").Value;
                    _itemDetContratoStruct.CallPut = itemdetContrato.Attribute("CallPut").Value;
                    _itemDetContratoStruct.CVOpc = itemdetContrato.Attribute("CVOpc").Value;
                    _itemDetContratoStruct.TipoEjercicio = itemdetContrato.Attribute("CaTipoEjercicio").Value;
                    _itemDetContratoStruct.FechaInicioOpc = DateTime.Parse(itemdetContrato.Attribute("FechaInicioOpc").Value);
                    _itemDetContratoStruct.FechaVcto = DateTime.Parse(itemdetContrato.Attribute("FechaVcto").Value);
                    _itemDetContratoStruct.Strike = double.Parse(itemdetContrato.Attribute("Strike").Value);
                    _itemDetContratoStruct.MontoMon1 = double.Parse(itemdetContrato.Attribute("MontoMon1").Value);
                    _itemDetContratoStruct.ParStrike = itemdetContrato.Attribute("ParStrike").Value;
                    _itemDetContratoStruct.SpotDet = double.Parse(itemdetContrato.Attribute("SpotDet").Value);
                    _itemDetContratoStruct.CurveMon1 = this.curvaDom;
                    _itemDetContratoStruct.CurveMon2 = this.curvaFor;
                    _itemDetContratoStruct.FormaPagoMon1 = int.Parse(itemdetContrato.Attribute("CaFormaPagoMon1").Value);
                    _itemDetContratoStruct.FormaPagoMon2 = int.Parse(itemdetContrato.Attribute("CaFormaPagoMon2").Value);
                    _itemDetContratoStruct.MdaCompensacion = int.Parse(itemdetContrato.Attribute("CaMdaCompensacion").Value);
                    _itemDetContratoStruct.FormaPagoComp = int.Parse(itemdetContrato.Attribute("CaFormaPagoComp").Value);
                    _itemDetContratoStruct.Modalidad = itemdetContrato.Attribute("Modalidad").Value.Equals("C") ? true : false;
                    _itemDetContratoStruct.TipoTransaccion = itemdetContrato.Attribute("TipoTransaccion").Value;
                    _itemDetContratoStruct.PorcStrike = double.Parse(itemdetContrato.Attribute("CaPorcStrike").Value);//PRD_12567

                    DetContratoList.Add(_itemDetContratoStruct);
                }

                #endregion

                #region Carga Fijación

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

                #endregion

                #region Carga Encabezado del Contrato

                EncContratoList.Add(_itemEncContratoStruct);

                #endregion

            }

            #endregion

            ReCreateDataGrid();

            XElement _Deltas = new XElement(xdoc.Element("Data").Element("Deltas"));

            ValidAmount _Value = new ValidAmount();

            _Value.DecimalPlaces = 0;
            _Value.SetChange(this.txtPosicionSpot, double.Parse(_Deltas.Attribute("SpotDelta").Value));
            _Value.DecimalPlaces = 0;
            _Value.SetChange(this.txtPosicionForward, double.Parse(_Deltas.Attribute("ForwardDelta").Value));

            isCarteraLoaded = true;
            QuitLayer(CanvasPrincipalValorizadorCartera);
        }

        private void _itemDetContratoStruct_Detalle_Checked_detContrato(int NumContrato, bool Value)
        {
            if (!NumContrato.Equals(0))
            {
                int StructCount;
                int _checked = 0;

                string true_false_partial;

                IEnumerable<StructDetContrato> _DetContraloList = DetContratoList.Where(x => x.NumContrato.Equals(NumContrato));

                StructCount = _DetContraloList.Count();

                foreach (StructDetContrato _detContrato in _DetContraloList)
                {
                    if (_detContrato.Checked.Equals(true))
                    {
                        _checked++;
                    }
                }
                if (StructCount.Equals(_checked))
                {
                    true_false_partial = "true";
                }
                else if (_checked.Equals(0))
                {
                    true_false_partial = "false";
                }
                else
                {
                    true_false_partial = "partial";

                }

                switch (true_false_partial)
                {
                    case "true":
                        EncContratoList.First(x => x.NumContrato.Equals(NumContrato)).isChecked = true;
                        break;
                    case "false":
                        EncContratoList.First(x => x.NumContrato.Equals(NumContrato)).isChecked = false;
                        break;
                    case "partial":
                        EncContratoList.First(x => x.NumContrato.Equals(NumContrato)).isChecked = false;
                        break;
                }
            }

            int _AllChecks = DetContratoList.Count;
            int _checks = 0;

            for (int i = 0; i < _AllChecks; i++)
            {
                if (DetContratoList[i].Checked)
                    _checks++;
            }

            SomeCheck.Visibility = _checks > 0 && _checks < _AllChecks ? Visibility.Visible : Visibility.Collapsed;
            CheckImage.Visibility = _checks == _AllChecks ? Visibility.Visible : Visibility.Collapsed;
        }

        private void _itemEncContratoStruct_Encabezado_Checked(int NumContrato, bool Value)
        {
            foreach (StructDetContrato _detContrato in DetContratoList.Where(x => x.NumContrato.Equals(NumContrato)))
            {
                if (Value.Equals(true))
                {
                    _detContrato.isChecked = true;
                }
                else
                {
                    _detContrato.isChecked = false; ;
                }
            }

            int _AllChecks = EncContratoList.Count;
            int _checks = 0;

            for (int i = 0; i < _AllChecks; i++)
            {
                if (EncContratoList[i].Checked)
                    _checks++;
            }

            SomeCheck.Visibility = _checks > 0 && _checks < _AllChecks ? Visibility.Visible : Visibility.Collapsed;
            CheckImage.Visibility = _checks == _AllChecks ? Visibility.Visible : Visibility.Collapsed;
        }

        private void event_comboAtmRRFlyCallPut_SelectedChanged(object sender, SelectionChangedEventArgs e)
        {
            if (SmileCallPutList != null && SmileCallPutList.Count > 0)
            {
                ComboBox _Combo = sender as ComboBox;
                ComboBoxItem _Item = _Combo.SelectedItem as ComboBoxItem;
                if (_Item.Content.Equals("Call-Put"))
                {
                    this.grdCallPut.ItemsSource = SmileCallPutList;
                    this.grdCallPut.Visibility = Visibility.Visible;
                    this.grdAtmRRFly.Visibility = Visibility.Collapsed;
                }
                else
                {
                    this.grdAtmRRFly.ItemsSource = SmileATMRRFLYList;
                    this.grdCallPut.Visibility = Visibility.Collapsed;
                    this.grdAtmRRFly.Visibility = Visibility.Visible;
                }
            }
        }

        private void event_btnValorizadorCartera_Clicked(object sender, RoutedEventArgs e)
        {
            btnTopologiaVega.IsEnabled = false;
            ValorizadorCartera();
        }

        private void ValorizadorCartera()
        {
            StartLoading(CanasTab2);

            isEncOrDetCheck_Clicked = false;
            if (DetContratoList != null && DetContratoList.Count > 0 && !this.txtSpotValorizacion.Text.Equals(""))
            {
                string _DetContratoFixingData = "<Data>\n";

                _DetContratoFixingData += "\t<FechaValorizacion Fecha='" + this.DatePickerCartera.SelectedDate.Value.ToString("dd-MM-yyyy") + "'/>\n";
                _DetContratoFixingData += "\t<SpotValorizacion Spot='" + this.BSSpotValorizacion + "'/>\n";
                _DetContratoFixingData += "\t<DetContrato>\n";
                List<StructDetContrato> DetContratlo_CHECKED_List = new List<StructDetContrato>();

                //DetContratlo_CHECKED_List = DetContratoList.Where<StructDetContrato>(x => x.Checked.Equals(true)).ToList<StructDetContrato>();

                for (int i = 0; i < DetContratoList.Count; i++)
                {
                    _DetContratoFixingData += "\t\t<itemDetContrato Checked='" + DetContratoList[i].Checked + "'";
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
                    _DetContratoFixingData += "PorcStrike='" + DetContratoList[i].PorcStrike + "' ";//PRD_12567
                    _DetContratoFixingData += "  />\n";
                }

                _DetContratoFixingData += "\t</DetContrato>\n";

                int _NumContrato, _NumEstructura;
                StructFixingDataContrato _itemFixindData = new StructFixingDataContrato();
                _DetContratoFixingData += "\t<Fixing>\n";
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
                            _DetContratoFixingData += "\t\t<itemFixing NumContrato='" + _itemFixindData.NumContrato + "' ";
                            _DetContratoFixingData += "NumEstructura='" + _itemFixindData.NucEstructura + "' ";
                            _DetContratoFixingData += "FixFecha='" + _itemFixindData.Fijaciones[j].Fecha + "' ";
                            _DetContratoFixingData += "FixNumero='" + (j + 1) + "' ";
                            _DetContratoFixingData += "PesoFij='" + _itemFixindData.Fijaciones[j].Peso + "' ";
                            _DetContratoFixingData += "VolFij='" + _itemFixindData.Fijaciones[j].Volatilidad + "' ";
                            _DetContratoFixingData += "Fijacion='" + _itemFixindData.Fijaciones[j].Valor + "' />\n";
                        }
                    }
                }
                _DetContratoFixingData += "\t</Fixing>\n";
                _DetContratoFixingData += "</Data>";

                SrvValorizador.SrvValorizadorCarteraSoapClient _SrvValorizador = wsGlobales.Valorizador;//new AdminOpciones.SrvValorizador.SrvValorizadorCarteraSoapClient();
                _SrvValorizador.ValorizarCarteraCompleted += new EventHandler<AdminOpciones.SrvValorizador.ValorizarCarteraCompletedEventArgs>(_SrvValorizador_ValorizarCarteraCompleted);
                _SrvValorizador.ValorizarCarteraAsync(_DetContratoFixingData, FechaSetdePrecios, setPreciosValCartera);
            }
            else
            {
                btnTopologiaVega.IsEnabled = true;
                StopLoading(CanasTab2);
            }
            ReCreateDataGrid();
        }

        private void _SrvValorizador_ValorizarCarteraCompleted(object sender, AdminOpciones.SrvValorizador.ValorizarCarteraCompletedEventArgs e)
        {
            string MtMGriegas = e.Result;

            XDocument _MtMGriegasXML = new XDocument();

            try
            {
                _MtMGriegasXML = XDocument.Parse(MtMGriegas);
            }
            catch
            {
                _MtMGriegasXML = null;
            }
            if (_MtMGriegasXML.Elements().Attributes("Error").Any())
            {
                string _alerta = _MtMGriegasXML.Element("Data").Attribute("Error").Value;
                System.Windows.Browser.HtmlPage.Window.Alert(_alerta);
            }

            if (_MtMGriegasXML != null) //<Data Error="Referencia a objeto no establecida como instancia de un objeto." />
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

                #region Opcion

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
                        _DeltaSpot = a.cleanNaN(_DeltaSpot);

                        //ASVG_20130726, se calcula DeltaForward 
                        //if (!_TipoPayOff.Equals("02"))
                        //{
                        //    _DeltaForward = double.Parse(_elementOpcion.Element("GriegasMonto").Attribute("DeltaForward").Value);
                        //}
                        //else
                        //{
                        //    _DeltaForward = double.NaN;
                        //}
                        _DeltaForward = double.Parse(_elementOpcion.Element("GriegasMonto").Attribute("DeltaForward").Value);
                        _Gamma = double.Parse(_elementOpcion.Element("GriegasMonto").Attribute("Gamma").Value);
                        _Vega = double.Parse(_elementOpcion.Element("GriegasMonto").Attribute("Vega").Value);
                        _Vanna = double.Parse(_elementOpcion.Element("GriegasMonto").Attribute("Vanna").Value);
                        _Volga = double.Parse(_elementOpcion.Element("GriegasMonto").Attribute("Volga").Value);
                        _Theta = double.Parse(_elementOpcion.Element("GriegasMonto").Attribute("Theta").Value);
                        _RhoDom = double.Parse(_elementOpcion.Element("GriegasMonto").Attribute("Rho").Value);
                        _RhoFor = double.Parse(_elementOpcion.Element("GriegasMonto").Attribute("Rhof").Value);
                        _Charm = double.Parse(_elementOpcion.Element("GriegasMonto").Attribute("Charm").Value);

                        StructEncContrato _ContractHead = new StructEncContrato();
                        _ContractHead = EncContratoList.First(x => x.NumContrato.Equals(_NumContrato));

                        if (oldNumContrato != _NumContrato)
                        {
                            _ContractHead.MtM = _MtM;
                            _ContractHead.DeltaSpot = _DeltaSpot;
                            //ASVG_20130726, se calcula DeltaForward
                            //if (!_TipoPayOff.Equals("02"))
                            //{
                            //    _ContractHead.DeltaForward = _DeltaForward;
                            //}
                            //else
                            //{
                            //    _ContractHead.DeltaForward = double.NaN;
                            //}
                            _ContractHead.DeltaForward = _DeltaForward;
                            _ContractHead.Gamma = _Gamma;
                            _ContractHead.Vega = _Vega;
                            _ContractHead.Vanna = _Vanna;
                            _ContractHead.Volga = _Volga;
                            _ContractHead.Theta = _Theta;
                            _ContractHead.RhoDom = _RhoDom;
                            _ContractHead.RhoFor = _RhoFor;
                            _ContractHead.Charm = _Charm;
                            oldNumContrato = _NumContrato;
                        }
                        else
                        {
                            _ContractHead.MtM += _MtM;
                            _ContractHead.DeltaSpot += _DeltaSpot;

                            //ASVG_20130726, se calcula DeltaForward
                            //if (!_TipoPayOff.Equals("02"))
                            //{
                            //    _ContractHead.DeltaForward += _DeltaForward;
                            //}
                            //else
                            //{
                            //    _ContractHead.DeltaForward = double.NaN;
                            //}
                            _ContractHead.DeltaForward += _DeltaForward;
                            _ContractHead.Gamma += _Gamma;
                            _ContractHead.Vega += _Vega;
                            _ContractHead.Vanna += _Vanna;
                            _ContractHead.Volga += _Volga;
                            _ContractHead.Theta += _Theta;
                            _ContractHead.RhoDom += _RhoDom;
                            _ContractHead.RhoFor += _RhoFor;
                            _ContractHead.Charm += _Charm;
                        }

                        _DetContratoElement.MtM = _MtM;
                        _DetContratoElement.DeltaSpot = _DeltaSpot;

                        //ASVG_20130726, se calcula DeltaForward
                        //if (!_TipoPayOff.Equals("02"))
                        //{
                        //    _DetContratoElement.DeltaForward = _DeltaForward;
                        //}
                        //else
                        //{
                        //    _DetContratoElement.DeltaForward = double.NaN;
                        //}

                        _DetContratoElement.DeltaForward = _DeltaForward;
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

                            //ASVG_20130726, se calcula DeltaForward
                            //if (!_TipoPayOff.Equals("02"))
                            //{
                            //    _itemMtMTotalizador.DeltaForward += _DeltaForward;
                            //}
                            //else
                            //{
                            //    _itemMtMTotalizador.DeltaForward += 0;
                            //}

                            _itemMtMTotalizador.DeltaForward += _DeltaForward;
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

                #endregion

                ValidAmount _Value = new ValidAmount();

                _Value.DecimalPlaces = 0;
                _Value.SetChange(this.txtPosicionOpciones, _itemMtMTotalizador.DeltaSpot);
                MtMGriegasTotalizador.Add(_itemMtMTotalizador);


                ReCreateDataGrid();

                this.grdTotalizadorValCartera.ItemsSource = MtMGriegasTotalizador;

                isCarteraValorizada = true;
                if (isTopologiaVegaClicked == true)
                {
                    StopLoading(CanvasItemTopologiaVega);
                    LoadTopologiaVega();
                    isTopologiaVegaClicked = false;
                }


            }
            btnTopologiaVega.IsEnabled = true;
            StopLoading(CanasTab2);

            //throw new NotImplementedException();
        }

        #region Topología

        public void TopologiaVega(double MTM_Totalizador, string rrfly_callput)
        {
            if (DetContratoList != null && DetContratoList.Count > 0 && !this.txtSpotValorizacion.Text.Equals(""))
            {
                string _DetContratoFixingData = "<Data>\n";
                int _Count = 0;

                _DetContratoFixingData += "<FechaValorizacion Fecha='" + this.DatePickerCartera.SelectedDate.Value.ToString("dd-MM-yyyy") + "'/>\n";
                _DetContratoFixingData += string.Format(
                                                         "<SpotValorizacion Spot='{0}' SpotSmile='{1}' />\n",
                                                         this.BSSpotValorizacion,
                                                         this.BSSpotValorizacion
                                                       );
                _DetContratoFixingData += "<DetContrato>\n";
                List<StructDetContrato> DetContratlo_CHECKED_List = new List<StructDetContrato>();

                for (int i = 0; i < DetContratoList.Count; i++)
                {
                    if (DetContratoList[i].Checked)
                    {
                        _Count++;
                    }
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
                    _DetContratoFixingData += "PuntosFwd='" + DetContratoList[i].PuntosFwd + "' ";
                    _DetContratoFixingData += "SpotDet='" + DetContratoList[i].SpotDet + "' ";
                    _DetContratoFixingData += "CurveMon1='" + DetContratoList[i].CurveMon1 + "' ";
                    _DetContratoFixingData += "CurveMon2='" + DetContratoList[i].CurveMon2 + "' ";
                    _DetContratoFixingData += "PorcStrike='" + DetContratoList[i].PorcStrike + "' ";//PRD_12567
                    _DetContratoFixingData += "MTM='" + DetContratoList[i].MtM + "' ";
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

                #region Smile ...comentado...

                //string Smile = CreateSmileXML();

                #endregion

                if (_Count > 0)
                {
                    SrvValorizador.SrvValorizadorCarteraSoapClient _SrvValorizador = wsGlobales.Valorizador;//new AdminOpciones.SrvValorizador.SrvValorizadorCarteraSoapClient();
                    _SrvValorizador.TopologiaVegaCompleted += new EventHandler<AdminOpciones.SrvValorizador.TopologiaVegaCompletedEventArgs>(_SrvValorizador_TopologiaVegaCompleted);
                    _SrvValorizador.TopologiaVegaAsync("BsSpot", _DetContratoFixingData, FechaSetdePrecios, MTM_Totalizador, rrfly_callput, setPreciosValCartera);
                    StartLoading(this.CanvasItemTopologiaVega);
                }
                else
                {
                    btnValorizadorCartera.IsEnabled = true;
                    this.grdTopologiaVegaRRFLY.ItemsSource = null;
                    this.grdTopologiaVegaCALLPUT.ItemsSource = null;

                    if (checkTopologiaPricing.IsChecked.Value)
                    {
                        this.grdTopologiaVegaRRFLY.ItemsSource = null;
                        this.grdTopologiaVegaCALLPUT.ItemsSource = null;

                        if (TopologiaVegaCALLPUTListPricing != null)
                        {
                            //TopologiaVegaATMRRFLYList = new List<StructSmileATMRRFLY>();
                            //StructSmileATMRRFLY _Value = new StructSmileATMRRFLY();
                            //foreach (StructSmileATMRRFLY _Item in TopologiaVegaCALLPUTListPricing)
                            //{
                            //    _Value.Tenor = _Item.Tenor;
                            //    _Value.ATM = _Item.ATM;
                            //    _Value.BF10D = _Item.BF10D;
                            //    _Value.BF25D = _Item.BF25D;
                            //    _Value.RR10D = _Item.Tenor;
                            //}

                            //TopologiaVegaATMRRFLYList = TopologiaVegaCALLPUTListPricing;
                            this.grdTopologiaVegaRRFLY.ItemsSource = this.TopologiaVegaATMRRFLYPricingList;
                        }
                        if (TopologiaVegaATMRRFLYPricingList != null)
                        {
                            //TopologiaVegaCALLPUTList
                            this.grdTopologiaVegaCALLPUT.ItemsSource = TopologiaVegaCALLPUTListPricing;
                        }

                    }
                }

            }
            else
            {
                btnValorizadorCartera.IsEnabled = true;
            }

        }

        //ASVG mejorar.
        void _SrvValorizador_TopologiaVegaCompleted(object sender, AdminOpciones.SrvValorizador.TopologiaVegaCompletedEventArgs e)
        {

            StopLoading(this.CanvasItemTopologiaVega);

            #region Variables
            //StructSmileATMRRFLY row_ATMRRFLY;
            //StructSmileCallPut row_CALLPUT;
            List<StructSmileATMRRFLY> TopologiaVegaATMRRFLYList = new List<StructSmileATMRRFLY>();
            List<StructSmileCallPut> TopologiaVegaCALLPUTList = new List<StructSmileCallPut>();
            TopologiaVegaATMRRFLYList.Clear();
            TopologiaVegaCALLPUTList.Clear();

            StructSmileGeneric row_SmileGeneric;
            List<StructSmileGeneric> TopologiaVegaGenericList = new List<StructSmileGeneric>();

            XDocument TopologiaVegaXML = new XDocument(XDocument.Parse(e.Result));
            int rows, detContratoElements, tenor;
            double MTM_Tolat,MTM_a10,MTM_a25,MTM_atm,MTM_b25,MTM_b10;
            string tag_a10, tag_a25, tag_ATM, tag_b25, tag_b10;
            string _TOPOname = "";

            bool _TOPOtype = ((ComboBoxItem)this.comboTopologiaVega.SelectedItem).Content.Equals("RRFLY");

            #endregion Variables

            #region Tag's
            if ( _TOPOtype )
            {
                _TOPOname = "RRFLY";

                tag_ATM = "ATM";
                tag_a10 = "BF10";
                tag_a25 = "BF25";
                tag_b10 = "RR10";
                tag_b25 = "RR25";
            }
            else
            {
                _TOPOname = "CALLPUT";

                tag_ATM = "ATM";
                tag_a10 = "PUT10";
                tag_a25 = "PUT25";
                tag_b10 = "CALL10";
                tag_b25 = "CALL25";
            }
            #endregion Tag's

            #region seteos
            XElement _TOPO = new XElement(TopologiaVegaXML.Element("TOPOLOGIA").Element(_TOPOname));

            try
            {
                rows = int.Parse(_TOPO.Attribute("rows").Value);
                detContratoElements = int.Parse(_TOPO.Attribute("detContratoElements").Value);
                MTM_Tolat = double.Parse(_TOPO.Attribute("MTMTOTAL").Value);
            }
            catch
            {
                rows = 0;
                detContratoElements = 0;
                MTM_Tolat = 0;
            }
            #endregion seteos

            if (_TOPOtype) { } else { TopologiadelaVegaTotalizador = 0; } //esto estaba...

            #region for grande
            for (int i = 0; i < rows; i++)
            {
                MTM_atm = 0;
                MTM_a10 = 0;
                MTM_a25 = 0;
                MTM_b10 = 0;
                MTM_b25 = 0;

                tenor = int.Parse(_TOPO.Elements("ATM").ElementAt(i).Attribute("tenor").Value);

                #region for chico
                for (int j = 0; j < detContratoElements; j++)
                {
                    try
                    {
#region Parse Comentados
                        //MTM_atm += double.Parse(_TOPO.Elements(tag_ATM).ElementAt(i).Elements("itemTopologiaVega").ElementAt(j).Attribute("MTM").Value);
                        //MTM_PUT10 += double.Parse(_TOPO.Elements(tag_a10).ElementAt(i).Elements("itemTopologiaVega").ElementAt(j).Attribute("MTM").Value);
                        //MTM_PUT25 += double.Parse(_TOPO.Elements(tag_a25).ElementAt(i).Elements("itemTopologiaVega").ElementAt(j).Attribute("MTM").Value);
                        //MTM_CALL10 += double.Parse(_TOPO.Elements(tag_b10).ElementAt(i).Elements("itemTopologiaVega").ElementAt(j).Attribute("MTM").Value);
                        //MTM_CALL25 += double.Parse(_TOPO.Elements(tag_b25).ElementAt(i).Elements("itemTopologiaVega").ElementAt(j).Attribute("MTM").Value);

                        //MTM_ATM += double.Parse(_RRFLY.Elements("ATM").ElementAt(i).Elements("itemTopologiaVega").ElementAt(j).Attribute("MTM").Value);
                        //MTM_RR10 += double.Parse(_RRFLY.Elements("RR10").ElementAt(i).Elements("itemTopologiaVega").ElementAt(j).Attribute("MTM").Value);
                        //MTM_RR25 += double.Parse(_RRFLY.Elements("RR25").ElementAt(i).Elements("itemTopologiaVega").ElementAt(j).Attribute("MTM").Value);
                        //MTM_BF10 += double.Parse(_RRFLY.Elements("BF10").ElementAt(i).Elements("itemTopologiaVega").ElementAt(j).Attribute("MTM").Value);
                        //MTM_BF25 += double.Parse(_RRFLY.Elements("BF25").ElementAt(i).Elements("itemTopologiaVega").ElementAt(j).Attribute("MTM").Value);
#endregion Parse Comentados
                        string _MTM_ATM = _TOPO.Elements(tag_ATM).ElementAt(i).Elements("itemTopologiaVega").ElementAt(j).Attribute("MTM").Value;
                        string _MTM_B10 = _TOPO.Elements(tag_b10).ElementAt(i).Elements("itemTopologiaVega").ElementAt(j).Attribute("MTM").Value;
                        string _MTM_B25 = _TOPO.Elements(tag_b25).ElementAt(i).Elements("itemTopologiaVega").ElementAt(j).Attribute("MTM").Value;
                        string _MTM_A10 = _TOPO.Elements(tag_a10).ElementAt(i).Elements("itemTopologiaVega").ElementAt(j).Attribute("MTM").Value;
                        string _MTM_A25 = _TOPO.Elements(tag_a25).ElementAt(i).Elements("itemTopologiaVega").ElementAt(j).Attribute("MTM").Value;

                        if (_MTM_ATM.Equals("NaN") || _MTM_ATM.Equals("NeuN")) { MTM_atm = 0; } else { MTM_atm += double.Parse(_MTM_ATM); }
                        if (_MTM_B10.Equals("NaN") || _MTM_B10.Equals("NeuN")) { MTM_b10 = 0; } else { MTM_b10 += double.Parse(_MTM_B10); }
                        if (_MTM_B25.Equals("NaN") || _MTM_B25.Equals("NeuN")) { MTM_b25 = 0; } else { MTM_b25 += double.Parse(_MTM_B25); }
                        if (_MTM_A10.Equals("NaN") || _MTM_A10.Equals("NeuN")) { MTM_a10 = 0; } else { MTM_a10 += double.Parse(_MTM_A10); }
                        if (_MTM_A25.Equals("NaN") || _MTM_A25.Equals("NeuN")) { MTM_a25 = 0; } else { MTM_a25 += double.Parse(_MTM_A25); }
                    }
                    catch
                    {
                        System.Windows.Browser.HtmlPage.Window.Alert("OJO: Catch en Topología Vega");
                        //ASVG peligroso.
                        MTM_atm += -MTM_Tolat;
                        MTM_b10 += -MTM_Tolat;
                        MTM_b25 += -MTM_Tolat;
                        MTM_a10 += -MTM_Tolat;
                        MTM_a25 += -MTM_Tolat;
                    }
                }
                #endregion for chico

                row_SmileGeneric = new StructSmileGeneric(_TOPOname, tenor, MTM_a10 - MTM_Tolat, MTM_a25 - MTM_Tolat, MTM_atm - MTM_Tolat, MTM_b25 - MTM_Tolat, MTM_b10 - MTM_Tolat);
                TopologiaVegaGenericList.Add(row_SmileGeneric);

                //funciona: row_ATMRRFLY = row_SmileGeneric;

                if (_TOPOtype)
                {
                    //agregar acá los elementos
                    TopologiaVegaATMRRFLYList.Add(row_SmileGeneric); // = (List<StructSmileATMRRFLY>)TopologiaVegaGenericList;
                }
                else
                {
                    TopologiaVegaCALLPUTList.Add(row_SmileGeneric); // = TopologiaVegaGenericList;

                    TopologiadelaVegaTotalizador += MTM_atm - MTM_Tolat;
                    TopologiadelaVegaTotalizador += MTM_a10 - MTM_Tolat;
                    TopologiadelaVegaTotalizador += MTM_a25 - MTM_Tolat;
                    TopologiadelaVegaTotalizador += MTM_b10 - MTM_Tolat;
                    TopologiadelaVegaTotalizador += MTM_b25 - MTM_Tolat;
                }
            }
            #endregion for grande

            if (_TOPOtype)
            {
                #region check RR

                if (checkTopologiaPricing.IsChecked.Value)
                {
                    if (TopologiaVegaATMRRFLYPricingList != null && TopologiaVegaATMRRFLYPricingList.Count > 0 && TopologiaVegaATMRRFLYList != null && TopologiaVegaATMRRFLYList.Count > 0)
                    {
                        for (int i = 0; i < TopologiaVegaATMRRFLYPricingList.Count; i++)
                        {
                            TopologiaVegaATMRRFLYList[i].ATM += TopologiaVegaATMRRFLYPricingList[i].ATM;
                            TopologiaVegaATMRRFLYList[i].BF10D += TopologiaVegaATMRRFLYPricingList[i].BF10D;
                            TopologiaVegaATMRRFLYList[i].BF25D += TopologiaVegaATMRRFLYPricingList[i].BF25D;
                            TopologiaVegaATMRRFLYList[i].RR10D += TopologiaVegaATMRRFLYPricingList[i].RR10D;
                            TopologiaVegaATMRRFLYList[i].RR25D += TopologiaVegaATMRRFLYPricingList[i].RR25D;
                        }
                    }
                    else
                    {
                        if (TopologiaVegaATMRRFLYPricingList == null || TopologiaVegaATMRRFLYPricingList.Count == 0)
                        {
                            System.Windows.Browser.HtmlPage.Window.Alert("No existe Topologia Vega para Pricing ");
                            this.checkTopologiaPricing.IsChecked = false;
                        }
                    }
                }
                #endregion check RR

                this.grdTopologiaVegaRRFLY.ItemsSource = null;
                this.grdTopologiaVegaRRFLY.ItemsSource = TopologiaVegaGenericList;// TopologiaVegaATMRRFLYList;
            }
            else
            {
                #region check CP

                if (checkTopologiaPricing.IsChecked.Value)
                {
                    if (TopologiaVegaCALLPUTListPricing != null && TopologiaVegaCALLPUTListPricing.Count > 0 && TopologiaVegaCALLPUTList != null && TopologiaVegaCALLPUTList.Count > 0)
                    {
                        for (int i = 0; i < TopologiaVegaATMRRFLYPricingList.Count; i++)
                        {
                            TopologiaVegaCALLPUTList[i].Atm += TopologiaVegaCALLPUTListPricing[i].Atm;
                            TopologiaVegaCALLPUTList[i].Call10 += TopologiaVegaCALLPUTListPricing[i].Call10;
                            TopologiaVegaCALLPUTList[i].Call25 += TopologiaVegaCALLPUTListPricing[i].Call25;
                            TopologiaVegaCALLPUTList[i].Put10 += TopologiaVegaCALLPUTListPricing[i].Put10;
                            TopologiaVegaCALLPUTList[i].Put25 += TopologiaVegaCALLPUTListPricing[i].Put25;
                        }

                    }
                    else
                    {
                        if (TopologiaVegaCALLPUTListPricing == null || TopologiaVegaCALLPUTListPricing.Count == 0)
                        {
                            System.Windows.Browser.HtmlPage.Window.Alert("No existe Topologia Vega para Pricing ");
                            this.checkTopologiaPricing.IsChecked = false;
                        }
                    }
                }

                #endregion check CP

                this.grdTopologiaVegaCALLPUT.ItemsSource = null;
                this.grdTopologiaVegaCALLPUT.ItemsSource = TopologiaVegaGenericList;// TopologiaVegaCALLPUTList;
            }

            #region Check Final

            if (checkTopologiaPricing.IsChecked.Value)
            {
                if (TopologiaVegaATMRRFLYPricingList != null && TopologiaVegaATMRRFLYPricingList.Count > 0
                    && TopologiaVegaCALLPUTListPricing != null && TopologiaVegaCALLPUTListPricing.Count > 0
                    && TopologiaVegaCALLPUTList.Count == 0
                    && TopologiaVegaATMRRFLYList.Count == 0)
                {
                    grdTopologiaVegaRRFLY.ItemsSource = null;
                    grdTopologiaVegaRRFLY.ItemsSource = TopologiaVegaATMRRFLYPricingList;

                    grdTopologiaVegaCALLPUT.ItemsSource = null;
                    grdTopologiaVegaCALLPUT.ItemsSource = TopologiaVegaCALLPUTListPricing;
                }
            }
            else if (TopologiaVegaCALLPUTList.Count == 0 && TopologiaVegaATMRRFLYList.Count == 0)
            {
                grdTopologiaVegaRRFLY.ItemsSource = null;
                grdTopologiaVegaCALLPUT.ItemsSource = null;

            }
            btnValorizadorCartera.IsEnabled = true;

            #endregion Check Final
        }

        private void event_btnTopologiaVega_Clicked(object sender, RoutedEventArgs e)
        {
            isTopologiaVegaClicked = true;
            btnValorizadorCartera.IsEnabled = false;
            LoadTopologiaVega();
        }

        private void LoadTopologiaVega()
        {
            if (MtMGriegasTotalizador != null && isCarteraValorizada && !isEncOrDetCheck_Clicked && DetContratoList.Count > 0)
            {
                if (this.MtMGriegasTotalizador != null && ((ComboBoxItem)comboTopologiaVega.SelectedItem).Content.Equals("RRFLY"))
                {
                    TopologiaVega(this.MtMGriegasTotalizador[0].MtM, "rrfly");
                    isTopologiaVegaClicked = false;

                }
                else if (this.MtMGriegasTotalizador != null && ((ComboBoxItem)comboTopologiaVega.SelectedItem).Content.Equals("Call Put") && DetContratoList.Count > 0)
                {
                    TopologiaVega(this.MtMGriegasTotalizador[0].MtM, "callput");
                    isTopologiaVegaClicked = false;
                }
            }
            else
            {
                if (DetContratoList != null && DetContratoList.Count > 0)
                {
                    StartLoading(CanvasItemTopologiaVega);
                    ValorizadorCartera();
                }
                else
                {
                    if (btnTopoLogiaVegaPricing.IsEnabled && checkTopologiaPricing.IsChecked.Value)
                    {
                        this.grdTopologiaVegaCALLPUT.ItemsSource = TopologiaVegaCALLPUTListPricing;
                        this.grdTopologiaVegaRRFLY.ItemsSource = TopologiaVegaATMRRFLYPricingList;
                        btnValorizadorCartera.IsEnabled = true;
                    }
                    else
                    {
                        this.grdTopologiaVegaCALLPUT.ItemsSource = null;
                        this.grdTopologiaVegaRRFLY.ItemsSource = null;
                        btnValorizadorCartera.IsEnabled = true;
                    }
                }
            }
        }

        private void event_comboTopologiaVega_SelectedChanged(object sender, SelectionChangedEventArgs e)
        {
            if (comboTopologiaVega != null)
            {
                if (((ComboBoxItem)comboTopologiaVega.SelectedItem).Content.Equals("RRFLY"))
                {
                    grdTopologiaVegaRRFLY.Visibility = Visibility.Visible;
                    grdTopologiaVegaCALLPUT.Visibility = Visibility.Collapsed;

                }
                else
                {
                    grdTopologiaVegaRRFLY.Visibility = Visibility.Collapsed;
                    grdTopologiaVegaCALLPUT.Visibility = Visibility.Visible;
                }
            }

        }

        private void TopologiaVegaPricing(string input, double MtM, string rrfly_callput, int SetPricing)
        {
            //string Smile = CreateSmileXML();

            SrvValorizador.SrvValorizadorCarteraSoapClient _SrvValorizador_TopologiaPricing = wsGlobales.Valorizador;//new AdminOpciones.SrvValorizador.SrvValorizadorCarteraSoapClient();
            _SrvValorizador_TopologiaPricing.TopologiaVegaCompleted += new EventHandler<AdminOpciones.SrvValorizador.TopologiaVegaCompletedEventArgs>(_SrvValorizador_TopologiaPricing_TopologiaVegaCompleted);
            _SrvValorizador_TopologiaPricing.TopologiaVegaAsync(BsSpot_BsFwd_AsianMomentos_flag, input, FechaSetdePrecios, MtM, rrfly_callput, SetPricing);

            TopologiaVegaCALLPUTListPricing = null;
            TopologiaVegaATMRRFLYPricingList = null;
        }

        void _SrvValorizador_TopologiaPricing_TopologiaVegaCompleted(object sender, AdminOpciones.SrvValorizador.TopologiaVegaCompletedEventArgs e)
        {
            try
            {
                XDocument TopologiaVegaXML = new XDocument(XDocument.Parse(e.Result));

                if (TopologiaVegaXML.Element("TOPOLOGIA").Attribute("Name").Value.Equals("RRFLY"))
                {
                    #region RRFLY

                    TopologiaVegaATMRRFLYPricingList = new List<StructSmileATMRRFLY>();

                    XElement _RRFLY = new XElement(TopologiaVegaXML.Element("TOPOLOGIA").Element("RRFLY"));

                    int rows, detContratoElements;
                    double MTM_Tolat;
                    try
                    {
                        rows = int.Parse(_RRFLY.Attribute("rows").Value);
                        detContratoElements = int.Parse(_RRFLY.Attribute("detContratoElements").Value);
                        MTM_Tolat = double.Parse(_RRFLY.Attribute("MTMTOTAL").Value);
                    }
                    catch
                    {
                        System.Windows.Browser.HtmlPage.Window.Alert("no viene RRFLY");
                        rows = 0;
                        detContratoElements = 0;
                        MTM_Tolat = 0;
                    }

                    int tenor;

                    StructSmileATMRRFLY row_ATMRRFLY;

                    double MTM_ATM, MTM_RR10, MTM_RR25, MTM_BF10, MTM_BF25;

                    for (int i = 0; i < rows; i++)
                    {
                        MTM_ATM = 0;
                        MTM_RR10 = 0;
                        MTM_RR25 = 0;
                        MTM_BF10 = 0;
                        MTM_BF25 = 0;

                        tenor = int.Parse(_RRFLY.Elements("ATM").ElementAt(i).Attribute("tenor").Value);

                        for (int j = 0; j < detContratoElements; j++)
                        {
                            MTM_ATM += double.Parse(_RRFLY.Elements("ATM").ElementAt(i).Elements("itemTopologiaVega").ElementAt(j).Attribute("MTM").Value);
                            MTM_RR10 += double.Parse(_RRFLY.Elements("RR10").ElementAt(i).Elements("itemTopologiaVega").ElementAt(j).Attribute("MTM").Value);
                            MTM_RR25 += double.Parse(_RRFLY.Elements("RR25").ElementAt(i).Elements("itemTopologiaVega").ElementAt(j).Attribute("MTM").Value);
                            MTM_BF10 += double.Parse(_RRFLY.Elements("BF10").ElementAt(i).Elements("itemTopologiaVega").ElementAt(j).Attribute("MTM").Value);
                            MTM_BF25 += double.Parse(_RRFLY.Elements("BF25").ElementAt(i).Elements("itemTopologiaVega").ElementAt(j).Attribute("MTM").Value);
                        }
                        row_ATMRRFLY = new StructSmileATMRRFLY(tenor, MTM_ATM - MTM_Tolat, MTM_RR25 - MTM_Tolat, MTM_BF25 - MTM_Tolat, MTM_RR10 - MTM_Tolat, MTM_BF10 - MTM_Tolat);

                        //Total+= (MTM_ATM - MTM_Tolat)+ (MTM_RR25 - MTM_Tolat)+(MTM_BF25 - MTM_Tolat)+( MTM_RR10 - MTM_Tolat)+( MTM_BF10 - MTM_Tolat);

                        TopologiaVegaATMRRFLYPricingList.Add(row_ATMRRFLY);
                    }

                    TopologiaVegaNew();

                    //Thread t = new Thread(new ThreadStart(() =>
                    //{
                    //    Thread.Sleep(1000);

                    //}));
                    //t.Start(); 

                    #endregion RRFLY

                    #region Smile

                    #region Volatilidades

                    TopologiaVegaVolatibilidadesPricingList = new List<StructSmileATMRRFLY>();

                    var _TopoVol = from _item in TopologiaVegaXML.Element("TOPOLOGIA").Element("DataSmile").Element("ATMRRFLY").Descendants("itemATMRRFLY")
                                   select new StructSmileATMRRFLY
                                   {
                                       Tenor = int.Parse(_item.Attribute("TENOR").Value),
                                       ATM = double.Parse(_item.Attribute("ATM").Value),
                                       BF10D = double.Parse(_item.Attribute("BF10D").Value),
                                       RR10D = double.Parse(_item.Attribute("RR10D").Value),
                                       BF25D = double.Parse(_item.Attribute("RR25D").Value),
                                       RR25D = double.Parse(_item.Attribute("BF25D").Value),
                                   };
                    TopologiaVegaVolatibilidadesPricingList = _TopoVol.ToList();

                    #endregion Volatilidades

                    #region Strikes

                    TopologiaVegaStrikesPricing = new List<StructSmileCallPut>();

                    var _TopoStrikes = from _item in TopologiaVegaXML.Element("TOPOLOGIA").Element("DataSmile").Element("STRIKES").Descendants("itemSTRIKES")
                                       select new StructSmileCallPut
                                       {
                                           Tenor = int.Parse(_item.Attribute("TENOR").Value),
                                           Atm = double.Parse(_item.Attribute("ATM").Value),
                                           Put10 = double.Parse(_item.Attribute("PUT10D").Value),
                                           Call10 = double.Parse(_item.Attribute("CALL10D").Value),
                                           Put25 = double.Parse(_item.Attribute("PUT25D").Value),
                                           Call25 = double.Parse(_item.Attribute("CALL25D").Value),
                                       };
                    TopologiaVegaStrikesPricing = _TopoStrikes.ToList();

                    #endregion Strikes

                    this._TopologiaVegaPricingControl.grdTopologiaVolatilidadesPricing.ItemsSource = TopologiaVegaVolatibilidadesPricingList;
                    this._TopologiaVegaPricingControl.grdTopologiaVegaStrikesPricing.ItemsSource = TopologiaVegaStrikesPricing;

                    #endregion Smile
                }
                else
                {
                    #region Call/Put

                    TopologiaVegaCALLPUTListPricing = new List<StructSmileCallPut>();


                    XElement _CALLPUT = new XElement(TopologiaVegaXML.Element("TOPOLOGIA").Element("CALLPUT"));

                    int rows, detContratoElements;
                    double MTM_Tolat;
                    try
                    {
                        rows = int.Parse(_CALLPUT.Attribute("rows").Value);
                        detContratoElements = int.Parse(_CALLPUT.Attribute("detContratoElements").Value);
                        MTM_Tolat = double.Parse(_CALLPUT.Attribute("MTMTOTAL").Value);
                    }
                    catch
                    {
                        System.Windows.Browser.HtmlPage.Window.Alert("no viene CALLPUT");
                        rows = 0;
                        detContratoElements = 0;
                        MTM_Tolat = 0;
                    }

                    int tenor;

                    StructSmileCallPut row_CALLPUT;

                    double MTM_ATM, MTM_PUT10, MTM_PUT25, MTM_CALL10, MTM_CALL25;
                    TopologiadelaVegaTotalizador = 0;

                    for (int i = 0; i < rows; i++)
                    {
                        MTM_ATM = 0;
                        MTM_PUT10 = 0;
                        MTM_PUT25 = 0;
                        MTM_CALL10 = 0;
                        MTM_CALL25 = 0;

                        tenor = int.Parse(_CALLPUT.Elements("ATM").ElementAt(i).Attribute("tenor").Value);

                        for (int j = 0; j < detContratoElements; j++)
                        {
                            MTM_ATM += double.Parse(_CALLPUT.Elements("ATM").ElementAt(i).Elements("itemTopologiaVega").ElementAt(j).Attribute("MTM").Value);
                            MTM_PUT10 += double.Parse(_CALLPUT.Elements("PUT10").ElementAt(i).Elements("itemTopologiaVega").ElementAt(j).Attribute("MTM").Value);
                            MTM_PUT25 += double.Parse(_CALLPUT.Elements("PUT25").ElementAt(i).Elements("itemTopologiaVega").ElementAt(j).Attribute("MTM").Value);
                            MTM_CALL10 += double.Parse(_CALLPUT.Elements("CALL10").ElementAt(i).Elements("itemTopologiaVega").ElementAt(j).Attribute("MTM").Value);
                            MTM_CALL25 += double.Parse(_CALLPUT.Elements("CALL25").ElementAt(i).Elements("itemTopologiaVega").ElementAt(j).Attribute("MTM").Value);
                        }
                        row_CALLPUT = new StructSmileCallPut(tenor, MTM_PUT10 - MTM_Tolat, MTM_PUT25 - MTM_Tolat, MTM_ATM - MTM_Tolat, MTM_CALL25 - MTM_Tolat, MTM_CALL10 - MTM_Tolat);

                        TopologiaVegaCALLPUTListPricing.Add(row_CALLPUT);

                    }

                    TopologiaVegaNew();

                    //Thread t = new Thread(new ThreadStart(() => 
                    //{            
                    //    Thread.Sleep(1000);

                    //}
                    //));
                    //t.Start(); 

                    #endregion Call/Put
                }

                if (
                     (TopologiaVegaCALLPUTListPricing != null && TopologiaVegaCALLPUTListPricing.Count > 0)
                    &&
                     (TopologiaVegaATMRRFLYPricingList != null && TopologiaVegaATMRRFLYPricingList.Count > 0)
                    )
                {
                    btnTopoLogiaVegaPricing.IsEnabled = true;
                }
                else
                {
                    //string topomsg = "Topología Vega: ";
                    //if(TopologiaVegaCALLPUTListPricing == null) topomsg += "CALLPUT null";
                    //else if(TopologiaVegaCALLPUTListPricing.Count <= 0) topomsg += "CALLPUT vacío";

                    //if(TopologiaVegaATMRRFLYPricingList == null) topomsg += "RRFLY null ";
                    //else if(TopologiaVegaATMRRFLYPricingList.Count <= 0) topomsg += "RRFLY vacío";

                    //System.Windows.Browser.HtmlPage.Window.Alert(topomsg);
                    btnTopoLogiaVegaPricing.IsEnabled = true;
                }
            }
            catch
            {
                //this._TopologiaVegaPricingControl.grdTopologiaVegaCALLPUTPricing.ItemsSource = null;
                //this._TopologiaVegaPricingControl.grdTopologiaVegaRRFLYPricing.ItemsSource = null;

                TopologiaVegaCALLPUTListPricing = null;
                TopologiaVegaATMRRFLYPricingList = null;

                btnTopoLogiaVegaPricing.IsEnabled = false;
            }

            //throw new NotImplementedException();
        }
        
        #endregion Topología

        #region SendId
        private void event_SendChecked_Enc()
        {
            isEncOrDetCheck_Clicked = true;
        }

        private void event_SendChecked_Det()
        {
            isEncOrDetCheck_Clicked = true;
        }

        private void event_SendID_Det(int ID)
        {
            this.ClearData();
            IsLoading = true;
            ValidAmount _Value = new ValidAmount();

            try
            {
                isOpcionFromCartera = true;
                StructDetContrato _detContrato = this.DetContratoList[ID];
                StructEncContrato _encContrato = this.EncContratoList.First(x => x.NumContrato.Equals(_detContrato.NumContrato));

                _opcionEstructuraSeleccionada.Check = false;
                _opcionEstructuraSeleccionada.Codigo = _encContrato.CodEstructura.ToString();
                _opcionEstructuraSeleccionada.Descripcion = _encContrato.Estructura;
                _opcionEstructuraSeleccionada.Valor = 0.0;

                if (_encContrato.CodEstructura.Equals(8)) //PRD_7274 ASVG_2111202
                {
                    #region Forward Americano

                    isOpcionFromCartera = true;

                    List<StructDetContrato> _DetContratoList = this.DetContratoList.Where(x => x.NumContrato.Equals(_encContrato.NumContrato)).OrderBy(x => x.NumEstructura).ToList<StructDetContrato>();
                    List<StructFixingDataContrato> _FixingSelected = this.FijacionesList.Where(x => x.NumContrato.Equals(_encContrato.NumContrato)).ToList<StructFixingDataContrato>();

                    List<StructFixingDataContrato> _fixingList = new List<StructFixingDataContrato>();

                    this.txtSetdePrecios_Pricing.Text = ((ComboBoxItem)this.comboSetPrecios.SelectedItem).Content.ToString();

                    this.txtPuntosCosto.Text = "";
                    PuntosCosto = double.NaN;

                    this.itemTabSrikes.IsSelected = true;

                    Type _radioButtonType;
                    List<UIElement> _UIElementList;
                    List<RadioButton> _RadioButtonList;
                    RadioButton _radioTemp;

                    globales._NumContrato = _encContrato.NumContrato;
                    globales._NumFolio = _encContrato.NumFolio;

                    _Guardar.NumeroContrato = _encContrato.NumContrato;
                    _Guardar.NumeroFolio = _encContrato.NumFolio;

                    //5843
                    _Value.DecimalPlaces = 0;
                    _Value.SetChange(this.txtResultadoVta, _encContrato.ResultadoVta);
                    this.ResultVenta = _encContrato.ResultadoVta;

                    _detContrato = _DetContratoList.First(x => x.NumContrato.Equals(_encContrato.NumContrato));

                    if (_detContrato.CallPut.Equals("PUT"))
                    {
                        this.radioCompra.IsChecked = true;
                    }
                    else
                    {
                        this.radioVenta.IsChecked = true;
                    }

                    _radioButtonType = (new RadioButton()).GetType();

                    _UIElementList = (this.stackOpciones.Children.ToList<UIElement>()).Where(x => x.GetType().Equals(_radioButtonType)).ToList<UIElement>();

                    _RadioButtonList = new List<RadioButton>();

                    foreach (UIElement _radioButtonElement in _UIElementList)
                    {
                        RadioButton _radio = _radioButtonElement as RadioButton;
                        _RadioButtonList.Add(_radio);
                    }

                    _radioTemp = _RadioButtonList.First(x => x.Content.Equals(OpcionesEstructuraList.First(op => op.Codigo.Equals(_encContrato.CodEstructura.ToString())).Descripcion));

                    _radioTemp.IsChecked = true;

                    this.opcionContrato = OpcionesEstructuraList.First(x => x.Codigo.Equals(_encContrato.CodEstructura.ToString())).Descripcion;

                    this.itemTabSrikes.IsSelected = true;
                    strikes_delta_flag = "strikes";

                    this.txtPlazo.Text = _detContrato.FechaVcto.Subtract(this.datePiker_DateProccess.SelectedDate.Value).Days.ToString() + "d";
                    this.DatePickerVencimiento.SelectedDate = _detContrato.FechaVcto;
                    this.fechaVencimiento = _detContrato.FechaVcto;

                    this.comboPayOff.SelectedIndex = 0;

                    (this.comboBsFwdBsSpotAsianMomenos.Items[0] as ComboBoxItem).IsEnabled = true;
                    (this.comboBsFwdBsSpotAsianMomenos.Items[1] as ComboBoxItem).IsEnabled = true;
                    (this.comboBsFwdBsSpotAsianMomenos.Items[2] as ComboBoxItem).IsEnabled = false;
                    this.comboBsFwdBsSpotAsianMomenos.SelectedIndex = 1;
                    this.radioEntregaFisica.IsEnabled = true;

                    comboEjercicio.SelectedIndex = 2;

                    _Value.DecimalPlaces = 0;
                    _Value.SetChange(this.txtPrimaContrato, _encContrato.PrimaInicial);
                    this.PrimaContrato = _encContrato.PrimaInicial;

                    _Value.DecimalPlaces = 0;
                    _Value.SetChange(this.txtNocional, _detContrato.MontoMon1);
                    this.nocional = _detContrato.MontoMon1;

                    _Value.DecimalPlaces = 2;
                    _Value.SetChange(this.txtStrike1, _detContrato.Strike);
                    this.strike = _detContrato.Strike;

                    _Value.DecimalPlaces = 2;
                    _Value.SetChange(this.txtNocionalContraMoneda, (this.strike * this.nocional));
                    this.txtStrike1.Focus();

                    _Value.DecimalPlaces = 4;
                    _Value.SetChange(this.txtSpotCosto, this.BSSpotValorizacion);
                    this.spot = this.BSSpotValorizacion;

                    _Value.DecimalPlaces = 0;
                    _Value.SetChange(this.txtPrimaContrato, 0);
                    valtxtPrimaContrato.DecimalPlaces = _Value.DecimalPlaces;

                    this.ComboUnidadPrima.SelectedIndex = 0;

                    this.ParidadPrima = 0; // _encContrato.ParMdaPrima;
                    _Value.DecimalPlaces = 4;
                    _Value.SetChange(this.txtParidadPrima, 0);

                    if (_DetContratoList[0].Modalidad)
                    {
                        this.radioCompensacion.IsChecked = true;
                        this.radioEntregaFisica.IsChecked = false;
                    }
                    else
                    {
                        this.radioEntregaFisica.IsChecked = true;
                        this.radioCompensacion.IsChecked = false;
                    }

                    txtNocional.Focus();
                    txtSpotCosto.Focus();
                    itemFrontOpciones.Focus();

                    this.tabPrincipal.SelectedIndex = 0;
                    this.isTextChanged = true;

                    try
                    {
                        Valorizar();
                    }
                    catch { }

                    #endregion
                    btnSensibilidadPricing.Content = "  Sensibilidad";
                    checkboxSensitivity.Visibility = Visibility.Visible;
                }
                else
                {
                    StructFixingDataContrato _FixingSelected = this.FijacionesList.First(x => x.NumContrato.Equals(_detContrato.NumContrato) && x.NucEstructura.Equals(_detContrato.NumEstructura));

                    StructFixingDataContrato _fixingTable = new StructFixingDataContrato(_FixingSelected);

                    this.txtPuntosCosto.Text = "";
                    PuntosCosto = double.NaN;

                    this._TablaFixing.Cargar(_fixingTable.Fijaciones, true);

                    this.txtSetdePrecios_Pricing.Text = ((ComboBoxItem)this.comboSetPrecios.SelectedItem).Content.ToString();

                    this.itemTabSrikes.IsSelected = true;

                    if (_detContrato.CVOpc.Equals("C"))
                    {
                        this.radioCompra.IsChecked = true;
                    }
                    else
                    {
                        this.radioVenta.IsChecked = true;
                    }

                    if (_detContrato.CallPut.Equals("Call"))
                    {
                        this.radioOpcCall.IsChecked = true;
                    }
                    else
                    {
                        this.radioOpcPut.IsChecked = true;
                    }

                    this.itemTabSrikes.IsSelected = true;
                    strikes_delta_flag = "strikes";

                    this.txtPlazo.Text = _detContrato.FechaVcto.Subtract(this.datePiker_DateProccess.SelectedDate.Value).Days.ToString() + "d";
                    this.DatePickerVencimiento.SelectedDate = _detContrato.FechaVcto;
                    this.fechaVencimiento = _detContrato.FechaVcto;

                    if (_detContrato.TipoPayOff.Equals("01"))//Vanilla
                    {
                        this.comboPayOff.SelectedIndex = 0;

                        (this.comboBsFwdBsSpotAsianMomenos.Items[0] as ComboBoxItem).IsEnabled = true;
                        (this.comboBsFwdBsSpotAsianMomenos.Items[1] as ComboBoxItem).IsEnabled = true;
                        (this.comboBsFwdBsSpotAsianMomenos.Items[2] as ComboBoxItem).IsEnabled = false;
                        this.comboBsFwdBsSpotAsianMomenos.SelectedIndex = 1;
                        this.radioEntregaFisica.IsEnabled = true;
                    }
                    else
                    {
                        this.comboPayOff.SelectedIndex = 1;

                        (this.comboBsFwdBsSpotAsianMomenos.Items[0] as ComboBoxItem).IsEnabled = false;
                        (this.comboBsFwdBsSpotAsianMomenos.Items[1] as ComboBoxItem).IsEnabled = false;
                        (this.comboBsFwdBsSpotAsianMomenos.Items[2] as ComboBoxItem).IsEnabled = true;
                        this.comboBsFwdBsSpotAsianMomenos.SelectedIndex = 2;

                        this.radioCompensacion.IsChecked = true;
                        this.radioEntregaFisica.IsEnabled = false;

                        this._TablaFixing.comboFrecuencia.SelectedIndex = 4;
                        this._TablaFixing.comboTipoPeso.SelectedIndex = 2;
                        _TablaFixing.isEditing = true;
                        if (_detContrato.CodEstructura == 9 || _detContrato.CodEstructura == 10)
                        {
                            //setea el intervalo de fixing correspondiente a la fecha elegida
                            this._TablaFixing.datePikerInicio.SelectedDate = _fixingTable.Fijaciones[0].Fecha;
                        }
                        else
                        {
                            this._TablaFixing.datePikerInicio.SelectedDate = _encContrato.FechaContrato;
                        }

                        this._TablaFixing.datePikerFin.SelectedDate = _fixingTable.Fijaciones[_fixingTable.Fijaciones.Count - 1].Fecha;
                        _TablaFixing.isEditing = false;

                        this._TablaFixing.checkSantiago.IsChecked = true;
                        this._TablaFixing.Town = 2;

                        this._TablaFixing.strike = _detContrato.Strike;
                        this._TablaFixing.spot = this.BSSpotValorizacion;
                    }

                    if (_detContrato.Modalidad)
                    {
                        this.radioCompensacion.IsChecked = true;
                    }
                    else
                    {
                        this.radioEntregaFisica.IsChecked = true;
                    }

                    this.PrimaContrato = _encContrato.PrimaInicial;

                    _Value.DecimalPlaces = 0;
                    _Value.SetChange(this.txtNocional, _detContrato.MontoMon1);
                    this.nocional = _detContrato.MontoMon1;

                    _Value.DecimalPlaces = 2;
                    if (_encContrato.CodEstructura.Equals(13)) //PRD_12567
                    {
                        _Value.SetChange(this.txtStrike1, _detContrato.PorcStrike);
                        this.strike = _detContrato.PorcStrike;
                    }
                    else
                    {
                        _Value.SetChange(this.txtStrike1, _detContrato.Strike);
                        this.strike = _detContrato.Strike;
                    }

                    _Value.DecimalPlaces = 0;
                    _Value.SetChange(this.txtNocionalContraMoneda, (this.strike * this.nocional));
                    this.txtNocionalContraMoneda.Focus();

                    _Value.DecimalPlaces = 4;
                    _Value.SetChange(this.txtSpotCosto, this.BSSpotValorizacion);
                    this.spot = this.BSSpotValorizacion;

                    _Value.DecimalPlaces = _encContrato.CodMonPagPrima.Equals(13) ? 2 : 0;
                    _Value.SetChange(this.txtPrimaContrato, _encContrato.PrimaInicial);

                    valtxtPrimaContrato.DecimalPlaces = _Value.DecimalPlaces;

                    if (_encContrato.CodMonPagPrima.Equals(13))
                    {
                        this.ComboUnidadPrima.SelectedIndex = 1;
                    }
                    else
                    {
                        this.ComboUnidadPrima.SelectedIndex = 0;
                    }

                    this.ParidadPrima = double.Parse(this.txtSpotValorizacion.Text); //_encContrato.ParMdaPrima;
                    _Value.DecimalPlaces = 4;
                    _Value.SetChange(this.txtParidadPrima, _encContrato.ParMdaPrima);

                    this.txtStrike1.Focus();
                    txtNocional.Focus();
                    txtSpotCosto.Focus();
                    itemFrontOpciones.Focus();

                    this.tabPrincipal.SelectedIndex = 0;
                    this.isTextChanged = true;
                    try
                    {
                        Valorizar();
                    }
                    catch { }
                }
            }
            catch
            {
                isOpcionFromCartera = false;
            }

            IsLoading = false;
        }

        private void event_SendID_Enc(int ID)
        {
            this.ClearData();
            IsLoading = true;
            ValidAmount _Value = new ValidAmount();

            //MEJORAR
            ID_Contrato = ID;

            try
            {
                isOpcionFromCartera = true;
                StructEncContrato _encContrato = this.EncContratoList[ID];
                List<StructDetContrato> _DetContratoList = this.DetContratoList.Where(x => x.NumContrato.Equals(_encContrato.NumContrato)).OrderBy(x => x.NumEstructura).ToList<StructDetContrato>();
                List<StructFixingDataContrato> _FixingSelected = this.FijacionesList.Where(x => x.NumContrato.Equals(_encContrato.NumContrato)).ToList<StructFixingDataContrato>();

                List<StructFixingDataContrato> _fixingList = new List<StructFixingDataContrato>();
                foreach (StructFixingDataContrato _Item in _FixingSelected)
                {
                    _fixingList.Add(new StructFixingDataContrato(_Item));
                }

                _opcionEstructuraSeleccionada.Check = false;
                _opcionEstructuraSeleccionada.Codigo = _encContrato.CodEstructura.ToString();
                _opcionEstructuraSeleccionada.Descripcion = _encContrato.Estructura;
                _opcionEstructuraSeleccionada.Valor = 0.0;

                StructDetContrato _detContrato;

                this.txtSetdePrecios_Pricing.Text = ((ComboBoxItem)this.comboSetPrecios.SelectedItem).Content.ToString();

                this.txtPuntosCosto.Text = "";
                PuntosCosto = double.NaN;

                //Permite cargar solo una de las tabla de fijacion, es decir, todos los componentes tienen la misma tabla de fijaciones. (Concuerda con pantalla pricing)
                this._TablaFixing.Cargar(_fixingList[0].Fijaciones.Where(_Element => _Element.Peso > 0).ToList(), true);//PRD_12567

                if (_encContrato.CodEstructura.Equals(13))
                {
                    this._TablaFixing.CargarEntrada(_fixingList[0].Fijaciones.Where(_Element => _Element.Peso < 0).ToList(), true);//PRD_12567
                    this._TablaFixing.TabEntrada.Visibility = Visibility.Visible;//PRD_12567
                }
                this.itemTabSrikes.IsSelected = true;

                Type _radioButtonType;
                List<UIElement> _UIElementList;
                List<RadioButton> _RadioButtonList;
                RadioButton _radioTemp;

                globales._NumContrato = _encContrato.NumContrato;
                globales._NumFolio = _encContrato.NumFolio;

                _Guardar.NumeroContrato = _encContrato.NumContrato;
                _Guardar.NumeroFolio = _encContrato.NumFolio;

                //5843
                _Value.DecimalPlaces = 0;
                _Value.SetChange(this.txtResultadoVta, _encContrato.ResultadoVta);
                this.ResultVenta = _encContrato.ResultadoVta;
                btnTopoLogiaVegaPricing.IsEnabled = true;

                if (_encContrato.CodEstructura.Equals(0))
                {
                    #region Estructura individual

                    _detContrato = _DetContratoList.First(x => x.NumContrato.Equals(_encContrato.NumContrato));

                    SetRadioCompraVenta(_detContrato.CVOpc);

                    if (_detContrato.CallPut.Equals("Call"))
                    {
                        this.radioOpcCall.IsChecked = true;
                    }
                    else
                    {
                        this.radioOpcPut.IsChecked = true;
                    }

                    this.itemTabSrikes.IsSelected = true;
                    strikes_delta_flag = "strikes";

                    this.txtPlazo.Text = _detContrato.FechaVcto.Subtract(this.datePiker_DateProccess.SelectedDate.Value).Days.ToString() + "d";
                    this.DatePickerVencimiento.SelectedDate = _detContrato.FechaVcto;
                    this.fechaVencimiento = _detContrato.FechaVcto;

                    if (_detContrato.TipoPayOff.Equals("01"))//Vanilla
                    {
                        this.comboPayOff.SelectedIndex = 0;

                        (this.comboBsFwdBsSpotAsianMomenos.Items[0] as ComboBoxItem).IsEnabled = true;
                        (this.comboBsFwdBsSpotAsianMomenos.Items[1] as ComboBoxItem).IsEnabled = true;
                        (this.comboBsFwdBsSpotAsianMomenos.Items[2] as ComboBoxItem).IsEnabled = false;
                        this.comboBsFwdBsSpotAsianMomenos.SelectedIndex = 1;
                        this.radioEntregaFisica.IsEnabled = true;
                    }
                    else
                    {
                        this.comboPayOff.SelectedIndex = 1;

                        (this.comboBsFwdBsSpotAsianMomenos.Items[0] as ComboBoxItem).IsEnabled = false;
                        (this.comboBsFwdBsSpotAsianMomenos.Items[1] as ComboBoxItem).IsEnabled = false;
                        (this.comboBsFwdBsSpotAsianMomenos.Items[2] as ComboBoxItem).IsEnabled = true;
                        this.comboBsFwdBsSpotAsianMomenos.SelectedIndex = 2;

                        this._TablaFixing.comboFrecuencia.SelectedIndex = 4;
                        this._TablaFixing.comboTipoPeso.SelectedIndex = 2;

                        _TablaFixing.isEditing = true;
                        this._TablaFixing.datePikerInicio.SelectedDate = _fixingList[0].Fijaciones[0].Fecha; //_encContrato.FechaContrato;
                        this._TablaFixing.datePikerFin.SelectedDate = _fixingList[0].Fijaciones[_fixingList[0].Fijaciones.Count - 1].Fecha;
                        _TablaFixing.isEditing = false;

                        this._TablaFixing.checkSantiago.IsChecked = true;
                        this._TablaFixing.Town = 2;

                        this.radioEntregaFisica.IsEnabled = false;

                        this._TablaFixing.strike = _detContrato.Strike;
                        this._TablaFixing.spot = this.BSSpotValorizacion;
                    }

                    _Value.DecimalPlaces = 0;
                    _Value.SetChange(this.txtPrimaContrato, _encContrato.PrimaInicial);
                    this.PrimaContrato = _encContrato.PrimaInicial;

                    _Value.DecimalPlaces = 0;
                    _Value.SetChange(this.txtNocional, _detContrato.MontoMon1);
                    this.nocional = _detContrato.MontoMon1;

                    _Value.DecimalPlaces = 2;
                    _Value.SetChange(this.txtStrike1, _detContrato.Strike);
                    this.strike = _detContrato.Strike;

                    _Value.DecimalPlaces = 2;
                    _Value.SetChange(this.txtNocionalContraMoneda, (this.strike * this.nocional));
                    this.txtStrike1.Focus();

                    _Value.DecimalPlaces = 4;
                    _Value.SetChange(this.txtSpotCosto, this.BSSpotValorizacion);
                    this.spot = this.BSSpotValorizacion;

                    _Value.DecimalPlaces = _encContrato.CodMonPagPrima.Equals(13) ? 2 : 0;
                    _Value.SetChange(this.txtPrimaContrato, _encContrato.PrimaInicial);
                    valtxtPrimaContrato.DecimalPlaces = _Value.DecimalPlaces;

                    if (_encContrato.CodMonPagPrima.Equals(13))
                    {
                        this.ComboUnidadPrima.SelectedIndex = 1;
                    }
                    else
                    {
                        this.ComboUnidadPrima.SelectedIndex = 0;
                    }

                    this.ParidadPrima = double.Parse(this.txtSpotValorizacion.Text); // _encContrato.ParMdaPrima;
                    _Value.DecimalPlaces = 4;
                    _Value.SetChange(this.txtParidadPrima, _encContrato.ParMdaPrima);

                    if (_DetContratoList[0].Modalidad)
                    {
                        this.radioCompensacion.IsChecked = true;
                        this.radioEntregaFisica.IsChecked = false;
                    }
                    else
                    {
                        this.radioEntregaFisica.IsChecked = true;
                        this.radioCompensacion.IsChecked = false;
                    }

                    txtNocional.Focus();
                    txtSpotCosto.Focus();
                    itemFrontOpciones.Focus();

                    this.tabPrincipal.SelectedIndex = 0;
                    this.isTextChanged = true;

                    try
                    {
                        Valorizar();
                    }
                    catch { }

                    #endregion
                }
                else
                {
                    switch (_encContrato.CodEstructura)
                    {
                        case 1:
                            #region Straddle

                            SetRadioCompraVenta(_encContrato.CVEstructura);

                            _radioButtonType = (new RadioButton()).GetType();

                            _UIElementList = (this.stackOpciones.Children.ToList<UIElement>()).Where(x => x.GetType().Equals(_radioButtonType)).ToList<UIElement>();

                            _RadioButtonList = new List<RadioButton>();

                            foreach (UIElement _radioButtonElement in _UIElementList)
                            {
                                RadioButton _radio = _radioButtonElement as RadioButton;
                                _RadioButtonList.Add(_radio);
                            }

                            _radioTemp = _RadioButtonList.First(x => x.Content.Equals(OpcionesEstructuraList.First(op => op.Codigo.Equals("1")).Descripcion));

                            _radioTemp.IsChecked = true;

                            this.opcionContrato = OpcionesEstructuraList.First(x => x.Codigo.Equals("1")).Descripcion;

                            this.itemTabSrikes.IsSelected = true;
                            strikes_delta_flag = "strikes";

                            this.txtPlazo.Text = _DetContratoList[0].FechaVcto.Subtract(this.datePiker_DateProccess.SelectedDate.Value).Days.ToString() + "d";
                            this.DatePickerVencimiento.SelectedDate = _DetContratoList[0].FechaVcto;
                            this.fechaVencimiento = _DetContratoList[0].FechaVcto;

                            if (_DetContratoList[0].TipoPayOff.Equals("01"))//Vanilla
                            {
                                this.comboPayOff.SelectedIndex = 0;

                                (this.comboBsFwdBsSpotAsianMomenos.Items[0] as ComboBoxItem).IsEnabled = true;
                                (this.comboBsFwdBsSpotAsianMomenos.Items[1] as ComboBoxItem).IsEnabled = true;
                                (this.comboBsFwdBsSpotAsianMomenos.Items[2] as ComboBoxItem).IsEnabled = false;
                                this.comboBsFwdBsSpotAsianMomenos.SelectedIndex = 1;

                                this.radioCompensacion.IsChecked = true;
                                this.radioEntregaFisica.IsEnabled = false;
                            }
                            else
                            {
                                this.comboPayOff.SelectedIndex = 1;

                                (this.comboBsFwdBsSpotAsianMomenos.Items[0] as ComboBoxItem).IsEnabled = false;
                                (this.comboBsFwdBsSpotAsianMomenos.Items[1] as ComboBoxItem).IsEnabled = false;
                                (this.comboBsFwdBsSpotAsianMomenos.Items[2] as ComboBoxItem).IsEnabled = true;
                                this.comboBsFwdBsSpotAsianMomenos.SelectedIndex = 2;

                                this._TablaFixing.comboFrecuencia.SelectedIndex = 4;
                                this._TablaFixing.comboTipoPeso.SelectedIndex = 2;
                                _TablaFixing.isEditing = true;
                                this._TablaFixing.datePikerInicio.SelectedDate = _fixingList[0].Fijaciones[0].Fecha; //_encContrato.FechaContrato; 
                                this._TablaFixing.datePikerFin.SelectedDate = _fixingList[0].Fijaciones[_fixingList[0].Fijaciones.Count - 1].Fecha;
                                _TablaFixing.isEditing = false;
                                this._TablaFixing.checkSantiago.IsChecked = true;
                                this._TablaFixing.Town = 2;

                                this.radioCompensacion.IsChecked = true;
                                this.radioEntregaFisica.IsEnabled = false;

                                this._TablaFixing.strike = _DetContratoList[0].Strike;
                                this._TablaFixing.spot = this.BSSpotValorizacion;
                            }

                            _Value.DecimalPlaces = 0;
                            _Value.SetChange(this.txtNocional, _DetContratoList[0].MontoMon1);
                            this.nocional = _DetContratoList[0].MontoMon1;

                            _Value.DecimalPlaces = 2;
                            _Value.SetChange(this.txtStrike1, _DetContratoList[0].Strike);
                            this.strike = _DetContratoList[0].Strike;

                            _Value.DecimalPlaces = 0;
                            _Value.SetChange(this.txtNocionalContraMoneda, (this.strike * this.nocional));
                            this.txtStrike1.Focus();

                            _Value.DecimalPlaces = 4;
                            _Value.SetChange(this.txtSpotCosto, this.BSSpotValorizacion);
                            this.spot = this.BSSpotValorizacion;

                            _Value.DecimalPlaces = _encContrato.CodMonPagPrima.Equals(13) ? 2 : 0;
                            _Value.SetChange(this.txtPrimaContrato, _encContrato.PrimaInicial);
                            valtxtPrimaContrato.DecimalPlaces = _Value.DecimalPlaces;

                            if (_encContrato.CodMonPagPrima.Equals(13))
                            {
                                this.ComboUnidadPrima.SelectedIndex = 1;
                            }
                            else
                            {
                                this.ComboUnidadPrima.SelectedIndex = 0;
                            }

                            this.ParidadPrima = double.Parse(this.txtSpotValorizacion.Text);  // _encContrato.ParMdaPrima;
                            _Value.DecimalPlaces = 4;
                            _Value.SetChange(this.txtParidadPrima, this.ParidadPrima); // _encContrato.ParMdaPrima);

                            this.txtStrike1.Focus();
                            txtNocional.Focus();
                            txtSpotCosto.Focus();
                            itemFrontOpciones.Focus();

                            this.tabPrincipal.SelectedIndex = 0;
                            this.isTextChanged = true;

                            try
                            {
                                Valorizar();
                            }
                            catch { }

                            #endregion Straddle
                            break;

                        case 2:
                            #region Risk Reversal

                            SetRadioCompraVenta(_encContrato.CVEstructura);

                            _radioButtonType = (new RadioButton()).GetType();

                            _UIElementList = (this.stackOpciones.Children.ToList<UIElement>()).Where(x => x.GetType().Equals(_radioButtonType)).ToList<UIElement>();

                            _RadioButtonList = new List<RadioButton>();

                            foreach (UIElement _radioButtonElement in _UIElementList)
                            {
                                RadioButton _radio = _radioButtonElement as RadioButton;
                                _RadioButtonList.Add(_radio);

                            }

                            _radioTemp = _RadioButtonList.First(x => x.Content.Equals(OpcionesEstructuraList.First(op => op.Codigo.Equals("2")).Descripcion));

                            _radioTemp.IsChecked = true;

                            this.opcionContrato = OpcionesEstructuraList.First(x => x.Codigo.Equals("2")).Descripcion;

                            this.itemTabSrikes.IsSelected = true;
                            strikes_delta_flag = "strikes";

                            this.txtPlazo.Text = _DetContratoList[0].FechaVcto.Subtract(this.datePiker_DateProccess.SelectedDate.Value).Days.ToString() + "d";
                            this.DatePickerVencimiento.SelectedDate = _DetContratoList[0].FechaVcto;
                            this.fechaVencimiento = _DetContratoList[0].FechaVcto;
                            this.radioEntregaFisica.IsEnabled = true; //Collar por Entrega Física.

                            if (_DetContratoList[0].TipoPayOff.Equals("01"))//Vanilla
                            {
                                this.comboPayOff.SelectedIndex = 0;

                                (this.comboBsFwdBsSpotAsianMomenos.Items[0] as ComboBoxItem).IsEnabled = true;
                                (this.comboBsFwdBsSpotAsianMomenos.Items[1] as ComboBoxItem).IsEnabled = true;
                                (this.comboBsFwdBsSpotAsianMomenos.Items[2] as ComboBoxItem).IsEnabled = false;
                                this.comboBsFwdBsSpotAsianMomenos.SelectedIndex = 1;
                            }
                            else
                            {
                                this.comboPayOff.SelectedIndex = 1;
                                (this.comboBsFwdBsSpotAsianMomenos.Items[0] as ComboBoxItem).IsEnabled = false;
                                (this.comboBsFwdBsSpotAsianMomenos.Items[1] as ComboBoxItem).IsEnabled = false;
                                (this.comboBsFwdBsSpotAsianMomenos.Items[2] as ComboBoxItem).IsEnabled = true;
                                this.comboBsFwdBsSpotAsianMomenos.SelectedIndex = 2;

                                this._TablaFixing.comboFrecuencia.SelectedIndex = 4;
                                this._TablaFixing.comboTipoPeso.SelectedIndex = 2;
                                _TablaFixing.isEditing = true;
                                this._TablaFixing.datePikerInicio.SelectedDate = _fixingList[0].Fijaciones[0].Fecha; //_encContrato.FechaContrato; //_;
                                this._TablaFixing.datePikerFin.SelectedDate = _fixingList[0].Fijaciones[_fixingList[0].Fijaciones.Count - 1].Fecha;
                                _TablaFixing.isEditing = false;
                                this._TablaFixing.checkSantiago.IsChecked = true;
                                this._TablaFixing.Town = 2;

                                this._TablaFixing.strike = _DetContratoList[0].Strike;
                                this._TablaFixing.spot = this.BSSpotValorizacion;
                            }

                            _Value.DecimalPlaces = 0;
                            _Value.SetChange(this.txtNocional, _DetContratoList[0].MontoMon1);
                            this.nocional = _DetContratoList[0].MontoMon1;

                            _Value.DecimalPlaces = 2;
                            _Value.SetChange(this.txtStrike1, _DetContratoList[0].Strike);
                            this.strike = _DetContratoList[0].Strike;

                            _Value.DecimalPlaces = 2;
                            _Value.SetChange(this.txtStrike2, _DetContratoList[1].Strike);
                            this.strike2 = _DetContratoList[1].Strike;

                            _Value.DecimalPlaces = 4;
                            _Value.SetChange(this.txtSpotCosto, this.BSSpotValorizacion);
                            this.spot = this.BSSpotValorizacion;

                            _Value.DecimalPlaces = _encContrato.CodMonPagPrima.Equals(13) ? 2 : 0;
                            _Value.SetChange(this.txtPrimaContrato, _encContrato.PrimaInicial);
                            valtxtPrimaContrato.DecimalPlaces = _Value.DecimalPlaces;

                            if (_encContrato.CodMonPagPrima.Equals(13))
                            {
                                this.ComboUnidadPrima.SelectedIndex = 1;
                            }
                            else
                            {
                                this.ComboUnidadPrima.SelectedIndex = 0;
                            }

                            this.ParidadPrima = double.Parse(this.txtSpotValorizacion.Text);  // _encContrato.ParMdaPrima;
                            _Value.DecimalPlaces = 4;
                            _Value.SetChange(this.txtParidadPrima, this.ParidadPrima); // _encContrato.ParMdaPrima);

                            if (_DetContratoList[0].Modalidad)
                            {
                                this.radioCompensacion.IsChecked = true;
                                this.radioEntregaFisica.IsChecked = false;
                            }
                            else
                            {
                                this.radioEntregaFisica.IsChecked = true;
                                this.radioCompensacion.IsChecked = false;
                            }

                            this.txtPlazo.Focus();
                            this.txtStrike1.Focus();
                            txtNocional.Focus();
                            txtSpotCosto.Focus();
                            itemFrontOpciones.Focus();

                            this.tabPrincipal.SelectedIndex = 0;
                            this.isTextChanged = true;

                            try
                            {
                                Valorizar();
                            }
                            catch { }

                            #endregion Risk Reversal
                            break;

                        case 3:
                            #region Butterfly

                            SetRadioCompraVenta(_encContrato.CVEstructura);

                            _radioButtonType = (new RadioButton()).GetType();

                            _UIElementList = (this.stackOpciones.Children.ToList<UIElement>()).Where(x => x.GetType().Equals(_radioButtonType)).ToList<UIElement>();

                            _RadioButtonList = new List<RadioButton>();

                            foreach (UIElement _radioButtonElement in _UIElementList)
                            {
                                RadioButton _radio = _radioButtonElement as RadioButton;
                                _RadioButtonList.Add(_radio);
                            }

                            _radioTemp = _RadioButtonList.First(x => x.Content.Equals(OpcionesEstructuraList.First(op => op.Codigo.Equals("3")).Descripcion));

                            _radioTemp.IsChecked = true;

                            this.opcionContrato = OpcionesEstructuraList.First(x => x.Codigo.Equals("3")).Descripcion;

                            this.itemTabSrikes.IsSelected = true;
                            strikes_delta_flag = "strikes";

                            this.txtPlazo.Text = _DetContratoList[0].FechaVcto.Subtract(this.datePiker_DateProccess.SelectedDate.Value).Days.ToString() + "d";
                            this.DatePickerVencimiento.SelectedDate = _DetContratoList[0].FechaVcto;
                            this.fechaVencimiento = _DetContratoList[0].FechaVcto;

                            if (_DetContratoList[0].TipoPayOff.Equals("01"))//Vanilla
                            {
                                this.comboPayOff.SelectedIndex = 0;

                                (this.comboBsFwdBsSpotAsianMomenos.Items[0] as ComboBoxItem).IsEnabled = true;
                                (this.comboBsFwdBsSpotAsianMomenos.Items[1] as ComboBoxItem).IsEnabled = true;
                                (this.comboBsFwdBsSpotAsianMomenos.Items[2] as ComboBoxItem).IsEnabled = false;
                                this.comboBsFwdBsSpotAsianMomenos.SelectedIndex = 1;

                                this.radioCompensacion.IsChecked = true;
                                this.radioEntregaFisica.IsEnabled = false;
                            }
                            else
                            {
                                this.comboPayOff.SelectedIndex = 1;

                                (this.comboBsFwdBsSpotAsianMomenos.Items[0] as ComboBoxItem).IsEnabled = false;
                                (this.comboBsFwdBsSpotAsianMomenos.Items[1] as ComboBoxItem).IsEnabled = false;
                                (this.comboBsFwdBsSpotAsianMomenos.Items[2] as ComboBoxItem).IsEnabled = true;
                                this.comboBsFwdBsSpotAsianMomenos.SelectedIndex = 2;

                                this._TablaFixing.comboFrecuencia.SelectedIndex = 4;
                                this._TablaFixing.comboTipoPeso.SelectedIndex = 2;
                                _TablaFixing.isEditing = true;
                                this._TablaFixing.datePikerInicio.SelectedDate = _fixingList[0].Fijaciones[0].Fecha; //_encContrato.FechaContrato; 
                                this._TablaFixing.datePikerFin.SelectedDate = _fixingList[0].Fijaciones[_fixingList[0].Fijaciones.Count - 1].Fecha;
                                _TablaFixing.isEditing = false;
                                this._TablaFixing.checkSantiago.IsChecked = true;
                                this._TablaFixing.Town = 2;

                                this.radioCompensacion.IsChecked = true;
                                this.radioEntregaFisica.IsEnabled = false;

                                this._TablaFixing.strike = _DetContratoList[0].Strike;
                                this._TablaFixing.spot = this.BSSpotValorizacion;
                            }

                            // 1, 2 Straddle : _DetContratoList[0] ,_DetContratoList[1]
                            // 3, 4 Strangle : _DetContratoList[2] , _DetContratoList[3]
                            PrimaContrato = _encContrato.PrimaInicial;
                            _Value.DecimalPlaces = _encContrato.CodMonPagPrima.Equals(13) ? 2 : 0;
                            _Value.SetChange(this.txtPrimaContrato, _encContrato.PrimaInicial);
                            valtxtPrimaContrato.DecimalPlaces = _Value.DecimalPlaces;

                            if (_encContrato.CodMonPagPrima.Equals(13))
                            {
                                this.ComboUnidadPrima.SelectedIndex = 1;
                            }
                            else
                            {
                                this.ComboUnidadPrima.SelectedIndex = 0;
                            }

                            this.ParidadPrima = double.Parse(this.txtSpotValorizacion.Text);  // _encContrato.ParMdaPrima;
                            _Value.DecimalPlaces = 4;
                            _Value.SetChange(this.txtParidadPrima, this.ParidadPrima); //_encContrato.ParMdaPrima);

                            //strike1 -> strangle Call
                            //strike2 -> strangle Put
                            //strike3 -> straddle
                            if (_DetContratoList[0].Strike == _DetContratoList[1].Strike)
                            {
                                _Value.DecimalPlaces = 0;
                                _Value.SetChange(this.txtNocional, _DetContratoList[0].MontoMon1);
                                this.nocional = _DetContratoList[0].MontoMon1;

                                _Value.DecimalPlaces = 0;
                                _Value.SetChange(this.txtNocionalStrangle, _DetContratoList[2].MontoMon1);
                                this.NocionalStrangle = _DetContratoList[2].MontoMon1;

                                if (_DetContratoList[2].CallPut.Equals("Call"))
                                {
                                    _Value.DecimalPlaces = 2;
                                    _Value.SetChange(this.txtStrike1, _DetContratoList[2].Strike);
                                    this.strike = _DetContratoList[2].Strike;

                                    _Value.DecimalPlaces = 2;
                                    _Value.SetChange(this.txtStrike2, _DetContratoList[3].Strike);
                                    this.strike2 = _DetContratoList[3].Strike;
                                }
                                else
                                {
                                    _Value.DecimalPlaces = 2;
                                    _Value.SetChange(this.txtStrike1, _DetContratoList[3].Strike);
                                    this.strike = _DetContratoList[3].Strike;

                                    _Value.DecimalPlaces = 2;
                                    _Value.SetChange(this.txtStrike2, _DetContratoList[2].Strike);
                                    this.strike2 = _DetContratoList[2].Strike;

                                }

                                _Value.DecimalPlaces = 2;
                                _Value.SetChange(this.txtStrike3, _DetContratoList[0].Strike);
                                this.strike3 = _DetContratoList[0].Strike;
                            }
                            else
                            {
                                _Value.DecimalPlaces = 0;
                                _Value.SetChange(this.txtNocional, _DetContratoList[2].MontoMon1);
                                this.nocional = _DetContratoList[2].MontoMon1;

                                _Value.DecimalPlaces = 0;
                                _Value.SetChange(this.txtNocionalStrangle, _DetContratoList[0].MontoMon1);
                                this.NocionalStrangle = _DetContratoList[0].MontoMon1;

                                if (_DetContratoList[0].CallPut.Equals("Call"))
                                {
                                    _Value.DecimalPlaces = 2;
                                    _Value.SetChange(this.txtStrike1, _DetContratoList[0].Strike);
                                    this.strike = _DetContratoList[0].Strike;

                                    _Value.DecimalPlaces = 2;
                                    _Value.SetChange(this.txtStrike2, _DetContratoList[1].Strike);
                                    this.strike2 = _DetContratoList[1].Strike;
                                }
                                else
                                {
                                    _Value.DecimalPlaces = 2;
                                    _Value.SetChange(this.txtStrike1, _DetContratoList[1].Strike);
                                    this.strike = _DetContratoList[1].Strike;

                                    _Value.DecimalPlaces = 2;
                                    _Value.SetChange(this.txtStrike2, _DetContratoList[0].Strike);
                                    this.strike2 = _DetContratoList[0].Strike;

                                }

                                _Value.DecimalPlaces = 2;
                                _Value.SetChange(this.txtStrike3, _DetContratoList[2].Strike);
                                this.strike3 = _DetContratoList[2].Strike;
                            }

                            _Value.DecimalPlaces = 4;
                            _Value.SetChange(this.txtSpotCosto, this.BSSpotValorizacion);
                            this.spot = this.BSSpotValorizacion;


                            this.txtStrike1.Focus();
                            txtNocional.Focus();
                            txtSpotCosto.Focus();
                            itemFrontOpciones.Focus();

                            this.tabPrincipal.SelectedIndex = 0;
                            this.isTextChanged = true;

                            try
                            {
                                Valorizar();
                            }
                            catch { }

                            #endregion Butterfly
                            break;

                        case 4:
                            #region Forward Utilidad Acotada

                            this.radioCompensacion.IsEnabled = true;
                            this.radioEntregaFisica.IsEnabled = true;

                            this.radioEntregaFisica.IsChecked = !(_DetContratoList[0].Modalidad);
                            this.radioCompensacion.IsChecked = _DetContratoList[0].Modalidad;

                            SetRadioCompraVenta(_encContrato.CVEstructura);

                            _radioButtonType = (new RadioButton()).GetType();

                            _UIElementList = (this.stackOpciones.Children.ToList<UIElement>()).Where(x => x.GetType().Equals(_radioButtonType)).ToList<UIElement>();

                            _RadioButtonList = new List<RadioButton>();

                            foreach (UIElement _radioButtonElement in _UIElementList)
                            {
                                RadioButton _radio = _radioButtonElement as RadioButton;
                                _RadioButtonList.Add(_radio);

                            }

                            _radioTemp = _RadioButtonList.First(x => x.Content.Equals(OpcionesEstructuraList.First(op => op.Codigo.Equals("4")).Descripcion));

                            _radioTemp.IsChecked = true;

                            this.opcionContrato = OpcionesEstructuraList.First(x => x.Codigo.Equals("4")).Descripcion;

                            this.itemTabSrikes.IsSelected = true;
                            strikes_delta_flag = "strikes";

                            this.txtPlazo.Text = _DetContratoList[0].FechaVcto.Subtract(this.datePiker_DateProccess.SelectedDate.Value).Days.ToString() + "d";
                            this.DatePickerVencimiento.SelectedDate = _DetContratoList[0].FechaVcto;
                            this.fechaVencimiento = _DetContratoList[0].FechaVcto;

                            if (_DetContratoList[0].TipoPayOff.Equals("01"))//Vanilla
                            {
                                this.comboPayOff.SelectedIndex = 0;

                                (this.comboBsFwdBsSpotAsianMomenos.Items[0] as ComboBoxItem).IsEnabled = true;
                                (this.comboBsFwdBsSpotAsianMomenos.Items[1] as ComboBoxItem).IsEnabled = true;
                                (this.comboBsFwdBsSpotAsianMomenos.Items[2] as ComboBoxItem).IsEnabled = false;
                                this.comboBsFwdBsSpotAsianMomenos.SelectedIndex = 1;

                            }
                            else
                            {
                                this.comboPayOff.SelectedIndex = 1;

                                (this.comboBsFwdBsSpotAsianMomenos.Items[0] as ComboBoxItem).IsEnabled = false;
                                (this.comboBsFwdBsSpotAsianMomenos.Items[1] as ComboBoxItem).IsEnabled = false;
                                (this.comboBsFwdBsSpotAsianMomenos.Items[2] as ComboBoxItem).IsEnabled = true;
                                this.comboBsFwdBsSpotAsianMomenos.SelectedIndex = 2;

                                this._TablaFixing.comboFrecuencia.SelectedIndex = 4;
                                this._TablaFixing.comboTipoPeso.SelectedIndex = 2;
                                _TablaFixing.isEditing = true;
                                this._TablaFixing.datePikerInicio.SelectedDate = _fixingList[0].Fijaciones[0].Fecha;  //_encContrato.FechaContrato; 
                                this._TablaFixing.datePikerFin.SelectedDate = _fixingList[0].Fijaciones[_fixingList[0].Fijaciones.Count - 1].Fecha;
                                _TablaFixing.isEditing = false;
                                this._TablaFixing.checkSantiago.IsChecked = true;
                                this._TablaFixing.Town = 2;

                                this._TablaFixing.strike = _DetContratoList[0].Strike;
                                this._TablaFixing.spot = this.BSSpotValorizacion;
                            }

                            _Value.DecimalPlaces = 0;
                            _Value.SetChange(this.txtNocional, _DetContratoList[0].MontoMon1);
                            this.nocional = _DetContratoList[0].MontoMon1;

                            if (_DetContratoList[0].Strike == _DetContratoList[1].Strike) //Forward Sintetico {0, 1}
                            {
                                _Value.DecimalPlaces = 2;
                                _Value.SetChange(this.txtStrike2, _DetContratoList[2].Strike);
                                this.strike2 = _DetContratoList[2].Strike;

                                _Value.DecimalPlaces = 2;
                                _Value.SetChange(this.txtStrike1, _DetContratoList[0].Strike);
                                this.strike = _DetContratoList[0].Strike;
                            }
                            else
                            {
                                _Value.DecimalPlaces = 2;
                                _Value.SetChange(this.txtStrike2, _DetContratoList[0].Strike);
                                this.strike2 = _DetContratoList[0].Strike;

                                _Value.DecimalPlaces = 2;
                                _Value.SetChange(this.txtStrike1, _DetContratoList[2].Strike);
                                this.strike = _DetContratoList[2].Strike;
                            }

                            _Value.DecimalPlaces = 0;
                            _Value.SetChange(this.txtNocionalContraMoneda, (this.strike * this.nocional));

                            _Value.DecimalPlaces = 4;
                            _Value.SetChange(this.txtSpotCosto, this.BSSpotValorizacion);
                            this.spot = this.BSSpotValorizacion;

                            this.PrimaContrato = _encContrato.PrimaInicial;
                            _Value.DecimalPlaces = _encContrato.CodMonPagPrima.Equals(13) ? 2 : 0;
                            _Value.SetChange(this.txtPrimaContrato, _encContrato.PrimaInicial);
                            valtxtPrimaContrato.DecimalPlaces = _Value.DecimalPlaces;

                            if (_encContrato.CodMonPagPrima.Equals(13))
                            {
                                this.ComboUnidadPrima.SelectedIndex = 1;
                            }
                            else
                            {
                                this.ComboUnidadPrima.SelectedIndex = 0;
                            }

                            this.ParidadPrima = double.Parse(this.txtSpotValorizacion.Text);  // _encContrato.ParMdaPrima;
                            _Value.DecimalPlaces = 4;
                            _Value.SetChange(this.txtParidadPrima, this.ParidadPrima); //_encContrato.ParMdaPrima);

                            this.txtStrike1.Focus();
                            txtNocional.Focus();
                            txtSpotCosto.Focus();
                            itemFrontOpciones.Focus();

                            this.tabPrincipal.SelectedIndex = 0;
                            this.isTextChanged = true;

                            try
                            {
                                Valorizar();
                            }
                            catch { }

                            #endregion Forward Utilidad Acotada
                            break;

                        case 5:
                            #region Forward Perdida Acotada

                            this.radioCompensacion.IsEnabled = true;
                            this.radioEntregaFisica.IsEnabled = true;

                            this.radioEntregaFisica.IsChecked = !(_DetContratoList[0].Modalidad);
                            this.radioCompensacion.IsChecked = _DetContratoList[0].Modalidad;

                            SetRadioCompraVenta(_encContrato.CVEstructura);

                            _radioButtonType = (new RadioButton()).GetType();

                            _UIElementList = (this.stackOpciones.Children.ToList<UIElement>()).Where(x => x.GetType().Equals(_radioButtonType)).ToList<UIElement>();

                            _RadioButtonList = new List<RadioButton>();

                            foreach (UIElement _radioButtonElement in _UIElementList)
                            {
                                RadioButton _radio = _radioButtonElement as RadioButton;
                                _RadioButtonList.Add(_radio);
                            }

                            _radioTemp = _RadioButtonList.First(x => x.Content.Equals(OpcionesEstructuraList.First(op => op.Codigo.Equals("5")).Descripcion));

                            _radioTemp.IsChecked = true;

                            this.opcionContrato = OpcionesEstructuraList.First(x => x.Codigo.Equals("5")).Descripcion;

                            this.itemTabSrikes.IsSelected = true;
                            strikes_delta_flag = "strikes";

                            this.txtPlazo.Text = _DetContratoList[0].FechaVcto.Subtract(this.datePiker_DateProccess.SelectedDate.Value).Days.ToString() + "d";
                            this.DatePickerVencimiento.SelectedDate = _DetContratoList[0].FechaVcto;
                            this.fechaVencimiento = _DetContratoList[0].FechaVcto;

                            if (_DetContratoList[0].TipoPayOff.Equals("01"))//Vanilla
                            {
                                this.comboPayOff.SelectedIndex = 0;

                                (this.comboBsFwdBsSpotAsianMomenos.Items[0] as ComboBoxItem).IsEnabled = true;
                                (this.comboBsFwdBsSpotAsianMomenos.Items[1] as ComboBoxItem).IsEnabled = true;
                                (this.comboBsFwdBsSpotAsianMomenos.Items[2] as ComboBoxItem).IsEnabled = false;
                                this.comboBsFwdBsSpotAsianMomenos.SelectedIndex = 1;

                            }
                            else
                            {
                                this.comboPayOff.SelectedIndex = 1;

                                (this.comboBsFwdBsSpotAsianMomenos.Items[0] as ComboBoxItem).IsEnabled = false;
                                (this.comboBsFwdBsSpotAsianMomenos.Items[1] as ComboBoxItem).IsEnabled = false;
                                (this.comboBsFwdBsSpotAsianMomenos.Items[2] as ComboBoxItem).IsEnabled = true;
                                this.comboBsFwdBsSpotAsianMomenos.SelectedIndex = 2;

                                this._TablaFixing.comboFrecuencia.SelectedIndex = 4;
                                this._TablaFixing.comboTipoPeso.SelectedIndex = 2;
                                _TablaFixing.isEditing = true;
                                this._TablaFixing.datePikerInicio.SelectedDate = _fixingList[0].Fijaciones[0].Fecha; //_encContrato.FechaContrato; 
                                this._TablaFixing.datePikerFin.SelectedDate = _fixingList[0].Fijaciones[_fixingList[0].Fijaciones.Count - 1].Fecha;
                                _TablaFixing.isEditing = false;
                                this._TablaFixing.checkSantiago.IsChecked = true;
                                this._TablaFixing.Town = 2;

                                this._TablaFixing.strike = _DetContratoList[0].Strike;
                                this._TablaFixing.spot = this.BSSpotValorizacion;
                            }

                            _Value.DecimalPlaces = 0;
                            _Value.SetChange(this.txtNocional, _DetContratoList[0].MontoMon1);
                            this.nocional = _DetContratoList[0].MontoMon1;

                            if (_DetContratoList[0].Strike == _DetContratoList[1].Strike) //Forward Sintetico {0, 1}
                            {
                                _Value.DecimalPlaces = 2;
                                _Value.SetChange(this.txtStrike2, _DetContratoList[2].Strike);
                                this.strike2 = _DetContratoList[2].Strike;

                                _Value.DecimalPlaces = 2;
                                _Value.SetChange(this.txtStrike1, _DetContratoList[0].Strike);
                                this.strike = _DetContratoList[0].Strike;
                            }
                            else
                            {
                                _Value.DecimalPlaces = 2;
                                _Value.SetChange(this.txtStrike2, _DetContratoList[0].Strike);
                                this.strike2 = _DetContratoList[0].Strike;

                                _Value.DecimalPlaces = 2;
                                _Value.SetChange(this.txtStrike1, _DetContratoList[2].Strike);
                                this.strike = _DetContratoList[2].Strike;
                            }

                            _Value.DecimalPlaces = 0;
                            _Value.SetChange(this.txtNocionalContraMoneda, (this.strike * this.nocional));

                            _Value.DecimalPlaces = 4;
                            _Value.SetChange(this.txtSpotCosto, this.BSSpotValorizacion);
                            this.spot = this.BSSpotValorizacion;

                            this.PrimaContrato = _encContrato.PrimaInicial;
                            _Value.DecimalPlaces = _encContrato.CodMonPagPrima.Equals(13) ? 2 : 0;
                            _Value.SetChange(this.txtPrimaContrato, _encContrato.PrimaInicial);
                            valtxtPrimaContrato.DecimalPlaces = _Value.DecimalPlaces;

                            if (_encContrato.CodMonPagPrima.Equals(13))
                            {
                                this.ComboUnidadPrima.SelectedIndex = 1;
                            }
                            else
                            {
                                this.ComboUnidadPrima.SelectedIndex = 0;
                            }

                            this.ParidadPrima = double.Parse(this.txtSpotValorizacion.Text);  // _encContrato.ParMdaPrima;
                            _Value.DecimalPlaces = 4;
                            _Value.SetChange(this.txtParidadPrima, this.ParidadPrima); //_encContrato.ParMdaPrima);

                            this.txtStrike1.Focus();
                            txtNocional.Focus();
                            txtSpotCosto.Focus();
                            itemFrontOpciones.Focus();

                            this.tabPrincipal.SelectedIndex = 0;
                            this.isTextChanged = true;

                            try
                            {
                                Valorizar();
                            }
                            catch { }

                            #endregion Forward Perdida Acotada
                            break;

                        case 6:
                            #region Forward Sintetico

                            SetRadioCompraVenta(_encContrato.CVEstructura);

                            _radioButtonType = (new RadioButton()).GetType();

                            _UIElementList = (this.stackOpciones.Children.ToList<UIElement>()).Where(x => x.GetType().Equals(_radioButtonType)).ToList<UIElement>();

                            _RadioButtonList = new List<RadioButton>();

                            foreach (UIElement _radioButtonElement in _UIElementList)
                            {
                                RadioButton _radio = _radioButtonElement as RadioButton;
                                _RadioButtonList.Add(_radio);
                            }

                            _radioTemp = _RadioButtonList.First(x => x.Content.Equals(OpcionesEstructuraList.First(op => op.Codigo.Equals("6")).Descripcion));

                            _radioTemp.IsChecked = true;

                            this.opcionContrato = OpcionesEstructuraList.First(x => x.Codigo.Equals("6")).Descripcion;

                            this.itemTabSrikes.IsSelected = true;
                            strikes_delta_flag = "strikes";

                            this.txtPlazo.Focus();
                            this.txtPlazo.Text = _DetContratoList[0].FechaVcto.Subtract(this.datePiker_DateProccess.SelectedDate.Value).Days.ToString() + "d";
                            this.DatePickerVencimiento.SelectedDate = _DetContratoList[0].FechaVcto;
                            this.fechaVencimiento = _DetContratoList[0].FechaVcto;

                            if (_DetContratoList[0].TipoPayOff.Equals("01"))//Vanilla 
                            {
                                this.comboPayOff.SelectedIndex = 0;
                                (this.comboBsFwdBsSpotAsianMomenos.Items[0] as ComboBoxItem).IsEnabled = true;
                                (this.comboBsFwdBsSpotAsianMomenos.Items[1] as ComboBoxItem).IsEnabled = true;
                                (this.comboBsFwdBsSpotAsianMomenos.Items[2] as ComboBoxItem).IsEnabled = false;
                                this.comboBsFwdBsSpotAsianMomenos.SelectedIndex = 1;

                                this.radioCompensacion.IsChecked = true;

                                this.radioEntregaFisica.IsEnabled = false;
                            }
                            else
                            {
                                this.comboPayOff.SelectedIndex = 1;
                                (this.comboBsFwdBsSpotAsianMomenos.Items[0] as ComboBoxItem).IsEnabled = false;
                                (this.comboBsFwdBsSpotAsianMomenos.Items[1] as ComboBoxItem).IsEnabled = false;
                                (this.comboBsFwdBsSpotAsianMomenos.Items[2] as ComboBoxItem).IsEnabled = true;

                                this.comboBsFwdBsSpotAsianMomenos.SelectedIndex = 2;
                                this._TablaFixing.comboFrecuencia.SelectedIndex = 4;
                                this._TablaFixing.comboTipoPeso.SelectedIndex = 2;
                                _TablaFixing.isEditing = true;
                                this._TablaFixing.datePikerInicio.SelectedDate = _fixingList[0].Fijaciones[0].Fecha; // _encContrato.FechaContrato; 
                                this._TablaFixing.datePikerFin.SelectedDate = _fixingList[0].Fijaciones[_fixingList[0].Fijaciones.Count - 1].Fecha;
                                _TablaFixing.isEditing = false;

                                this._TablaFixing.checkSantiago.IsChecked = true;
                                this._TablaFixing.Town = 2;

                                this.radioCompensacion.IsChecked = true;
                                this.radioEntregaFisica.IsEnabled = false;

                                this._TablaFixing.strike = _DetContratoList[0].Strike;
                                this._TablaFixing.spot = this.BSSpotValorizacion;
                            }

                            this.strike = _DetContratoList[1].Strike;
                            _Value.DecimalPlaces = 2;
                            _Value.SetChange(this.txtStrike1, strike);

                            _Value.DecimalPlaces = 0;
                            _Value.SetChange(this.txtNocional, _DetContratoList[1].MontoMon1);
                            this.nocional = _DetContratoList[1].MontoMon1;

                            _Value.DecimalPlaces = 0;
                            _Value.SetChange(this.txtNocionalContraMoneda, (this.strike * this.nocional));

                            _Value.DecimalPlaces = 4;
                            _Value.SetChange(this.txtPuntosCosto, (_DetContratoList[1].Strike - _DetContratoList[1].SpotDet));
                            this.PuntosCosto = Math.Round(_DetContratoList[1].Strike - _DetContratoList[1].SpotDet, 4);

                            _Value.DecimalPlaces = 4;
                            _Value.SetChange(this.txtSpotCosto, this.BSSpotValorizacion);
                            this.spot = this.BSSpotValorizacion;

                            PrimaContrato = _encContrato.PrimaInicial;
                            _Value.DecimalPlaces = _encContrato.CodMonPagPrima.Equals(13) ? 2 : 0;
                            _Value.SetChange(this.txtPrimaContrato, _encContrato.PrimaInicial);
                            valtxtPrimaContrato.DecimalPlaces = _Value.DecimalPlaces;

                            if (_encContrato.CodMonPagPrima.Equals(13))
                            {
                                this.ComboUnidadPrima.SelectedIndex = 1;
                            }
                            else
                            {
                                this.ComboUnidadPrima.SelectedIndex = 0;
                            }

                            this.ParidadPrima = double.Parse(this.txtSpotValorizacion.Text);  // _encContrato.ParMdaPrima;
                            _Value.DecimalPlaces = 4;
                            _Value.SetChange(this.txtParidadPrima, this.ParidadPrima); // _encContrato.ParMdaPrima);

                            this.txtStrike1.Focus();
                            txtNocional.Focus();
                            txtSpotCosto.Focus();
                            itemFrontOpciones.Focus();

                            this.tabPrincipal.SelectedIndex = 0;
                            this.isTextChanged = true;

                            try
                            {
                                Valorizar();
                            }
                            catch { }

                            #endregion Forward Sintetico
                            break;

                        case 7:
                            #region Strangle

                            SetRadioCompraVenta(_encContrato.CVEstructura);

                            _radioButtonType = (new RadioButton()).GetType();

                            _UIElementList = (this.stackOpciones.Children.ToList<UIElement>()).Where(x => x.GetType().Equals(_radioButtonType)).ToList<UIElement>();

                            _RadioButtonList = new List<RadioButton>();

                            foreach (UIElement _radioButtonElement in _UIElementList)
                            {
                                RadioButton _radio = _radioButtonElement as RadioButton;
                                _RadioButtonList.Add(_radio);
                            }

                            _radioTemp = _RadioButtonList.First(x => x.Content.Equals(OpcionesEstructuraList.First(op => op.Codigo.Equals("7")).Descripcion));

                            _radioTemp.IsChecked = true;

                            this.opcionContrato = OpcionesEstructuraList.First(x => x.Codigo.Equals("7")).Descripcion;

                            this.itemTabSrikes.IsSelected = true;
                            strikes_delta_flag = "strikes";

                            this.txtPlazo.Text = _DetContratoList[0].FechaVcto.Subtract(this.datePiker_DateProccess.SelectedDate.Value).Days.ToString() + "d";
                            this.DatePickerVencimiento.SelectedDate = _DetContratoList[0].FechaVcto;
                            this.fechaVencimiento = _DetContratoList[0].FechaVcto;

                            if (_DetContratoList[0].TipoPayOff.Equals("01"))    //Vanilla
                            {
                                this.comboPayOff.SelectedIndex = 0;

                                (this.comboBsFwdBsSpotAsianMomenos.Items[0] as ComboBoxItem).IsEnabled = true;
                                (this.comboBsFwdBsSpotAsianMomenos.Items[1] as ComboBoxItem).IsEnabled = true;
                                (this.comboBsFwdBsSpotAsianMomenos.Items[2] as ComboBoxItem).IsEnabled = false;
                                this.comboBsFwdBsSpotAsianMomenos.SelectedIndex = 1;

                                this.radioCompensacion.IsChecked = true;
                                this.radioEntregaFisica.IsEnabled = false;
                            }
                            else
                            {
                                this.comboPayOff.SelectedIndex = 1;

                                (this.comboBsFwdBsSpotAsianMomenos.Items[0] as ComboBoxItem).IsEnabled = false;
                                (this.comboBsFwdBsSpotAsianMomenos.Items[1] as ComboBoxItem).IsEnabled = false;
                                (this.comboBsFwdBsSpotAsianMomenos.Items[2] as ComboBoxItem).IsEnabled = true;
                                this.comboBsFwdBsSpotAsianMomenos.SelectedIndex = 2;

                                this._TablaFixing.comboFrecuencia.SelectedIndex = 4;
                                this._TablaFixing.comboTipoPeso.SelectedIndex = 2;
                                _TablaFixing.isEditing = true;
                                this._TablaFixing.datePikerInicio.SelectedDate = _fixingList[0].Fijaciones[0].Fecha; //_encContrato.FechaContrato; 
                                this._TablaFixing.datePikerFin.SelectedDate = _fixingList[0].Fijaciones[_fixingList[0].Fijaciones.Count - 1].Fecha;
                                _TablaFixing.isEditing = false;
                                this._TablaFixing.checkSantiago.IsChecked = true;
                                this._TablaFixing.Town = 2;

                                this.radioCompensacion.IsChecked = true;
                                this.radioEntregaFisica.IsEnabled = false;

                                this._TablaFixing.strike = _DetContratoList[0].Strike;
                                this._TablaFixing.spot = this.BSSpotValorizacion;
                            }

                            _Value.DecimalPlaces = 0;
                            _Value.SetChange(this.txtNocional, _DetContratoList[0].MontoMon1);
                            this.nocional = _DetContratoList[0].MontoMon1;

                            _Value.DecimalPlaces = 2;
                            _Value.SetChange(this.txtStrike1, _DetContratoList[0].Strike);
                            this.strike = _DetContratoList[0].Strike;

                            _Value.DecimalPlaces = 2;
                            _Value.SetChange(this.txtStrike2, _DetContratoList[1].Strike);
                            this.strike2 = _DetContratoList[1].Strike;

                            _Value.DecimalPlaces = 2;
                            _Value.SetChange(this.txtSpotCosto, this.BSSpotValorizacion);
                            this.spot = this.BSSpotValorizacion;

                            this.PrimaContrato = _encContrato.PrimaInicial;
                            _Value.DecimalPlaces = _encContrato.CodMonPagPrima.Equals(13) ? 2 : 0;
                            _Value.SetChange(this.txtPrimaContrato, _encContrato.PrimaInicial);
                            valtxtPrimaContrato.DecimalPlaces = _Value.DecimalPlaces;

                            if (_encContrato.CodMonPagPrima.Equals(13))
                            {
                                this.ComboUnidadPrima.SelectedIndex = 1;
                            }
                            else
                            {
                                this.ComboUnidadPrima.SelectedIndex = 0;
                            }

                            this.ParidadPrima = double.Parse(this.txtSpotValorizacion.Text);  // _encContrato.ParMdaPrima;
                            _Value.DecimalPlaces = 4;
                            _Value.SetChange(this.txtParidadPrima, this.ParidadPrima); // _encContrato.ParMdaPrima);

                            this.txtStrike1.Focus();
                            txtNocional.Focus();
                            txtSpotCosto.Focus();
                            itemFrontOpciones.Focus();

                            this.tabPrincipal.SelectedIndex = 0;
                            this.isTextChanged = true;

                            try
                            {
                                Valorizar();
                            }
                            catch { }

                            #endregion Strangle
                            break;

                        case 8:
                            #region Forward Americano

                            this.txtNocional.IsReadOnly = false;
                            _detContrato = _DetContratoList.First(x => x.NumContrato.Equals(_encContrato.NumContrato));

                            //Caso especial, siempre venta del derecho, se infiere C o V según subyacente.
                            //SetRadioCompraVenta(_encContrato.CVEstructura);
                            if (_detContrato.CallPut.Equals("PUT"))
                            {
                                this.radioCompra.IsChecked = true;
                            }
                            else
                            {
                                this.radioVenta.IsChecked = true;
                            }

                            _radioButtonType = (new RadioButton()).GetType();

                            _UIElementList = (this.stackOpciones.Children.ToList<UIElement>()).Where(x => x.GetType().Equals(_radioButtonType)).ToList<UIElement>();

                            _RadioButtonList = new List<RadioButton>();

                            foreach (UIElement _radioButtonElement in _UIElementList)
                            {
                                RadioButton _radio = _radioButtonElement as RadioButton;
                                _RadioButtonList.Add(_radio);
                            }

                            _radioTemp = _RadioButtonList.First(x => x.Content.Equals(OpcionesEstructuraList.First(op => op.Codigo.Equals(_encContrato.CodEstructura.ToString())).Descripcion));

                            _radioTemp.IsChecked = true;

                            this.opcionContrato = OpcionesEstructuraList.First(x => x.Codigo.Equals(_encContrato.CodEstructura.ToString())).Descripcion;

                            this.itemTabSrikes.IsSelected = true;
                            strikes_delta_flag = "strikes";

                            this.txtPlazo.Text = _detContrato.FechaVcto.Subtract(this.datePiker_DateProccess.SelectedDate.Value).Days.ToString() + "d";
                            this.DatePickerVencimiento.SelectedDate = _detContrato.FechaVcto;
                            this.fechaVencimiento = _detContrato.FechaVcto;

                            this.comboPayOff.SelectedIndex = 0;

                            (this.comboBsFwdBsSpotAsianMomenos.Items[0] as ComboBoxItem).IsEnabled = true;
                            (this.comboBsFwdBsSpotAsianMomenos.Items[1] as ComboBoxItem).IsEnabled = true;
                            (this.comboBsFwdBsSpotAsianMomenos.Items[2] as ComboBoxItem).IsEnabled = false;
                            this.comboBsFwdBsSpotAsianMomenos.SelectedIndex = 1;
                            this.radioEntregaFisica.IsEnabled = true;

                            comboEjercicio.SelectedIndex = 2;

                            _Value.DecimalPlaces = 0;
                            _Value.SetChange(this.txtPrimaContrato, _encContrato.PrimaInicial);
                            this.PrimaContrato = _encContrato.PrimaInicial;

                            _Value.DecimalPlaces = 0;
                            _Value.SetChange(this.txtNocional, _detContrato.MontoMon1);
                            this.nocional = _detContrato.MontoMon1;

                            _Value.DecimalPlaces = 2;
                            _Value.SetChange(this.txtStrike1, _detContrato.Strike);
                            this.strike = _detContrato.Strike;

                            _Value.DecimalPlaces = 2;
                            _Value.SetChange(this.txtNocionalContraMoneda, (this.strike * this.nocional));
                            this.txtStrike1.Focus();

                            _Value.DecimalPlaces = 4;
                            _Value.SetChange(this.txtSpotCosto, this.BSSpotValorizacion);
                            this.spot = this.BSSpotValorizacion;

                            _Value.DecimalPlaces = 0;
                            _Value.SetChange(this.txtPrimaContrato, 0);
                            valtxtPrimaContrato.DecimalPlaces = _Value.DecimalPlaces;

                            this.ComboUnidadPrima.SelectedIndex = 0;

                            this.ParidadPrima = 0; // _encContrato.ParMdaPrima;
                            _Value.DecimalPlaces = 4;
                            _Value.SetChange(this.txtParidadPrima, 0);

                            if (_DetContratoList[0].Modalidad)
                            {
                                this.radioCompensacion.IsChecked = true;
                                this.radioEntregaFisica.IsChecked = false;
                            }
                            else
                            {
                                this.radioEntregaFisica.IsChecked = true;
                                this.radioCompensacion.IsChecked = false;
                            }

                            txtNocional.Focus();
                            txtSpotCosto.Focus();
                            itemFrontOpciones.Focus();

                            this.tabPrincipal.SelectedIndex = 0;
                            this.isTextChanged = true;

                            try
                            {
                                Valorizar();
                            }
                            catch { }

                            btnTopoLogiaVegaPricing.IsEnabled = false;
                            btnSensibilidadPricing.Content = "  Sensibilidad";
                            checkboxSensitivity.Visibility = Visibility.Visible;

                            #endregion Forward Americano
                            break;

                        case 9:
                        case 10:
                            #region Strip Asiático

                            SetRadioCompraVenta(_encContrato.CVEstructura);

                            _radioButtonType = (new RadioButton()).GetType();

                            _UIElementList = (this.stackOpciones.Children.ToList<UIElement>()).Where(x => x.GetType().Equals(_radioButtonType)).ToList<UIElement>();

                            _RadioButtonList = new List<RadioButton>();

                            foreach (UIElement _radioButtonElement in _UIElementList)
                            {
                                RadioButton _radio = _radioButtonElement as RadioButton;
                                _RadioButtonList.Add(_radio);

                            }

                            _radioTemp = _RadioButtonList.First(x => x.Content.Equals(OpcionesEstructuraList.First(op => op.Codigo.Equals(_encContrato.CodEstructura.ToString())).Descripcion));
                            _radioTemp.IsChecked = true;

                            this.opcionContrato = OpcionesEstructuraList.First(x => x.Codigo.Equals(_encContrato.CodEstructura.ToString())).Descripcion;

                            this.itemTabSrikes.IsSelected = true;
                            strikes_delta_flag = "strikes";

                            this.txtPlazo.Text = _DetContratoList[_DetContratoList.Count - 1].FechaVcto.Subtract(this.datePiker_DateProccess.SelectedDate.Value).Days.ToString() + "d";
                            this.DatePickerVencimiento.SelectedDate = _DetContratoList[_DetContratoList.Count - 1].FechaVcto;
                            this.fechaVencimiento = _DetContratoList[_DetContratoList.Count - 1].FechaVcto;

                            if (_DetContratoList[0].TipoPayOff.Equals("01"))//Vanilla
                            {
                                this.comboPayOff.SelectedIndex = 0;

                                (this.comboBsFwdBsSpotAsianMomenos.Items[0] as ComboBoxItem).IsEnabled = true;
                                (this.comboBsFwdBsSpotAsianMomenos.Items[1] as ComboBoxItem).IsEnabled = true;
                                (this.comboBsFwdBsSpotAsianMomenos.Items[2] as ComboBoxItem).IsEnabled = false;
                                this.comboBsFwdBsSpotAsianMomenos.SelectedIndex = 1;

                                this.radioCompensacion.IsChecked = true;
                                this.radioEntregaFisica.IsEnabled = false;
                            }
                            else
                            {
                                this.comboPayOff.SelectedIndex = 1;

                                (this.comboBsFwdBsSpotAsianMomenos.Items[0] as ComboBoxItem).IsEnabled = false;
                                (this.comboBsFwdBsSpotAsianMomenos.Items[1] as ComboBoxItem).IsEnabled = false;
                                (this.comboBsFwdBsSpotAsianMomenos.Items[2] as ComboBoxItem).IsEnabled = true;
                                this.comboBsFwdBsSpotAsianMomenos.SelectedIndex = 2;

                                //Bandera para que valorize correctamente 
                                IsLoadStripContrat = true;

                                checkboxAsociadoStrip.IsChecked = true;

                                #region Cargar Fixing del Contrato

                                List<StructFixingData> CargaFixingTabla = new List<StructFixingData>();
                                StructFixingData grdFixingContrato;

                                for (int s = 0; s < _fixingList.Count; s++)
                                {
                                    for (int t = 0; t < _fixingList[s].Fijaciones.Count; t++)
                                    {
                                        grdFixingContrato = new StructFixingData();
                                        grdFixingContrato.Fecha = _fixingList[s].Fijaciones[t].Fecha;
                                        grdFixingContrato.Peso = _fixingList[s].Fijaciones[t].Peso;
                                        grdFixingContrato.Valor = _fixingList[s].Fijaciones[t].Valor;
                                        grdFixingContrato.Volatilidad = _fixingList[s].Fijaciones[t].Volatilidad;
                                        grdFixingContrato.Plazo = _fixingList[s].Fijaciones[t].Plazo;

                                        CargaFixingTabla.Add(grdFixingContrato);

                                    }

                                }

                                this._TablaFixing.grdTablaFixing.ItemsSource = null;
                                this._TablaFixing.grdTablaFixing.ItemsSource = CargaFixingTabla;


                                //Frecuencia = Custom
                                this._TablaFixing.comboFrecuencia.SelectedIndex = 4;
                                this._TablaFixing.comboTipoPeso.SelectedIndex = 2;
                                //no se puede editar tablafixing
                                _TablaFixing.isEditing = false;

                                this._TablaFixing.datePikerInicio.SelectedDate = _encContrato.FechaContrato;

                                this._TablaFixing.datePikerFin.SelectedDate = _DetContratoList[_DetContratoList.Count - 1].FechaVcto;

                                this._TablaFixing.checkSantiago.IsChecked = true;
                                this._TablaFixing.Town = 2;

                                this.radioCompensacion.IsChecked = true;
                                this.radioEntregaFisica.IsEnabled = false;

                                this._TablaFixing.comboTipoPeso.SelectedIndex = 2;

                                //this._TablaFixing.strike = _DetContratoList[0].Strike;
                                //this._TablaFixing.spot = this.BSSpotValorizacion;

                                #endregion

                                #region Cargar Strip Asiatico con sus Fixing

                                //se setea la fecha de inicio del contrato
                                String DateStart = _DetContratoList[0].sFechaInicioOpc;
                                DateTime DateAnterior = DateTime.Parse(DateStart);

                                //creamos una lista con los contratos (el strip)
                                StripList = new List<StructStrip>();

                                for (int i = 0; i < _DetContratoList.Count; i++)
                                {
                                    CreaStrip = new StructStrip();
                                    CreaStrip.ID = i + 1;
                                    CreaStrip.FechaInicio = _DetContratoList[i].sFechaInicioOpc;
                                    CreaStrip.FechaInicioFixing = DateAnterior;
                                    CreaStrip.FechaVencimiento = _DetContratoList[i].FechaVcto;
                                    DateAnterior = CreaStrip.FechaVencimiento;
                                    CreaStrip.PrecioStrike = _DetContratoList[i].Strike;
                                    CreaStrip.NocionalTotal = _DetContratoList[i].MontoMon1;

                                    //extraemos la porción de Fixing que nos interesa.
                                    List<StructFixingData> ListFixing3 = new List<StructFixingData>();
                                    StructFixingData grdFixing3;

                                    for (int k = 0; k < _fixingList[i].Fijaciones.Count; k++)
                                    {
                                        grdFixing3 = new StructFixingData();
                                        grdFixing3.Fecha = _fixingList[i].Fijaciones[k].Fecha;
                                        grdFixing3.Peso = _fixingList[i].Fijaciones[k].Peso;
                                        grdFixing3.Valor = _fixingList[i].Fijaciones[k].Valor;
                                        grdFixing3.Volatilidad = _fixingList[i].Fijaciones[k].Volatilidad;
                                        grdFixing3.Plazo = _fixingList[i].Fijaciones[k].Plazo;

                                        ListFixing3.Add(grdFixing3);
                                    }

                                    CreaStrip.TablaFixing = ListFixing3;
                                    StripList.Add(CreaStrip);
                                }

                                GridStrip.ItemsSource = null;
                                GridStrip.ItemsSource = StripList;

                                #endregion

                            }

                            _Value.DecimalPlaces = 0;
                            _Value.SetChange(this.txtNocional, _DetContratoList[0].MontoMon1);
                            this.nocional = _DetContratoList[0].MontoMon1;

                            _Value.DecimalPlaces = 2;
                            _Value.SetChange(this.txtStrike1, _DetContratoList[0].Strike);
                            this.strike = _DetContratoList[0].Strike;

                            _Value.DecimalPlaces = 0;
                            _Value.SetChange(this.txtNocionalContraMoneda, (this.strike * this.nocional));

                            _Value.DecimalPlaces = 4;
                            _Value.SetChange(this.txtSpotCosto, this.BSSpotValorizacion);
                            this.spot = this.BSSpotValorizacion;

                            this.PrimaContrato = _encContrato.PrimaInicial;
                            _Value.DecimalPlaces = _encContrato.CodMonPagPrima.Equals(13) ? 2 : 0;
                            _Value.SetChange(this.txtPrimaContrato, _encContrato.PrimaInicial);
                            valtxtPrimaContrato.DecimalPlaces = _Value.DecimalPlaces;

                            if (_encContrato.CodMonPagPrima.Equals(13))
                            {
                                this.ComboUnidadPrima.SelectedIndex = 1;
                            }
                            else
                            {
                                this.ComboUnidadPrima.SelectedIndex = 0;
                            }

                            this.ParidadPrima = double.Parse(this.txtSpotValorizacion.Text);  // _encContrato.ParMdaPrima;
                            _Value.DecimalPlaces = 4;
                            _Value.SetChange(this.txtParidadPrima, this.ParidadPrima); //_encContrato.ParMdaPrima);

                            this.txtStrike1.Focus();
                            txtNocional.Focus();
                            txtSpotCosto.Focus();
                            itemFrontOpciones.Focus();

                            this.tabPrincipal.SelectedIndex = 0;
                            this.isTextChanged = true;

                            try
                            {
                                Valorizar();

                            }
                            catch { }

                            #endregion Strip Asiático
                            break;

                        case 11:
                        case 12:
                            #region Call/Put Spread

                            SetRadioCompraVenta(_encContrato.CVEstructura);

                            _radioButtonType = (new RadioButton()).GetType();

                            _UIElementList = (this.stackOpciones.Children.ToList<UIElement>()).Where(x => x.GetType().Equals(_radioButtonType)).ToList<UIElement>();

                            _RadioButtonList = new List<RadioButton>();

                            foreach (UIElement _radioButtonElement in _UIElementList)
                            {
                                RadioButton _radio = _radioButtonElement as RadioButton;
                                _RadioButtonList.Add(_radio);

                            }

                            this.radioCompensacion.IsChecked = true;
                            this.radioEntregaFisica.IsEnabled = false;

                            if (_encContrato.CodEstructura == 11)
                            {
                                _radioTemp = _RadioButtonList.First(x => x.Content.Equals(OpcionesEstructuraList.First(op => op.Codigo.Equals("11")).Descripcion));
                                this.opcionContrato = OpcionesEstructuraList.First(x => x.Codigo.Equals("11")).Descripcion;
                            }
                            else
                            {
                                _radioTemp = _RadioButtonList.First(x => x.Content.Equals(OpcionesEstructuraList.First(op => op.Codigo.Equals("12")).Descripcion));
                                this.opcionContrato = OpcionesEstructuraList.First(x => x.Codigo.Equals("12")).Descripcion;
                            }

                            _radioTemp.IsChecked = true;

                            this.itemTabSrikes.IsSelected = true;
                            strikes_delta_flag = "strikes";

                            this.txtPlazo.Text = _DetContratoList[0].FechaVcto.Subtract(this.datePiker_DateProccess.SelectedDate.Value).Days.ToString() + "d";
                            this.DatePickerVencimiento.SelectedDate = _DetContratoList[0].FechaVcto;
                            this.fechaVencimiento = _DetContratoList[0].FechaVcto;
                            this.radioEntregaFisica.IsEnabled = false;

                            if (_DetContratoList[0].TipoPayOff.Equals("01"))//Vanilla
                            {
                                this.comboPayOff.SelectedIndex = 0;

                                (this.comboBsFwdBsSpotAsianMomenos.Items[0] as ComboBoxItem).IsEnabled = true;
                                (this.comboBsFwdBsSpotAsianMomenos.Items[1] as ComboBoxItem).IsEnabled = true;
                                (this.comboBsFwdBsSpotAsianMomenos.Items[2] as ComboBoxItem).IsEnabled = false;
                                this.comboBsFwdBsSpotAsianMomenos.SelectedIndex = 1;
                            }
                            else
                            {
                                this.comboPayOff.SelectedIndex = 1;
                                (this.comboBsFwdBsSpotAsianMomenos.Items[0] as ComboBoxItem).IsEnabled = false;
                                (this.comboBsFwdBsSpotAsianMomenos.Items[1] as ComboBoxItem).IsEnabled = false;
                                (this.comboBsFwdBsSpotAsianMomenos.Items[2] as ComboBoxItem).IsEnabled = true;
                                this.comboBsFwdBsSpotAsianMomenos.SelectedIndex = 2;

                                this._TablaFixing.comboFrecuencia.SelectedIndex = 4;
                                this._TablaFixing.comboTipoPeso.SelectedIndex = 2;
                                _TablaFixing.isEditing = true;
                                this._TablaFixing.datePikerInicio.SelectedDate = _fixingList[0].Fijaciones[0].Fecha; //_encContrato.FechaContrato; //_;
                                this._TablaFixing.datePikerFin.SelectedDate = _fixingList[0].Fijaciones[_fixingList[0].Fijaciones.Count - 1].Fecha;
                                _TablaFixing.isEditing = false;
                                this._TablaFixing.checkSantiago.IsChecked = true;
                                this._TablaFixing.Town = 2;

                                this._TablaFixing.strike = _DetContratoList[0].Strike;
                                this._TablaFixing.spot = this.BSSpotValorizacion;
                            }

                            _Value.DecimalPlaces = 0;
                            _Value.SetChange(this.txtNocional, _DetContratoList[0].MontoMon1);
                            this.nocional = _DetContratoList[0].MontoMon1;

                            _Value.DecimalPlaces = 2;
                            _Value.SetChange(this.txtStrike1, _DetContratoList[0].Strike);
                            this.strike = _DetContratoList[0].Strike;

                            _Value.DecimalPlaces = 2;
                            _Value.SetChange(this.txtStrike2, _DetContratoList[1].Strike);
                            this.strike2 = _DetContratoList[1].Strike;

                            _Value.DecimalPlaces = 4;
                            _Value.SetChange(this.txtSpotCosto, this.BSSpotValorizacion);
                            this.spot = this.BSSpotValorizacion;

                            _Value.DecimalPlaces = _encContrato.CodMonPagPrima.Equals(13) ? 2 : 0;
                            _Value.SetChange(this.txtPrimaContrato, _encContrato.PrimaInicial);
                            valtxtPrimaContrato.DecimalPlaces = _Value.DecimalPlaces;

                            if (_encContrato.CodMonPagPrima.Equals(13))
                            {
                                this.ComboUnidadPrima.SelectedIndex = 1;
                            }
                            else
                            {
                                this.ComboUnidadPrima.SelectedIndex = 0;
                            }

                            this.ParidadPrima = double.Parse(this.txtSpotValorizacion.Text);  // _encContrato.ParMdaPrima;
                            _Value.DecimalPlaces = 4;
                            _Value.SetChange(this.txtParidadPrima, this.ParidadPrima); // _encContrato.ParMdaPrima);

                            if (_DetContratoList[0].Modalidad)
                            {
                                this.radioCompensacion.IsChecked = true;
                                this.radioEntregaFisica.IsChecked = false;
                            }
                            else
                            {
                                this.radioEntregaFisica.IsChecked = true;
                                this.radioCompensacion.IsChecked = false;
                            }

                            this.txtPlazo.Focus();
                            this.txtStrike1.Focus();
                            txtNocional.Focus();
                            txtSpotCosto.Focus();
                            itemFrontOpciones.Focus();

                            this.tabPrincipal.SelectedIndex = 0;
                            this.isTextChanged = true;

                            try
                            {
                                Valorizar();
                            }
                            catch { }

                            #endregion
                            break;

                        case 13: //MEJORAR si está repetido
                            #region Forward Asiático Entrada Salida

                            SetRadioCompraVenta(_encContrato.CVEstructura);

                            _radioButtonType = (new RadioButton()).GetType();

                            _UIElementList = (this.stackOpciones.Children.ToList<UIElement>()).Where(x => x.GetType().Equals(_radioButtonType)).ToList<UIElement>();

                            _RadioButtonList = new List<RadioButton>();

                            foreach (UIElement _radioButtonElement in _UIElementList)
                            {
                                RadioButton _radio = _radioButtonElement as RadioButton;
                                _RadioButtonList.Add(_radio);
                            }

                            _radioTemp = _RadioButtonList.First(x => x.Content.Equals(OpcionesEstructuraList.First(op => op.Codigo.Equals("13")).Descripcion));

                            _radioTemp.IsChecked = true;

                            this.opcionContrato = OpcionesEstructuraList.First(x => x.Codigo.Equals("13")).Descripcion;

                            this.itemTabSrikes.IsSelected = true;
                            strikes_delta_flag = "strikes";

                            this.txtPlazo.Focus();
                            this.txtPlazo.Text = _DetContratoList[0].FechaVcto.Subtract(this.datePiker_DateProccess.SelectedDate.Value).Days.ToString() + "d";
                            this.DatePickerVencimiento.SelectedDate = _DetContratoList[0].FechaVcto;
                            this.fechaVencimiento = _DetContratoList[0].FechaVcto;

                            if (_DetContratoList[0].TipoPayOff.Equals("01"))//Forward Asiático pero Vanilla?!?!?!?! (sacar este if)
                            {
                                this.comboPayOff.SelectedIndex = 0;
                                (this.comboBsFwdBsSpotAsianMomenos.Items[0] as ComboBoxItem).IsEnabled = true;
                                (this.comboBsFwdBsSpotAsianMomenos.Items[1] as ComboBoxItem).IsEnabled = true;
                                (this.comboBsFwdBsSpotAsianMomenos.Items[2] as ComboBoxItem).IsEnabled = false;
                                this.comboBsFwdBsSpotAsianMomenos.SelectedIndex = 1;

                                this.radioCompensacion.IsChecked = true;

                                this.radioEntregaFisica.IsEnabled = false;
                            }
                            else
                            {
                                this.comboPayOff.SelectedIndex = 1;
                                (this.comboBsFwdBsSpotAsianMomenos.Items[0] as ComboBoxItem).IsEnabled = false;
                                (this.comboBsFwdBsSpotAsianMomenos.Items[1] as ComboBoxItem).IsEnabled = false;
                                (this.comboBsFwdBsSpotAsianMomenos.Items[2] as ComboBoxItem).IsEnabled = true;

                                //Esto está controlado en el switch... if (_opcionEstructuraSeleccionada.Codigo.Equals("13"))

                                this._TablaFixing.comboFrecuenciaEntrada.SelectedIndex = 0;//No queda grabado en cartera.
                                this._TablaFixing.comboTipoPesoEntrada.SelectedIndex = 1;
                                    
                                this._TablaFixing.datePikerInicioEntrada.SelectedDate = _fixingList[0].Fijaciones.OrderBy(_Fix => _Fix.Fecha).First(_Fix => _Fix.Peso < 0).Fecha; // _encContrato.FechaContrato; 
                                this._TablaFixing.datePikerFinEntrada.SelectedDate = _fixingList[0].Fijaciones.OrderBy(_Fix => _Fix.Fecha).Last(_Fix => _Fix.Peso < 0).Fecha;

                                this._TablaFixing.datePikerInicio.SelectedDate = _fixingList[0].Fijaciones.OrderBy(_Fix => _Fix.Fecha).First(_Fix => _Fix.Peso >= 0).Fecha;
                                this._TablaFixing.datePikerFin.SelectedDate = _fixingList[0].Fijaciones.OrderBy(_Fix => _Fix.Fecha).Last(_Fix => _Fix.Peso >= 0).Fecha;

                                this._TablaFixing.checkSantiagoEntrada.IsChecked = true;


                                this.comboBsFwdBsSpotAsianMomenos.SelectedIndex = 2;                                
                                _TablaFixing.isEditing = true;
                                _TablaFixing.isEditing = false;                              
                                this._TablaFixing.Town = 2;

                                this.radioCompensacion.IsChecked = true;
                                this.radioEntregaFisica.IsEnabled = false;

                                this._TablaFixing.strike = _DetContratoList[0].Strike;
                                this._TablaFixing.spot = this.BSSpotValorizacion;
                            }
                            
                             this.strike = _DetContratoList[0].PorcStrike;
                            _Value.DecimalPlaces = 2;
                            _Value.SetChange(this.txtStrike1, strike);

                            _Value.DecimalPlaces = 0;
                            _Value.SetChange(this.txtNocional, _DetContratoList[0].MontoMon1);
                            this.nocional = _DetContratoList[0].MontoMon1;

                            _Value.DecimalPlaces = 0;
                            _Value.SetChange(this.txtNocionalContraMoneda, (this.strike * this.nocional));

                            _Value.DecimalPlaces = 4;
                            _Value.SetChange(this.txtPuntosCosto, (_DetContratoList[0].Strike - _DetContratoList[0].SpotDet));
                            this.PuntosCosto = Math.Round(_DetContratoList[0].Strike - _DetContratoList[0].SpotDet, 4);

                            _Value.DecimalPlaces = 4;
                            _Value.SetChange(this.txtSpotCosto, this.BSSpotValorizacion);
                            this.spot = this.BSSpotValorizacion;

                            PrimaContrato = _encContrato.PrimaInicial;
                            _Value.DecimalPlaces = _encContrato.CodMonPagPrima.Equals(13) ? 2 : 0;
                            _Value.SetChange(this.txtPrimaContrato, _encContrato.PrimaInicial);
                            valtxtPrimaContrato.DecimalPlaces = _Value.DecimalPlaces;

                            if (_encContrato.CodMonPagPrima.Equals(13))
                            {
                                this.ComboUnidadPrima.SelectedIndex = 1;
                            }
                            else
                            {
                                this.ComboUnidadPrima.SelectedIndex = 0;
                            }

                            this.ParidadPrima = double.Parse(this.txtSpotValorizacion.Text);  // _encContrato.ParMdaPrima;
                            _Value.DecimalPlaces = 4;
                            _Value.SetChange(this.txtParidadPrima, this.ParidadPrima); // _encContrato.ParMdaPrima);

                            this.txtStrike1.Focus();
                            txtNocional.Focus();
                            txtSpotCosto.Focus();
                            itemFrontOpciones.Focus();

                            this.tabPrincipal.SelectedIndex = 0;
                            this.isTextChanged = true;

                            try
                            {
                                Valorizar();
                            }
                            catch { }

                            #endregion Forward Asiático Entrada Salida
                            break;

                        case 14:
                            #region Call Spread Doble

                            SetRadioCompraVenta(_encContrato.CVEstructura);

                            _radioButtonType = (new RadioButton()).GetType();

                            _UIElementList = (this.stackOpciones.Children.ToList<UIElement>()).Where(x => x.GetType().Equals(_radioButtonType)).ToList<UIElement>();

                            _RadioButtonList = new List<RadioButton>();

                            foreach (UIElement _radioButtonElement in _UIElementList)
                            {
                                RadioButton _radio = _radioButtonElement as RadioButton;
                                _RadioButtonList.Add(_radio);

                            }

                            this.radioCompensacion.IsChecked = true;
                            this.radioEntregaFisica.IsEnabled = false;

                                //ASVG redundante??
                                _radioTemp = _RadioButtonList.First(x => x.Content.Equals(OpcionesEstructuraList.First(op => op.Codigo.Equals("14")).Descripcion));
                                this.opcionContrato = OpcionesEstructuraList.First(x => x.Codigo.Equals("14")).Descripcion;


                            _radioTemp.IsChecked = true;

                            this.itemTabSrikes.IsSelected = true;
                            strikes_delta_flag = "strikes";

                            this.txtPlazo.Text = _DetContratoList[0].FechaVcto.Subtract(this.datePiker_DateProccess.SelectedDate.Value).Days.ToString() + "d";
                            this.DatePickerVencimiento.SelectedDate = _DetContratoList[0].FechaVcto;
                            this.fechaVencimiento = _DetContratoList[0].FechaVcto;
                            this.radioEntregaFisica.IsEnabled = false;

                            if (_DetContratoList[0].TipoPayOff.Equals("01"))//Vanilla
                            {
                                this.comboPayOff.SelectedIndex = 0;

                                (this.comboBsFwdBsSpotAsianMomenos.Items[0] as ComboBoxItem).IsEnabled = true;
                                (this.comboBsFwdBsSpotAsianMomenos.Items[1] as ComboBoxItem).IsEnabled = true;
                                (this.comboBsFwdBsSpotAsianMomenos.Items[2] as ComboBoxItem).IsEnabled = false;
                                this.comboBsFwdBsSpotAsianMomenos.SelectedIndex = 1;
                            }

                            _Value.DecimalPlaces = 0;
                            _Value.SetChange(this.txtNocional, _DetContratoList[0].MontoMon1);
                            this.nocional = _DetContratoList[0].MontoMon1;

                            _Value.DecimalPlaces = 2;
                            _Value.SetChange(this.txtStrike1, _DetContratoList[0].Strike);
                            this.strike = _DetContratoList[0].Strike;

                            _Value.DecimalPlaces = 2;
                            _Value.SetChange(this.txtStrike2, _DetContratoList[1].Strike);
                            this.strike2 = _DetContratoList[1].Strike;

                            _Value.DecimalPlaces = 2;
                            _Value.SetChange(this.txtStrike3, _DetContratoList[2].Strike);
                            this.strike3 = _DetContratoList[2].Strike;

                            _Value.DecimalPlaces = 2;
                            _Value.SetChange(this.txtStrike4, _DetContratoList[3].Strike);
                            this.strike4 = _DetContratoList[3].Strike;

                            _Value.DecimalPlaces = 4;
                            _Value.SetChange(this.txtSpotCosto, this.BSSpotValorizacion);
                            this.spot = this.BSSpotValorizacion;

                            _Value.DecimalPlaces = _encContrato.CodMonPagPrima.Equals(13) ? 2 : 0;
                            _Value.SetChange(this.txtPrimaContrato, _encContrato.PrimaInicial);
                            valtxtPrimaContrato.DecimalPlaces = _Value.DecimalPlaces;

                            if (_encContrato.CodMonPagPrima.Equals(13))
                            {
                                this.ComboUnidadPrima.SelectedIndex = 1;
                            }
                            else
                            {
                                this.ComboUnidadPrima.SelectedIndex = 0;
                            }

                            this.ParidadPrima = double.Parse(this.txtSpotValorizacion.Text);  // _encContrato.ParMdaPrima;
                            _Value.DecimalPlaces = 4;
                            _Value.SetChange(this.txtParidadPrima, this.ParidadPrima); // _encContrato.ParMdaPrima);

                            if (_DetContratoList[0].Modalidad)
                            {
                                this.radioCompensacion.IsChecked = true;
                                this.radioEntregaFisica.IsChecked = false;
                            }
                            else
                            {
                                this.radioEntregaFisica.IsChecked = true;
                                this.radioCompensacion.IsChecked = false;
                            }

                            this.txtPlazo.Focus();
                            this.txtStrike1.Focus();
                            txtNocional.Focus();
                            txtSpotCosto.Focus();
                            itemFrontOpciones.Focus();

                            this.tabPrincipal.SelectedIndex = 0;
                            this.isTextChanged = true;

                            try
                            {
                                Valorizar();
                            }
                            catch { }

                            #endregion Call Spread Doble
                            break;
                    }
                }

                if (_encContrato.CodMonPagPrima.Equals(13))
                {
                    this.txtParidadPrima.IsEnabled = true;
                }
                else
                {
                    this.txtParidadPrima.IsEnabled = false;
                    this.txtParidadPrima.Text = "";
                }

                if (_encContrato.Estado.Equals("M") || _encContrato.Estado.Equals("N") || _encContrato.Estado.Equals("U") || _encContrato.Estado.Equals("E"))
                {
                    _Guardar.RutCliente = _encContrato.RutCliente;
                    _Guardar.CodigoCliente = _encContrato.Codigo;
                    _Guardar.Libro = _encContrato.Libro;
                    _Guardar.CarteraFinanciera = _encContrato.CarteraFinanciera;
                    _Guardar.CarteraNormativa = _encContrato.CarNormativa;
                    _Guardar.SubCarteraNormativa = _encContrato.SubCarNormativa;
                    _Guardar.FormaPagoPrima = _encContrato.fPagoPrima;
                    _Guardar.MonedaCompensacion = _DetContratoList[0].MdaCompensacion;
                    _Guardar.FormaPagoCompensacion = _DetContratoList[0].FormaPagoComp;
                    _Guardar.FormaPagoEntregaFisica = _DetContratoList[0].FormaPagoMon1;
                    _Guardar.FormaPagoContraMonedaEntregaFisica = _DetContratoList[0].FormaPagoMon2;
                    _Guardar.txtGlosa.Text = _encContrato.Glosa;
                    //PRD_10449
                    //_Guardar.CbxOpePAE.IsChecked = _encContrato.sRelacionaPAE.Equals("0") ? false : true;

                    //PRD_16803
                    string RelacionaPAE = _encContrato.sRelacionaPAE.ToString();
                    for (int i = 0; i < _Guardar.EstructuraRelacion.Count; i++)
                    {
                        if (_Guardar.EstructuraRelacion[i].CodigoRelacion == "2" && RelacionaPAE == "1")
                        {
                            _Guardar.ComboEstructRelacion.SelectedIndex = i;
                            this._Guardar.autoCompleteBoxOpLeasing.IsEnabled = false;
                            this._Guardar.autoCompleteBoxNumBienLeasing.IsEnabled = false;
                        }
                        else if (_Guardar.EstructuraRelacion[i].CodigoRelacion == "1" && RelacionaPAE == "0")
                        {
                            _Guardar.ComboEstructRelacion.SelectedIndex = i;
                            this._Guardar.autoCompleteBoxOpLeasing.IsEnabled = false;
                            this._Guardar.autoCompleteBoxNumBienLeasing.IsEnabled = false;
                        }
                    }                  
                    txtGlosaPricing.Text = _encContrato.Glosa;
                }

                globales._NumContrato = _Guardar.NumeroContrato;
                globales._NumFolio = _Guardar.NumeroFolio;
                itemTabPrima.IsSelected = true;
                itemTabDistribucion.IsSelected = true;
                itemTabEjercicio.Visibility = Visibility.Collapsed;

                //PRD_16803
                if (globales._NumContrato != 0 && _encContrato.Estado == "M" && _encContrato.CodEstructura.Equals(8) && _encContrato.CVEstructura.Equals("V"))
                {
                    AdminOpciones.SrvDetalles.WebDetallesSoapClient svc = wsGlobales.Detalles;
                    svc.Trae_ForwardRelacionadoAsync(globales._NumContrato);
                    svc.Trae_ForwardRelacionadoCompleted += new EventHandler<AdminOpciones.SrvDetalles.Trae_ForwardRelacionadoCompletedEventArgs>(svc_Trae_ForwardRelacionadoCompleted);
                }

                switch (_encContrato.Estado)
                {
                    case "M":
                        Recursos.globales._Estado = "M";
                        event_SendChangeTitle(string.Format("Modificación de Contrato N° : {0}", globales._NumContrato), UserControlName);
                        this._Transaccion = "MODIFICA";
                        Modificar();
                        break;
                    case "N":
                        Recursos.globales._Estado = "N";
                        event_SendChangeTitle(string.Format("Anticipo de Contrato N° : {0}", globales._NumContrato), UserControlName);
                        this._Transaccion = "ANTICIPA";
                        Anticipar();
                        break;
                    case "U":
                        Recursos.globales._Estado = "U";
                        this._Transaccion = "ANULA";
                        event_SendChangeTitle(string.Format("Anulación de Contrato N° : {0}", globales._NumContrato), UserControlName);
                        Anular();
                        break;
                    case "E":
                        itemTabEjercicio.Visibility = Visibility.Visible;
                        Recursos.globales._Estado = "E";
                        this._Transaccion = "EJERCE";

                        if (_encContrato.CVEstructura.Equals("C"))
                        {
                            textblockTitleEjercer.Text = "Banco Ejerce";
                            event_SendChangeTitle(string.Format("Banco Ejerce el Contrato N° : {0}", globales._NumContrato), UserControlName);
                        }
                        else
                        {
                            textblockTitleEjercer.Text = "Cliente Ejerce";
                            event_SendChangeTitle(string.Format("Cliente Ejerce el Contrato N° : {0}", globales._NumContrato), UserControlName);
                        }
                        ShowEjercer();
                        break;
                    default:
                        Recursos.globales._Estado = "C";
                        this._Transaccion = "";
                        event_SendChangeTitle(_TitleOriginal, UserControlName);
                        this.IdBtnLimpiar.Content = "Limpiar";
                        this.IdBtnGuardar.Content = "Grabar";
                        break;
                }

            }
            catch
            {
                isOpcionFromCartera = false;
            }

            IsLoading = false;

        }
        #endregion SendId

        /// <summary>
        /// Setea los radio button de Compra o Venta.
        /// </summary>
        /// <param name="CoV">String con 'C' o 'V'.</param>
        private void SetRadioCompraVenta(String CoV)
        {
            if (CoV.Equals("C"))
            {
                this.radioCompra.IsChecked = true;
                this.radioVenta.IsChecked = false;
            }
            else
            {
                this.radioCompra.IsChecked = false;
                this.radioVenta.IsChecked = true;
            }
        }

        private void Modificar()
        {
            this.ComboUnidadPrima.IsEnabled = false;
            this.txtPrimaContrato.IsEnabled = false;
            this.expanderOpciones.IsEnabled = false;
            this.itemTabDeltas.IsEnabled = false;
            this.itemValCartera.IsEnabled = false;
            this.itemSetdePrecios.IsEnabled = false;
            this.itemTabResultadoVenta.IsEnabled = true; //5843
            this.IdBtnLimpiar.Content = "Cancelar";
            this.IdBtnGuardar.Content = "Modificar";
            LoadPortfolioAndBook();   //PRD-3162
        }

        private void Anticipar()
        {
            CanvasNocional.IsHitTestVisible = false;
            CanvasDefinicionOpcion.IsHitTestVisible = false;
            CanvasOpionesContratoFront.IsHitTestVisible = false;
            CanvasStrikesDelta.IsHitTestVisible = false;

            this.itemValCartera.IsEnabled = false;
            this.itemSetdePrecios.IsEnabled = false;
            this.itemTabDeltas.IsEnabled = false;
            this.DatePickerSetPrecios.IsEnabled = false;
            this.DatePickerVencimiento.IsEnabled = false;
            this.datePiker_DateProccess.IsEnabled = false;

            this.radioCompra.IsEnabled = false;
            this.radioVenta.IsEnabled = false;

            this.btnTablaFixing.IsEnabled = false;
            this.btnComponentes.IsEnabled = false;
            this.btnTopoLogiaVegaPricing.IsEnabled = false;

            this.expanderOpciones.IsEnabled = false;

            this.comboPayOff.IsEnabled = false;
            this.comboBsFwdBsSpotAsianMomenos.IsEnabled = false;

            this.txtNocional.IsEnabled = false;
            this.txtStrike1.IsEnabled = false;
            this.txtStrike2.IsEnabled = false;
            this.txtStrike3.IsEnabled = false;
            this.txtSpotCosto.IsEnabled = false;
            this.txtPlazo.IsEnabled = false;
            this.txtPuntosCosto.IsEnabled = false;

            this.itemTabPrima.IsEnabled = false;
            this.itemTabDistribucion.IsEnabled = false;

            this.itemTabUnwind.IsSelected = true;

            CanvasSpotPuntos.IsHitTestVisible = false;
            CanvasGriegas.IsHitTestVisible = false;
            this.IdBtnLimpiar.Content = "Cancelar";
            this.IdBtnGuardar.Content = "Anticipar";
            LoadPortfolioAndBook();   //PRD-3162
        }

        private void Anular()
        {
            this.itemValCartera.IsEnabled = false;
            this.itemSetdePrecios.IsEnabled = false;
            CanvasNocional.IsHitTestVisible = false;
            CanvasDefinicionOpcion.IsHitTestVisible = false;
            CanvasOpionesContratoFront.IsHitTestVisible = false;
            CanvasStrikesDelta.IsHitTestVisible = false;
            CanvasCostoContrato.IsHitTestVisible = false;
            CanvasSpotPuntos.IsHitTestVisible = false;
            CanvasGriegas.IsHitTestVisible = false;
            this.IdBtnLimpiar.Content = "Cancelar";
            this.IdBtnGuardar.Content = "Anular";
        }

        private void event_tabGridsValCartera_SelectedChanched(object sender, SelectionChangedEventArgs e)
        {
            ReCreateDataGrid();
        }

        private void ReCreateDataGrid() // DataGrid OldDataGrid, TabItem ItemParent
        {
            #region Encabezado

            if (canvasTabEncContrato != null)
            {
                if (canvasTabEncContrato.Children.Count > 0)
                {
                    canvasTabEncContrato.Children.Clear();
                }

                AdminOpciones.OpcionesFX.DataGrids.EncCartera _Encabezado = new AdminOpciones.OpcionesFX.DataGrids.EncCartera();
                _Encabezado.grdValCarteraEstructuras.ItemsSource = EncContratoList;
                _Encabezado.event_SendChecked += new AdminOpciones.Delegados.SendChecked(event_SendChecked_Enc);
                _Encabezado.event_SendID += new AdminOpciones.Delegados.SendID(event_SendID_Enc);

                canvasTabEncContrato.Children.Add(_Encabezado);
                CargaEstructuraRelacion();
            }

            #endregion

            #region Detalle

            if (canvasTabDetContrato != null)
            {
                if (canvasTabDetContrato.Children.Count > 0)
                {
                    canvasTabDetContrato.Children.Clear();
                }
                //Aquí no viene el nombre de la estructura para el detalle??
                //binding por campo Estructura
                AdminOpciones.OpcionesFX.DataGrids.DetCartera _Detalle = new AdminOpciones.OpcionesFX.DataGrids.DetCartera();
                _Detalle.grdValCartera.ItemsSource = DetContratoList;
                _Detalle.event_SendChecked += new AdminOpciones.Delegados.SendChecked(event_SendChecked_Det);
                _Detalle.event_SendID += new AdminOpciones.Delegados.SendID(event_SendID_Det);

                canvasTabDetContrato.Children.Add(_Detalle);
            }

            #endregion
        }

        private void event_checkBoxVegaWeighted_Clicked(object sender, RoutedEventArgs e)
        {
            this.isTextChanged = true;
            Valorizar();
        }

        private void event_txtPosicionDelta_TextChanged(object sender, TextChangedEventArgs e)
        {
            ActualizarTotalizadorDeltas();
        }

        private void ActualizarTotalizadorDeltas()
        {
            double _opciones, _forward, _spot, _total;

            try
            {
                _opciones = double.Parse(this.txtPosicionOpciones.Text);
            }
            catch { _opciones = 0; }
            try
            {
                _forward = double.Parse(this.txtPosicionForward.Text);
            }
            catch { _forward = 0; }

            try
            {
                _spot = double.Parse(this.txtPosicionSpot.Text);
            }
            catch { _spot = 0; }

            try
            {

                _total = _opciones + _forward + _spot;
            }
            catch { _total = 0; }

            if (txtTotalDeltas != null)
            {
                ValidAmount _Valid = new ValidAmount();
                _Valid.DecimalPlaces = 0;
                _Valid.SetChange(this.txtTotalDeltas, _total);
            }

        }

        private void event_comboSetPrecios_SelectedChanged(object sender, SelectionChangedEventArgs e)
        {
            ComboBox _comboSetPrecios = sender as ComboBox;

            switch (_comboSetPrecios.SelectedIndex)
            {
                case 0:
                    this.setPreciosValCartera = 0;//Riesgo
                    this.setPrecios_Pricing = 0;
                    if (txtSetdePrecioValCartera != null)
                        txtSetdePrecioValCartera.Text = "Riesgo";
                    if (txtSetdePrecios_Pricing != null)
                        txtSetdePrecios_Pricing.Text = "Riesgo";
                    break;
                case 1:

                    this.setPreciosValCartera = 2;//Costo                
                    this.setPrecios_Pricing = 2;
                    txtSetdePrecioValCartera.Text = "Costo";
                    txtSetdePrecios_Pricing.Text = "Costo";
                    break;
            }

            //CargarSetdePrecios();
            if (DatePickerSetPrecios != null)
                LoadSetPrecios(DatePickerSetPrecios.SelectedDate.Value, curvaDom, curvaFor, setPreciosValCartera);


        }

        private void event_radioVariando_Checked(object sender, RoutedEventArgs e)
        {
            RadioButton _radioVariando = sender as RadioButton;

            switch (_radioVariando.Name)
            {
                case "radioVariando_Strike1":
                    if (radioVariando_Strike2 != null)
                        this.radioVariando_Strike2.IsChecked = false;

                    break;
                case "radioVariando_Strike2":
                    this.radioVariando_Strike1.IsChecked = false;

                    break;
                case "radioVariando_Strike3":

                    break;
                case "radioVariando_Puntos":
                    this.radioVariando_Strike1.IsChecked = false;
                    this.radioVariando_Strike2.IsChecked = false;

                    break;

            }
        }

        private void Variando_Valorizar()
        {
            try
            {
                //if "es una estructura"
                if ((!_opcionEstructuraSeleccionada.Codigo.Equals("-1") && !_opcionEstructuraSeleccionada.Codigo.Equals("0")))
                {
                    string strikes_delta_values_xml = a.genera_XML_strikes_deltas(this);

                    switch (_opcionEstructuraSeleccionada.Codigo)
                    {
                        case "8":
                            Variando_ForwardAmericano();
                            break;

                        case "6":
                            StartLoading(this.PrincipalCanvas);
                            Variando_ForwardSintetico("strikes", ((ComboBoxItem)this.comboPayOff.SelectedItem).Content.ToString(), this.BsSpot_BsFwd_AsianMomentos_flag, this.FixingDataString, "Forward Sintetico", ((ComboBoxItem)this.comboPayOff.SelectedItem).Content.ToString(), PuntosCosto, this.datePiker_DateProccess.SelectedDate.Value, this.fechaVencimiento, this.paridad, this.compra_venta, this.nocional, this.spot, strikes_delta_values_xml, this.curvaDom, this.curvaFor, this.setPrecios_Pricing);
                            break;

                        case "1":
                            break;

                        case "7":
                            break;

                        case "3":
                            break;

                        case "2":
                            StartLoading(this.PrincipalCanvas);
                            Variando_RiskReversal(this.radioVariando_Strike1.IsChecked.Value ? "Ceiling" : this.radioVariando_Strike2.IsChecked.Value ? "Floor" : "", "strikes", "Vanilla", this.BsSpot_BsFwd_AsianMomentos_flag, this.FixingDataString, "Risk Reversal", "Vanilla", PuntosCosto, this.datePiker_DateProccess.SelectedDate.Value, this.fechaVencimiento, this.paridad, this.compra_venta, this.nocional, this.spot, strikes_delta_values_xml, this.curvaDom, this.curvaFor, this.setPrecios_Pricing);
                            break;

                        case "4":
                            StartLoading(this.PrincipalCanvas);
                            Variando_ForwardAcotado(this.radioVariando_Strike2.IsChecked.Value ? "Cota" : this.radioVariando_Strike1.IsChecked.Value ? "Puntos" : "", "Ganancia", "strikes", "Vanilla", this.BsSpot_BsFwd_AsianMomentos_flag, this.FixingDataString, "Forward Perdida Acotada", "Vanilla", PuntosCosto, this.datePiker_DateProccess.SelectedDate.Value, this.fechaVencimiento, this.call_put, this.paridad, this.compra_venta, this.nocional, this.spot, strikes_delta_values_xml, this.curvaDom, this.curvaFor, this.SpotContrato, this.PuntosCosto, this.setPrecios_Pricing);
                            break;

                        case "5":
                            StartLoading(this.PrincipalCanvas);
                            Variando_ForwardAcotado(this.radioVariando_Strike2.IsChecked.Value ? "Cota" : this.radioVariando_Strike1.IsChecked.Value ? "Puntos" : "", "Perdida", "strikes", "Vanilla", this.BsSpot_BsFwd_AsianMomentos_flag, this.FixingDataString, "Forward Perdida Acotada", "Vanilla", PuntosCosto, this.datePiker_DateProccess.SelectedDate.Value, this.fechaVencimiento, this.call_put, this.paridad, this.compra_venta, this.nocional, this.spot, strikes_delta_values_xml, this.curvaDom, this.curvaFor, this.SpotContrato, this.PuntosCosto, this.setPrecios_Pricing);
                            break;

                        case "9":
                        case "10":
                            StartLoading(this.PrincipalCanvas);
                            double MtM = double.Parse(this.txtMtMContrato.Text);
                            Variando_StripAsiatico(MtM, ((ComboBoxItem)this.comboPayOff.SelectedItem).Content.ToString(), FixingDataString, this.opcionContrato, ((ComboBoxItem)this.comboPayOff.SelectedItem).Content.ToString(), PuntosCosto, this.datePiker_DateProccess.SelectedDate.Value, fechaVencimiento, this.call_put, paridad, compra_venta, nocional, spot, strikes_delta_values_xml, curvaDom, curvaFor, 0, xmlStrip);
                            break;

                        case "11":
                        case "12":
                            StartLoading(this.PrincipalCanvas);
                            string TipoSpread = _opcionEstructuraSeleccionada.Codigo;
                            Variando_CallPutSpread(this.radioVariando_Strike1.IsChecked.Value ? "Ceiling" : this.radioVariando_Strike2.IsChecked.Value ? "Floor" : "", "strikes", "Vanilla", this.BsSpot_BsFwd_AsianMomentos_flag, this.FixingDataString, "Risk Reversal", "Vanilla", PuntosCosto, this.datePiker_DateProccess.SelectedDate.Value, this.fechaVencimiento, this.paridad, this.compra_venta, this.nocional, this.spot, strikes_delta_values_xml, this.curvaDom, this.curvaFor, this.setPrecios_Pricing, TipoSpread);
                            break;

                        case "13"://Forward Asiatico Entrada Salida PRD_12567
                            break;

                        case "14"://PRD_20559 Call Spread Doble
                            StartLoading(this.PrincipalCanvas);
                            string _SolverStrike = "";
                            //ASVG solución temporal muy básica
                            #region Determina el Strike Resuelto
                            if (this.radioVariando_Strike1.IsChecked.Value)
                            {
                                _SolverStrike = "Strike1";
                            }
                            else if (this.radioVariando_Strike2.IsChecked.Value)
                            {
                                _SolverStrike = "Strike2";
                            }
                            else if (this.radioVariando_Strike3.IsChecked.Value)
                            {
                                _SolverStrike = "Strike3";
                            }
                            else if (this.radioVariando_Strike4.IsChecked.Value)
                            {
                                _SolverStrike = "Strike4";
                            }
                            #endregion Determina el Strike Resuelto
                            Variando_CallSpreadDoble(_SolverStrike, "strikes", "Vanilla", this.BsSpot_BsFwd_AsianMomentos_flag, this.FixingDataString, "Risk Reversal", "Vanilla", PuntosCosto, this.datePiker_DateProccess.SelectedDate.Value, this.fechaVencimiento, this.paridad, this.compra_venta, this.nocional, this.spot, strikes_delta_values_xml, this.curvaDom, this.curvaFor, this.setPrecios_Pricing, _opcionEstructuraSeleccionada.Codigo);
                            break;//Revisar esta funcionalidad.
                    }
                }
                else //no es una estructura
                {
                    //validaciones pre-valorizar
                    if (
                        (!this.datePiker_DateProccess.SelectedDate.Value.Equals(new DateTime(0001, 01, 01)) && this.datePiker_DateProccess.Text != "" && this.datePiker_DateProccess.SelectedDate.Value != new DateTime(0001, 01, 01))
                                   && this.txtPlazo.Text != ""
                                   && this.txtNocional.Text != ""
                                   && this.txtSpotCosto.Text != ""
                                   && (this.txtStrike1.Text != "" && this.itemTabSrikes.IsSelected)
                        && this.txtMtMContrato.Text != ""
                        )
                    {
                        //Opción Vanilla
                        if (((ComboBoxItem)this.comboPayOff.SelectedItem).Content.Equals("Vanilla"))
                        {
                            StartLoading(this.PrincipalCanvas);
                            double MtM = double.Parse(this.txtMtMContrato.Text);
                            Variando_Vanilla(BsSpot_BsFwd_AsianMomentos_flag, this.paridad, this.call_put, this.compra_venta, this.nocional, this.spot, this.PuntosCosto, this.strike, MtM, this.datePiker_DateProccess.SelectedDate.Value, this.fechaVencimiento, this.curvaDom, this.curvaFor, this.setPrecios_Pricing);
                        }
                        //Opción Asiática
                        else if (((ComboBoxItem)this.comboPayOff.SelectedItem).Content.Equals("Asiaticas"))
                        {
                            StartLoading(this.PrincipalCanvas);
                            double MtM = double.Parse(this.txtMtMContrato.Text);
                            Variando_Asiatica(BsSpot_BsFwd_AsianMomentos_flag, this.paridad, this.call_put, this.compra_venta, this.nocional, this.spot, this.strike, MtM, this.datePiker_DateProccess.SelectedDate.Value, this.fechaVencimiento, this.curvaDom, this.curvaFor, this.FixingDataString, this.setPrecios_Pricing);
                        }
                    }
                }
            }
            catch
            {
            }
        }

        private void Enable_RadioButtons_Solver()
        {
            a.Enable_RadioButtons_Solver(this);
        }

        private void event_comboBsFwdBsSpotAsianMomenos_SelectedChanged(object sender, SelectionChangedEventArgs e)
        {
            ComboBox _ComboModelo = sender as ComboBox;

            switch (_ComboModelo.SelectedIndex)
            {
                case 0:
                    BsSpot_BsFwd_AsianMomentos_flag = "BsFwd";
                    if (txtPuntosCosto != null)
                    {
                        this.txtPuntosCosto.IsEnabled = comboPayOff.SelectedIndex.Equals(0) ? true : false;
                        if (isOpcionFromCartera == false && datePiker_DateProccess.SelectedDate != null && DatePickerVencimiento.SelectedDate != null && BsSpot_BsFwd_AsianMomentos_flag.Equals("BsFwd"))
                        {
                            SetPuntosForward(datePiker_DateProccess.SelectedDate.Value, fechaVencimiento, this.spot, this.curvaDom, this.curvaFor, this.setPrecios_Pricing);
                        }
                    }
                    break;
                case 1:
                    BsSpot_BsFwd_AsianMomentos_flag = "BsSpot";
                    this.txtPuntosCosto.IsEnabled = false;
                    if (isOpcionFromCartera == false && datePiker_DateProccess.SelectedDate != null && DatePickerVencimiento.SelectedDate != null && BsSpot_BsFwd_AsianMomentos_flag.Equals("BsSpot"))
                    {
                        SetPuntosForward(datePiker_DateProccess.SelectedDate.Value, fechaVencimiento, this.spot, this.curvaDom, this.curvaFor, this.setPrecios_Pricing);
                    }
                    break;
                case 2:
                    BsSpot_BsFwd_AsianMomentos_flag = "AsianMomentos";
                    this.txtPuntosCosto.IsEnabled = false;
                    this.txtPuntosCosto.Text = "";
                    PuntosCosto = double.NaN;
                    break;
            }

            isTextChanged = true;
            if (!IsClearData)
            {
                Valorizar();
            }
        }

        private void event_ComboCurva_SelectedChange(object sender, SelectionChangedEventArgs e)
        {
            if (CurvasMonedasList != null && CurvasMonedasList.Count > 0 && CurvasMonedasList[0].CodigoCurva != null && comboCurvas.SelectedIndex >= 0)
            {
                this.grdCurvas.ItemsSource = CurvasMonedasList.First(x => x.CodigoCurva.Equals(comboCurvas.SelectedItem)).CurvaMoneda;
            }
        }

        private void event_TotalizadorGriegasTab_SelectedChange(object sender, SelectionChangedEventArgs e)
        {
            ActualizarTotalizadorDeltas();
        }

        private void event_btnLimpiar_Clecked(object sender, RoutedEventArgs e)
        {
            checkboxAsociadoStrip.IsChecked = false;
            string _fix = "<FixingData>";
            _fix += "<FixingValues/>";
            _fix += "</FixingData>";
            this.radioVariando_Strike1.IsEnabled = false;
            this.radioVariando_Strike2.IsEnabled = false;
            this.radioVariando_Strike3.IsEnabled = false;
            this.radioVariando_Strike4.IsEnabled = false;

            _TablaFixing.grdTablaFixing.ItemsSource = null;
            _TablaFixing_event_TablaFixingResult(_fix);
            isOpcionFromCartera = false;
            this.IdBtnGuardar.IsEnabled = true;
            this.radioOpcCall.IsChecked = true;
            btnSensibilidadPricing.Content = "Sensibilidad";
            checkboxSensitivity.Visibility = Visibility.Collapsed;
            ClearData();
            //se hace en la ClearData();
            //event_SendChangeTitle(_TitleOriginal, UserControlName);
        }

        private void grdTopologiaVegaCALLPUT_KeyDown(object sender, KeyEventArgs e)
        {
            CopyDataGridContentCallPut(sender, e);
        }

        private void grdTopologiaVegaRRFLY_KeyDown(object sender, KeyEventArgs e)
        {
            CopyDataGridContentRRFLY(sender, e);
        }

        private void event_MouseEnter_itemSetdePrecios(object sender, MouseEventArgs e)
        {
        }

        private void event_MouseEnter_itemFrontOpciones(object sender, MouseEventArgs e)
        {
        }

        private void event_btnCargarSpot_Clicked(object sender, RoutedEventArgs e)
        {
            SrvLoadFront.LoadFrontSoapClient _SrvLoadFront = wsGlobales.LoadFront;//new AdminOpciones.SrvLoadFront.LoadFrontSoapClient();
            _SrvLoadFront.LoadSpotCompleted += new EventHandler<AdminOpciones.SrvLoadFront.LoadSpotCompletedEventArgs>(_SrvLoadFront_LoadSpotCompleted);

            if (this.DatePickerSetPrecios.SelectedDate != null)
            {
                _SrvLoadFront.LoadSpotAsync(setPreciosValCartera, this.DatePickerSetPrecios.SelectedDate.Value);
            }
        }

        void _SrvLoadFront_LoadSpotCompleted(object sender, AdminOpciones.SrvLoadFront.LoadSpotCompletedEventArgs e)
        {
            XDocument SpotXML;
            string strFechaSetPrecio = "";
            string strSpot = "";
            string strStatus = "";
            bool Status;
            ValidAmount _Value = new ValidAmount();
            try
            {
                SpotXML = new XDocument(XDocument.Parse(e.Result));

                strStatus = SpotXML.Element("Data").Element("Status").Attribute("Value").Value;

                Status = strStatus.Equals("OK") ? true : false;

                if (Status)
                {
                    strFechaSetPrecio = SpotXML.Element("Data").Element("FechaSetPrecios").Attribute("Fecha").Value;
                    strSpot = SpotXML.Element("Data").Element("Spot").Attribute("Value").Value;

                    this.FechaSetdePrecios = DateTime.Parse(strFechaSetPrecio);
                    this.BSSpotValorizacion = double.Parse(strSpot);
                    this.spot = BSSpotValorizacion;
                    _Value.DecimalPlaces = 4;
                    _Value.SetChange(this.txtSpotValorizacion, BSSpotValorizacion);
                    LoadSetPreciosSpot(this.DatePickerSetPrecios.SelectedDate.Value, BSSpotValorizacion, curvaDom, curvaFor, setPreciosValCartera);
                }
                else
                {
                    LoadSetPrecios(this.DatePickerSetPrecios.SelectedDate.Value, curvaDom, curvaFor, setPreciosValCartera);
                }

            }
            catch
            {
                this.txtSpotValorizacion.Text = "";
                this.BSSpotValorizacion = double.NaN;
                this.spot = double.NaN;

                PutLayer(this.PrincipalCanvas, "SET DE PRECIOS INCOMPLETO");
                PutLayer(this.CanasTab2, "SET DE PRECIOS INCOMPLETO");

            }

        }

        /// <summary>
        /// Trae y Actualiza Puntos Forward y re-valoriza en el "Completed".
        /// </summary>
        /// <param name="fechaVal"></param>
        /// <param name="fechaVcto"></param>
        /// <param name="Spot"></param>
        /// <param name="curvaDom"></param>
        /// <param name="curvaFor"></param>
        /// <param name="enumSetPrecios"></param>
        private void SetPuntosForward(DateTime fechaVal, DateTime fechaVcto, double Spot, string curvaDom, string curvaFor, int enumSetPrecios)
        {
            SrvLoadFront.LoadFrontSoapClient _SrvLoadFront = wsGlobales.LoadFront;//new AdminOpciones.SrvLoadFront.LoadFrontSoapClient();
            _SrvLoadFront.PuntosForwardCompleted += new EventHandler<AdminOpciones.SrvLoadFront.PuntosForwardCompletedEventArgs>(_SrvLoadFront_PuntosForwardCompleted);
            _SrvLoadFront.PuntosForwardAsync(fechaVal, fechaVcto, FechaSetdePrecios, Spot, curvaDom, curvaFor, enumSetPrecios);
        }

        void _SrvLoadFront_PuntosForwardCompleted(object sender, AdminOpciones.SrvLoadFront.PuntosForwardCompletedEventArgs e)
        {
            if (!e.Result.Equals(double.NaN))
            {
                double _puntosFwd = e.Result;

                ValidAmount _Value = new ValidAmount();

                _Value.DecimalPlaces = 4;
                _Value.SetChange(this.txtPuntosCosto, _puntosFwd);

                this.PuntosCosto = Math.Round(_puntosFwd, 4);
                if (!BsSpot_BsFwd_AsianMomentos_flag.Equals("AsianMomentos"))
                {
                    isTextChanged = true;
                    Valorizar();
                }
            }
            //throw new NotImplementedException();
        }

        private void event_ComboUnidadPrima_SelectedCHanged(object sender, SelectionChangedEventArgs e)
        {
            ComboBox _comboUnidadPrima = sender as ComboBox;
            ValidAmount _Value = new ValidAmount();

            if (_Guardar != null)
            {
                if (((ComboBoxItem)_comboUnidadPrima.SelectedItem).Content.Equals("CLP"))
                {
                    this._Guardar.codigoMonPrima = int.Parse(this.codigoMon2);
                    this._Guardar.CodigoMonedaPrima = int.Parse(this.codigoMon2);
                    PrimaContrato = (double.Parse(txtDistribucion.Text) - double.Parse(txtMtMContrato.Text));
                    this._Guardar.primaInicial = PrimaContrato;
                    this._Guardar.primaInicialML = PrimaContrato;
                }
                else
                {
                    if (ParidadPrima.Equals(0))
                    {
                        ParidadPrima = double.Parse(txtSpotCosto.Text);
                    }
                    _Value.DecimalPlaces = 4;
                    _Value.SetChange(txtParidadPrima, ParidadPrima);
                    this._Guardar.codigoMonPrima = int.Parse(this.codigoMon1);
                    this._Guardar.CodigoMonedaPrima = int.Parse(this.codigoMon1);

                    if (txtDistribucion.Text.Equals(""))
                    {
                        this._Guardar.primaInicial = (double.Parse(txtDistribucion.Text) - double.Parse(txtMtMContrato.Text)) / ParidadPrima;
                    }
                    else
                    {
                        this._Guardar.primaInicial = (0 - double.Parse(txtMtMContrato.Text)) / ParidadPrima;
                    }

                    this._Guardar.primaInicialML = (double.Parse(txtDistribucion.Text) - double.Parse(txtMtMContrato.Text));
                    PrimaContrato = this._Guardar.primaInicial;
                }

                this._Guardar.txtBlockMonedaPrimaCompensacion.Text = ((ComboBoxItem)_comboUnidadPrima.SelectedItem).Content.ToString();
                this._Guardar.txtBlockMonedaPrimaEntregaFisica.Text = ((ComboBoxItem)_comboUnidadPrima.SelectedItem).Content.ToString();
            }

            if (txtParidadPrima != null)
            {
                if (_comboUnidadPrima.SelectedIndex.Equals(0))
                {
                    this.txtParidadPrima.Text = "";
                    this.txtParidadPrima.IsEnabled = false;

                    if (!txtMtMContrato.Text.Equals("") && !this.txtPrimaContrato.Text.Equals(""))
                    {
                        try
                        {
                            _Value.DecimalPlaces = 0;
                            _Value.SetChange(this.txtDistribucion, (MtMContrato + PrimaContrato));

                            Distribucion = MtMContrato + PrimaContrato;
                        }
                        catch
                        {
                            this.txtDistribucion.Text = "";
                            Distribucion = double.NaN;
                        }
                    }
                    else
                    {
                        txtDistribucion.Text = "";
                        Distribucion = double.NaN;
                    }

                    _Value.DecimalPlaces = 0;
                    _Value.SetChange(this.txtPrimaContrato, PrimaContrato);
                }
                else
                {

                    this.txtParidadPrima.IsEnabled = true;
                    _Value.DecimalPlaces = 2;
                    _Value.SetChange(this.txtPrimaContrato, PrimaContrato);
                    IsCalculatePrima = true;
                }
            }
        }

        private void event_TabControlUnwind_SelectedChanged(object sender, SelectionChangedEventArgs e)
        {
            TabControl _TabControlUnWind = sender as TabControl;
            ValidAmount _Value = new ValidAmount();

            switch (_TabControlUnWind.SelectedIndex)
            {
                case 0:
                    if (this.txtUnwind != null)
                    {
                        if (this.txtUnwind.Text != "")
                        {
                            _Value.DecimalPlaces = 0;
                            _Value.SetChange(this.txtUnwind, Unwind);
                        }
                    }
                    break;
                case 1:
                    if (this.txtPrimaContrato.Text != "")
                    {
                        _Value.DecimalPlaces = this.ComboUnidadPrima.SelectedIndex.Equals(1) ? 2 : 0;
                        _Value.SetChange(this.txtPrimaContrato, PrimaContrato);
                    }

                    if (this.txtParidadPrima.IsEnabled == true && this.txtParidadPrima.Text != "")
                    {
                        _Value.DecimalPlaces = 4;
                        _Value.SetChange(this.txtParidadPrima, ParidadPrima);
                    }
                    break;
                case 2:
                    if (txtMtMContrato != null && txtMtMContrato.Text != "")
                    {
                        _Value.DecimalPlaces = 0;
                        _Value.SetChange(this.txtMtMContrato, MtMContrato);
                    }
                    if (txtDistribucion != null && txtDistribucion.Text != "")
                    {
                        _Value.DecimalPlaces = 0;
                        _Value.SetChange(this.txtDistribucion, Distribucion);
                    }
                    break;
            }


            if (ComboUnidadPrima != null && _TabControlUnWind.SelectedIndex == 2)
            {

                if (((ComboBoxItem)ComboUnidadPrima.SelectedItem).Content.Equals("CLP"))
                {
                    if (txtPrimaContrato.Text != "" && txtMtMContrato.Text != "")
                    {
                        try
                        {
                            _Value.DecimalPlaces = 0;
                            _Value.SetChange(this.txtDistribucion, (PrimaContrato + MtMContrato));
                            Distribucion = PrimaContrato + MtMContrato;

                        }
                        catch
                        {
                            txtDistribucion.Text = "";
                            Distribucion = double.NaN;
                        }
                    }
                    else
                    {
                        txtDistribucion.Text = "";
                        Distribucion = double.NaN;

                    }
                }

                if (((ComboBoxItem)ComboUnidadPrima.SelectedItem).Content.Equals("USD"))
                {
                    if (txtMtMContrato.Text != "" && txtParidadPrima.Text != "" && txtPrimaContrato.Text != "")
                    {
                        try
                        {
                            _Value.DecimalPlaces = 0;
                            _Value.SetChange(this.txtDistribucion, ((PrimaContrato * ParidadPrima) + MtMContrato));

                        }
                        catch
                        {
                            txtDistribucion.Text = "";
                            Distribucion = double.NaN;
                        }
                    }
                    else
                    {
                        txtDistribucion.Text = "";
                        Distribucion = double.NaN;
                    }
                }
            }
        }

        private void InterpVol(DateTime fechaSmile, int Plazo, string Paridad, double Spot, double Strike, string CurvaDom, string CurvaFor, int SetPricing)
        {
            SrvValorizador.SrvValorizadorCarteraSoapClient _SrvValorizador = wsGlobales.Valorizador;//new AdminOpciones.SrvValorizador.SrvValorizadorCarteraSoapClient();
            _SrvValorizador.InterpVolCompleted += new EventHandler<AdminOpciones.SrvValorizador.InterpVolCompletedEventArgs>(_SrvValorizador_InterpVolCompleted);
            _SrvValorizador.InterpVolAsync(fechaSmile, Plazo, Paridad, Spot, Strike, CurvaDom, CurvaFor, SetPricing);
        }

        void _SrvValorizador_InterpVolCompleted(object sender, AdminOpciones.SrvValorizador.InterpVolCompletedEventArgs e)
        {
            double _result = e.Result;
            if (!_result.Equals(double.NaN))
            {
                ValidAmount _Value = new ValidAmount();
                _Value.DecimalPlaces = 5;
                _Value.SetChange(this.txtInterpVol_Volatilidad, _result);
            }
            else
            {
                this.txtInterpVol_Volatilidad.Text = "";
            }
            //throw new NotImplementedException();
        }

        #region algunos eventos
        private void event_btnTopoLogiaVegaPricing_Click(object sender, RoutedEventArgs e)
        {
            popUpTopologiaVegaPricing.Show();
        }

        private void event_comboFiltroCheckOperacion_MouseEnter(object sender, MouseEventArgs e)
        {
            this.btnValorizadorCartera.Focus();
        }

        private void event_grdCurvaFwUSD_KeyDown(object sender, KeyEventArgs e)
        {
            CopyDataGridContentCurvaFwd(sender, e);

        }

        private void event_grdTotalizadorValCartera_KeyDown(object sender, KeyEventArgs e)
        {
            CopyDataGridContentTotalizador(sender, e);
        }

        private void event_btnguardar_MouseEnter(object sender, MouseEventArgs e)
        {
            this.IdBtnGuardar.Focus();
        }

        private void event_BorderCheckImage_MouseLeftButtonUp(object sender, MouseButtonEventArgs e)
        {
            if (EncContratoList != null && EncContratoList.Count > 0)
            {
                this.CheckImage.Visibility = this.CheckImage.Visibility == Visibility.Visible ? Visibility.Collapsed : Visibility.Visible;

                string _filtro = this.CheckImage.Visibility == Visibility.Visible ? "Todas" : "Ninguna";

                if (_filtro.Equals("Todas"))
                {
                    for (int i = 0; i < EncContratoList.Count; i++)
                    {
                        EncContratoList[i].Checked = true;
                    }
                }

                if (_filtro.Equals("Ninguna"))
                {
                    for (int i = 0; i < EncContratoList.Count; i++)
                    {
                        EncContratoList[i].Checked = false;
                    }
                }

                isEncOrDetCheck_Clicked = true;
            }
            ReCreateDataGrid();
        }

        private void event_BorderCheckImage_MouseEnter(object sender, MouseEventArgs e)
        {
        }
        #endregion algunos eventos

        #region "Modifica Contrato"

        private void _ModificaContrato(int _NumContrato)
        {
            isLoadContract = true;
            _CargaContrato();
        }

        private void _CargaContrato()
        {
            this.ClearData();
            ValidAmount _Value = new ValidAmount();

            try
            {
                #region "Variables"
                List<StructEncContrato> x_encContrato = this.EncContratoList.Where(x => x.NumContrato.Equals(Recursos.globales._NumContrato)).ToList<StructEncContrato>();
                StructEncContrato _encContrato = x_encContrato[0];

                List<StructDetContrato> _DetContratoList = this.DetContratoList.Where(x => x.NumContrato.Equals(_encContrato.NumContrato)).OrderBy(x => x.NumEstructura).ToList<StructDetContrato>();
                List<StructFixingDataContrato> _fixingList = this.FijacionesList.Where(x => x.NumContrato.Equals(_encContrato.NumContrato)).ToList<StructFixingDataContrato>();
                StructDetContrato _detContrato;

                if (_fixingList.Count > 0)
                {
                    FixingDataList = _fixingList[0].Fijaciones;

                    this.FixingDataString = NewMethod(this.FixingDataList);
                }

                //// MAP 
                //if (this._Transaccion == "ANULA")
                //{
                //    // MAP: Quiero cambiar el nombre del boton guardar
                //    this.IdBtnGuardar.Content = "Anular";
                //    this.IdBtnLimpiar.IsEnabled = false;
                //    this.IdBtnGuardar.IsEnabled = true;
                //}

                //// Anticipo CER 
                //if (this._Transaccion == "ANTICIPA")
                //{
                //    // MAP: Quiero cambiar el nombre del boton guardar
                //    this.IdBtnGuardar.Content = "Anticipar";
                //    this.IdBtnLimpiar.IsEnabled = false;
                //    this.IdBtnGuardar.IsEnabled = true;
                //    this.txtUnwind.IsEnabled = true;
                //}


                this.txtSetdePrecios_Pricing.Text = ((ComboBoxItem)this.comboSetPrecios.SelectedItem).Content.ToString();
                this.datePiker_DateProccess.SelectedDate = this.DatePickerCartera.SelectedDate.Value;
                //this.DateProccess = this.DatePickerSetPrecios.SelectedDate.Value; 
                //this._TablaFixing.Cargar(_fixingList[0].Fijaciones);

                this.itemTabSrikes.IsSelected = true;

                Type _radioButtonType;
                List<UIElement> _UIElementList;
                List<RadioButton> _RadioButtonList;
                RadioButton _radioTemp;
                #endregion

                globales._NumContrato = _encContrato.NumContrato;

                #region "Parametria y carga de datos"
                if (_encContrato.CodEstructura.Equals(0))
                {
                    _detContrato = _DetContratoList.First(x => x.NumContrato.Equals(_encContrato.NumContrato));

                    if (_detContrato.CVOpc.Equals("C"))
                    {
                        this.radioCompra.IsChecked = true;
                    }
                    else
                    {
                        this.radioVenta.IsChecked = true;
                    }

                    if (_detContrato.CallPut.Equals("Call"))
                    {
                        this.radioOpcCall.IsChecked = true;
                    }
                    else
                    {
                        this.radioOpcPut.IsChecked = true;
                    }

                    this.txtPlazo.Text = _detContrato.FechaVcto.Subtract(this.datePiker_DateProccess.SelectedDate.Value).Days.ToString() + "d";
                    this.DatePickerVencimiento.SelectedDate = _detContrato.FechaVcto;
                    this.fechaVencimiento = _detContrato.FechaVcto;


                    if (_detContrato.TipoPayOff.Equals("01"))//Vanilla
                    {
                        this.comboPayOff.SelectedIndex = 0;

                        (this.comboBsFwdBsSpotAsianMomenos.Items[0] as ComboBoxItem).IsEnabled = true;
                        (this.comboBsFwdBsSpotAsianMomenos.Items[1] as ComboBoxItem).IsEnabled = true;
                        (this.comboBsFwdBsSpotAsianMomenos.Items[2] as ComboBoxItem).IsEnabled = false;
                        this.comboBsFwdBsSpotAsianMomenos.SelectedIndex = 1;
                    }
                    else
                    {
                        this.comboPayOff.SelectedIndex = 1;

                        (this.comboBsFwdBsSpotAsianMomenos.Items[0] as ComboBoxItem).IsEnabled = false;
                        (this.comboBsFwdBsSpotAsianMomenos.Items[1] as ComboBoxItem).IsEnabled = false;
                        (this.comboBsFwdBsSpotAsianMomenos.Items[2] as ComboBoxItem).IsEnabled = true;
                        this.comboBsFwdBsSpotAsianMomenos.SelectedIndex = 2;
                        _TablaFixing.isEditing = true;
                        this._TablaFixing.datePikerInicio.SelectedDate = _fixingList[0].Fijaciones[0].Fecha;
                        this._TablaFixing.datePikerFin.SelectedDate = _fixingList[0].Fijaciones[_fixingList[0].Fijaciones.Count - 1].Fecha;
                        _TablaFixing.isEditing = false;
                    }

                    this.txtNocional.Text = _detContrato.MontoMon1.ToString();
                    this.nocional = _detContrato.MontoMon1;

                    this.txtStrike1.Text = _detContrato.Strike.ToString();
                    this.strike = _detContrato.Strike;

                    _Value.DecimalPlaces = 2;
                    _Value.SetChange(this.txtNocionalContraMoneda, (this.strike * this.nocional));

                    this.txtStrike1.Focus();

                    this.txtSpotCosto.Text = this.BSSpotValorizacion.ToString();
                    this.spot = this.BSSpotValorizacion;

                    this.tabPrincipal.SelectedIndex = 0;

                    this.isTextChanged = true;

                    this.itemTabSrikes.IsSelected = true;
                    strikes_delta_flag = "strikes";

                    try
                    {
                        Valorizar();
                    }
                    catch { }
                }
                else switch (_encContrato.CodEstructura)
                    {
                        case 1:
                            #region "Straddle"
                            if (_encContrato.CVEstructura.Equals("C"))
                            {
                                this.radioCompra.IsChecked = true;
                            }
                            else
                            {
                                this.radioVenta.IsChecked = true;
                            }

                            _radioButtonType = (new RadioButton()).GetType();

                            _UIElementList = (this.stackOpciones.Children.ToList<UIElement>()).Where(x => x.GetType().Equals(_radioButtonType)).ToList<UIElement>();

                            _RadioButtonList = new List<RadioButton>();

                            foreach (UIElement _radioButtonElement in _UIElementList)
                            {
                                RadioButton _radio = _radioButtonElement as RadioButton;
                                _RadioButtonList.Add(_radio);
                            }
                            _radioTemp = _RadioButtonList.First(x => x.Content.Equals(OpcionesEstructuraList.First(op => op.Codigo.Equals("1")).Descripcion));

                            _radioTemp.IsChecked = true;

                            this.opcionContrato = OpcionesEstructuraList.First(x => x.Codigo.Equals("1")).Descripcion;

                            this.txtPlazo.Text = _DetContratoList[0].FechaVcto.Subtract(this.datePiker_DateProccess.SelectedDate.Value).Days.ToString() + "d";
                            this.DatePickerVencimiento.SelectedDate = _DetContratoList[0].FechaVcto;
                            this.fechaVencimiento = _DetContratoList[0].FechaVcto;


                            if (_DetContratoList[0].TipoPayOff.Equals("01"))//Vanilla
                            {
                                this.comboPayOff.SelectedIndex = 0;

                                (this.comboBsFwdBsSpotAsianMomenos.Items[0] as ComboBoxItem).IsEnabled = true;
                                (this.comboBsFwdBsSpotAsianMomenos.Items[1] as ComboBoxItem).IsEnabled = true;
                                (this.comboBsFwdBsSpotAsianMomenos.Items[2] as ComboBoxItem).IsEnabled = false;
                                this.comboBsFwdBsSpotAsianMomenos.SelectedIndex = 1;
                            }
                            else
                            {
                                this.comboPayOff.SelectedIndex = 1;

                                (this.comboBsFwdBsSpotAsianMomenos.Items[0] as ComboBoxItem).IsEnabled = false;
                                (this.comboBsFwdBsSpotAsianMomenos.Items[1] as ComboBoxItem).IsEnabled = false;
                                (this.comboBsFwdBsSpotAsianMomenos.Items[2] as ComboBoxItem).IsEnabled = true;
                                this.comboBsFwdBsSpotAsianMomenos.SelectedIndex = 2;
                            }

                            this.txtNocional.Text = _DetContratoList[0].MontoMon1.ToString();
                            this.nocional = _DetContratoList[0].MontoMon1;

                            this.txtStrike1.Text = _DetContratoList[0].Strike.ToString();
                            this.strike = _DetContratoList[0].Strike;

                            _Value.DecimalPlaces = 2;
                            _Value.SetChange(this.txtNocionalContraMoneda, (this.strike * this.nocional));
                            this.txtStrike1.Focus();

                            this.txtSpotCosto.Text = this.BSSpotValorizacion.ToString();
                            this.spot = this.BSSpotValorizacion;

                            this.tabPrincipal.SelectedIndex = 0;
                            this.isTextChanged = true;

                            this.itemTabSrikes.IsSelected = true;
                            strikes_delta_flag = "strikes";

                            try
                            {
                                Valorizar();
                            }
                            catch { }
                            break;
                            #endregion
                        case 2:
                            #region "Risk Reversal"
                            if (_encContrato.CVEstructura.Equals("C"))
                            {
                                this.radioCompra.IsChecked = true;
                            }
                            else
                            {
                                this.radioVenta.IsChecked = true;

                                (this.comboBsFwdBsSpotAsianMomenos.Items[0] as ComboBoxItem).IsEnabled = false;
                                (this.comboBsFwdBsSpotAsianMomenos.Items[1] as ComboBoxItem).IsEnabled = false;
                                (this.comboBsFwdBsSpotAsianMomenos.Items[2] as ComboBoxItem).IsEnabled = true;
                                this.comboBsFwdBsSpotAsianMomenos.SelectedIndex = 2;
                            }

                            _radioButtonType = (new RadioButton()).GetType();

                            _UIElementList = (this.stackOpciones.Children.ToList<UIElement>()).Where(x => x.GetType().Equals(_radioButtonType)).ToList<UIElement>();

                            _RadioButtonList = new List<RadioButton>();

                            foreach (UIElement _radioButtonElement in _UIElementList)
                            {
                                RadioButton _radio = _radioButtonElement as RadioButton;
                                _RadioButtonList.Add(_radio);
                            }

                            _radioTemp = _RadioButtonList.First(x => x.Content.Equals(OpcionesEstructuraList.First(op => op.Codigo.Equals("2")).Descripcion));

                            _radioTemp.IsChecked = true;

                            this.opcionContrato = OpcionesEstructuraList.First(x => x.Codigo.Equals("2")).Descripcion;

                            this.txtPlazo.Text = _DetContratoList[0].FechaVcto.Subtract(this.datePiker_DateProccess.SelectedDate.Value).Days.ToString() + "d";
                            this.DatePickerVencimiento.SelectedDate = _DetContratoList[0].FechaVcto;
                            this.fechaVencimiento = _DetContratoList[0].FechaVcto;


                            if (_DetContratoList[0].TipoPayOff.Equals("01"))//Vanilla
                            {
                                this.comboPayOff.SelectedIndex = 0;

                                (this.comboBsFwdBsSpotAsianMomenos.Items[0] as ComboBoxItem).IsEnabled = false;
                                (this.comboBsFwdBsSpotAsianMomenos.Items[1] as ComboBoxItem).IsEnabled = true;
                                (this.comboBsFwdBsSpotAsianMomenos.Items[2] as ComboBoxItem).IsEnabled = false;
                                this.comboBsFwdBsSpotAsianMomenos.SelectedIndex = 1;
                            }
                            else
                            {
                                this.comboPayOff.SelectedIndex = 1;
                                (this.comboBsFwdBsSpotAsianMomenos.Items[0] as ComboBoxItem).IsEnabled = false;
                                (this.comboBsFwdBsSpotAsianMomenos.Items[1] as ComboBoxItem).IsEnabled = false;
                                (this.comboBsFwdBsSpotAsianMomenos.Items[2] as ComboBoxItem).IsEnabled = true;
                                this.comboBsFwdBsSpotAsianMomenos.SelectedIndex = 2;
                            }

                            this.txtNocional.Text = _DetContratoList[0].MontoMon1.ToString();
                            this.nocional = _DetContratoList[0].MontoMon1;

                            this.txtStrike1.Text = _DetContratoList[0].Strike.ToString();
                            this.strike = _DetContratoList[0].Strike;

                            this.txtStrike2.Text = _DetContratoList[1].Strike.ToString();
                            this.strike2 = _DetContratoList[1].Strike;

                            this.txtSpotCosto.Text = this.BSSpotValorizacion.ToString();
                            this.spot = this.BSSpotValorizacion;

                            this.tabPrincipal.SelectedIndex = 0;
                            this.isTextChanged = true;

                            this.itemTabSrikes.IsSelected = true;
                            strikes_delta_flag = "strikes";

                            try
                            {
                                Valorizar();
                            }
                            catch { }
                            break;
                            #endregion
                        case 3:
                            #region "Butterfly"
                            if (_encContrato.CVEstructura.Equals("C"))
                            {
                                this.radioCompra.IsChecked = true;
                            }
                            else
                            {
                                this.radioVenta.IsChecked = true;
                            }

                            _radioButtonType = (new RadioButton()).GetType();

                            _UIElementList = (this.stackOpciones.Children.ToList<UIElement>()).Where(x => x.GetType().Equals(_radioButtonType)).ToList<UIElement>();

                            _RadioButtonList = new List<RadioButton>();

                            foreach (UIElement _radioButtonElement in _UIElementList)
                            {
                                RadioButton _radio = _radioButtonElement as RadioButton;
                                _RadioButtonList.Add(_radio);
                            }

                            _radioTemp = _RadioButtonList.First(x => x.Content.Equals(OpcionesEstructuraList.First(op => op.Codigo.Equals("3")).Descripcion));

                            _radioTemp.IsChecked = true;

                            this.opcionContrato = OpcionesEstructuraList.First(x => x.Codigo.Equals("3")).Descripcion;

                            this.txtPlazo.Text = _DetContratoList[0].FechaVcto.Subtract(this.datePiker_DateProccess.SelectedDate.Value).Days.ToString() + "d";
                            this.DatePickerVencimiento.SelectedDate = _DetContratoList[0].FechaVcto;
                            this.fechaVencimiento = _DetContratoList[0].FechaVcto;


                            if (_DetContratoList[0].TipoPayOff.Equals("01"))//Vanilla
                            {
                                this.comboPayOff.SelectedIndex = 0;

                                (this.comboBsFwdBsSpotAsianMomenos.Items[0] as ComboBoxItem).IsEnabled = false;
                                (this.comboBsFwdBsSpotAsianMomenos.Items[1] as ComboBoxItem).IsEnabled = true;
                                (this.comboBsFwdBsSpotAsianMomenos.Items[2] as ComboBoxItem).IsEnabled = false;
                                this.comboBsFwdBsSpotAsianMomenos.SelectedIndex = 1;
                            }
                            else
                            {
                                this.comboPayOff.SelectedIndex = 1;

                                (this.comboBsFwdBsSpotAsianMomenos.Items[0] as ComboBoxItem).IsEnabled = false;
                                (this.comboBsFwdBsSpotAsianMomenos.Items[1] as ComboBoxItem).IsEnabled = false;
                                (this.comboBsFwdBsSpotAsianMomenos.Items[2] as ComboBoxItem).IsEnabled = true;
                                this.comboBsFwdBsSpotAsianMomenos.SelectedIndex = 2;
                            }

                            this.txtNocional.Text = _DetContratoList[0].MontoMon1.ToString();
                            this.nocional = _DetContratoList[0].MontoMon1;

                            this.txtNocionalStrangle.Text = _DetContratoList[2].MontoMon1.ToString();
                            this.NocionalStrangle = _DetContratoList[2].MontoMon1;

                            if (_DetContratoList[0].Strike == _DetContratoList[1].Strike)
                            {
                                if (_DetContratoList[2].CallPut.Equals("Call"))
                                {
                                    this.txtStrike1.Text = _DetContratoList[2].Strike.ToString();
                                    this.strike = _DetContratoList[2].Strike;

                                    this.txtStrike2.Text = _DetContratoList[3].Strike.ToString();
                                    this.strike2 = _DetContratoList[3].Strike;
                                }
                                else
                                {
                                    this.txtStrike1.Text = _DetContratoList[3].Strike.ToString();
                                    this.strike = _DetContratoList[3].Strike;

                                    this.txtStrike2.Text = _DetContratoList[2].Strike.ToString();
                                    this.strike2 = _DetContratoList[2].Strike;
                                }

                                this.txtStrike3.Text = _DetContratoList[0].Strike.ToString();
                                this.strike3 = _DetContratoList[0].Strike;
                            }
                            else
                            {
                                if (_DetContratoList[0].CallPut.Equals("Call"))
                                {
                                    this.txtStrike1.Text = _DetContratoList[0].Strike.ToString();
                                    this.strike = _DetContratoList[0].Strike;

                                    this.txtStrike2.Text = _DetContratoList[1].Strike.ToString();
                                    this.strike2 = _DetContratoList[1].Strike;
                                }
                                else
                                {
                                    this.txtStrike1.Text = _DetContratoList[1].Strike.ToString();
                                    this.strike = _DetContratoList[1].Strike;

                                    this.txtStrike2.Text = _DetContratoList[0].Strike.ToString();
                                    this.strike2 = _DetContratoList[0].Strike;
                                }

                                this.txtStrike3.Text = _DetContratoList[2].Strike.ToString();
                                this.strike3 = _DetContratoList[2].Strike;
                            }

                            this.txtSpotCosto.Text = this.BSSpotValorizacion.ToString();
                            this.spot = this.BSSpotValorizacion;

                            this.tabPrincipal.SelectedIndex = 0;
                            this.isTextChanged = true;

                            this.itemTabSrikes.IsSelected = true;
                            strikes_delta_flag = "strikes";

                            try
                            {
                                Valorizar();
                            }
                            catch { }
                            break;
                            #endregion
                        case 4:
                            #region "Forward Utilidad Acotada"
                            if (_encContrato.CVEstructura.Equals("C"))
                            {
                                this.radioCompra.IsChecked = true;
                            }
                            else
                            {
                                this.radioVenta.IsChecked = true;
                            }

                            _radioButtonType = (new RadioButton()).GetType();

                            _UIElementList = (this.stackOpciones.Children.ToList<UIElement>()).Where(x => x.GetType().Equals(_radioButtonType)).ToList<UIElement>();

                            _RadioButtonList = new List<RadioButton>();

                            foreach (UIElement _radioButtonElement in _UIElementList)
                            {
                                RadioButton _radio = _radioButtonElement as RadioButton;
                                _RadioButtonList.Add(_radio);
                            }

                            _radioTemp = _RadioButtonList.First(x => x.Content.Equals(OpcionesEstructuraList.First(op => op.Codigo.Equals("4")).Descripcion));

                            _radioTemp.IsChecked = true;

                            this.opcionContrato = OpcionesEstructuraList.First(x => x.Codigo.Equals("4")).Descripcion;

                            this.txtPlazo.Text = _DetContratoList[0].FechaVcto.Subtract(this.datePiker_DateProccess.SelectedDate.Value).Days.ToString() + "d";
                            this.DatePickerVencimiento.SelectedDate = _DetContratoList[0].FechaVcto;
                            this.fechaVencimiento = _DetContratoList[0].FechaVcto;


                            if (_DetContratoList[0].TipoPayOff.Equals("01"))//Vanilla
                            {
                                this.comboPayOff.SelectedIndex = 0;

                                (this.comboBsFwdBsSpotAsianMomenos.Items[0] as ComboBoxItem).IsEnabled = false;
                                (this.comboBsFwdBsSpotAsianMomenos.Items[1] as ComboBoxItem).IsEnabled = true;
                                (this.comboBsFwdBsSpotAsianMomenos.Items[2] as ComboBoxItem).IsEnabled = false;
                                this.comboBsFwdBsSpotAsianMomenos.SelectedIndex = 1;
                            }
                            else
                            {
                                this.comboPayOff.SelectedIndex = 1;

                                (this.comboBsFwdBsSpotAsianMomenos.Items[0] as ComboBoxItem).IsEnabled = false;
                                (this.comboBsFwdBsSpotAsianMomenos.Items[1] as ComboBoxItem).IsEnabled = false;
                                (this.comboBsFwdBsSpotAsianMomenos.Items[2] as ComboBoxItem).IsEnabled = true;
                                this.comboBsFwdBsSpotAsianMomenos.SelectedIndex = 2;
                            }

                            this.txtNocional.Text = _DetContratoList[0].MontoMon1.ToString();
                            this.nocional = _DetContratoList[0].MontoMon1;

                            if (_DetContratoList[0].Strike == _DetContratoList[1].Strike)
                            {
                                this.txtStrike2.Text = _DetContratoList[2].Strike.ToString();
                                this.strike2 = _DetContratoList[2].Strike;

                                this.txtStrike1.Text = _DetContratoList[0].Strike.ToString();
                                this.strike = _DetContratoList[0].Strike;
                            }
                            else
                            {
                                this.txtStrike2.Text = _DetContratoList[0].Strike.ToString();
                                this.strike2 = _DetContratoList[0].Strike;

                                this.txtStrike1.Text = _DetContratoList[2].Strike.ToString();
                                this.strike = _DetContratoList[2].Strike;
                            }

                            this.txtSpotCosto.Text = this.BSSpotValorizacion.ToString();
                            this.spot = this.BSSpotValorizacion;

                            this.tabPrincipal.SelectedIndex = 0;
                            this.isTextChanged = true;

                            this.itemTabSrikes.IsSelected = true;
                            strikes_delta_flag = "strikes";

                            try
                            {
                                Valorizar();
                            }
                            catch { }
                            break;
                            #endregion
                        case 5:
                            #region "Forward Perdida Acotada"
                            if (_encContrato.CVEstructura.Equals("C"))
                            {
                                this.radioCompra.IsChecked = true;
                            }
                            else
                            {
                                this.radioVenta.IsChecked = true;
                            }

                            _radioButtonType = (new RadioButton()).GetType();

                            _UIElementList = (this.stackOpciones.Children.ToList<UIElement>()).Where(x => x.GetType().Equals(_radioButtonType)).ToList<UIElement>();

                            _RadioButtonList = new List<RadioButton>();

                            foreach (UIElement _radioButtonElement in _UIElementList)
                            {
                                RadioButton _radio = _radioButtonElement as RadioButton;
                                _RadioButtonList.Add(_radio);
                            }

                            _radioTemp = _RadioButtonList.First(x => x.Content.Equals(OpcionesEstructuraList.First(op => op.Codigo.Equals("5")).Descripcion));

                            _radioTemp.IsChecked = true;

                            this.opcionContrato = OpcionesEstructuraList.First(x => x.Codigo.Equals("5")).Descripcion;

                            this.txtPlazo.Text = _DetContratoList[0].FechaVcto.Subtract(this.datePiker_DateProccess.SelectedDate.Value).Days.ToString() + "d";
                            this.DatePickerVencimiento.SelectedDate = _DetContratoList[0].FechaVcto;
                            this.fechaVencimiento = _DetContratoList[0].FechaVcto;


                            if (_DetContratoList[0].TipoPayOff.Equals("01"))//Vanilla
                            {
                                this.comboPayOff.SelectedIndex = 0;

                                (this.comboBsFwdBsSpotAsianMomenos.Items[0] as ComboBoxItem).IsEnabled = false;
                                (this.comboBsFwdBsSpotAsianMomenos.Items[1] as ComboBoxItem).IsEnabled = true;
                                (this.comboBsFwdBsSpotAsianMomenos.Items[2] as ComboBoxItem).IsEnabled = false;
                                this.comboBsFwdBsSpotAsianMomenos.SelectedIndex = 1;
                            }
                            else
                            {
                                this.comboPayOff.SelectedIndex = 1;
                                (this.comboBsFwdBsSpotAsianMomenos.Items[0] as ComboBoxItem).IsEnabled = false;
                                (this.comboBsFwdBsSpotAsianMomenos.Items[1] as ComboBoxItem).IsEnabled = false;
                                (this.comboBsFwdBsSpotAsianMomenos.Items[2] as ComboBoxItem).IsEnabled = true;
                                this.comboBsFwdBsSpotAsianMomenos.SelectedIndex = 2;
                            }

                            this.txtNocional.Text = _DetContratoList[0].MontoMon1.ToString();
                            this.nocional = _DetContratoList[0].MontoMon1;

                            if (_DetContratoList[0].Strike == _DetContratoList[1].Strike) //Forward Sintetico {0, 1}
                            {
                                this.txtStrike2.Text = _DetContratoList[2].Strike.ToString();
                                this.strike2 = _DetContratoList[2].Strike;

                                this.txtStrike1.Text = _DetContratoList[0].Strike.ToString();
                                this.strike = _DetContratoList[0].Strike;
                            }
                            else //_DetContratoList[1].Strike == _DetContratoList[2].Strike
                            {
                                this.txtStrike2.Text = _DetContratoList[0].Strike.ToString();
                                this.strike2 = _DetContratoList[0].Strike;

                                this.txtStrike1.Text = _DetContratoList[2].Strike.ToString();
                                this.strike = _DetContratoList[2].Strike;
                            }

                            this.txtSpotCosto.Text = this.BSSpotValorizacion.ToString();
                            this.spot = this.BSSpotValorizacion;

                            this.tabPrincipal.SelectedIndex = 0;
                            this.isTextChanged = true;

                            this.itemTabSrikes.IsSelected = true;
                            strikes_delta_flag = "strikes";

                            try
                            {
                                Valorizar();
                            }
                            catch { }
                            break;
                            #endregion
                        case 6:
                            #region "Forward Sintetico"
                            if (_encContrato.CVEstructura.Equals("C"))
                            {
                                this.radioCompra.IsChecked = true;
                            }
                            else
                            {
                                this.radioVenta.IsChecked = true;
                            }

                            _radioButtonType = (new RadioButton()).GetType();

                            _UIElementList = (this.stackOpciones.Children.ToList<UIElement>()).Where(x => x.GetType().Equals(_radioButtonType)).ToList<UIElement>();

                            _RadioButtonList = new List<RadioButton>();

                            foreach (UIElement _radioButtonElement in _UIElementList)
                            {
                                RadioButton _radio = _radioButtonElement as RadioButton;
                                _RadioButtonList.Add(_radio);
                            }

                            _radioTemp = _RadioButtonList.First(x => x.Content.Equals(OpcionesEstructuraList.First(op => op.Codigo.Equals("6")).Descripcion));

                            _radioTemp.IsChecked = true;

                            this.opcionContrato = OpcionesEstructuraList.First(x => x.Codigo.Equals("6")).Descripcion;

                            this.txtPlazo.Text = _DetContratoList[0].FechaVcto.Subtract(this.datePiker_DateProccess.SelectedDate.Value).Days.ToString() + "d";
                            this.DatePickerVencimiento.SelectedDate = _DetContratoList[0].FechaVcto;
                            this.fechaVencimiento = _DetContratoList[0].FechaVcto;


                            if (_DetContratoList[0].TipoPayOff.Equals("01"))//Vanilla
                            {
                                this.comboPayOff.SelectedIndex = 0;

                                (this.comboBsFwdBsSpotAsianMomenos.Items[0] as ComboBoxItem).IsEnabled = false;
                                (this.comboBsFwdBsSpotAsianMomenos.Items[1] as ComboBoxItem).IsEnabled = true;
                                (this.comboBsFwdBsSpotAsianMomenos.Items[2] as ComboBoxItem).IsEnabled = false;
                                this.comboBsFwdBsSpotAsianMomenos.SelectedIndex = 1;
                            }
                            else
                            {
                                this.comboPayOff.SelectedIndex = 1;

                                (this.comboBsFwdBsSpotAsianMomenos.Items[0] as ComboBoxItem).IsEnabled = false;
                                (this.comboBsFwdBsSpotAsianMomenos.Items[1] as ComboBoxItem).IsEnabled = false;
                                (this.comboBsFwdBsSpotAsianMomenos.Items[2] as ComboBoxItem).IsEnabled = true;
                                this.comboBsFwdBsSpotAsianMomenos.SelectedIndex = 2;

                                this._TablaFixing.datePikerFin.SelectedDate = _DetContratoList[0].FechaVcto;
                            }

                            this.txtNocional.Text = _DetContratoList[0].MontoMon1.ToString();
                            this.nocional = _DetContratoList[0].MontoMon1;

                            this.txtStrike1.Text = _DetContratoList[0].Strike.ToString();
                            this.strike = _DetContratoList[0].Strike;

                            _Value.DecimalPlaces = 4;
                            _Value.SetChange(this.txtPuntosCosto, (_DetContratoList[0].Strike - _DetContratoList[0].SpotDet));
                            this.PuntosCosto = Math.Round(_DetContratoList[0].Strike - _DetContratoList[0].SpotDet, 4);

                            this.txtSpotCosto.Text = this.BSSpotValorizacion.ToString();
                            this.spot = this.BSSpotValorizacion;

                            this.tabPrincipal.SelectedIndex = 0;
                            this.isTextChanged = true;

                            this.itemTabSrikes.IsSelected = true;
                            strikes_delta_flag = "strikes";

                            try
                            {
                                Valorizar();
                            }
                            catch { }
                            break;
                            #endregion
                        case 7:
                            #region "Strangle"
                            if (_encContrato.CVEstructura.Equals("C"))
                            {
                                this.radioCompra.IsChecked = true;
                            }
                            else
                            {
                                this.radioVenta.IsChecked = true;
                            }

                            _radioButtonType = (new RadioButton()).GetType();

                            _UIElementList = (this.stackOpciones.Children.ToList<UIElement>()).Where(x => x.GetType().Equals(_radioButtonType)).ToList<UIElement>();

                            _RadioButtonList = new List<RadioButton>();

                            foreach (UIElement _radioButtonElement in _UIElementList)
                            {
                                RadioButton _radio = _radioButtonElement as RadioButton;
                                _RadioButtonList.Add(_radio);

                            }

                            _radioTemp = _RadioButtonList.First(x => x.Content.Equals(OpcionesEstructuraList.First(op => op.Codigo.Equals("7")).Descripcion));
                            _radioTemp.IsChecked = true;

                            this.opcionContrato = OpcionesEstructuraList.First(x => x.Codigo.Equals("7")).Descripcion;

                            this.txtPlazo.Text = _DetContratoList[0].FechaVcto.Subtract(this.datePiker_DateProccess.SelectedDate.Value).Days.ToString() + "d";
                            this.DatePickerVencimiento.SelectedDate = _DetContratoList[0].FechaVcto;
                            this.fechaVencimiento = _DetContratoList[0].FechaVcto;

                            if (_DetContratoList[0].TipoPayOff.Equals("01"))//Vanilla
                            {
                                this.comboPayOff.SelectedIndex = 0;

                                (this.comboBsFwdBsSpotAsianMomenos.Items[0] as ComboBoxItem).IsEnabled = true;
                                (this.comboBsFwdBsSpotAsianMomenos.Items[1] as ComboBoxItem).IsEnabled = true;
                                (this.comboBsFwdBsSpotAsianMomenos.Items[2] as ComboBoxItem).IsEnabled = false;
                                this.comboBsFwdBsSpotAsianMomenos.SelectedIndex = 1;
                            }
                            else
                            {
                                this.comboPayOff.SelectedIndex = 1;

                                (this.comboBsFwdBsSpotAsianMomenos.Items[0] as ComboBoxItem).IsEnabled = false;
                                (this.comboBsFwdBsSpotAsianMomenos.Items[1] as ComboBoxItem).IsEnabled = false;
                                (this.comboBsFwdBsSpotAsianMomenos.Items[2] as ComboBoxItem).IsEnabled = true;
                                this.comboBsFwdBsSpotAsianMomenos.SelectedIndex = 2;
                            }

                            this.txtNocional.Text = _DetContratoList[0].MontoMon1.ToString();
                            this.nocional = _DetContratoList[0].MontoMon1;

                            this.txtStrike1.Text = _DetContratoList[0].Strike.ToString();
                            this.strike = _DetContratoList[0].Strike;

                            this.txtStrike2.Text = _DetContratoList[1].Strike.ToString();
                            this.strike2 = _DetContratoList[1].Strike;

                            this.txtSpotCosto.Text = this.BSSpotValorizacion.ToString();
                            this.spot = this.BSSpotValorizacion;

                            this.tabPrincipal.SelectedIndex = 0;
                            this.isTextChanged = true;

                            this.itemTabSrikes.IsSelected = true;
                            strikes_delta_flag = "strikes";

                            try
                            {
                                Valorizar();
                            }
                            catch { }
                            break;
                            #endregion
                    }
                #endregion
            }
            catch { }
        }

        #endregion "Modifica Contrato"

        private void event_btnRecargarCartera_Clicked(object sender, RoutedEventArgs e)
        {
            DateTime _fechaContrato = new DateTime();
            _fechaContrato = this.DatePickerCartera.SelectedDate.Value;
            string _estado;

            _estado = StatusString();

            if (!_estado.Equals(""))
            {
                ReloadDetEncContrato(_fechaContrato, StatusString(), this.paridad, this.BSSpotValorizacion, this.curvaDom, this.curvaFor);
            }
            else
            {
                System.Windows.Browser.HtmlPage.Window.Alert("Tipo opcion inválida");
            }
        }

        private string StatusString()
        {
            string _estado = "";
            foreach (Node _Item in TreeEstadoOperacion.Get("*").Nodes)
            {
                if (_Item.IsChecked.Value)
                {
                    _estado += (_estado.Length > 0 ? ", " : "") +
                               string.Format("'{0}'", _Item.ID);
                }
            }
            if (_estado.Length == 0)
            {
                foreach (StructCodigoDescripcion _item in this.OptionStateList)
                {
                    _estado += (_estado.Length > 0 ? ", " : "!,") +
                               string.Format("'{0}'", _item.Codigo);
                }
            }
            return _estado;
        }

        private void ReloadDetEncContrato(DateTime fechaContrato, string Estado, string paridadValorizacion, double spotValorizacion, string curvaDomValorizacion, string curvaForValorizacion)
        {
            a.StartLoading(this);

            SrvValorizador.SrvValorizadorCarteraSoapClient _SrvValCartera = wsGlobales.Valorizador;//new AdminOpciones.SrvValorizador.SrvValorizadorCarteraSoapClient();
            _SrvValCartera.getDetContratoFixingCompleted += new EventHandler<AdminOpciones.SrvValorizador.getDetContratoFixingCompletedEventArgs>(_ReloadDetEncContrato_getDetContratoFixingCompleted);
            _SrvValCartera.getDetContratoFixingAsync(fechaContrato, Estado, FechaDeProceso);
        }

        void _ReloadDetEncContrato_getDetContratoFixingCompleted(object sender, AdminOpciones.SrvValorizador.getDetContratoFixingCompletedEventArgs e)
        {
            a.StopLoading(this);//Podría ir al final de esta función

            string _EncContrato = e.Result;

            XDocument xdoc = new XDocument();
            xdoc = XDocument.Parse(_EncContrato);
            EncContratoList = new List<StructEncContrato>();
            DetContratoList = new List<StructDetContrato>();
            FijacionesList = new List<StructFixingDataContrato>();

            StructEncContrato _itemEncContratoStruct;
            StructDetContrato _itemDetContratoStruct;
            StructFixingDataContrato _itemFixingData;

            int _idDet = 0;
            int _idEnc = 0;
            string _Filtro = CheckImage.Visibility == Visibility.Visible ? "Todas" : "Ninguna";

            #region Carga Contratos Contratos

            foreach (XElement itemEncContrato in xdoc.Descendants("Opcion"))
            {
                _idEnc++;

                #region Inicializa Variable de Contrato

                _itemEncContratoStruct = new StructEncContrato();
                _itemEncContratoStruct.Encabezado_Checked += new delegate_Checked(_itemEncContratoStruct_Encabezado_Checked);

                #endregion

                #region Setea encabezados

                _itemEncContratoStruct.Estado = itemEncContrato.Element("itemEncContrato").Attribute("Estado").Value;

                try
                {
                    try
                    {
                        _itemEncContratoStruct.Estado = _itemEncContratoStruct.Estado.Equals("") ? " " : _itemEncContratoStruct.Estado;
                        _itemEncContratoStruct.GlosaEstado = OptionStateList.First(x => x.Codigo.Equals(_itemEncContratoStruct.Estado)).Descripcion;
                    }
                    catch { }
                }
                catch { }

                _itemEncContratoStruct.ID = _idEnc;
                _itemEncContratoStruct.Checked = _Filtro.Equals("Todas") ? true : false;
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
                _itemEncContratoStruct.Glosa = itemEncContrato.Element("itemEncContrato").Attribute("Glosa").Value;
                _itemEncContratoStruct.TipoTransaccion = itemEncContrato.Element("itemEncContrato").Attribute("TipoTransaccion").Value;
                //PRD_10449 ASVG_20111222
                _itemEncContratoStruct.RelacionaPAE = int.Parse(itemEncContrato.Element("itemEncContrato").Attribute("RelacionaPAE").Value);

                #region Carga de Prima

                #region Código de Moneda

                _itemEncContratoStruct.CodMonPagPrima = int.Parse(itemEncContrato.Element("itemEncContrato").Attribute("CaCodMonPagPrima").Value);

                #endregion

                #region Prima inicial MO

                if (itemEncContrato.Element("itemEncContrato").Attribute("PrimaInicial").Value != "")
                {
                    _itemEncContratoStruct.PrimaInicial = double.Parse(itemEncContrato.Element("itemEncContrato").Attribute("PrimaInicial").Value);
                }
                else
                {
                    _itemEncContratoStruct.PrimaInicial = double.NaN;
                }

                #endregion

                #region Paridad Prima Inicial

                if (itemEncContrato.Element("itemEncContrato").Attribute("ParMdaPrima").Value != "")
                {
                    _itemEncContratoStruct.ParMdaPrima = double.Parse(itemEncContrato.Element("itemEncContrato").Attribute("ParMdaPrima").Value);
                }
                else
                {
                    _itemEncContratoStruct.ParMdaPrima = double.NaN;
                }

                #endregion

                //5843
                #region Resultado Venta

                if (itemEncContrato.Element("itemEncContrato").Attribute("ResultadoVta").Value != "")
                {
                    _itemEncContratoStruct.ResultadoVta = double.Parse(itemEncContrato.Element("itemEncContrato").Attribute("ResultadoVta").Value);
                }
                else
                {
                    _itemEncContratoStruct.ResultadoVta = double.NaN;
                }

                #endregion


                #region Prima Inicial CLP

                if (itemEncContrato.Element("itemEncContrato").Attribute("PrimaInicialML").Value != "")
                {
                    _itemEncContratoStruct.PrimaInicialML = double.Parse(itemEncContrato.Element("itemEncContrato").Attribute("PrimaInicialML").Value);
                }
                else
                {
                    _itemEncContratoStruct.PrimaInicialML = double.NaN;
                }

                #endregion

                #region Forma de Pago Prima

                _itemEncContratoStruct.fPagoPrima = int.Parse(itemEncContrato.Element("itemEncContrato").Attribute("CafPagoPrima").Value);
                try
                {
                    _itemEncContratoStruct.FormaPagoPrima = this.formaDePagoList.First(x => x.Codigo.Equals(_itemEncContratoStruct.fPagoPrima.ToString())).Descripcion;
                }
                catch
                {
                    _itemEncContratoStruct.FormaPagoPrima = "NO DISPONIBLE " + _itemEncContratoStruct.fPagoPrima.ToString();
                }

                #endregion

                #endregion

                #endregion

                #region Carga Detalle

                foreach (XElement itemdetContrato in itemEncContrato.Descendants("itemDetContrato"))
                {
                    _itemDetContratoStruct = new StructDetContrato();
                    _itemDetContratoStruct.Detalle_Checked_detContrato += new delegate_Checked_DetContrato(_itemDetContratoStruct_Detalle_Checked_detContrato);

                    _idDet++;

                    _itemDetContratoStruct.ID = _idDet;
                    _itemDetContratoStruct.Checked = _Filtro.Equals("Todas") ? true : false;
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
                    _itemDetContratoStruct.CurveMon1 = this.curvaDom;
                    _itemDetContratoStruct.CurveMon2 = this.curvaFor;
                    _itemDetContratoStruct.FormaPagoMon1 = int.Parse(itemdetContrato.Attribute("CaFormaPagoMon1").Value);
                    _itemDetContratoStruct.FormaPagoMon2 = int.Parse(itemdetContrato.Attribute("CaFormaPagoMon2").Value);
                    _itemDetContratoStruct.MdaCompensacion = int.Parse(itemdetContrato.Attribute("CaMdaCompensacion").Value);
                    _itemDetContratoStruct.FormaPagoComp = int.Parse(itemdetContrato.Attribute("CaFormaPagoComp").Value);
                    _itemDetContratoStruct.TipoTransaccion = itemdetContrato.Attribute("TipoTransaccion").Value;
                    _itemDetContratoStruct.Modalidad = itemdetContrato.Attribute("Modalidad").Value.Equals("C") ? true : false;
                    _itemDetContratoStruct.PorcStrike = double.Parse(itemdetContrato.Attribute("CaPorcStrike").Value);//PRD_12567

                    DetContratoList.Add(_itemDetContratoStruct);
                }

                #endregion

                #region Carga Fijación

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

                #endregion

                #region Carga Encabezado del Contrato

                EncContratoList.Add(_itemEncContratoStruct);

                #endregion
            }

            #endregion

            ReCreateDataGrid();

            this.grdTopologiaVegaCALLPUT.ItemsSource = null;
            this.grdTopologiaVegaRRFLY.ItemsSource = null;
            this.grdTotalizadorValCartera.ItemsSource = null;
            this.MtMGriegasTotalizador = null;
            txtPosicionOpciones.Text = "";
            txtTotalDeltas.Text = "";
            ActualizarTotalizadorDeltas();
        }

        private void event_btnRecargarCartera_MouseEnter(object sender, MouseEventArgs e)
        {
        }

        private void event_expaderEstadoOperacion_MouseLeave(object sender, MouseEventArgs e)
        {
            if (this.expaderEstadoOperacion.IsExpanded == true)
            {
                DateTime _fechaContrato = new DateTime();
                _fechaContrato = this.DatePickerCartera.SelectedDate.Value;
                string _estado;

                _estado = StatusString();

                if (!_estado.Equals(""))
                {
                    ReloadDetEncContrato(_fechaContrato, StatusString(), this.paridad, this.BSSpotValorizacion, this.curvaDom, this.curvaFor);
                }

                this.expaderEstadoOperacion.IsExpanded = false;
            }
        }

        private void event_expaderEstadoOperacion_MouseEnter(object sender, MouseEventArgs e)
        {
        }

        #region LoadTableClose

        /// <summary>
        /// Invoca servicio de consulta estado de apertura de Mesa.
        /// </summary>
        private void LoadTableClose()
        {
            TableClose = false;
            AdminOpciones.SrvDetalles.WebDetallesSoapClient _SrvCierreMesa = wsGlobales.Detalles;
            _SrvCierreMesa.RetornaCierreMesaCompleted += new EventHandler<AdminOpciones.SrvDetalles.RetornaCierreMesaCompletedEventArgs>(LoadTableCloseCompleted);
            _SrvCierreMesa.RetornaCierreMesaAsync(Convert.ToDateTime(Convert.ToString(globales._FechaProceso)).ToString());
        }

        private void LoadTableCloseCompleted(object sender, AdminOpciones.SrvDetalles.RetornaCierreMesaCompletedEventArgs e)
        {
            string _fproc = Convert.ToDateTime(Convert.ToString(globales._FechaProceso)).ToString("yyyyMMdd");
            string _strResult = e.Result.ToString();
            XDocument _xmlResult = XDocument.Parse(_strResult);
            List<AdminOpciones.Page._Resultado_Mesa> _data = new List<AdminOpciones.Page._Resultado_Mesa>();

            IEnumerable<XElement> elements = _xmlResult.Element("CierreMesa").Elements("Data");
            foreach (XElement element in elements)
            {
                AdminOpciones.Page._Resultado_Mesa _sData = new AdminOpciones.Page._Resultado_Mesa();
                _sData.ResultMesa = element.FirstAttribute.Value.ToString();
                TableClose = Convert.ToInt32(_sData.ResultMesa) == 1 ? true : false;
            }
            if (!TableClose)
            {
                SaveOptions();
                if (this._Transaccion == "CREACION")
                {
                    LoadPortfolioAndBook();
                }
            }
            else
            {
                System.Windows.Browser.HtmlPage.Window.Alert("No se puede grabar la operación, debido a que la mesa se encuentra cerrada.");
            }
        }

        /// <summary>
        /// Prepara XML grabación, revisa controles y levanta pantalla de Grabación.
        /// </summary>
        private void SaveOptions()
        {
            //Aqui guardar los valores de las primas y forma de pago y monedas
            try
            {
                // MAP 18 Agosto
                if (this._Transaccion == "ANULA" || this._Transaccion == "ANTICIPA" || this._Transaccion.Equals("EJERCE"))
                {
                    // MAP:  boton guardar (Anular)
                    // CER 27 Agosto Anticipo
                    // CER: botón Guardar (ANTICIPAR)
                    //ASVG: se junta todo en la misma condición.
                    this.IdBtnLimpiar.IsEnabled = false;
                    this.IdBtnGuardar.IsEnabled = false;
                }

                #region Valida Fecha Proceso

                if (this.datePiker_DateProccess.Text.Equals("") || this.datePiker_DateProccess.SelectedDate == null || this.txtPlazo.Text.Equals("") || this.DatePickerVencimiento.Text.Equals("") || txtNocional.Text.Equals("") || txtSpotCosto.Text.Equals("") || txtMtMContrato.Equals(""))
                {
                    isGuardarValid = false;
                }

                #endregion

                #region Griegas

                if (txtDeltaSpot.Text.Equals("") || txtDeltaFwd.Text.Equals("") || txtGamma.Text.Equals("") || txtVega.Text.Equals("") || txtVolga.Text.Equals("") || txtVanna.Text.Equals("") || txtCharm.Text.Equals("") || txtTheta.Text.Equals("") || txtRhoDom.Text.Equals("") || txtRhoFor.Text.Equals(""))
                {
                    isGuardarValid = false;
                }

                if (txtDeltaSpot.Equals("NaN") || txtGamma.Text.Equals("NaN") || txtVega.Text.Equals("NaN") || txtVolga.Text.Equals("NaN") || txtVanna.Text.Equals("NaN") || txtCharm.Text.Equals("NaN") || txtTheta.Text.Equals("NaN") || txtRhoDom.Text.Equals("NaN") || txtRhoFor.Text.Equals("NaN"))
                {
                    isGuardarValid = false;
                }

                if (txtDeltaSpot.Equals("Infinity") || txtDeltaFwd.Text.Equals("Infinity") || txtGamma.Text.Equals("Infinity") || txtVega.Text.Equals("Infinity") || txtVolga.Text.Equals("Infinity") || txtVanna.Text.Equals("Infinity") || txtCharm.Text.Equals("Infinity") || txtTheta.Text.Equals("Infinity") || txtRhoDom.Text.Equals("Infinity") || txtRhoFor.Text.Equals("Infinity"))
                {
                    isGuardarValid = false;
                }

                #endregion

                #region Validación por Estructura

                switch (_opcionEstructuraSeleccionada.Codigo)
                {
                    case "-1":
                    case "0":
                    case "1":
                    case "8":
                        if (this.txtStrike1.Text.Equals("") || this.strike.Equals(double.NaN) || strike.Equals(double.NegativeInfinity) || strike.Equals(double.PositiveInfinity))
                        {
                            isGuardarValid = false;
                        }

                        if (((ComboBoxItem)comboPayOff.SelectedItem).Content.Equals("Vanilla"))
                        {
                            if (this.txtDelta1.Text.Equals("") || this.delta1.Equals(double.NaN) || this.delta1.Equals(double.NegativeInfinity) || this.delta1.Equals(double.PositiveInfinity))
                            {
                                isGuardarValid = false;
                            }
                        }
                        if (BsSpot_BsFwd_AsianMomentos_flag.Equals("BsFwd") && (txtPuntosCosto.Text.Equals("") || PuntosCosto.Equals(double.NaN) || PuntosCosto.Equals(double.PositiveInfinity) || PuntosCosto.Equals(double.NegativeInfinity)))
                        {
                            isGuardarValid = false;
                        }
                        break;
                    case "2":
                    case "7":
                        if (this.txtStrike1.Text.Equals("") || this.strike.Equals(double.NaN) || strike.Equals(double.NegativeInfinity) || strike.Equals(double.PositiveInfinity))
                        {
                            isGuardarValid = false;
                        }
                        if (this.txtStrike2.Text.Equals("") || this.strike2.Equals(double.NaN) || strike2.Equals(double.NegativeInfinity) || strike2.Equals(double.PositiveInfinity))
                        {
                            isGuardarValid = false;
                        }
                        if (this.txtDelta1.Text.Equals("") || this.delta1.Equals(double.NaN) || this.delta1.Equals(double.NegativeInfinity) || this.delta1.Equals(double.PositiveInfinity))
                        {
                            isGuardarValid = false;
                        }
                        break;
                    case "4":
                    case "5":
                        if (this.txtStrike1.Text.Equals("") || this.strike.Equals(double.NaN) || strike.Equals(double.NegativeInfinity) || strike.Equals(double.PositiveInfinity))
                        {
                            isGuardarValid = false;
                        }
                        if (this.txtStrike2.Text.Equals("") || this.strike2.Equals(double.NaN) || strike2.Equals(double.NegativeInfinity) || strike2.Equals(double.PositiveInfinity))
                        {
                            isGuardarValid = false;
                        }
                        break;
                    case "6":
                    case "13"://Forward Asiatico PRD_12567
                        if (this.txtStrike1.Text.Equals("") || this.strike.Equals(double.NaN) || strike.Equals(double.NegativeInfinity) || strike.Equals(double.PositiveInfinity))
                        {
                            isGuardarValid = false;
                        }
                        break;

                    case "9": //Call Strip Asiático
                    case "10"://Put  Strip Asiático

                        if (this.txtStrike1.Text.Equals("") || this.strike.Equals(double.NaN) || strike.Equals(double.NegativeInfinity) || strike.Equals(double.PositiveInfinity))
                        {
                            isGuardarValid = false;
                        }

                        if (BsSpot_BsFwd_AsianMomentos_flag.Equals("BsFwd") || BsSpot_BsFwd_AsianMomentos_flag.Equals("BsSpot") && (txtPuntosCosto.Text.Equals("") || PuntosCosto.Equals(double.NaN) || PuntosCosto.Equals(double.PositiveInfinity) || PuntosCosto.Equals(double.NegativeInfinity)))
                        {
                            isGuardarValid = false;
                        }
                        break;

                }

                #endregion

                #region Comprobar Prima
                //IAF 30/10/2009 (Cod. 148)
                bool isPrimaValid = true;

                if (((ComboBoxItem)ComboUnidadPrima.SelectedItem).Content.Equals("USD"))
                {
                    //Si la prima esta en dólares, y se ha ingresado prima, entonces BEDE ingresarse tambien el tipo cambio.             

                    if ((txtPrimaContrato.Text != "0" || txtPrimaContrato.Text != "") && !PrimaContrato.Equals(0) && (txtParidadPrima.Text == "" || ParidadPrima.Equals(0) || ParidadPrima.Equals(double.NaN)))
                    {
                        isPrimaValid = false;
                    }


                }

                if (MtMContrato > 0 && PrimaContrato > 0)
                {
                    isPrimaValid = false;
                }
                else if (MtMContrato < 0 && PrimaContrato < 0)
                {
                    isPrimaValid = false;
                }

                #endregion

                #region UnWind

                bool isUnWind = true;
                //PRD_12567 try-catch nuevo
                try
                {
                    double _UnWind = double.Parse(this.txtUnwind.Text);

                    if ((MtMContrato > 0 && _UnWind < 0) || (MtMContrato < 0 && _UnWind > 0))
                    {
                        isUnWind = false;
                    }

                }
                catch (Exception e)
                {
                    System.Windows.Browser.HtmlPage.Window.Alert("Verificar UnWind " + e);
                }

                #endregion

                #region UnWindCosto

                bool isUnWindCosto = true;
                double _UnWindCosto = double.Parse(this.txtUnwindCosto.Text);

                if ((MtMContrato > 0 && _UnWindCosto < 0) || (MtMContrato < 0 && _UnWindCosto > 0))
                {
                    isUnWindCosto = false;
                }

                #endregion

                #region Valores de Prima y PrimaML
                if (this.ComboUnidadPrima.SelectedIndex == 0)
                {
                    _Guardar.primaInicial = PrimaContrato;
                    _Guardar.primaInicialML = PrimaContrato;
                    _Guardar.paridadPrima = 1;
                }
                else
                {
                    _Guardar.primaInicial = PrimaContrato;
                    _Guardar.primaInicialML = Math.Round(PrimaContrato * ParidadPrima, 0);
                    _Guardar.paridadPrima = ParidadPrima;
                }
                #endregion Valores de Prima y PrimaML

                //5843
                _Guardar.ResultVenta = ResultVenta;

                bool _StructOption = false;
                _opcionEstructuraSeleccionada = OpcionesEstructuraList.First(x => x.Descripcion.Equals(opcionContrato));
                string _OptionID = _opcionEstructuraSeleccionada.Codigo;

                if (_OptionID.Equals("-1") || _OptionID.Equals("0") || _OptionID.Equals("1") || _OptionID.Equals("7"))
                {
                    _StructOption = true;
                }
                else
                {
                    isPrimaValid = true;
                }

                if (this.EnableComponentes && isGuardarValid && isPrimaValid && isUnWind && isUnWindCosto)
                {
                    try
                    {
                        XDocument _ResultXML = new XDocument(XDocument.Parse(XMLResult));
                        GenerateXmlData(_ResultXML, this.MtMContrato, griegas);

                        _Guardar.FechaVal = this.datePiker_DateProccess.SelectedDate.Value;
                        _Guardar.codigoMon1 = int.Parse(this.codigoMon1);
                        _Guardar.codigoMon2 = int.Parse(this.codigoMon2);

                        LoadPortfolioAndBook();

                        _Guardar.Load();

                        // CER
                        _Guardar.ShowControl(this._Transaccion);

                        //alanrevisar esto esta dos veces :S
                        //alanrevisar el nuevo no lo tiene
                        LoadPortfolioAndBook();

                        #region if CREACION?
                        if ((this._Transaccion != "ANULA") && (this._Transaccion != "ANTICIPA") && (this._Transaccion != "EJERCE"))
                        {
                            this.Mask.Visibility = Visibility.Visible;
                            _Guardar.btnCancelarGuardar.IsEnabled = true;
                            _Guardar.btnAceptarGuardar.IsEnabled = true;

                            //PAE
                            ValidaPae();

                            popUpGuardar.Show();
                            // MAP
                            _Guardar._Transaccion = "CREACION";
                        }
                        #endregion if CREACION?

                        #region if EJERCE
                        else if (this._Transaccion.Equals("EJERCE"))
                        {
                            if (radioCompensacionEjercicio.IsChecked.Value)
                            {
                                _Guardar.CanvasCompensacion.Visibility = Visibility.Visible;
                                _Guardar.CanvasEntregaFisia.Visibility = Visibility.Collapsed;
                            }
                            else
                            {
                                _Guardar.CanvasEntregaFisia.Visibility = Visibility.Visible;
                                _Guardar.CanvasCompensacion.Visibility = Visibility.Collapsed;
                            }
                            _Guardar._Transaccion = _Transaccion;
                            this.Mask.Visibility = Visibility.Visible;
                            _Guardar.btnCancelarGuardar.IsEnabled = true;
                            _Guardar.btnAceptarGuardar.IsEnabled = true;

                            //PAE
                            ValidaPae();

                            popUpGuardar.Show();
                        }
                        #endregion if EJERCE

                        #region if ANTICIPA
                        else if (this._Transaccion == "ANTICIPA")
                        {
                            _Guardar._Transaccion = "ANTICIPA";
                            this.Mask.Visibility = Visibility.Visible;
                            _Guardar.btnCancelarGuardar.IsEnabled = true;
                            _Guardar.btnAceptarGuardar.IsEnabled = true;

                            //PAE
                            ValidaPae();

                            popUpGuardar.Show();
                        }
                        #endregion if ANTICIPA

                        #region ANULA
                        else
                        {
                            _Guardar._Transaccion = "ANULA";
                            // CER
                            //_Guardar.btnAceptarGuardar.Click += new RoutedEventHandler(_Guardar.event_btnAceptar_Click);
                            _Guardar.event_btnAceptar_Click(null, null);

                        }
                        #endregion
                    }
                    catch { }
                }
                else
                {
                    #region Alert's no grabación.
                    if (!isGuardarValid || !isPrimaValid)
                    {
                        if (((MtMContrato > 0 && PrimaContrato > 0) || (MtMContrato < 0 && PrimaContrato < 0)) && _StructOption)
                        {
                            System.Windows.Browser.HtmlPage.Window.Alert("Verificar prima.");
                        }
                        else
                        {
                            System.Windows.Browser.HtmlPage.Window.Alert("Algunos datos son inválidos para guardar");
                        }
                    }
                    else if (!isUnWind)
                    {
                        System.Windows.Browser.HtmlPage.Window.Alert("Verificar UnWind.");
                    }
                    else if (!isUnWindCosto)
                    {
                        System.Windows.Browser.HtmlPage.Window.Alert("Verificar UnWind Costo.");
                    }
                    #endregion Alert's no grabación.
                }
            }
            catch
            {
            }
        }
        #endregion LoadTableClose


        private void popUpComponentes_SizeChanged(object sender, SizeChangedEventArgs e)
        {
            _ComponentesTable.Height = e.NewSize.Height - 26;
            _ComponentesTable.Width = e.NewSize.Width - 6;
        }

        //REVISAR
        private void event_LiquidPopUpDialog_Closed(object sender, DialogEventArgs e)
        {
            try
            {
                if (_TablaFixing.datePikerFinEntrada.SelectedDate > this.fechaVencimiento || _TablaFixing.datePikerFin.SelectedDate > this.fechaVencimiento)
                {
                    System.Windows.Browser.HtmlPage.Window.Alert("Fecha Fin no puede ser mayor a Fecha Vencimiento");
                    e.Cancel = true;
                    return;
                }

                if (_TablaFixing.IsValidPeso())
                {
                    isTextChanged = true;
                    this.FixingDataList = (List<StructFixingData>)_TablaFixing.grdTablaFixing.ItemsSource;
                    this._TablaFixing.fixingdataList = this.FixingDataList;

                    FixingDataString = "<FixingData>";
                    foreach (StructFixingData FixingData in FixingDataList)
                    {
                        if (FixingData.Peso > 0)
                        {
                            FixingDataString += string.Format(
                                                                "<FixingValues Fecha='{0}' Valor='{1}' Peso='{2}' Volatilidad ='{3}' Plazo='{4}' />",
                                                                FixingData.Fecha.ToString("dd-MM-yyyy"),
                                                                FixingData.Valor.ToString(),
                                                                FixingData.Peso.ToString(),
                                                                FixingData.Volatilidad.ToString(),
                                                                FixingData.Plazo.ToString()
                                                             );
                        }
                    }
                    if (_opcionEstructuraSeleccionada.Codigo.Equals("13"))//PRD_12567
                    {

                        this.FixingDataListEntrada = (List<StructFixingData>)_TablaFixing.grdTablaFixingEntrada.ItemsSource;//PRD_12567

                        foreach (StructFixingData FixingData in FixingDataListEntrada)
                        {
                            FixingDataString += string.Format(
                                                            "<FixingValues Fecha='{0}' Valor='{1}' Peso='{2}' Volatilidad ='{3}' Plazo='{4}' />",
                                                            FixingData.Fecha.ToString("dd-MM-yyyy"),
                                                            FixingData.Valor.ToString(),
                                                            FixingData.Peso * -1,
                                                            FixingData.Volatilidad.ToString(),
                                                            FixingData.Plazo
                                                             );
                        }
                    }//PRD_12567

                    FixingDataString += "</FixingData>";

                    Valorizar();
                }
                else
                {
                    System.Windows.Browser.HtmlPage.Window.Alert("El total de los pesos no es igual a 1");
                    e.Cancel = true;
                }
            }
            catch
            {
                isTextChanged = false;
            }
        }

        private void event_btnCargarCartera_Click(object sender, RoutedEventArgs e)
        {
            getDetContratoFijaciones(DatePickerCartera.SelectedDate.Value, StatusString());
        }

        private void event_DatePickerCartera_SelectedDateChanged(object sender, SelectionChangedEventArgs e)
        {
            DatePicker _calendar = (sender as DatePicker);
            if (_calendar.SelectedDate != null && _calendar.SelectedDate.Value.CompareTo(this.FechaDeProceso) > 0)
            {
                _calendar.SelectedDate = FechaDeProceso;
            }
        }

        private void btnCalcular_Clecked(object sender, RoutedEventArgs e)
        {
            isTextChanged = true;
            Valorizar();
        }

        private void DatePickerVencimiento_LostFocus(object sender, RoutedEventArgs e)
        {
            if (!IsOpenCalendarExpiryDate)
            {
                if (this.DatePickerVencimiento.SelectedDate != null) // (!txtPlazo.Text.Equals(""))
                {
                    //if (DatePickerVencimiento.SelectedDate != null && fechaVencimiento != DatePickerVencimiento.SelectedDate.Value)
                    if (fechaVencimiento != DatePickerVencimiento.SelectedDate.Value)
                    {
                        this.txtPlazo.Text = this.DatePickerVencimiento.SelectedDate.Value.Subtract(this.datePiker_DateProccess.SelectedDate.Value).Days.ToString() + "d";
                        fechaVencimiento = DatePickerVencimiento.SelectedDate.Value;

                        Eventos_Cambio_Plazo();
                        #region old Eventos_Cambio_Plazo
                        /*
                        if (((ComboBoxItem)this.comboPayOff.SelectedItem).Content.Equals("Vanilla"))
                        {
                            isTextChanged = true;
                            this.txtPuntosCosto.Text = "";
                            this.PuntosCosto = double.NaN;
                            Valorizar();
                        }

                        if (isOpcionFromCartera == false && !BsSpot_BsFwd_AsianMomentos_flag.Equals("AsianMomentos") && datePiker_DateProccess.SelectedDate != null)
                        {
                            SetPuntosForward(datePiker_DateProccess.SelectedDate.Value, fechaVencimiento, this.spot, this.curvaDom, this.curvaFor, this.setPrecios_Pricing);
                        }

                        if (isTablaFixingLoadedFromValcartera == false)
                        {
                            _TablaFixing.isEditing = true;
                            this._TablaFixing.datePikerInicio.SelectedDate = datePiker_DateProccess.SelectedDate.Value;
                            this._TablaFixing.datePikerFin.SelectedDate = fechaVencimiento;
                            _TablaFixing.isEditing = false;
                        }

                        if (!((ComboBoxItem)this.comboPayOff.SelectedItem).Content.Equals("Vanilla"))
                        {
                            CrearFixing();
                        }
                        else
                        {
                            btnTablaFixing.IsEnabled = true;
                            IsChangeFixing = false;
                        }

                        isdatePickerVencChanged = false;
                        isPlazoChanged = false;
                         * */
                        #endregion old Eventos_Cambio_Plazo
                        this.txtNocional.Focus();
                    }
                    else
                    {
                        btnTablaFixing.IsEnabled = true;
                        IsChangeFixing = false;
                    }
                }
                else
                {
                    this.txtPlazo.Text = "";
                    fechaVencimiento = new DateTime();
                }
            }
        }

        private void DatePickerVencimiento_GotFocus(object sender, RoutedEventArgs e)
        {
            IsChangeFixing = true;
            btnTablaFixing.IsEnabled = false;
        }

        private void DatePickerVencimiento_CalendarOpened(object sender, RoutedEventArgs e)
        {
            IsChangeFixing = true;
            IsOpenCalendarExpiryDate = true;
            btnTablaFixing.IsEnabled = false;
        }

        private void DatePickerVencimiento_CalendarClosed(object sender, RoutedEventArgs e)
        {
            IsOpenCalendarExpiryDate = false;
            DatePickerVencimiento.Focus();
        }

        #region Sensibilidad
        private void grdSensibilidadCLP_KeyDown(object sender, KeyEventArgs e)
        {

            DataGrid _DataGrid = sender as DataGrid;

            #region Copy uisng Ctrl-C

            if (e.Key == Key.C &&
                ((Keyboard.Modifiers & ModifierKeys.Control) == ModifierKeys.Control
                || (Keyboard.Modifiers & ModifierKeys.Apple) == ModifierKeys.Apple)
                )
            {
                string textData = "";

                #region Head

                string _TextColumn = "";

                foreach (DataGridColumn _Column in _DataGrid.Columns)
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

                int _ID = 1;

                foreach (StructSensibilidad _Item in (List<StructSensibilidad>)_DataGrid.ItemsSource)
                {
                    textData += string.Format("{0}\t{1}\n",
                                               _Item.Tenor.ToString(),
                                                _Item.Delta.ToString()
                                             );
                    _ID++;
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

        private void checkSensibilidad_Click(object sender, RoutedEventArgs e)
        {

        }

        private void grdSensibilidadLocal_KeyDown(object sender, KeyEventArgs e)
        {
            grdSensibilidadCLP_KeyDown(sender, e);
        }

        private void btnSetPricing_Click(object sender, RoutedEventArgs e)
        {
            Sensibilidad(0);
        }

        public void Sensibilidad(double MTM_Totalizador)
        {
            bool _SensPortfolio = false;

            if (DetContratoList != null && DetContratoList.Count > 0 && !this.txtSpotValorizacion.Text.Equals(""))
            {
                string _DetContratoFixingData = "<Data>\n";
                int _Count = 0;

                _DetContratoFixingData += "<FechaValorizacion Fecha='" + this.DatePickerCartera.SelectedDate.Value.ToString("dd-MM-yyyy") + "'/>\n";
                _DetContratoFixingData += string.Format(
                                                         "<SpotValorizacion Spot='{0}' SpotSmile='{1}' />\n",
                                                         this.BSSpotValorizacion,
                                                         this.BSSpotValorizacion
                                                       );
                _DetContratoFixingData += "<DetContrato>\n";
                List<StructDetContrato> DetContratlo_CHECKED_List = new List<StructDetContrato>();

                for (int i = 0; i < DetContratoList.Count; i++)
                {
                    if (DetContratoList[i].Checked)
                    {
                        if (DetContratoList[i].Checked)
                        {
                            _Count++;
                        }
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
                        _DetContratoFixingData += "PuntosFwd='" + DetContratoList[i].PuntosFwd + "' ";
                        _DetContratoFixingData += "SpotDet='" + DetContratoList[i].SpotDet + "' ";
                        _DetContratoFixingData += "CurveMon1='" + DetContratoList[i].CurveMon1 + "' ";
                        _DetContratoFixingData += "CurveMon2='" + DetContratoList[i].CurveMon2 + "' ";
                        _DetContratoFixingData += "PorcStrike='" + DetContratoList[i].PorcStrike + "' ";//PRD_12567
                        _DetContratoFixingData += "  />\n";
                    }
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

                #region Smile

                //string Smile = CreateSmileXML();

                #endregion

                if (_Count > 0)
                {
                    _SensPortfolio = true;
                    SrvValorizador.SrvValorizadorCarteraSoapClient _SrvValorizador = wsGlobales.Valorizador;//new AdminOpciones.SrvValorizador.SrvValorizadorCarteraSoapClient();
                    _SrvValorizador.SensibilidadCompleted += new EventHandler<AdminOpciones.SrvValorizador.SensibilidadCompletedEventArgs>(_SrvValorizador_SensibilidadCompleted);
                    _SrvValorizador.SensibilidadAsync(_DetContratoFixingData, FechaSetdePrecios, MTM_Totalizador, setPreciosValCartera);
                    StartLoading(this.CanvasItemSensibilidad);
                }
                else
                {
                    _SensPortfolio = false;
                }
            }

            if (!_SensPortfolio)
            {
                grdSensibilidadLocal.ItemsSource = null;
                grdSensibilidadCLP.ItemsSource = null;

                if (checkSensibilidad.IsChecked.Value)
                {
                    if (_ListCurvaCLPPricing != null)
                    {
                        _ListCurvaCLP = _ListCurvaCLPPricing;
                        grdSensibilidadCLP.ItemsSource = _ListCurvaCLP;
                    }
                    if (_ListCurvaLocalPricing != null)
                    {
                        _ListCurvaLocal = _ListCurvaLocalPricing;
                        grdSensibilidadLocal.ItemsSource = _ListCurvaLocal;
                    }
                }
            }

        }

        void _SrvValorizador_SensibilidadCompleted(object sender, AdminOpciones.SrvValorizador.SensibilidadCompletedEventArgs e)
        {
            StopLoading(this.CanvasItemSensibilidad);
            XDocument _MtMGriegasXML;
            try
            {
                #region Sensibilidad
                _MtMGriegasXML = XDocument.Parse(e.Result);
                _ListCurvaCLP = new List<StructSensibilidad>();
                _ListCurvaLocal = new List<StructSensibilidad>();

                try
                {
                    var _ListCLP = from _Item in _MtMGriegasXML.Element("Sensitivity").Element(curvaDom).Descendants("Value")
                                   select new StructSensibilidad
                                   {
                                       Tenor = int.Parse(_Item.Attribute("Tenor").Value),
                                       MTM = double.Parse(_Item.Attribute("MTM").Value),
                                       MTMSens = double.Parse(_Item.Attribute("MTMSensitivity").Value),
                                       Delta = double.Parse(_Item.Attribute("Sensitivity").Value)
                                   };

                    _ListCurvaCLP = _ListCLP.ToList();

                    if (checkSensibilidad.IsChecked.Value && _ListCurvaCLPPricing != null)
                    {
                        foreach (StructSensibilidad _Sens in _ListCurvaCLP)
                        {
                            List<StructSensibilidad> _SensPricingCLPList = _ListCurvaCLPPricing.Where(_Element => _Element.Tenor.Equals(_Sens.Tenor)).ToList();
                            foreach (StructSensibilidad _SensPricing in _SensPricingCLPList)
                            {
                                _Sens.MTM += _SensPricing.MTM;
                                _Sens.MTMSens += _SensPricing.MTMSens;
                                _Sens.Delta += _SensPricing.Delta;
                            }
                        }
                    }

                    grdSensibilidadCLP.ItemsSource = null;
                    grdSensibilidadCLP.ItemsSource = _ListCurvaCLP;

                    var _ListLocal = from _Item in _MtMGriegasXML.Element("Sensitivity").Element(curvaFor).Descendants("Value")
                                     select new StructSensibilidad
                                     {
                                         Tenor = int.Parse(_Item.Attribute("Tenor").Value),
                                         MTM = double.Parse(_Item.Attribute("MTM").Value),
                                         MTMSens = double.Parse(_Item.Attribute("MTMSensitivity").Value),
                                         Delta = double.Parse(_Item.Attribute("Sensitivity").Value)
                                     };

                    _ListCurvaLocal = _ListLocal.ToList();

                    if (checkSensibilidad.IsChecked.Value && _ListCurvaLocalPricing != null)
                    {
                        foreach (StructSensibilidad _Sens in _ListCurvaLocal)
                        {
                            List<StructSensibilidad> _SensPricingLocalList = _ListCurvaLocalPricing.Where(_Element => _Element.Tenor.Equals(_Sens.Tenor)).ToList();
                            foreach (StructSensibilidad _SensPricing in _SensPricingLocalList)
                            {
                                _Sens.MTM += _SensPricing.MTM;
                                _Sens.MTMSens += _SensPricing.MTMSens;
                                _Sens.Delta += _SensPricing.Delta;
                            }
                        }
                    }

                    grdSensibilidadLocal.ItemsSource = null;
                    grdSensibilidadLocal.ItemsSource = _ListCurvaLocal;
                }
                catch
                {
                }

                #endregion
            }
            catch
            {
            }

        }

        private void SensibilidadPricing(string input, double MtM, int SetPricing)
        {
            SrvValorizador.SrvValorizadorCarteraSoapClient _SrvValorizadorSensibilidad = wsGlobales.Valorizador;//new AdminOpciones.SrvValorizador.SrvValorizadorCarteraSoapClient();
            _SrvValorizadorSensibilidad.SensibilidadCompleted += new EventHandler<AdminOpciones.SrvValorizador.SensibilidadCompletedEventArgs>(_SrvValorizador_SensibilidadPricingCompleted);
            _SrvValorizadorSensibilidad.SensibilidadAsync(input, FechaSetdePrecios, MtM, SetPricing);
        }

        private void _SrvValorizador_SensibilidadPricingCompleted(object sender, AdminOpciones.SrvValorizador.SensibilidadCompletedEventArgs e)
        {
            XDocument _MtMGriegasXML;
            try
            {
                #region Sensibilidad
                _MtMGriegasXML = XDocument.Parse(e.Result);
                _ListCurvaCLPPricing = new List<StructSensibilidad>();
                _ListCurvaLocalPricing = new List<StructSensibilidad>();

                try
                {
                    //alanrevisar esto es viejo: var _ListCLP = from _Item in _MtMGriegasXML.Element("Sensibilidad").Element(curvaDom).Descendants("Value")
                    var _ListCLP = from _Item in _MtMGriegasXML.Element("Sensitivity").Element(curvaDom).Descendants("Value")
                                   select new StructSensibilidad
                                   {
                                       Tenor = int.Parse(_Item.Attribute("Tenor").Value),
                                       MTM = double.Parse(_Item.Attribute("MTM").Value),
                                       //alanrevisar esto es viejo: MTMSens = double.Parse(_Item.Attribute("MTMSens").Value),
                                       //alanrevisar esto es viejo: Delta = double.Parse(_Item.Attribute("Delta").Value)
                                       MTMSens = double.Parse(_Item.Attribute("MTMSensitivity").Value),
                                       Delta = double.Parse(_Item.Attribute("Sensitivity").Value)
                                   };

                    _ListCurvaCLPPricing = _ListCLP.ToList();
                    grdSensibilidadCLPPricing.ItemsSource = null;
                    grdSensibilidadCLPPricing.ItemsSource = _ListCurvaCLPPricing;

                    //alanrevisar esto es viejo: var _ListLocal = from _Item in _MtMGriegasXML.Element("Sensibilidad").Element(CurvaFor).Descendants("Value")
                    var _ListLocal = from _Item in _MtMGriegasXML.Element("Sensitivity").Element(curvaFor).Descendants("Value")
                                     select new StructSensibilidad
                                     {
                                         Tenor = int.Parse(_Item.Attribute("Tenor").Value),
                                         MTM = double.Parse(_Item.Attribute("MTM").Value),
                                         //alanrevisar esto es viejo: MTMSens = double.Parse(_Item.Attribute("MTMSens").Value),
                                         //alanrevisar esto es viejo: Delta = double.Parse(_Item.Attribute("Delta").Value)
                                         MTMSens = double.Parse(_Item.Attribute("MTMSensitivity").Value),
                                         Delta = double.Parse(_Item.Attribute("Sensitivity").Value)
                                     };

                    _ListCurvaLocalPricing = _ListLocal.ToList();
                    grdSensibilidadLocalPricing.ItemsSource = null;
                    grdSensibilidadLocalPricing.ItemsSource = _ListCurvaLocalPricing;
                }
                catch
                {
                }

                #endregion
            }
            catch
            {
            }

            if (IsLoading == true)
            {
                StopLoading(this.PrincipalCanvas);
            }
        }

        private void event_btnSensibilidadPricing_Click(object sender, RoutedEventArgs e)
        {
            popSensibilidad.Show();
        }
        #endregion Sensibilidad

        private void radioEntregaFisicaEjercicio_checked(object sender, RoutedEventArgs e)
        {
            CalcularEjercer();
        }

        private void radioCompensacionEjercicio_checked(object sender, RoutedEventArgs e)
        {
            CalcularEjercer();
        }

        #region LCR

        #region Simular_LCR

        private XDocument GenerateXml_LCR()
        {
            int FormaPagoMon1 = 0;
            int FormaPagoMon2 = 0;
            int FormaPagoPrimaInicial = 0;
            int FormaPagoCompensacion = 0;
            int FormaPagoUnWind = 0;
            string strGlosa; 
            string _diasValuta;
            XDocument xmlDataLCR;

            xmlDataLCR = this.xmlCreate;

            if (this.radioCompensacion.IsChecked.Value)
            {
                
                FormaPagoCompensacion = 0; 
                FormaPagoPrimaInicial = 0; 
            }
            else
            {
                FormaPagoMon1 = 0; 
                FormaPagoMon2 = 0; 
                FormaPagoPrimaInicial = 0; 
            }

 

            if ((this._Transaccion != "ANULA") && (this._Transaccion != "ANTICIPA"))
            {
                string _CodigoRelacion = "";

                try
                {

                    _CodigoRelacion = "0";
                }
                catch (NullReferenceException)
                {
                    _CodigoRelacion = "-1";
                }

                string RutCliente = "96665450"; // Por solicitud de Banco se utiliza ITAU CORREDORES DE BOLSA LTDA. Para almacenar operacíón// 

                string CodigoRutCliente = "1"; 

                Libro = "1";                
                CarteraFinanciera = "8";    
                CarteraNormativa = "T";     
                SubCarteraNormativa = "4";  

                strGlosa = "Simulación consumo LCR / Opciones"; 
                
                xmlDataLCR.Element("Datos").Element("encContrato").Element("Contrato").Attribute("MoEstado").Value = "C";       
                xmlDataLCR.Element("Datos").Element("encContrato").Element("Contrato").Attribute("MoGlosa").Value = strGlosa;

                xmlDataLCR.Element("Datos").Element("encContrato").Element("Contrato").Attribute("MoRelacionaPAE").Value = "0"; 
                xmlDataLCR.Element("Datos").Element("encContrato").Element("Contrato").Attribute("MoRelacionaLeasing").Value = "1"; 
                xmlDataLCR.Element("Datos").Element("encContrato").Element("Contrato").Attribute("MoNumeroLeasing").Value = string.Empty; 
                xmlDataLCR.Element("Datos").Element("encContrato").Element("Contrato").Attribute("MoNumeroBien").Value = string.Empty; 

                xmlDataLCR.Element("Datos").Element("encContrato").Element("Resultados").Attribute("MoPrimaInicial").Value = "0"; 
                xmlDataLCR.Element("Datos").Element("encContrato").Element("Resultados").Attribute("MoResultadoVentasML").Value = "0"; 

                xmlDataLCR.Element("Datos").Element("encContrato").Element("Resultados").Attribute("MoPrimaInicialML").Value = "0"; 
                xmlDataLCR.Element("Datos").Element("encContrato").Element("Resultados").Attribute("MoParMdaPrima").Value = "1"; 

                xmlDataLCR.Element("Datos").Element("encContrato").Element("Resultados").Attribute("MofPagoPrima").Value = "5"; 

                xmlDataLCR.Element("Datos").Element("encContrato").Element("Contraparte").Attribute("MoRutCliente").Value = RutCliente;
                xmlDataLCR.Element("Datos").Element("encContrato").Element("Contraparte").Attribute("MoCodigo").Value = CodigoRutCliente;

                xmlDataLCR.Element("Datos").Element("encContrato").Element("Carteras").Attribute("MoCarteraFinanciera").Value = CarteraFinanciera.ToString();
                xmlDataLCR.Element("Datos").Element("encContrato").Element("Carteras").Attribute("MoLibro").Value = Libro.ToString();
                xmlDataLCR.Element("Datos").Element("encContrato").Element("Carteras").Attribute("MoCarNormativa").Value = CarteraNormativa;
                xmlDataLCR.Element("Datos").Element("encContrato").Element("Carteras").Attribute("MoSubCarNormativa").Value = SubCarteraNormativa.ToString();

                _diasValuta = this.txtPlazo.Text; 
                xmlDataLCR.Element("Datos").Element("encContrato").Element("Resultados").Attribute("MoFechaPagoPrima").Value = this.FechaDeProceso.ToString("dd-MM-yyyy"); // 

                xmlDataLCR.Element("Datos").Element("encContrato").Element("Resultados").Attribute("MoCodMonPagPrima").Value = "999"; 

                xmlDataLCR.Element("Datos").Element("encContrato").Element("Griegas").Attribute("MoMondelta").Value = this.codigoMon2.ToString();
                xmlDataLCR.Element("Datos").Element("encContrato").Element("Griegas").Attribute("MoMon_gamma").Value = this.codigoMon2.ToString();
                xmlDataLCR.Element("Datos").Element("encContrato").Element("Griegas").Attribute("MoMon_vega").Value = this.codigoMon2.ToString();
                xmlDataLCR.Element("Datos").Element("encContrato").Element("Griegas").Attribute("MoMon_vanna").Value = this.codigoMon2.ToString();
                xmlDataLCR.Element("Datos").Element("encContrato").Element("Griegas").Attribute("MoMon_volga").Value = this.codigoMon2.ToString();
                xmlDataLCR.Element("Datos").Element("encContrato").Element("Griegas").Attribute("MoMon_theta").Value = this.codigoMon2.ToString();
                xmlDataLCR.Element("Datos").Element("encContrato").Element("Griegas").Attribute("MoMon_rho").Value = this.codigoMon2.ToString();
                xmlDataLCR.Element("Datos").Element("encContrato").Element("Griegas").Attribute("MoMon_rhof").Value = this.codigoMon2.ToString();
                xmlDataLCR.Element("Datos").Element("encContrato").Element("Griegas").Attribute("MoMon_charm").Value = this.codigoMon2.ToString();
                
                string TipoEstructura = xmlDataLCR.Element("Datos").Element("encContrato").Element("Estructura").Attribute("MoCodEstructura").Value;


                //if (ModalidadPago)
                //{
                foreach (XElement _Item in xmlDataLCR.Descendants("detContrato"))
                {
                    _Item.Element("Subyacente").Attribute("MoMdaCompensacion").Value = "999";// MonedaCompensacion.ToString();
                    _Item.Element("Subyacente").Attribute("MoFormaPagoComp").Value = FormaPagoCompensacion.ToString();
                    _Item.Element("Subyacente").Attribute("MoFormaPagoMon1").Value = "";
                    _Item.Element("Subyacente").Attribute("MoFormaPagoMon2").Value = "";
                }
                //}
                //else
                //{
                //    foreach (XElement _Item in xmlDataLCR.Descendants("detContrato"))
                //    {
                //        // PRD_13575
                //        if ((TipoEstructura.Equals("4") || TipoEstructura.Equals("5")) //&& radioCompensacion.IsChecked.Value //Compensacion_EntregaFisica.Equals("E")
                //            && _Item.Element("Estructura").Attribute("MoNumEstructura").Value.Equals("3"))
                //        {
                //            _Item.Element("Subyacente").Attribute("MoMdaCompensacion").Value = this.codigoMon2.ToString(); //MonedaCompensacion.ToString();
                //            _Item.Element("Subyacente").Attribute("MoFormaPagoComp").Value = FormaPagoMon2.ToString();
                //            _Item.Element("Subyacente").Attribute("MoFormaPagoMon1").Value = "";
                //            _Item.Element("Subyacente").Attribute("MoFormaPagoMon2").Value = "";
                //        }
                //        else
                //        {
                //            _Item.Element("Subyacente").Attribute("MoMdaCompensacion").Value = "";
                //            _Item.Element("Subyacente").Attribute("MoFormaPagoComp").Value = "";
                //            _Item.Element("Subyacente").Attribute("MoFormaPagoMon1").Value = FormaPagoMon1.ToString();
                //            _Item.Element("Subyacente").Attribute("MoFormaPagoMon2").Value = FormaPagoMon2.ToString();
                //        }
                //    }
                //}

                double _peso = 0;
                foreach (XElement _fix in xmlDataLCR.Descendants("FixingValues"))
                {
                    _peso = double.Parse(_fix.Attribute("Peso").Value);
                    _peso = _peso * 100;
                    _fix.Attribute("Peso").Value = _peso.ToString();
                }
                // E-mail de Ivan Acevedo 20 Agosto 16:00
            }

            return xmlDataLCR;
        }
        private int GetNumeroOperacion(string mensaje)
        {
            int inicioNumOp = (mensaje.ElementAt(mensaje.IndexOf('°') + 1).Equals(' ')) ? mensaje.IndexOf('°') + 2 : mensaje.IndexOf('°') + 1;
            string partialMsj = mensaje.Substring(inicioNumOp);
            int finNumOp = partialMsj.IndexOf(' ');
            string msjFinal = mensaje.Substring(inicioNumOp, finNumOp);
            return Convert.ToInt32(msjFinal);
        }

        void _SrvBDOpciones_InsertOptionCompleted4LCR(object sender, AdminOpciones.SrvBDOpciones.InsertOptionCompletedEventArgs e)
        {
            string mensajeRetorno;
         

            mensajeRetorno = "";
      
            if (e.Error != null)
            {
                System.Windows.Browser.HtmlPage.Window.Alert(e.Error.ToString());

            }
            else
            {
                if (e.Result.ToString().Contains("Contrato"))
                {
                    int numOp = GetNumeroOperacion(e.Result);
                    mensajeRetorno = e.Result;
                    SrvValorizador.SrvValorizadorCarteraSoapClient _SrvValorizador = wsGlobales.Valorizador;

                    _SrvValorizador.CalcularLCRCompleted += new EventHandler<AdminOpciones.SrvValorizador.CalcularLCRCompletedEventArgs>(CalcularLCRCompleted);
                    _SrvValorizador.CalcularLCRAsync(numOp, NumeroContrato.ToString());
                }
                else
                {
                    System.Windows.Browser.HtmlPage.Window.Alert(e.Result);
                }

            }
        }
      
        private void event_btnLCR_Click(object sender, RoutedEventArgs e)
        {
            if (!txtMtMContrato.Text.Equals("") && !txtDeltaSpot.Text.Equals("") && !txtSpotCosto.Text.Equals(""))
            {
                bool _Error = false;
                double _Tenor = 0;
                try
                {
                    _Tenor = DatePickerVencimiento.SelectedDate.Value.ToOADate() - datePiker_DateProccess.SelectedDate.Value.ToOADate();
                }
                catch
                {
                    _Error = true;
                }



                XDocument xmlLcr;
                xmlLcr = GenerateXml_LCR();

                NumeroFolio = 0;
                NumeroContrato = 0;

                SrvBDOpciones.BDOpcionesSoapClient _SrvBDOpciones = wsGlobales.BDOpciones;
                _SrvBDOpciones.InsertOptionCompleted += new EventHandler<AdminOpciones.SrvBDOpciones.InsertOptionCompletedEventArgs>(_SrvBDOpciones_InsertOptionCompleted4LCR);
                _SrvBDOpciones.InsertOptionAsync(xmlLcr.ToString(), globales._Usuario, globales._Estado, NumeroFolio, NumeroContrato, globales.FechaProceso, globales._Turing);


                if (!_Error)
                {
                    if (NumeroFolio>0)
                         {
                                SrvValorizador.SrvValorizadorCarteraSoapClient _SrvValorizador = wsGlobales.Valorizador;//new AdminOpciones.SrvValorizador.SrvValorizadorCarteraSoapClient();

                                _SrvValorizador.CalcularLCRCompleted += new EventHandler<AdminOpciones.SrvValorizador.CalcularLCRCompletedEventArgs>(CalcularLCRCompleted);
                                _SrvValorizador.CalcularLCRAsync(NumeroFolio, NumeroContrato.ToString());
                         }
                }
            }
        }

        private void CalcularLCRCompleted(object sender, AdminOpciones.SrvValorizador.CalcularLCRCompletedEventArgs e)
        {
            if (e.Error == null)
            {
                ValidAmount _Value = new ValidAmount();
                _Value.DecimalPlaces = 0;
                XDocument _xmlValue = XDocument.Parse(e.Result);

                // <LCR MTM='{0}' AddOn='{1}' LCR='{2}' LCRusd='{3}' Parity='{4}' Factor='{5}' />
                _Value.SetChange(txtLCRMTM, double.Parse(_xmlValue.Element("LCR").Attribute("MTM").Value));
                _Value.SetChange(txtLCRAddon, double.Parse(_xmlValue.Element("LCR").Attribute("AddOn").Value));
                _Value.SetChange(txtLCRCLP, double.Parse(_xmlValue.Element("LCR").Attribute("LCR").Value));
                _Value.DecimalPlaces = 2;
                _Value.SetChange(txtLCRUSD, double.Parse(_xmlValue.Element("LCR").Attribute("LCRusd").Value));
                _Value.DecimalPlaces = 4;
                _Value.SetChange(txtLCRParity, double.Parse(_xmlValue.Element("LCR").Attribute("Parity").Value));

                popUpLCR.Show();
            }
            else
            {
                System.Windows.Browser.HtmlPage.Window.Alert(e.Error.Message);
            }
        }

        #endregion Simular_LCR

        #endregion LCR

        //Rq_13090
        void svc_AnticipaSolicitudCompleted(object sender, AdminOpciones.SrvDetalles.AnticipaSolicitudCompletedEventArgs e)
        {
            #region Validacion Cartera

            string _xmlResult = e.Result.ToString();
            string NumContrato = "";
            string MontoSolicitud = "";
            string ModalidadPago = "";

            XDocument xmlResult = new XDocument();
            xmlResult = XDocument.Parse(_xmlResult);

            IEnumerable<XElement> elements = xmlResult.Element("Result").Elements("Status").Elements("Item");
            foreach (XElement element in elements)
            {
                MontoSolicitud = element.Attribute("MONTO_SOLICITUD").Value.ToString();
                ModalidadPago = element.Attribute("TIPO_ANTICIPO").Value.ToString();
                NumContrato = element.Attribute("CaNumContrato").Value.ToString();
            }

            if (NumContrato == "0")
            {
                valtxtNocional.SetChange(txtEjercerMP, double.Parse(this.txtNocional.Text));

                if (radioEntregaFisica.IsChecked.Value)
                {
                    radioEntregaFisicaEjercicio.IsChecked = true;
                    radioCompensacionEjercicio.IsChecked = false;
                }
                else
                {
                    radioCompensacionEjercicio.IsChecked = true;
                    radioEntregaFisicaEjercicio.IsChecked = false;
                }

                CalcularEjercer();
            }
            else
            {
                valtxtNocional.SetChange(txtEjercerMP, double.Parse(MontoSolicitud));

                if (radioEntregaFisica.IsChecked.Value && ModalidadPago == "E")
                {
                    radioEntregaFisicaEjercicio.IsChecked = true;
                    radioCompensacionEjercicio.IsChecked = false;
                }
                else
                {
                    radioCompensacionEjercicio.IsChecked = true;
                    radioEntregaFisicaEjercicio.IsChecked = false;
                }

                CalcularEjercer();
            }

            #endregion
        }

        private void _TablaFixing_event_TablaFixingResultEntrada(string strFixingValue)
        {
            try
            {
                //la solución correcta pasa por modificar StructFixingData para generar campos de pantalla que controlen el signo.
                //implica cambiar los binding, pero están directos al "Peso"...

                //viene con los signos positivos desde la pantalla, porque se determinó que en la pantalla siempre se verían positivos.
                //List<StructFixingData> fixingdataList = XML_StructFixingData_ToList(strFixingValue, -1);
                List<StructFixingData> fixingdataList = strFixingValue.ToListStructFixingData(-1);

                this._Guardar.FixingDataListEntrada = fixingdataList;
                this.FixingDataListEntrada = fixingdataList;

                string _fixingDataXMLEntrada = List_StructFixingData_ToXML(fixingdataList);

                //acá se setea la lista con los signos negativos generados en XML_StructFixingData_ToList(strFixingValue, -1);
                this.FixingDataStringEntrada = _fixingDataXMLEntrada;

                //MEJORAR URGENTE!!!
                this.FixingDataString = this.FixingDataStringEntrada + this.FixingDataStringSalida;

                string regex = "</FixingData><FixingData>";
                string resultado = Regex.Replace(FixingDataString, regex, "");

                this.FixingDataString = resultado;

                //esto tiene sentido?
                this.Town = this._TablaFixing.Town;
                this._TablaFixing.SetTownEntrada(this.Town);

                if (!IsClearData)
                {
                    Valorizar();
                }
                isTablaFixingCreated = false;
            }
            catch { }
        }

        private string List_StructFixingData_ToXML(List<StructFixingData> fixingdatalist)
        {
            string _sFixingDataXML = "<FixingData>\n";

            for (int i = 0; i < fixingdatalist.Count; i++)
            {
                //ANOTAR el formato de Fecha Fecha='07-06-2013 0:00:00'
                _sFixingDataXML += string.Format(
                                                 "<FixingValues Fecha='{0}' Valor='{1}' Peso='{2}' Volatilidad='{3}' Plazo='{4}' />\n",
                                                 fixingdatalist[i].Fecha,
                                                 fixingdatalist[i].Valor,
                                                 fixingdatalist[i].Peso,
                                                 fixingdatalist[i].Volatilidad,
                                                 fixingdatalist[i].Fecha.Subtract(this._TablaFixing.fechaHoy).Days.ToString()
                                               );
            }
            _sFixingDataXML += "</FixingData>";

            return _sFixingDataXML;
        }

        //REVISAR: es como la List_StructFixingData_ToXML pero por Plazo
        private string NewMethod(List<StructFixingData> fixingdatalist)
        {
            string _FixingDataString = "<FixingData>";
            foreach (StructFixingData FixingData in fixingdatalist)
            {
                //ANOTAR el formato de Fecha
                _FixingDataString += string.Format(
                                                    "<FixingValues Fecha='{0}' Valor='{1}' Peso='{2}' Volatilidad ='{3}' Plazo='{4}' />",
                                                    FixingData.Fecha.ToString("dd-MM-yyyy"),
                                                    FixingData.Valor.ToString(),
                                                    FixingData.Peso.ToString(),
                                                    FixingData.Volatilidad.ToString(),
                                                    FixingData.Plazo.ToString()
                                                 );
            }
            _FixingDataString += "</FixingData>";

            return _FixingDataString;
        }

        void _TablaFixing_event_TablaFixing_CalculaPesoEntrada(string tipoPeso_flag)
        {
            try
            {
                if (tipoPeso_flag.Equals("Equiproporcional") && _TablaFixing.fixingdataListEntrada.Count > 0)
                {
                    int _N = _TablaFixing.fixingdataListEntrada.Count;
                    double _peso;
                    try
                    {
                        _peso = 1.0 / _N;
                        if (_peso.Equals(double.NaN))
                        {
                            _peso = 0;
                        }
                    }
                    catch
                    {
                        _peso = 0;
                    }
                    for (int i = 0; i < _N; i++)
                    {
                        _TablaFixing.fixingdataListEntrada[i].Peso = -_peso;
                    }

                    this.FixingDataListEntrada = _TablaFixing.fixingdataListEntrada;
                    _TablaFixing.CargarEntrada(_TablaFixing.fixingdataListEntrada, isTablaFixingLoadedFromValcartera);
                }

                if (tipoPeso_flag.Equals("Proporcional al Tiempo") && _TablaFixing.fixingdataListEntrada.Count > 0)
                {
                    int _N = _TablaFixing.fixingdataListEntrada.Count;
                    double Dias_Totales = _TablaFixing.datePikerFinEntrada.SelectedDate.Value.Subtract(_TablaFixing.datePikerInicioEntrada.SelectedDate.Value).Days;
                    double _peso;

                    try
                    {
                        _peso = (_TablaFixing.fixingdataListEntrada[0].Fecha.Subtract(_TablaFixing.datePikerInicioEntrada.SelectedDate.Value).Days / Dias_Totales);
                        if (_peso.Equals(double.NaN))
                        {
                            _peso = 0;
                        }
                    }
                    catch
                    {
                        _peso = 0;
                    }

                    _TablaFixing.fixingdataListEntrada[0].Peso = _peso;

                    for (int i = 1; i < _N; i++)
                    {
                        try
                        {
                            _peso = (_TablaFixing.fixingdataListEntrada[i].Fecha.Subtract(_TablaFixing.fixingdataListEntrada[(i - 1)].Fecha).Days / Dias_Totales);
                            if (_peso.Equals(double.NaN))
                            {
                                _peso = 0;
                            }
                        }
                        catch
                        {
                            _peso = 0;
                        }
                        _TablaFixing.fixingdataListEntrada[i].Peso = _peso;
                    }

                    this.FixingDataListEntrada = _TablaFixing.fixingdataListEntrada;
                    _TablaFixing.CargarEntrada(_TablaFixing.fixingdataListEntrada, isTablaFixingLoadedFromValcartera);

                }
            }
            catch { }
        }

        //Prd_16803
        #region Estructurados
        // PAE
        public void ValidaPae()
        {
            Object s = new Object();
            RoutedEventArgs e = new RoutedEventArgs();
            this._Guardar.ComboEstructRelacion.IsEnabled = false;

            try
            {
                int MaxDiasPae = this.DatePickerVencimiento.SelectedDate.Value.Subtract(this.datePiker_DateProccess.SelectedDate.Value).Days;

                if (((ComboBoxItem)comboPayOff.SelectedItem).Content.Equals("Vanilla")
                    && this.radioCompra.IsChecked == true
                    && this.radioOpcCall.IsChecked == true
                    && MaxDiasPae <= 367 //PAE Estructurado Bonificado
                    && ((ComboBoxItem)this.ComboUnidadPrima.SelectedItem).Content.Equals("USD")
                    && radioCompensacion.IsChecked.Value.Equals(true))
                {
                    this._Guardar.CanvasPae.Visibility = Visibility.Collapsed;
                    this._Guardar.ComboEstructRelacion.IsEnabled = true; //Prd_16803
                    this._Guardar.ComboEstructRelacion.SelectedIndex = -1;//revisar
                }
                else
                {
                    this._Guardar.CanvasPae.Visibility = Visibility.Visible;
                    this._Guardar.ComboEstructRelacion.SelectedIndex = -1;//revisar
                    //this._Guardar.CbxOpePAE.IsChecked = false;
                    //PAE 20120112
                    //this._Guardar.event_CbxPAE_FormaPago(s, e);
                }
            }
            catch
            {
                this._Guardar.CanvasPae.Visibility = Visibility.Visible;
                this._Guardar.ComboEstructRelacion.IsEnabled = true; //Prd_16803
                this._Guardar.ComboEstructRelacion.SelectedIndex = -1;//revisar
                //this._Guardar.CbxOpePAE.IsChecked = false;
                ////PAE 20120112
                //this._Guardar.event_CbxPAE_FormaPago(s, e);
            }

            //PRD_16803
            ValidaLeasing();
        }

        public void ValidaLeasing()
        {
            //this._Guardar.CbxOpePAE.IsEnabled = true;
            //this._Guardar.ComboEstructRelacion.IsEnabled = false;
            this._Guardar.autoCompleteBoxOpLeasing.IsEnabled = false;
            this._Guardar.autoCompleteBoxNumBienLeasing.IsEnabled = false;

            if(_opcionEstructuraSeleccionada.Codigo.Equals("8"))
            {
                try
                {
                    if (radioVenta.IsChecked.Equals(true) && radioCompensacion.IsChecked.Equals(true))
                    {
                        this._Guardar.CanvasPae.Visibility = Visibility.Collapsed;
                        this._Guardar.ComboEstructRelacion.IsEnabled = true;
                        //this._Guardar.autoCompleteBoxOpLeasing.IsEnabled = true;
                        //this._Guardar.autoCompleteBoxNumBienLeasing.IsEnabled = true;
                        //this._Guardar.CbxOpePAE.IsEnabled = false;

                        if (globales._Estado == "M" && globales._NumContrato != 0)
                        {
                            for (int i = 0; i < _Guardar.EstructuraRelacion.Count; i++)
                            {
                                if (_Guardar.EstructuraRelacion[i].CodigoRelacion == "3")
                                {
                                    _Guardar.ComboEstructRelacion.SelectedIndex = i;
                                    this._Guardar.autoCompleteBoxOpLeasing.IsEnabled = true;
                                    this._Guardar.autoCompleteBoxNumBienLeasing.IsEnabled = true;
                                }
                            }
                            this._Guardar.autoCompleteBoxOpLeasing.Text = ConsRelacionFwd[0].ReNumeroLeasing;
                            this._Guardar.autoCompleteBoxNumBienLeasing.Text = ConsRelacionFwd[0].ReNumeroBien;
                        }
                    }
                }
                catch { }
            }
        }

        public void CargaEstructuraRelacion()
        {
            AdminOpciones.SrvDetalles.WebDetallesSoapClient svc = wsGlobales.Detalles;
            svc.Trae_EstructurasRelacionadasAsync();
            svc.Trae_EstructurasRelacionadasCompleted += new EventHandler<AdminOpciones.SrvDetalles.Trae_EstructurasRelacionadasCompletedEventArgs>(svc_TraeEstructuraRelacionCompleted);
        }

        void svc_TraeEstructuraRelacionCompleted(object sender, AdminOpciones.SrvDetalles.Trae_EstructurasRelacionadasCompletedEventArgs e)
        {
            string _xmlResult = e.Result.ToString();
            XDocument xmlResult = new XDocument();
            xmlResult = XDocument.Parse(_xmlResult);

            var DataEstructura = from itemDataLoad in xmlResult.Element("Result").Elements("Status").Elements("Item") //xmlResult.Descendants("DataFormaDePago")
                                 select new StructRelacion
                                 {
                                     CodigoRelacion = itemDataLoad.Attribute("ReId").Value.ToString(),
                                     DescripcionRelacion = itemDataLoad.Attribute("ReDescripcion").Value.ToString()
                                 };

            _Guardar.EstructuraRelacion = DataEstructura.ToList();
            _Guardar.ComboEstructRelacion.ItemsSource = _Guardar.EstructuraRelacion;
            _Guardar.ComboEstructRelacion.DisplayMemberPath = "DescripcionRelacion";

            for (int i = 0; i < _Guardar.EstructuraRelacion.Count; i++)
            {
                if (_Guardar.EstructuraRelacion[i].CodigoRelacion == "1")
                {
                    _Guardar.ComboEstructRelacion.SelectedIndex = i;
                }
            }         
        }
        
        void svc_Trae_ForwardRelacionadoCompleted(object sender, AdminOpciones.SrvDetalles.Trae_ForwardRelacionadoCompletedEventArgs e)
        {
            string _xmlResult = e.Result.ToString();
            XDocument xmlResult = new XDocument();
            xmlResult = XDocument.Parse(_xmlResult);

            var DataRelacion = from itemDataLoad in xmlResult.Element("Result").Elements("Status").Elements("Item") //xmlResult.Descendants("DataFormaDePago")
                                 select new StructRelacionForward
                                 {
                                     ReNumeroLeasing = itemDataLoad.Attribute("ReNumeroLeasing").Value.ToString(),
                                     ReNumeroBien = itemDataLoad.Attribute("ReNumeroBien").Value.ToString(),
                                     ReCaNumContrato = itemDataLoad.Attribute("ReCaNumContrato").Value.ToString(),
                                     ReCaNumFolio = itemDataLoad.Attribute("ReCaNumFolio").Value.ToString()
                                 };

            ConsRelacionFwd = DataRelacion.ToList();
        }
        #endregion Estructurados


    } //partial class FontOpciones

} //namespace AdminOpciones.OpcionesFX.Front
