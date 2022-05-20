using System;
using System.Net;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Documents;
using System.Windows.Ink;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Animation;
using System.Windows.Shapes;
using WC = AdminOpciones.Controls.WindowsControls;
using AdminOpciones.Recursos;
using System.Xml.Linq;
using AdminOpciones.Delegados;

namespace AdminOpciones.Controls
{

    public static class NewWindonwsControls
    {

        public static event RefreshControlMesa event_RefreshMesa;

        private static string __UserControlTitle { get; set; }
        private static string __UserControlName { get; set; }
        private static string __UserControlID { get; set; }
        private static int _CountFrontOpciones = 0;

        #region Inicio Dia

        #region Inicio de Día

        public static void InicioDia(string optionmenu)
        {
            try
            {
                __UserControlTitle = "Inicio Dia";
                __UserControlID = "UserControlInicioDia";
                __UserControlName = "UserControlInicioDia";

                if (!WC.FindUserControl(__UserControlID))
                {
                    InicioDia cdia = new InicioDia();
                    WC.CreateUserControl(cdia, __UserControlTitle, __UserControlName, __UserControlID, optionmenu, 0);
                }
            }
            catch (Exception _Error)
            {
                System.Windows.Browser.HtmlPage.Window.Alert(_Error.Message);
            }
        }

        #endregion

        #region Recálculo de Líneas de Crédito

        public static void RecalculoLinea(string optionmenu)
        {

            try
            {
                __UserControlTitle = "Recalculo Línea";
                __UserControlID = "UserControlProcess";
                __UserControlName = "UserControlRecalculoLinea";

                if (!WC.FindUserControl(__UserControlID))
                {
                    AdminOpciones.Controls.Process _Process = new Process();
                    _Process.UserControlName = __UserControlName;
                    _Process.event_CloseWindows += new CloseWindows(event_CloseWindows);
                    _Process.Executing(EnumProcess.RecalcularLineas);
                    WC.CreateUserControl(_Process, __UserControlTitle, __UserControlName, __UserControlID, optionmenu, 1);
                }
            }
            catch (Exception _Error)
            {
                System.Windows.Browser.HtmlPage.Window.Alert(_Error.Message);
            }

        }

        #endregion

        #endregion


        #region Cambio Contraseña

        

        public static void CambioClave(string optionmenu)
        {
            try
            {
                __UserControlTitle = "Cambio de Contraseña";
                __UserControlID = "UserControlCambiodeContraseña";
                __UserControlName = "UserControlCambiodeContraseña";

                if (!WC.FindUserControl(__UserControlID))
                {
                    //globales._FechaContrato1 = globales._FechaProceso;
                    //globales._FechaContrato2 = globales._FechaProceso;

                    AdminOpciones.Controls.CambioClave cCambioClave = new AdminOpciones.Controls.CambioClave();
                    cCambioClave.UserControlName = __UserControlName;
                    //cCambioClave.VerticalAlignment = VerticalAlignment.Top;
                    //cCambioClave.HorizontalAlignment = HorizontalAlignment.Right ;
                    //cCambioClave.ShowControls(EnumDetalleCartera.FaxConfirmacion); ;
                    WC.CreateUserControl(cCambioClave, __UserControlTitle, __UserControlName, __UserControlID, optionmenu, 1);
                }
            }
            catch (Exception _Error)
            {
                System.Windows.Browser.HtmlPage.Window.Alert(_Error.Message);
            }
        }

       

        #endregion


        #region Contratos

        #region Front Opciones

        public static void FrontOpciones(string optionmenu)
        {
            try
            {
                globales._Estado = "C";


                __UserControlID = "UserControlFrontOpciones";
                if (WC.Count(__UserControlID).Equals(0))
                {
                    _CountFrontOpciones = 0;
                }
                _CountFrontOpciones++;
                __UserControlTitle = _CountFrontOpciones.ToString() + ".- Ingreso de Opciones";
                __UserControlName = __UserControlID + _CountFrontOpciones.ToString("000000"); // WC.UserControlName();

                OpcionesFX.Front.FontOpciones cIngreso = new OpcionesFX.Front.FontOpciones();
                cIngreso._TitleOriginal = __UserControlTitle;
                cIngreso.UserControlName = __UserControlName;
                cIngreso.event_SendChangeTitle += new AdminOpciones.OpcionesFX.Front.SendChangeTitle(event_SendChangeTitle);

                WC.CreateUserControl(cIngreso, __UserControlTitle, __UserControlName, __UserControlID, optionmenu, 0);
            }
            catch (Exception _Error)
            {
                System.Windows.Browser.HtmlPage.Window.Alert(_Error.Message);
            }
        }

        private static void event_SendChangeTitle(string title, string usercontrolName)
        {
            for (int _Control = 0; _Control < WC.UserControls.Children.Count; _Control++)
            {
                if (WC.UserControls.Children[_Control].GetType().FullName.Equals("Liquid.Dialog"))
                {
                    Liquid.Dialog _Dialog = (Liquid.Dialog)WC.UserControls.Children[_Control];
                    if (_Dialog.Name.Equals(usercontrolName))
                    {
                        _Dialog.Title = title;
                        _Dialog.UpdateLayout();
                    }
                }
            }
        }

        #endregion

        #region Detalle de Movimiento

        public static void DetalleMovimiento(string optionmenu)
        {
            try
            {
                __UserControlTitle = "Detalle Movimientos";
                __UserControlID = "UserControlDetalleMovimiento";
                __UserControlName = "UserControlDetalleMovimiento";

                if (!WC.FindUserControl(__UserControlID))
                {
                    DetalleMovimiento cMovimiento = new DetalleMovimiento();
                    cMovimiento.VerticalAlignment = VerticalAlignment.Top;
                    cMovimiento.ShowControls(EnumDetalleMovimiento.ConsultaMovimiento);
                    WC.CreateUserControl(cMovimiento, __UserControlTitle, __UserControlName, __UserControlID, optionmenu, 0);
                }
            }
            catch (Exception _Error)
            {
                System.Windows.Browser.HtmlPage.Window.Alert(_Error.Message);
            }
        }

        #endregion

        #region Consulta de Cartera

        public static void ConsultaCartera(string optionmenu)
        {
            try
            {
                __UserControlTitle = "Consulta de Cartera";
                __UserControlID = "UserControlConsultaCartera";
                __UserControlName = "UserControlConsultaCartera";

                if (!WC.FindUserControl(__UserControlID))
                {
                    DetalleCartera cCartera = new DetalleCartera();
                    cCartera.VerticalAlignment = VerticalAlignment.Top;
                    cCartera.ShowControls(EnumDetalleCartera.ConsultaCartera);
                    WC.CreateUserControl(cCartera, __UserControlTitle, __UserControlName, __UserControlID, optionmenu, 0);
                }
            }
            catch (Exception _Error)
            {
                System.Windows.Browser.HtmlPage.Window.Alert(_Error.Message);
            }
        }

        #endregion

        #region Preparación Cartera

        public static void PreparacionCartera(string optionmenu)
        {
            try
            {
                __UserControlTitle = "Preparar Acción";
                __UserControlID = "UserControlPrepararCartera";
                __UserControlName = "UserControlPrepararCartera";

                if (!WC.FindUserControl(__UserControlID))
                {
                    DetalleCartera cCartera = new DetalleCartera();
                    cCartera.VerticalAlignment = VerticalAlignment.Top;
                    cCartera.ShowControls(EnumDetalleCartera.PrepararAccion);
                    WC.CreateUserControl(cCartera, __UserControlTitle, __UserControlName, __UserControlID, optionmenu, 0);
                }
            }
            catch (Exception _Error)
            {
                System.Windows.Browser.HtmlPage.Window.Alert(_Error.Message);
            }
        }

        #endregion

        #region Anticipo

        #region Consulta Anticipos

        public static void ConsultarAnticipo(string optionmenu)
        {
            try
            {
                __UserControlTitle = "Consulta Anticipos";
                __UserControlID = "UserControlConsultarAnticipos";
                __UserControlName = "UserControlConsultarAnticipos";

                if (!WC.FindUserControl(__UserControlID))
                {
                    DetalleMovimiento cMovimiento = new DetalleMovimiento();
                    cMovimiento.VerticalAlignment = VerticalAlignment.Top;
                    cMovimiento.ShowControls(EnumDetalleMovimiento.ConsultaAnticipo);
                    WC.CreateUserControl(cMovimiento, __UserControlTitle, __UserControlName, __UserControlID, optionmenu, 0);
                }
            }
            catch (Exception _Error)
            {
                System.Windows.Browser.HtmlPage.Window.Alert(_Error.Message);
            }

        }

        #endregion

        #region Anulacion de Anticipos

        public static void AnulacionAnticipos(string optionmenu)
        {
            try
            {
                __UserControlTitle = "Anulación Anticipos";
                __UserControlID = "UserControlConsultarAnticipos";
                __UserControlName = "UserControlConsultarAnticipos";

                if (!WC.FindUserControl(__UserControlID))
                {
                    DetalleMovimiento cMovimiento = new DetalleMovimiento();
                    cMovimiento.VerticalAlignment = VerticalAlignment.Top;
                    cMovimiento.ShowControls(EnumDetalleMovimiento.AnulacionAnticipo);
                    WC.CreateUserControl(cMovimiento, __UserControlTitle, __UserControlName, __UserControlID, optionmenu, 0);
                }
            }
            catch (Exception _Error)
            {
                System.Windows.Browser.HtmlPage.Window.Alert(_Error.Message);
            }

        }

        #endregion

        #region Consulta Anticipos

        public static void ConsultarSDA(string optionmenu)
        {
            try
            {
                globales._SDA = "Con_SDA";
                __UserControlTitle = "Consulta SDA";
                __UserControlID =   "UserControlConsultarSDA";
                __UserControlName = "UserControlConsultarSDA";

                if (!WC.FindUserControl(__UserControlID))
                {
                    DetalleMovimiento cMovimiento = new DetalleMovimiento();
                    cMovimiento.VerticalAlignment = VerticalAlignment.Top;
                    cMovimiento.ShowControls(EnumDetalleMovimiento.ConsultaSDA);
                    WC.CreateUserControl(cMovimiento, __UserControlTitle, __UserControlName, __UserControlID, optionmenu, 0);
                    cMovimiento.ExpExcel.Visibility = Visibility.Collapsed;
                    cMovimiento.SelTodo.Visibility = Visibility.Collapsed;
                    cMovimiento.Imprimir.Visibility = Visibility.Collapsed;
                }
            }
            catch (Exception _Error)
            {
                System.Windows.Browser.HtmlPage.Window.Alert(_Error.Message);
            }

        }

        #endregion

        #endregion

        #region Cierre / Apertura Mesa

        public static void CierreMesa(string optionmenu)
        {
            try
            {
                __UserControlTitle = "Cierre / Apertura Mesa";
                __UserControlID = "UserControlCierreMesa";
                __UserControlName = "UserControlCierreMesa";

                if (!WC.FindUserControl(__UserControlID))
                {
                    CierreAbreMesa cMesa = new CierreAbreMesa();
                    cMesa.send_controlmesa += new CierreAbreMesa.event_controlmesa(event_cierremesa);
                    cMesa.VerticalAlignment = VerticalAlignment.Top;
                    WC.CreateUserControl(cMesa, __UserControlTitle, __UserControlName, __UserControlID, optionmenu, 0);
                }
            }
            catch (Exception _Error)
            {
                System.Windows.Browser.HtmlPage.Window.Alert(_Error.Message);
            }

        }

        #endregion

        #endregion

        #region Consultas

        #region Consulta Pagos Compensados

        public static void ConsultaPagosCompensados(string optionmenu)
        {
            try
            {
                __UserControlTitle = "Consulta de Pagos Compensados";
                __UserControlID = "UserControlConsultaPagosCompensados";
                __UserControlName = "UserControlConsultaPagosCompensados";

                if (!WC.FindUserControl(__UserControlID))
                {
                    PagosCompensados cPagosComp = new PagosCompensados();
                    cPagosComp.Consult(true);
                    cPagosComp.VerticalAlignment = VerticalAlignment.Top;
                    cPagosComp.Dt_FechaDesde.Text = Convert.ToDateTime(Convert.ToString(globales._FechaProceso)).ToString("dd/MM/yyyy");
                    cPagosComp.Dt_FechaHasta.Text = Convert.ToDateTime(Convert.ToString(globales._FechaProceso)).ToString("dd/MM/yyyy");
                    WC.CreateUserControl(cPagosComp, __UserControlTitle, __UserControlName, __UserControlID, optionmenu, 0);
                }
            }
            catch (Exception _Error)
            {
                System.Windows.Browser.HtmlPage.Window.Alert(_Error.Message);
            }
        }

        #endregion

        #region Consulta Pagos Con Entrega Fisica

        public static void ConsultaPagosEntregaFisica(string optionmenu)
        {
            try
            {
                __UserControlTitle = "Consulta de Pagos Con Entrega Física";
                __UserControlID = "UserControlConsultasPagosEntregaFisica";
                __UserControlName = "UserControlConsultasPagosEntregaFisica";

                if (!WC.FindUserControl(__UserControlID))
                {
                    PagosEntregaFisica cPagosEntregaf = new PagosEntregaFisica();
                    cPagosEntregaf.Consult(true);
                    cPagosEntregaf.VerticalAlignment = VerticalAlignment.Top;
                    cPagosEntregaf.Dt_FechaDesde.Text = Convert.ToDateTime(Convert.ToString(globales._FechaProceso)).ToString("dd/MM/yyyy");
                    cPagosEntregaf.Dt_FechaHasta.Text = Convert.ToDateTime(Convert.ToString(globales._FechaProceso)).ToString("dd/MM/yyyy");
                    WC.CreateUserControl(cPagosEntregaf, __UserControlTitle, __UserControlName, __UserControlID, optionmenu, 0);
                }
            }
            catch (Exception _Error)
            {
                System.Windows.Browser.HtmlPage.Window.Alert(_Error.Message);
            }
        }

        #endregion

        #endregion

        #region Informes

        #region BCCH y Clientes

        #region Complemento Condiciones Generales

        public static void ComplementosCondicionesGenerales(string optionmenu)
        {
            try
            {
                __UserControlTitle = "Complemento Condiciones Generales";
                __UserControlID = "UserControlComplementoCondiconesGenerales";
                __UserControlName = "UserControlComplementoCondiconesGenerales";

                if (!WC.FindUserControl(__UserControlID))
                {
                    CondicionesGenerales cGenerales = new CondicionesGenerales();
                    cGenerales.VerticalAlignment = VerticalAlignment.Top;
                    cGenerales.SelTodo.Visibility = Visibility.Collapsed;
                    WC.CreateUserControl(cGenerales, __UserControlTitle, __UserControlName, __UserControlID, optionmenu, 0);
                }
            }
            catch (Exception _Error)
            {
                System.Windows.Browser.HtmlPage.Window.Alert(_Error.Message);
            }

        }

        #endregion

        #region Fax de Confirmación

        public static void FaxConfirmacion(string optionmenu)
        {
            try
            {
                __UserControlTitle = "Fax de Confirmación";
                __UserControlID = "UserControlFaxConfirmacion";
                __UserControlName = "UserControlFaxConfirmacion";

                if (!WC.FindUserControl(__UserControlID))
                {
                    globales._FechaContrato1 = globales._FechaProceso;
                    globales._FechaContrato2 = globales._FechaProceso;

                    DetalleCartera cCartera = new DetalleCartera();
                    cCartera.VerticalAlignment = VerticalAlignment.Top;
                    cCartera.ShowControls(EnumDetalleCartera.FaxConfirmacion); ;
                    WC.CreateUserControl(cCartera, __UserControlTitle, __UserControlName, __UserControlID, optionmenu, 0);
                }
            }
            catch (Exception _Error)
            {
                System.Windows.Browser.HtmlPage.Window.Alert(_Error.Message);
            }
        }

        #endregion

        #region Liquidaciones

        public static void Liquidaciones(string optionmenu)
        {
            try
            {
                __UserControlTitle = "Liquidaciones";
                __UserControlID = "UserControlLiquidaciones";
                __UserControlName = "UserControlLiquidaciones";

                if (!WC.FindUserControl(__UserControlID))
                {
                    DateTime RestaDia = Convert.ToDateTime(globales._FechaProceso).AddDays(-1);
                    DetalleLiquidacionDef cLiquidaciones = new DetalleLiquidacionDef();
                    cLiquidaciones.VerticalAlignment = VerticalAlignment.Top;
                    cLiquidaciones.Dt_FechaDesde.Text = Convert.ToDateTime(Convert.ToString(RestaDia)).ToString("dd/MM/yyyy");
                    cLiquidaciones.Dt_FechaHasta.Text = Convert.ToDateTime(Convert.ToString(globales._FechaProceso)).ToString("dd/MM/yyyy");
                    cLiquidaciones.InitializeComponent();
                    WC.CreateUserControl(cLiquidaciones, __UserControlTitle, __UserControlName, __UserControlID, optionmenu, 0);
                }
            }
            catch (Exception _Error)
            {
                System.Windows.Browser.HtmlPage.Window.Alert(_Error.Message);
            }

        }

        #endregion

        #region Emisión Contratos Empresas

        public static void EmisionContratosEmpresa(string optionmenu)
        {
            try
            {
                __UserControlTitle = "Emisión Contratos Empresas";
                __UserControlID = "UserControlEmisionContratosEmpresa";
                __UserControlName = "UserControlEmisionContratosEmpresa";

                if (!WC.FindUserControl(__UserControlID))
                {
                    DateTime RestaDia = new DateTime();
                    RestaDia = Convert.ToDateTime(globales._FechaProceso).AddDays(-1);

                    globales._FechaContrato1 = Convert.ToString(RestaDia);
                    globales._FechaContrato2 = globales._FechaProceso;

                    DetalleCartera cCartera = new DetalleCartera();
                    cCartera.VerticalAlignment = VerticalAlignment.Top;
                    cCartera.ShowControls(EnumDetalleCartera.EmisionContratosEmpresas);
                    WC.CreateUserControl(cCartera, __UserControlTitle, __UserControlName, __UserControlID, optionmenu, 0);
                }
            }
            catch (Exception _Error)
            {
                System.Windows.Browser.HtmlPage.Window.Alert(_Error.Message);
            }
        }

        #endregion

        #endregion

        #region Movimiento

        #region Listado Movimientos entre fechas

        public static void ListadoMovimientoEntreFecha(string optionmenu)
        {
            try
            {
                __UserControlTitle = "Listado Movimientos entre fechas";
                __UserControlID = "UserControlListadoMovimientoEntreFecha";
                __UserControlName = "UserControlListadoMovimientoEntreFecha";

                if (!WC.FindUserControl(__UserControlID))
                {
                    ControlReportes cReportes = new ControlReportes();
                    cReportes.TextBox1.Text = "Listado Movimientos entre fechas";
                    WC.CreateUserControl(cReportes, __UserControlTitle, __UserControlName, __UserControlID, optionmenu, 0);
                }
            }
            catch (Exception _Error)
            {
                System.Windows.Browser.HtmlPage.Window.Alert(_Error.Message);
            }

        }

        #endregion

        #region Listado Control de Precios

        public static void ListadoControldePrecios(string optionmenu)
        {
            try
            {
                __UserControlTitle = "Listado Control de Precios";
                __UserControlID = "UserControlListadoControlPrecio";
                __UserControlName = "UserControlListadoControlPrecio";

                if (!WC.FindUserControl(__UserControlID))
                {
                    ControlReportes cReportes = new ControlReportes();
                    cReportes.TextBox1.Text = "Listado Control de Precios";
                    WC.CreateUserControl(cReportes, __UserControlTitle, __UserControlName, __UserControlID, optionmenu, 0);
                }
            }
            catch (Exception _Error)
            {
                System.Windows.Browser.HtmlPage.Window.Alert(_Error.Message);
            }

        }

        #endregion

        #region Listado Anulaciones

        public static void ListadoAnulaciones(string optionmenu)
        {
            try
            {
                __UserControlTitle = "Listado Movimientos entre fechas";
                __UserControlID = "UserControlListadoMovimientoEntreFecha";
                __UserControlName = "UserControlListadoMovimientoEntreFecha";

                if (!WC.FindUserControl(__UserControlID))
                {
                    ControlReportes cReportes = new ControlReportes();
                    cReportes.TextBox1.Text = "Listado Anulaciones";
                    WC.CreateUserControl(cReportes, __UserControlTitle, __UserControlName, __UserControlID, optionmenu, 0);
                }
            }
            catch (Exception _Error)
            {
                System.Windows.Browser.HtmlPage.Window.Alert(_Error.Message);
            }

        }

        #endregion

        #endregion

        #region Cartera

        public static void Cartera(string optionmenu)
        {
            try
            {
                __UserControlTitle = "Cartera";
                __UserControlID = "UserControlCartera";
                __UserControlName = "UserControlCartera";

                if (!WC.FindUserControl(__UserControlID))
                {
                    ControlReportes cReportes = new ControlReportes();
                    cReportes.TextBox1.Text = "Cartera";
                    WC.CreateUserControl(cReportes, __UserControlTitle, __UserControlName, __UserControlID, optionmenu, 0);
                }
            }
            catch (Exception _Error)
            {
                System.Windows.Browser.HtmlPage.Window.Alert(_Error.Message);
            }

        }

        #endregion

        #region Contables

        #region Voucher Contables

        public static void VoucherContables(string optionmenu)
        {
            try
            {
                __UserControlTitle = "Voucher Contables";
                __UserControlID = "UserControlVoucherContables";
                __UserControlName = "UserControlVoucherContables";

                if (!WC.FindUserControl(__UserControlID))
                {
                    ControlReportes cReportes = new ControlReportes();
                    cReportes.TextBox1.Text = "Voucher Contables";
                    WC.CreateUserControl(cReportes, __UserControlTitle, __UserControlName, __UserControlID, optionmenu, 0);
                }
            }
            catch (Exception _Error)
            {
                System.Windows.Browser.HtmlPage.Window.Alert(_Error.Message);
            }

        }

        #endregion

        #region Movimientos por Cuenta

        public static void MovimientoporCuenta(string optionmenu)
        {
            try
            {
                __UserControlTitle = "Movimientos por Cuenta";
                __UserControlID = "UserControlMovimientoporCuenta";
                __UserControlName = "UserControlMovimientoporCuenta";

                if (!WC.FindUserControl(__UserControlID))
                {
                    ControlReportes cReportes = new ControlReportes();
                    cReportes.TextBox1.Text = "Movimientos por Cta.";  // MAP 30 Oct. 2009, no estaba bien el nombre
                    WC.CreateUserControl(cReportes, __UserControlTitle, __UserControlName, __UserControlID, optionmenu, 0);
                }
            }
            catch (Exception _Error)
            {
                System.Windows.Browser.HtmlPage.Window.Alert(_Error.Message);
            }

        }

        #endregion

        #region Balance por Operación

        public static void BalancerporOperacion(string optionmenu)
        {
            try
            {
                __UserControlTitle = "Balance por Operacións";
                __UserControlID = "UserControlBalancerporOperacion";
                __UserControlName = "UserControlBalancerporOperacion";

                if (!WC.FindUserControl(__UserControlID))
                {
                    ControlReportes cReportes = new ControlReportes();
                    cReportes.TextBox1.Text = "Balance por Operación";
                    WC.CreateUserControl(cReportes, __UserControlTitle, __UserControlName, __UserControlID, optionmenu, 0);
                }
            }
            catch (Exception _Error)
            {
                System.Windows.Browser.HtmlPage.Window.Alert(_Error.Message);
            }

        }

        #endregion

        #endregion

        #endregion

        #region Procesos

        #region Pagos Compensados

        public static void PagosCompensados(string optionmenu)
        {
            try
            {
                __UserControlTitle = "Pagos Compensados";
                __UserControlID = "UserControlPagosCompensados";
                __UserControlName = "UserControlPagosCompensados";

                if (!WC.FindUserControl(__UserControlID))
                {
                    PagosCompensados cPagosComp = new PagosCompensados();
                    cPagosComp.Consult(false);
                    cPagosComp.VerticalAlignment = VerticalAlignment.Top;
                    cPagosComp.Dt_FechaDesde.Text = Convert.ToDateTime(Convert.ToString(globales._FechaProceso)).ToString("dd/MM/yyyy");
                    cPagosComp.Dt_FechaHasta.Text = Convert.ToDateTime(Convert.ToString(globales._FechaProceso)).ToString("dd/MM/yyyy");
                    WC.CreateUserControl(cPagosComp, __UserControlTitle, __UserControlName, __UserControlID, optionmenu, 0);
                }
            }
            catch (Exception _Error)
            {
                System.Windows.Browser.HtmlPage.Window.Alert(_Error.Message);
            }
        }

        #endregion

        #region Vencimientos/Pagos Entrega Física

        public static void PagosEntregaFisica(string optionmenu)
        {
            try
            {
                __UserControlTitle = "Pagos Con Entrega Física";
                __UserControlID = "UserControlPagosEntregaFisica";
                __UserControlName = "UserControlPagosEntregaFisica";

                if (!WC.FindUserControl(__UserControlID))
                {
                    PagosEntregaFisica cPagosEntregaf = new PagosEntregaFisica();
                    cPagosEntregaf.Consult(false);
                    cPagosEntregaf.VerticalAlignment = VerticalAlignment.Top;
                    cPagosEntregaf.Dt_FechaDesde.Text = Convert.ToDateTime(Convert.ToString(globales._FechaProceso)).ToString("dd/MM/yyyy");
                    cPagosEntregaf.Dt_FechaHasta.Text = Convert.ToDateTime(Convert.ToString(globales._FechaProceso)).ToString("dd/MM/yyyy");
                    cPagosEntregaf.InitializeComponent();
                    WC.CreateUserControl(cPagosEntregaf, __UserControlTitle, __UserControlName, __UserControlID, optionmenu, 0);
                }
            }
            catch (Exception _Error)
            {
                System.Windows.Browser.HtmlPage.Window.Alert(_Error.Message);
            }
        }

        #endregion

        #region Proceso Fijación Contratos

        public static void Fijacion(string optionmenu)
        {
            try
            {
                __UserControlTitle = "Proceso Fijación Contratos";
                __UserControlID = "UserControlFijacion";
                __UserControlName = "UserControlFijacion";

                if (!WC.FindUserControl(__UserControlID))
                {
                    ProcesoFijacion cFijacion = new ProcesoFijacion();
                    cFijacion.Dt_FechaDesde.Text = Convert.ToDateTime(Convert.ToString(globales._FechaProceso)).ToString("dd/MM/yyyy");
                    cFijacion.Dt_FechaDesde_Copy.Text = Convert.ToDateTime(Convert.ToString(globales._FechaProceso)).ToString("dd/MM/yyyy");
                    WC.CreateUserControl(cFijacion, __UserControlTitle, __UserControlName, __UserControlID, optionmenu, 0);
                }
            }
            catch (Exception _Error)
            {
                System.Windows.Browser.HtmlPage.Window.Alert(_Error.Message);
            }

        }

        #endregion

        #region Proceso Decisiones de Ejercicio de Contratos

        public static void Ejercicio(string optionmenu)
        {
            try
            {
                __UserControlTitle = "Proceso Decisiones de Ejercicio de Contratos";
                __UserControlID = "UserControlEjercicio";
                __UserControlName = "UserControlEjercicio";

                if (!WC.FindUserControl(__UserControlID))
                {
                    ProcesoDecisionEjer cEjercicio = new ProcesoDecisionEjer();
                    cEjercicio.Dt_FechaHasta.Text = Convert.ToDateTime(Convert.ToString(globales._FechaProceso)).ToString("dd/MM/yyyy");
                    WC.CreateUserControl(cEjercicio, __UserControlTitle, __UserControlName, __UserControlID, optionmenu, 0);
                }
            }
            catch (Exception _Error)
            {
                System.Windows.Browser.HtmlPage.Window.Alert(_Error.Message);
            }

        }

        #endregion

        #region Valorizacion Carter

        public static void Valorizacion(string optionmenu)
        {
            try
            {
                __UserControlTitle = "Valorizacion Carter";
                __UserControlID = "UserControlValorizacion";
                __UserControlName = "UserControlValorizacion";

                if (!WC.FindUserControl(__UserControlID))
                {
                    OpcionesFX.ValorizadorCartera.ValorizadorCartera cValorizacion = new OpcionesFX.ValorizadorCartera.ValorizadorCartera();
                    WC.CreateUserControl(cValorizacion, __UserControlTitle, __UserControlName, __UserControlID, optionmenu, 0);
                }
            }
            catch (Exception _Error)
            {
                System.Windows.Browser.HtmlPage.Window.Alert(_Error.Message);
            }

        }

        #endregion

        #region Contabilizacion

        public static void Contabilizacion(string optionmenu)
        {

            try
            {
                __UserControlTitle = "Contabilidad";
                __UserControlID = "UserControlProcess";
                __UserControlName = "UserControlContabilidad";

                if (!WC.FindUserControl(__UserControlID))
                {
                    AdminOpciones.Controls.Process _Process = new Process();
                    _Process.UserControlName = __UserControlName;
                    _Process.event_CloseWindows += new CloseWindows(event_CloseWindows);
                    _Process.Executing(EnumProcess.Contabilidad);
                    WC.CreateUserControl(_Process, __UserControlTitle, __UserControlName, __UserControlID, optionmenu, 1);
                }
            }
            catch (Exception _Error)
            {
                System.Windows.Browser.HtmlPage.Window.Alert(_Error.Message);
            }

        }

        #endregion

        #endregion

        #region Interfaces

        #region Interfaz Operaciones

        public static void InterfazOperaciones(string optionmenu)
        {

            try
            {
                __UserControlTitle = "Interfaz de Operaciones";
                __UserControlID = "UserControlProcess";
                __UserControlName = "UserControlInterfazOperaciones";

                if (!WC.FindUserControl(__UserControlID))
                {
                    AdminOpciones.Controls.Process _Process = new Process();
                    _Process.UserControlName = __UserControlName;
                    _Process.event_CloseWindows += new CloseWindows(event_CloseWindows);
                    _Process.Executing(EnumProcess.InterfazOperacion);
                    WC.CreateUserControl(_Process, __UserControlTitle, __UserControlName, __UserControlID, optionmenu, 1);
                }
            }
            catch (Exception _Error)
            {
                System.Windows.Browser.HtmlPage.Window.Alert(_Error.Message);
            }

        }

        #endregion

        #region Interfaz de Derivados

        public static void InterfazDerivados(string optionmenu)
        {

            try
            {
                __UserControlTitle = "Interfaz de Derivados";
                __UserControlID = "UserControlProcess";
                __UserControlName = "UserControlInterfazDerivados";

                if (!WC.FindUserControl(__UserControlID))
                {
                    AdminOpciones.Controls.Process _Process = new Process();
                    _Process.UserControlName = __UserControlName;
                    _Process.event_CloseWindows += new CloseWindows(event_CloseWindows);
                    _Process.Executing(EnumProcess.InterfazDerivados);
                    WC.CreateUserControl(_Process, __UserControlTitle, __UserControlName, __UserControlID, optionmenu, 1);
                }
            }
            catch (Exception _Error)
            {
                System.Windows.Browser.HtmlPage.Window.Alert(_Error.Message);
            }

        }

        #endregion

        #region Interfaz de Balance

        public static void InterfazBalance(string optionmenu)
        {

            try
            {
                __UserControlTitle = "Interfaz de Balance";
                __UserControlID = "UserControlProcess";
                __UserControlName = "UserControlInterfazBalance";

                if (!WC.FindUserControl(__UserControlID))
                {
                    AdminOpciones.Controls.Process _Process = new Process();
                    _Process.UserControlName = __UserControlName;
                    _Process.event_CloseWindows += new CloseWindows(event_CloseWindows);
                    _Process.Executing(EnumProcess.InterfazBalance);
                    WC.CreateUserControl(_Process, __UserControlTitle, __UserControlName, __UserControlID, optionmenu, 1);
                }
            }
            catch (Exception _Error)
            {
                System.Windows.Browser.HtmlPage.Window.Alert(_Error.Message);
            }

        }

        #endregion

        #endregion

        #region Definiciones

        #region Firma de Condiciones Generales

        public static void FirmaCondicionesGenerales(string optionmenu)
        {
            try
            {
                __UserControlTitle = "Firma de Condiciones Generales";
                __UserControlID = "UserControlFirmaCondicionesGenerales";
                __UserControlName = "UserControlFirmaCondicionesGenerales";

                if (!WC.FindUserControl(__UserControlID))
                {
                    CondicionesGenerales cGenerales = new CondicionesGenerales();
                    WC.CreateUserControl(cGenerales, __UserControlTitle, __UserControlName, __UserControlID, optionmenu, 0);
                }
            }
            catch (Exception _Error)
            {
                System.Windows.Browser.HtmlPage.Window.Alert(_Error.Message);
            }

        }

        #endregion

        #endregion

        #region Fin de Día

        public static void FinDia(string optionmenu)
        {
            try
            {
                __UserControlTitle = "Fín Dia";
                __UserControlID = "UserControlFinDia";
                __UserControlName = "UserControlFinDia";

                if (!WC.FindUserControl(__UserControlID))
                {
                    FinDia cFinDia = new FinDia();
                    cFinDia.VerticalAlignment = VerticalAlignment.Top;
                    WC.CreateUserControl(cFinDia, __UserControlTitle, __UserControlName, __UserControlID, optionmenu, 0);
                }
            }
            catch (Exception _Error)
            {
                System.Windows.Browser.HtmlPage.Window.Alert(_Error.Message);
            }

        }

        #endregion

        #region Actualización Parámetros

        public static void ActualizacionParametros(string optionmenu)
        {
            try
            {
                __UserControlTitle = "Listado Movimientos entre fechas";
                __UserControlID = "UserControlActualizacionParametros";
                __UserControlName = "UserControlActualizacionParametros";

                if (!WC.FindUserControl(__UserControlID))
                {
                    ActualizaParametros cActualizacionParametros = new ActualizaParametros();
                    cActualizacionParametros.VerticalAlignment = VerticalAlignment.Top;
                    WC.CreateUserControl(cActualizacionParametros, __UserControlTitle, __UserControlName, __UserControlID, optionmenu, 0);
                }
            }
            catch (Exception _Error)
            {
                System.Windows.Browser.HtmlPage.Window.Alert(_Error.Message);
            }

        }

        #endregion

        #region Funciones privadas

        private static void event_cierremesa(int status)
        {
            event_RefreshMesa(status);
        }

        private static void event_CloseWindows(string userControlName)
        {
            AdminOpciones.Controls.LogAuditoria.SaveLogAuditoria(userControlName, "07", "");
            WC.CloseUserControl(userControlName);
        }

        #endregion

    }
}
