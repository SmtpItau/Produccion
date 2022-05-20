using System;
using System.Collections.Generic;
using System.Linq;
using System.Windows;
using System.Windows.Browser;
using System.Windows.Controls;
using System.Xml.Linq;
using AdminOpciones.OpcionesFX;
using AdminOpciones.Controls;
using AdminOpciones.Recursos;
using AdminOpciones.Struct;
using Liquid;
using System.Windows.Media;
using WC = AdminOpciones.Controls.WindowsControls;
using AdminOpciones.Delegados;
using Microsoft.Windows.Controls;

namespace AdminOpciones.MenuPrincipal
{

    public partial class Menu : UserControl
    {

        #region Definición de Eventos
        public event CierraSesion event_CierraSession;
        public event RefreshStatusSystem event_RefreshStatusSystem;
        public event RefreshControlMesa event_RefreshMesa;
        #endregion

        #region Definición de Variables

        private List<StructMenu> MenuLis;
        private List<string> MenuOPT = new List<string>();
        public List<string> _OpcionesElegidas = new List<string>();
        XDocument xmlOpcionesMenu = new XDocument();
        AdminOpciones.OpcionesFX.Icon RotateIcon = new AdminOpciones.OpcionesFX.Icon();
        string Aux;
        bool EstadoMenu = false; //true-> abierto, false ->cerrado.

        Dialog _DiagPopAux = new Dialog();

        public class _Exporta
        {
            public string _fecha { get; set; }

            public override string ToString()
            {
                return string.Format("?Fecha={0}", _fecha);
            }
        }
        public class _Resultados
        {
            public string Result1 { get; set; }
            public string Result2 { get; set; }
        }

        #endregion

        public Menu()
        {
            InitializeComponent();
            this.TMenu.SelectedItemChanged += new RoutedPropertyChangedEventHandler<object>(TMenu_SelectedItemChanged);
            this.TMenu.MouseLeftButtonUp += new System.Windows.Input.MouseButtonEventHandler(TMenu_MouseLeftButtonUp);

            WC.UserControls = this.gPrincipal;

            FechaEstado.Text = "Sin inicio Dia";
            FechaProceso.Text = "";

            #region "Opciones Menu"
            if (MenuOPT.Count == 0)
            {
                MenuOPT.Add("AdmOpc001");       //0    Menu Inicio Día
                MenuOPT.Add("AdmOpc00101");     //1    Inicio Día
                MenuOPT.Add("AdmOpc00102");     //2    Recálculo de Líneas de Crédito

                MenuOPT.Add("AdmOpc002");       //3    Menu Contratos
                MenuOPT.Add("AdmOpc00201");     //4    Ingreso de Contratos
                MenuOPT.Add("AdmOpc00202");     //5    Consulta de Movimientos
                MenuOPT.Add("AdmOpc00203");     //6    Consulta de Cartera
                MenuOPT.Add("AdmOpc00204");     //7    Mantención de Cartera
                MenuOPT.Add("AdmOpc00205");     //8    Preparar Acción
                MenuOPT.Add("AdmOpc00206");     //9    Anticipos
                MenuOPT.Add("AdmOpc0020601");   //10  Anticipar Contratos
                MenuOPT.Add("AdmOpc0020602");   //11  Consulta de Anticipos
                MenuOPT.Add("AdmOpc0020603");   //12  Anulacion de Anticipos
                MenuOPT.Add("AdmOpc0020604");   //13  Modificación de Formas de Pago
                MenuOPT.Add("AdmOpc00207");     //14  Cierre / Apertura de Mesa

                MenuOPT.Add("AdmOpc003");       //15  Menu Consultas 
                MenuOPT.Add("AdmOpc00301");     //16  Vencimientos/Pagos Compensados 
                MenuOPT.Add("AdmOpc00302");     //17  Vencimientos/Pagos Entrega Física

                MenuOPT.Add("AdmOpc004");       //18  Informes 
                MenuOPT.Add("AdmOpc00401");     //19  BCCH y Clientes
                MenuOPT.Add("AdmOpc0040101");   //20  Complemento Condiciones Generales
                MenuOPT.Add("AdmOpc0040102");   //21  Fax de Confirmación
                MenuOPT.Add("AdmOpc0040103");   //22  Liquidaciones
                MenuOPT.Add("AdmOpc0040104");   //23  Emisión Contratos SINACOFI
                MenuOPT.Add("AdmOpc0040105");   //24  Emisión Contratos Empresas
                MenuOPT.Add("AdmOpc00402");     //25  Movimiento 
                MenuOPT.Add("AdmOpc0040201");   //26  Listado Movimientos entre fechas
                MenuOPT.Add("AdmOpc0040202");   //27  Listado Control de Precios
                MenuOPT.Add("AdmOpc0040203");   //28  Listado Anulaciones
                MenuOPT.Add("AdmOpc0040204");   //29  Listado de Forward Asociados
                MenuOPT.Add("AdmOpc00403");     //30  Cartera 
                MenuOPT.Add("AdmOpc00404");     //31  Contables 
                MenuOPT.Add("AdmOpc0040401");   //32  Voucher Contables
                MenuOPT.Add("AdmOpc0040402");   //33  Movimientos por Cta.
                MenuOPT.Add("AdmOpc0040403");   //34  Balance por Operación

                MenuOPT.Add("AdmOpc005");       //35  Procesos 
                MenuOPT.Add("AdmOpc00501");     //36  Vencimientos/Pagos Compensados 
                MenuOPT.Add("AdmOpc00502");     //37  Vencimientos/Pagos Entrega Física              
                MenuOPT.Add("AdmOpc00503");     //38  Fijación  
                MenuOPT.Add("AdmOpc00504");     //39  Desiciones de Ejercicio de Contratos 
                MenuOPT.Add("AdmOpc00505");     //40  Valorizacion   
                MenuOPT.Add("AdmOpc00506");     //41  Contabilización

                MenuOPT.Add("AdmOpc006");       //42  Interfaces 
                MenuOPT.Add("AdmOpc00601");     //43  Interfaz de Operaciones   
                MenuOPT.Add("AdmOpc00602");     //44  Interfaz de Derivados 
                MenuOPT.Add("AdmOpc00603");     //45  Interfaz de Balance

                MenuOPT.Add("AdmOpc007");       //46 Definiciones
                MenuOPT.Add("AdmOpc00701");     //47 Firma de Condiciones Generales

                MenuOPT.Add("AdmOpc008");           //48  Fin de Día

                MenuOPT.Add("AdmOpc00507");         //49  Actualizar Parametros
            }
            #endregion
        }

        //Evento de seleccion del Treeview
        void TMenu_MouseLeftButtonUp(object sender, System.Windows.Input.MouseButtonEventArgs e)
        {
            //string Aux;
            string Nombre;
            Aux = "";
            bool Aux2 = this.Boton_Expander.IsExpanded;
            if (Aux2 == true) //valida si el menu esta desplegado
            {
                var _p = TMenu.SelectedValue;
                if (_p != null)
                {
                    Aux = TMenu.SelectedValue.ToString();
                    Microsoft.Windows.Controls.TreeViewItem TreeItem = TMenu.SelectedItem as Microsoft.Windows.Controls.TreeViewItem;
                    
                    Nombre = TreeItem.Header.ToString();
                    if (Aux != "AdmOpc001" && Aux != "AdmOpc002" &&
                        Aux != "AdmOpc003" && Aux != "AdmOpc004" &&
                        Aux != "AdmOpc005" && Aux != "AdmOpc006" &&
                        Aux != "AdmOpc007" && Aux != "AdmOpc00206" &&
                        Aux != "AdmOpc00401" && Aux != "AdmOpc00402" &&
                        Aux != "AdmOpc00404") //valida que no este ninguna de esta opciones seleccionada
                    {
                        MessageBoxResult Mes = System.Windows.MessageBox.Show("Desea Ver la Opción " + Nombre, "Administrador Opciones", MessageBoxButton.OKCancel);
                        if (Mes == MessageBoxResult.OK)
                        {
                            this.Boton_Expander.IsExpanded = false;
                            event_RefreshStatusSystem(Aux);
                        }
                        else
                        {
                            this.Boton_Expander.IsExpanded = true;
                        }
                    }
                }
            }
        }

        //Evento de seleccion del Treeview
        void TMenu_SelectedItemChanged(object sender, RoutedPropertyChangedEventArgs<object> e)
        {
            //string Aux;
            string Nombre;
            Aux = "";

            bool Aux2 = this.Boton_Expander.IsExpanded;
            if (Aux2 == true) //valida si el menu esta desplegado
            {
                var _p = TMenu.SelectedValue;
                if (_p != null)
                {
                    Aux = TMenu.SelectedValue.ToString();
                    Microsoft.Windows.Controls.TreeViewItem TreeItem = TMenu.SelectedItem as Microsoft.Windows.Controls.TreeViewItem;
                    
                    Nombre = TreeItem.Header.ToString();
                    if (Aux != "AdmOpc001" && Aux != "AdmOpc002" &&
                        Aux != "AdmOpc003" && Aux != "AdmOpc004" &&
                        Aux != "AdmOpc005" && Aux != "AdmOpc006" &&
                        Aux != "AdmOpc007" && Aux != "AdmOpc00206" &&
                        Aux != "AdmOpc00401" && Aux != "AdmOpc00402" &&
                        Aux != "AdmOpc00404") //valida que no este ninguna de esta opciones seleccionada
                    {
                        MessageBoxResult Mes = System.Windows.MessageBox.Show("Desea Ver la Opción " + Nombre, "Administrador Opciones", MessageBoxButton.OKCancel);
                        if (Mes == MessageBoxResult.OK)
                        {
                            this.Boton_Expander.IsExpanded = false;
                            event_RefreshStatusSystem(Aux);
                        }
                        else
                        {
                            this.Boton_Expander.IsExpanded = true;
                        }
                    }
                }
            }
        }

        void Opciones(string strXMLMenu)
        {
            xmlOpcionesMenu = XDocument.Parse(strXMLMenu);
            var OpcionMenuVar = from MenuOpcion in xmlOpcionesMenu.Descendants("Data")
                                select new StructMenu
                                {
                                    Entidad = MenuOpcion.Attribute("Entidad").Value.ToString().Trim(),
                                    Opcion = MenuOpcion.Attribute("Opcion").Value.ToString().Trim(),
                                    Habilitado = MenuOpcion.Attribute("Habilitado").Value.ToString().Trim()
                                };
            MenuLis = new List<StructMenu>(OpcionMenuVar.ToList<StructMenu>());
        }

        //Valida el perfil del usuario "este es temporal hasta no conectar definitivamente a la BD"
        public void Menu_event_ActivaMenu(string XmlResult)
        {
            Opciones(XmlResult);

            // MAP 31 Agosto 2009, opcion era activada para usuario sin opcion asignada
            if (globales._Usuario == "ADMINISTRA") { this.AdmOpc008.IsEnabled = true; }
            else { this.AdmOpc008.IsEnabled = false; }

            if (MenuLis.Count > 0)
            {
                foreach (StructMenu _Item in MenuLis)
                {
                    Microsoft.Windows.Controls.TreeViewItem _Control = (Microsoft.Windows.Controls.TreeViewItem)this.FindName(_Item.Opcion);
                                        
                    _Control.IsEnabled = _Item.Habilitado.Equals("S") ? true : false;
                }
            }

            this.AdmOpc001.IsExpanded = false;
            this.AdmOpc002.IsExpanded = false;
            this.AdmOpc003.IsExpanded = false;
            this.AdmOpc004.IsExpanded = false;
            this.AdmOpc005.IsExpanded = false;
            this.AdmOpc006.IsExpanded = false;
            this.AdmOpc007.IsExpanded = false;
            this.AdmOpc001.IsSelected = true;
        }

        //Evento cerrar aplicacion y dejar el login activo nuevamente
        private void HyperlinkButton_Click(object sender, RoutedEventArgs e)
        {
            this.AdmOpc001.IsSelected = true;
            this.Boton_Expander.IsExpanded = false;
            AdminOpciones.Controls.LogAuditoria.SaveLogAuditoria("", "06", "Cierre de sesión");
            event_CierraSession();
        }

        public void Seleccion(string Opcion)
        {
            this.cPrincipal.Visibility = Visibility.Visible;
            globales._FechaContrato1 = string.Empty;
            globales._FechaContrato2 = string.Empty;
            globales._FechaEjercicio1 = string.Empty;
            globales._FechaEjercicio2 = string.Empty;

            #region Ejecución de Opciones

            switch (Opcion)
            {
                case "AdmOpc00101":
                    #region Inicio Día
                    AdminOpciones.Controls.NewWindonwsControls.InicioDia(Opcion);
                    break;
                    #endregion

                case "AdmOpc00102":
                    #region Recálculo de Líneas de Crédito

                    AdminOpciones.Controls.NewWindonwsControls.RecalculoLinea(Opcion);
                    break;

                    #endregion

                case "AdmOpc00201":
                    #region Ingreso de Contratos

                    AdminOpciones.Controls.NewWindonwsControls.FrontOpciones(Opcion);
                    break;

                    #endregion

                case "AdmOpc00202":
                    #region Consulta de Movimientos

                    AdminOpciones.Controls.NewWindonwsControls.DetalleMovimiento(Opcion);
                    break;

                    #endregion

                case "AdmOpc00203":
                    #region Consulta de Cartera

                    AdminOpciones.Controls.NewWindonwsControls.ConsultaCartera(Opcion);
                    break;

                    #endregion

                case "AdmOpc00205":
                    #region Preparar Acción

                    AdminOpciones.Controls.NewWindonwsControls.PreparacionCartera(Opcion);
                    break;

                    #endregion

                case "AdmOpc0020602":
                    #region Consulta de Anticipos

                    AdminOpciones.Controls.NewWindonwsControls.ConsultarAnticipo(Opcion);
                    break;

                    #endregion

                case "AdmOpc0020603":
                    #region Anulacion de Anticipos

                    AdminOpciones.Controls.NewWindonwsControls.AnulacionAnticipos(Opcion);
                    break;

                    #endregion

                case "AdmOpc0020604":
                    #region Anulacion de Anticipos

                    AdminOpciones.Controls.NewWindonwsControls.ConsultarSDA(Opcion);
                    break;

                    #endregion

                case "AdmOpc00207":
                    #region Cierre / Apertura de Mesa

                    AdminOpciones.Controls.NewWindonwsControls.CierreMesa(Opcion);
                    break;

                    #endregion

                case "AdmOpc00301":
                    #region Vencimientos/Pagos Compensados

                    AdminOpciones.Controls.NewWindonwsControls.ConsultaPagosCompensados(Opcion);
                    break;

                    #endregion

                case "AdmOpc00302":
                    #region Vencimientos/Pagos Entrega Física

                    AdminOpciones.Controls.NewWindonwsControls.ConsultaPagosEntregaFisica(Opcion);
                    break;

                    #endregion

                case "AdmOpc0040101":
                    #region Complemento Condiciones Generales

                    AdminOpciones.Controls.NewWindonwsControls.ComplementosCondicionesGenerales(Opcion);
                    break;

                    #endregion

                case "AdmOpc0040102":
                    #region Fax de Confirmación

                    AdminOpciones.Controls.NewWindonwsControls.FaxConfirmacion(Opcion);
                    break;

                    #endregion

                case "AdmOpc0040103":
                    #region Liquidaciones

                    AdminOpciones.Controls.NewWindonwsControls.Liquidaciones(Opcion);
                    break;

                    #endregion

                case "AdmOpc0040104":
                    #region Emisión Contratos SINACOFI

                    break;

                    #endregion

                case "AdmOpc0040105":
                    #region Emisión Contratos Empresas

                    AdminOpciones.Controls.NewWindonwsControls.EmisionContratosEmpresa(Opcion);
                    break;

                    #endregion

                case "AdmOpc0040201":
                    #region Listado Movimientos entre fechas

                    AdminOpciones.Controls.NewWindonwsControls.ListadoMovimientoEntreFecha(Opcion);
                    break;

                    #endregion

                case "AdmOpc0040202":
                    #region Listado Control de Precios

                    AdminOpciones.Controls.NewWindonwsControls.ListadoControldePrecios(Opcion);
                    break;

                    #endregion

                case "AdmOpc0040203":
                    #region Listado Anulaciones

                    AdminOpciones.Controls.NewWindonwsControls.ListadoAnulaciones(Opcion);
                    break;

                    #endregion

                case "AdmOpc00403":
                    #region Cartera

                    AdminOpciones.Controls.NewWindonwsControls.Cartera(Opcion);
                    break;

                    #endregion

                case "AdmOpc0040401":
                    #region Voucher Contables

                    AdminOpciones.Controls.NewWindonwsControls.VoucherContables(Opcion);
                    break;

                    #endregion

                case "AdmOpc0040402":
                    #region Movimientos por Cuenta

                    AdminOpciones.Controls.NewWindonwsControls.MovimientoporCuenta(Opcion);
                    break;

                    #endregion

                case "AdmOpc0040403":
                    #region Balance por Operación

                    AdminOpciones.Controls.NewWindonwsControls.BalancerporOperacion(Opcion);
                    break;

                    #endregion

                case "AdmOpc00501":
                    #region Vencimientos/Pagos Compensados

                    AdminOpciones.Controls.NewWindonwsControls.PagosCompensados(Opcion);
                    break;

                    #endregion

                case "AdmOpc00502":
                    #region Vencimientos/Pagos Entrega Física

                    AdminOpciones.Controls.NewWindonwsControls.PagosEntregaFisica(Opcion);
                    break;

                    #endregion

                case "AdmOpc00503":
                    #region Fijación

                    AdminOpciones.Controls.NewWindonwsControls.Fijacion(Opcion);
                    break;

                    #endregion

                case "AdmOpc00504":
                    #region Desiciones de Ejercicio de Contratos

                    AdminOpciones.Controls.NewWindonwsControls.Ejercicio(Opcion);
                    break;

                    #endregion

                case "AdmOpc00505":
                    #region Valorización

                    AdminOpciones.Controls.NewWindonwsControls.Valorizacion(Opcion);
                    break;

                    #endregion

                case "AdmOpc00506":
                    #region Contabilización

                    AdminOpciones.Controls.NewWindonwsControls.Contabilizacion(Opcion);
                    break;

                    #endregion

                case "AdmOpc00507":
                    #region Actualiza Parametros

                    AdminOpciones.Controls.NewWindonwsControls.ActualizacionParametros(Opcion);
                    break;

                    #endregion

                case "AdmOpc00601":
                    #region Interfaz de Operaciones

                    AdminOpciones.Controls.NewWindonwsControls.InterfazOperaciones(Opcion);
                    break;

                    #endregion

                case "AdmOpc00602":
                    #region Interfaz de Derivados

                    AdminOpciones.Controls.NewWindonwsControls.InterfazDerivados(Opcion);
                    break;

                    #endregion

                case "AdmOpc00603":
                    #region Interfaz de Balance

                    AdminOpciones.Controls.NewWindonwsControls.InterfazBalance(Opcion);
                    break;

                    #endregion

                case "AdmOpc00701":
                    #region Firma de Condiciones Generales

                    AdminOpciones.Controls.NewWindonwsControls.FirmaCondicionesGenerales(Opcion);
                    break;

                    #endregion

                case "AdmOpc008":
                    #region Fin de Día

                    AdminOpciones.Controls.NewWindonwsControls.FinDia(Opcion);
                    break;

                    #endregion
            }
            #endregion
        }

        #region Control Mesa

        private void event_cierremesa(int status)
        {
            event_RefreshMesa(status);
        }

        #endregion

        private void Boton_Expander_Expanded(object sender, RoutedEventArgs e)
        {
            if (cPrincipal.Visibility == Visibility.Visible)
            {
                Canvas.SetZIndex(cPrincipal, 0);
                Canvas.SetZIndex(Controls, 0);
            }
        }

        private void Boton_Expander_Collapsed(object sender, RoutedEventArgs e)
        {
            if (cPrincipal.Visibility == Visibility.Visible)
            {
                Canvas.SetZIndex(Controls, 2);
            }
        }

        public void MenuAdministra()
        {
            AdmOpc001.IsEnabled = true;
            AdmOpc00101.IsEnabled = true;
            AdmOpc00102.IsEnabled = true;
            AdmOpc002.IsEnabled = true;
            AdmOpc00201.IsEnabled = true;
            AdmOpc00202.IsEnabled = true;
            AdmOpc00203.IsEnabled = true;
            AdmOpc00205.IsEnabled = true;
            AdmOpc00206.IsEnabled = true;
            AdmOpc0020602.IsEnabled = true;
            AdmOpc0020603.IsEnabled = true;
            AdmOpc0020604.IsEnabled = true;
            AdmOpc00207.IsEnabled = true;
            AdmOpc003.IsEnabled = true;
            AdmOpc00301.IsEnabled = true;
            AdmOpc00302.IsEnabled = true;
            AdmOpc004.IsEnabled = true;
            AdmOpc00401.IsEnabled = true;
            AdmOpc0040101.IsEnabled = true;
            AdmOpc0040102.IsEnabled = true;
            AdmOpc0040103.IsEnabled = true;
            AdmOpc0040104.IsEnabled = true;
            AdmOpc0040105.IsEnabled = true;
            AdmOpc00402.IsEnabled = true;
            AdmOpc0040201.IsEnabled = true;
            AdmOpc0040202.IsEnabled = true;
            AdmOpc0040203.IsEnabled = true;
            AdmOpc00403.IsEnabled = true;
            AdmOpc00404.IsEnabled = true;
            AdmOpc0040401.IsEnabled = true;
            AdmOpc0040402.IsEnabled = true;
            AdmOpc0040403.IsEnabled = true;
            AdmOpc005.IsEnabled = true;
            AdmOpc00501.IsEnabled = true;
            AdmOpc00502.IsEnabled = true;
            AdmOpc00503.IsEnabled = true;
            AdmOpc00504.IsEnabled = true;
            AdmOpc00505.IsEnabled = true;
            AdmOpc00506.IsEnabled = true;
            AdmOpc006.IsEnabled = true;
            AdmOpc00601.IsEnabled = true;
            AdmOpc00602.IsEnabled = true;
            AdmOpc00603.IsEnabled = true;
            AdmOpc007.IsEnabled = true;
            AdmOpc00701.IsEnabled = true;
            AdmOpc008.IsEnabled = true;
            AdmOpc00507.IsEnabled = true;
        }

        private void UserControl_SizeChanged(object sender, SizeChangedEventArgs e)
        {
            MenuSuperior.Width = e.NewSize.Width;
            MenuSuperior.Height = e.NewSize.Height;
            stackTitle01.Width = e.NewSize.Width;
            stackTitle02.Width = e.NewSize.Width;
            Controls.Width = e.NewSize.Width;
            Controls.Height = e.NewSize.Height - 29;
            cPrincipal.Width = Controls.Width;
            cPrincipal.Height = Controls.Height;
            gPrincipal.Width = Controls.Width;
            gPrincipal.Height = Controls.Height;

            if (globales._Turing)
            {

               

                Titulo.Text =  "Turing Opciones";
               
                //TMenu.Visibility = Visibility.Collapsed;
                //stackTitle01.Visibility = Visibility.Collapsed;
                //stackTitle01.Height = 0;
                //stackTitle02.Visibility = Visibility.Collapsed;
                //stackTitle02.Height = 0;
                //MesaEstado.Visibility = Visibility.Collapsed;
                //MesaEstado.Height = 0;
                //MesaEstadoTxt.Visibility = Visibility.Collapsed;
                //MesaEstadoTxt.Height = 0;
                //Server.Visibility = Visibility.Collapsed;
                //MesaEstadoTxt.Height = 0;
                //ServerName.Visibility = Visibility.Collapsed;
                //ServerName.Height = 0;
                //TxtUser_.Visibility = Visibility.Collapsed;
                //TxtUser_.Height = 0;
                //Usuario.Visibility = Visibility.Collapsed;
                //Usuario.Height = 0;
                hypCambioClave.Visibility = Visibility.Collapsed;
                hypCambioClave.Height = 0;
                prueba.Visibility = Visibility.Collapsed;
                prueba.Height = 0;
                //Boton_Expander.Visibility = Visibility.Collapsed;
                Boton_Expander.Height = 30;
                //FechaEstado.Visibility = Visibility.Collapsed;
                //FechaEstado.Height = 0;
                //FechaProceso.Visibility = Visibility.Collapsed;
                //FechaProceso.Height = 0;
                //gPrincipal.Margin = new Thickness(gPrincipal.Margin.Left,-71,gPrincipal.Margin.Right, gPrincipal.Margin.Bottom) ;
                
                //CanvasMenu.Visibility = Visibility.Collapsed;
            }
        }

        private void event_hypCambioClave_Click(object sender, RoutedEventArgs e)
        {
            AdminOpciones.Controls.NewWindonwsControls.CambioClave("opc_CambioClave");
        }
    }
}
