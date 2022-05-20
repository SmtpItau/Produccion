using System;
using System.Collections.Generic;
using System.Linq;
using System.Windows;
using System.Windows.Controls;
using System.Xml.Linq;
using AdminOpciones.Recursos;
using AdminOpciones.Struct;
using System.Windows.Browser;
using System.ServiceModel;
using System.Globalization;

namespace AdminOpciones
{
    public partial class Page : UserControl
    {
        AdminOpciones.SrvLogin.WebLoginSoapClient       _svcLogin;
        AdminOpciones.SrvDetalles.WebDetallesSoapClient _svcFechaProceso;
        AdminOpciones.SrvDetalles.WebDetallesSoapClient _svcValoresArt84;
        AdminOpciones.SrvConfig.SrvConfigSoapClient     _svcConfig;
        
        Recursos.Encript _Prueba = new Encript();
        private List<StructClave> ClaveLis;
        private List<string> Claves = new List<string>();
        XDocument xmlClave = new XDocument();
        XDocument xmlResult = new XDocument();
        string XmlResultClave;
        string XmlResultMenu;
        public int EstadoMesa_ = 0;
        public string _Opcion = "";
        string fech_aux = string.Empty;
        private string __Usuario = string.Empty;
        private string __Clave = string.Empty;
        private int __Intentos = 3;
        public bool Expirado = false;
        public bool A3deExpirar = false;
        DateTime FechaProcProx3;

        public Page(string baseuri, string basedir)
        {
            //Configuración automática de ruta para servicios
            wsGlobales.BaseUri = baseuri;
            wsGlobales.BaseDir = basedir;
            //System.Windows.Browser.HtmlPage.Window.Alert("Uri: " + wsGlobales.BaseUri + "; Dir: " + wsGlobales.BaseDir + "\nFull: " + wsGlobales.FullUri);

            _svcLogin = wsGlobales.WebLogin;
            _svcFechaProceso = wsGlobales.Detalles;
            _svcValoresArt84 = wsGlobales.Detalles;
            _svcConfig = wsGlobales.ConfigReader;

            InitializeComponent();
            //Crea instancia de validacion                        
            _svcLogin.PermisosMenuCompleted += new EventHandler<AdminOpciones.SrvLogin.PermisosMenuCompletedEventArgs>(_svcLogin_PermisosMenuCompleted);
            _svcLogin.ValidaPasswordCompleted += new EventHandler<AdminOpciones.SrvLogin.ValidaPasswordCompletedEventArgs>(_svcLogin_ValidaPasswordCompleted);
            _svcLogin.WebBloqueaUsuarioCompleted += new EventHandler<AdminOpciones.SrvLogin.WebBloqueaUsuarioCompletedEventArgs>(_svcLogin_WebBloqueaUsuarioCompleted);
            _svcLogin.FecProcHabilProxCompleted += new EventHandler<AdminOpciones.SrvLogin.FecProcHabilProxCompletedEventArgs>(_svclogin_FecProcHabilProxCompleted);
            //evento (delegado) boton cancelar de cambio de clave. Debe quitar todo el layer
            this.ControlCambioClaveExpirada.event_Cancelar += new AdminOpciones.Controls.Cancelar(ControlCambioClaveExpirada_event_Cancelar);
            this.ControlCambioClaveExpirada.event_Aceptar += new AdminOpciones.Controls.Aceptar(ControlCambioClaveExpirada_event_Aceptar);

            //Crea evento Click del boton Aceptar del Login
            this.LoginControl.btnLogin.Click += new RoutedEventHandler(btnLogin_Click);
            this.LoginControl.HazmeClickEvent += new AdminOpciones.Login.LoginControl.HazmeClickHandler(btnLogin_Click);

            //Crea evento Click del boton cerrar de la aplicación
            this.Menu.event_CierraSession += new AdminOpciones.Delegados.CierraSesion(Menu_event_CierraSession);
            this.Menu.event_RefreshStatusSystem += new AdminOpciones.Delegados.RefreshStatusSystem(Menu_event_RefreshStatusSystem);
            this.Menu.event_RefreshMesa += new AdminOpciones.Delegados.RefreshControlMesa(Menu_event_RefreshMesa);

            //Declarada en Clase.
            //SrvConfig.SrvConfigSoapClient _svcConfig = wsGlobales.ConfigReader;
            //Seteo de configuración. Genera efecto colateral de carga de ConfigurationManager.
            _svcConfig.SetApplicationSettingCompleted += new EventHandler<AdminOpciones.SrvConfig.SetApplicationSettingCompletedEventArgs>(_svcConfig_SetApplicationSettingCompleted);
            _svcConfig.SetApplicationSettingAsync("FULLURI", wsGlobales.FullUri);


            //ASVG_20150811 Carga URL servicio Art84 desde BBDD.
            _svcValoresArt84.GetUrl_WS_ART84Completed += new EventHandler<SrvDetalles.GetUrl_WS_ART84CompletedEventArgs>(_svcValoresArt84_GetUrl_WS_ART84Completed);
            _svcValoresArt84.GetUrl_WS_ART84Async();
            //_svcConfig.GetApplicationSettingAsync("Articulo84", wsGlobales.UriArticulo84);

            _svcValoresArt84.GetUrl_WS_TomaLineaCompleted += new EventHandler<SrvDetalles.GetUrl_WS_TomaLineaCompletedEventArgs>(_svcValoresArt84_GetUrl_WS_TomaLineaCompleted);
            _svcValoresArt84.GetUrl_WS_TomaLineaAsync();



            //ASVG_20110520 para que muestre el servidor de BBDD, se podría agregar al SetApplicationSettingCompleted
            _svcConfig.GetApplicationSettingCompleted += new EventHandler<SrvConfig.GetApplicationSettingCompletedEventArgs>(client_GetApplicationSettingCompleted);
            //se fué al completed del SetApplicationSetting:
            //_svcConfig.GetApplicationSettingAsync("OPCIONES");

            _svcConfig.CheckApplicationSettingsCompleted += new EventHandler<SrvConfig.CheckApplicationSettingsCompletedEventArgs>(_svcConfig_CheckApplicationSettingsCompleted);
            //ASVG_20130704 no sirve para nada.
            //_svcConfig.GetRegionCompleted += new EventHandler<SrvConfig.GetRegionCompletedEventArgs>(client_GetRegionCompleted);
            //_svcConfig.GetRegionAsync("Region");

            ShowLogin(false);

            //ver: private void DisplayHead() // Continuación _svcFechaProceso_InicioDiaCompleted
            _svcFechaProceso.InicioDiaCompleted += new EventHandler<AdminOpciones.SrvDetalles.InicioDiaCompletedEventArgs>(_svcFechaProceso_InicioDiaCompleted);

            _svcFechaProceso.RetornaCierreMesaCompleted += new EventHandler<AdminOpciones.SrvDetalles.RetornaCierreMesaCompletedEventArgs>(_svcFechaProceso_RetornaCierreMesaCompleted);
            //_svcFechaProceso.InicioDiaAsync("01/01/2009", "01/01/2009", "01/01/2009", 0);

            //termina inicialización, a la espera de los completed.

            if (globales._Turing)
            {
                this.LoginControl.Visibility = Visibility.Collapsed;
            }
        }

        void _svcValoresArt84_GetUrl_WS_ART84Completed(object sender, SrvDetalles.GetUrl_WS_ART84CompletedEventArgs e)
        {
            wsGlobales.UriArticulo84 = "";

            try
            {
                if (e != null && e.Result != null)
                {
                    //URL no puede tener espacios, adicionalmente viene con Trim().
                    if (!e.Result.Contains(" "))
                    {
                        wsGlobales.UriArticulo84 = "http://" + e.Result;
                    }
                    else
                    {
                        System.Windows.Browser.HtmlPage.Window.Alert("Ruta servicio Art.84 contiene espacios: " + e.Result);
                    }
                }
            }
            catch
            {
                System.Windows.Browser.HtmlPage.Window.Alert("No hay ruta servicio Art.84");
            }
        }

        void _svcConfig_SetApplicationSettingCompleted(object sender, SrvConfig.SetApplicationSettingCompletedEventArgs e)
        {
            try
            {
                if (e != null && e.Result != null)
                {
                    _svcConfig.GetApplicationSettingAsync("LIBRARY");
                    _svcConfig.GetApplicationSettingAsync("OPCIONES");
                    _svcFechaProceso.InicioDiaAsync("01/01/2009", "01/01/2009", "01/01/2009", 0);
                }
            }
            catch
            {
                System.Windows.Browser.HtmlPage.Window.Alert("No hay servicio web.");
            }
        }

        void ControlCambioClaveExpirada_event_Aceptar(bool estado, string msg)
        {
            //System.Windows.Browser.HtmlPage.Window.Alert(msg);

            if (estado)
            {
                this.CanvasCambioClavePage.Visibility = Visibility.Collapsed;

                this.LoginControl.Visibility = Visibility.Collapsed;
                this.Menu.Visibility = Visibility.Visible;
                globales._Usuario = __Usuario;
                if (globales._InicioDia != 0)
                {
                    this.Menu.FechaEstado.Text = "Fecha Proceso:";
                    this.Menu.FechaProceso.Text = globales._FechaProceso;
                }
                this.Menu.Usuario.Text = __Usuario;

                //Activa evento de habilitación de opciones
                this.Menu.Menu_event_ActivaMenu(XmlResultMenu);
                DisplayHead();
                AdminOpciones.Controls.LogAuditoria.SaveLogAuditoria("", __Usuario, "05", "Inicio de sesión");
            }
            else 
            {
                this.ControlCambioClaveExpirada.txbxContraseña.Password = "";
                this.ControlCambioClaveExpirada.txbxNuevaContraseña.Password = "";
                this.ControlCambioClaveExpirada.txbxRepContraseña.Password = "";                
            }
            //throw new NotImplementedException();
        }

        void ControlCambioClaveExpirada_event_Cancelar()
        {
            this.CanvasCambioClavePage.Visibility = Visibility.Collapsed;
        }

        /// <summary>
        /// Habilita o bloquea los campos de ingreso para control de Login.
        /// </summary>
        /// <param name="value"></param>
        private void ShowLogin(bool value)
        {
            LoginControl.btnLogin.IsEnabled = value;
            LoginControl.txtUserName.IsEnabled = value;
            LoginControl.txtPassword.IsEnabled = value;
        }

        private void TuringLogin()
        {
            if (!globales._Turing) return;

            LoginControl.txtUserName.Text = globales._Usuario_turing;
            LoginControl.txtPassword.Password = globales._Password_turing;
            LoginControl.Login();

            Menu.Seleccion("AdmOpc00201");

            Menu.TMenu.Visibility = Visibility.Collapsed;
            //Menu.stackTitle01.Visibility = Visibility.Collapsed;
            //Menu.stackTitle01.Height = 0;
            //Menu.stackTitle02.Visibility = Visibility.Collapsed;
            //Menu.stackTitle02.Height = 0;
            //Menu.MesaEstado.Visibility = Visibility.Collapsed;
            //Menu.MesaEstadoTxt.Visibility = Visibility.Collapsed;
            //Menu.Server.Visibility = Visibility.Collapsed;
            //Menu.ServerName.Visibility = Visibility.Collapsed;
            //Menu.TxtUser_.Visibility = Visibility.Collapsed;
            //Menu.Usuario.Visibility = Visibility.Collapsed;
            Menu.hypCambioClave.Visibility = Visibility.Collapsed;
            Menu.prueba.Visibility = Visibility.Collapsed;
            //Menu.Boton_Expander.Visibility = Visibility.Collapsed;
            //Menu.FechaEstado.Visibility = Visibility.Collapsed;
            //Menu.FechaProceso.Visibility = Visibility.Collapsed;        
            //Menu.CanvasMenu.Visibility = Visibility.Collapsed;

            
        }

        void client_GetApplicationSettingCompleted(object sender, SrvConfig.GetApplicationSettingCompletedEventArgs e)
        {
            if (e.Result != null)
            {
                //El Path de los Files no debería tener comas
                //Este if proteje la asignación de _Terminal más abajo.
                if (e.Result.IndexOf(",").Equals(-1))
                {
                    //define la uri base del Artículo 84
                    //if (e.Result.Contains("uri84")) 
                    //{
                        //string strURL = string.Empty;
                        //wsGlobales.UriArticulo84 = e.Result.Substring(e.Result.IndexOf('=')+1);
                        //_svcValoresArt84.GetUrl_WS_ART84Async();
                    //}
                    //this.Menu.Path.Text = e.Result;
                }
                else
                {
                    //this.Menu.ServerName.Text = e.Result;
                    //AdminOpcionesTool,cData,0,1,TESTAPPS009,CbMdbOpc,dbo_cbmdbopc,fvqRO5niRFuYTvpM8cf8lw==,120,600
                    //ASVG_20110520 para que muestre el nombre del servidor de BBDD
                    globales._Terminal = this.Menu.ServerName.Text = e.Result.Split(',')[4];
                    //globales._Terminal = this.Menu.ServerName.Text;// e.Result;
                }

                //Acá se podrían cargar todas las otras globales desde el Web.config
            }
        }

        //void client_GetRegionCompleted(object sender, SrvConfig.GetRegionCompletedEventArgs e)
        //{
        //    //System.Windows.Browser.HtmlPage.Window.Alert("client_GetRegionCompleted");
        //    if (e.Result != null)
        //    {
        //        globales._Region = e.Result;
        //    }
        //}

        public class _Resultados
        {
            public string FechaProc { get; set; }
            public string InicioDia { get; set; }
            public string FinDia { get; set; }
        }

        public class _Resultado_Mesa
        {
            public string ResultMesa { get; set; }
        }

        void _svcFechaProceso_InicioDiaCompleted(object sender, AdminOpciones.SrvDetalles.InicioDiaCompletedEventArgs e)
        {
            try
            {
                string _xmlResult = e.Result.ToString();
                XDocument xmlResult = new XDocument();
                xmlResult = XDocument.Parse(_xmlResult);
                List<_Resultados> _data = new List<_Resultados>();

                IEnumerable<XElement> elements = xmlResult.Element("InicioDia").Elements("Data");
                foreach (XElement element in elements)
                {
                    _Resultados _sData = new _Resultados();

                    string a = element.Attribute("FechaProc").Value;

                    //DateTimeFormatInfo dtfi = new DateTimeFormatInfo();
                    //dtfi.ShortDatePattern = "dd-MM-yyyy";

                    //dtfi.LongDatePattern  = "dd/MM/yyyy hh:mm:ss    '25/03/2011 12:00:00 a.m.
                    //DateTime dt = Convert.ToDateTime(a, dtfi.LongDatePattern);
                    
                    DateTime b = Convert.ToDateTime(a);
                    string c = b.ToString("dd-MM-yyyy");
                    _sData.FechaProc = c;
                    //_sData.FechaProc = Convert.ToDateTime(element.Attribute("FechaProc").Value).ToString("dd-MM-yyyy");

                    _sData.InicioDia = element.Attribute("InicioDia").Value.ToString();
                    _sData.FinDia = element.Attribute("FinDia").Value.ToString();
                    globales._CierreMesa = int.Parse(element.Attribute("CierreMesa").Value.ToString());

                    _data.Add(_sData);
                }

                globales._FechaProceso = _data[0].FechaProc.ToString();
                globales.FechaProceso = DateTime.Parse(globales._FechaProceso);
                globales._InicioDia = int.Parse(_data[0].InicioDia.ToString());
                ShowLogin(true); //este habilita el cuadro de login.
                
                //IAF problema de fin de dia, solicitado por MP. 17-11-2009 18:50pm
                if (_data[0].FinDia != "1" && _Opcion != "" && fech_aux != this.Menu.FechaProceso.Text)
                {
                    string Mensaje_ = "La Fecha de proceso a cambiado";
                    System.Windows.Browser.HtmlPage.Window.Alert(Mensaje_);
                    HtmlPage.Window.Invoke("CallThis", null);
                }

                if (_Opcion != "")
                {
                    this.Menu.Seleccion(_Opcion);
                    _Opcion = "";
                }
                RefreshMessageTableControl(globales._CierreMesa);
                fech_aux = globales._FechaProceso;
                _svcLogin.FecProcHabilProxAsync(globales.FechaProceso);

                TuringLogin();
            }
            catch (Exception ee)
            {
                AdminOpciones.Controls.LogAuditoria.SaveLogAuditoria("", "05", "Servicio: InicioDia");
                System.Windows.Browser.HtmlPage.Window.Alert("No se puede validar día.");
            }
        }

        private void _svcLogin_WebBloqueaUsuarioCompleted(object sender, AdminOpciones.SrvLogin.WebBloqueaUsuarioCompletedEventArgs e)
        {
            if (e.Error == null)
            {
                string Status = e.Result;
                AdminOpciones.Controls.LogAuditoria.SaveLogAuditoria("", "05", "Usuario Bloqueado");
            }
            ShowLogin(true);
        }

        // CER 

        private void _svclogin_FecProcHabilProxCompleted(object sender, AdminOpciones.SrvLogin.FecProcHabilProxCompletedEventArgs e)
        {
            if (e.Error == null)
            {
                XDocument XmlResultFecha = new XDocument(XDocument.Parse(e.Result));
                XElement dataXE = XmlResultFecha.Element("FecProcHabilProx").Element("Data");

                if (dataXE != null)
                {
                    FechaProcProx3 = Convert.ToDateTime(dataXE.Attribute("ProxProcHabil").Value);
                }
            }

            _svcConfig.CheckApplicationSettingsAsync();
        }

        void _svcConfig_CheckApplicationSettingsCompleted(object sender, SrvConfig.CheckApplicationSettingsCompletedEventArgs e)
        {
            if (e != null && e.Error == null)
            {
                if (e.Result != null && !e.Result.Equals("OK"))
                {
                    ShowLogin(false);
                    System.Windows.Browser.HtmlPage.Window.Alert(e.Result);
                }
            }
        }

        private void DisplayHead() // Continuación _svcFechaProceso_InicioDiaCompleted
        {
            string txtUser, txtPass;
            //String Mensaje;            
            txtUser = this.LoginControl.txtUserName.Text;
            txtPass = this.LoginControl.txtPassword.Password;

            this.LoginControl.Visibility = Visibility.Collapsed;
            this.Menu.Visibility = Visibility.Visible;
            globales._Usuario = txtUser;

            if (globales._InicioDia != 0)
            {
                this.Menu.FechaEstado.Text = "Fecha Proceso:";
                this.Menu.FechaProceso.Text = globales._FechaProceso;
            }
            this.Menu.Usuario.Text = txtUser;
            if (txtUser == "ADMINISTRA")
            {
                this.Menu.MenuAdministra();
            }

            _svcFechaProceso.RetornaCierreMesaAsync(Convert.ToDateTime(Convert.ToString(globales._FechaProceso)).ToString());

        }

        void _svcLogin_ValidaPasswordCompleted(object sender, AdminOpciones.SrvLogin.ValidaPasswordCompletedEventArgs e)
        {
            String Mensaje;
            A3deExpirar = false;
            Expirado = false;

            if (__Usuario.Equals(string.Empty) || !__Usuario.Equals(this.LoginControl.txtUserName.Text))
            {
                __Intentos = 3;
            }

            __Usuario = this.LoginControl.txtUserName.Text;
            __Clave = this.LoginControl.txtPassword.Password;

            XmlResultClave = e.Result;

            if (XmlResultClave.Length > 0)
            {
                ClaveOPT(XmlResultClave);

                if (ClaveLis.Count > 0)
                {
                    StructClave _Clave = ClaveLis[0];

                    if (_Clave.Bloqueado)
                    {
                        Mensaje = "El Usuario se encuentra bloqueado.";
                        System.Windows.Browser.HtmlPage.Window.Alert(Mensaje);
                        AdminOpciones.Controls.LogAuditoria.SaveLogAuditoria("", __Usuario, "05", Mensaje);
                        ShowLogin(true);
                    }
                    else if (globales.FechaProceso > _Clave.FechaExpiracion)
                    {
                        Mensaje = "La password ha expirado\n";
                        System.Windows.Browser.HtmlPage.Window.Alert(Mensaje);
                        AdminOpciones.Controls.LogAuditoria.SaveLogAuditoria("", __Usuario, "05", Mensaje);
                        ShowLogin(true);
                        Expirado = true;

                        this.ControlCambioClaveExpirada.isPantallaLayer = true;                        
                        this.ControlCambioClaveExpirada.txbxUsuario.Text = __Usuario;
                        this.CanvasCambioClavePage.Visibility = Visibility;
                        this.ControlCambioClaveExpirada.StackHeader.Visibility = Visibility.Visible;
                    }
                    else
                    {
                        bool cambiarClave = true;

                        //if (globales.FechaProceso.AddDays(3) >= _Clave.FechaExpiracion)
                        if (FechaProcProx3 >= _Clave.FechaExpiracion)
                        {
                            A3deExpirar = true;
                            int dif = _Clave.FechaExpiracion.Subtract(globales.FechaProceso).Days;
                            //Mensaje = "La password va a expirar en "+dif+" días \n ¿Desea cambiarla ahora?";
                            Mensaje = "Su clave va expirar el día " + _Clave.FechaExpiracion + " .  ¿ Desea Cambiar la Password ?";
                            //System.Windows.Browser.HtmlPage.Window.Alert(Mensaje);
                            cambiarClave = System.Windows.Browser.HtmlPage.Window.Confirm(Mensaje);
                            AdminOpciones.Controls.LogAuditoria.SaveLogAuditoria("", __Usuario, "05", Mensaje);                           
                        }

                        if (A3deExpirar && cambiarClave)
                        {
                            //AdminOpciones.Controls.LogAuditoria.SaveLogAuditoria("", __Usuario, "05", Mensaje);
                            ShowLogin(true);
                            //Expirado = true;

                            this.ControlCambioClaveExpirada.isPantallaLayer = true;
                            this.ControlCambioClaveExpirada.txbxUsuario.Text = __Usuario;
                            this.CanvasCambioClavePage.Visibility = Visibility;
                            this.ControlCambioClaveExpirada.StackHeader.Visibility = Visibility.Visible;
                        }
                        else
                        {
                            string sClave = _Clave.Clave.Trim();
                            string Aux = _Prueba.sEncript(sClave, false);

                            if (__Clave == Aux)
                            {
                                #region Mensaje de Ingreso Correcto

                                //Mensaje = "Ingreso correcto";
                                //System.Windows.Browser.HtmlPage.Window.Alert(Mensaje);
                                #endregion

                                this.LoginControl.Visibility = Visibility.Collapsed;
                                this.Menu.Visibility = Visibility.Visible;
                                globales._Usuario = __Usuario;
                                if (globales._InicioDia != 0)
                                {
                                    this.Menu.FechaEstado.Text = "Fecha Proceso:";
                                    this.Menu.FechaProceso.Text = globales._FechaProceso;
                                }
                                this.Menu.Usuario.Text = __Usuario;

                                //Activa evento de habilitación de opciones
                                this.Menu.Menu_event_ActivaMenu(XmlResultMenu);
                                DisplayHead();
                                AdminOpciones.Controls.LogAuditoria.SaveLogAuditoria("", __Usuario, "05", "Inicio de sesión");
                            }
                            else
                            {
                                Mensaje = "El Usuario o la Contraseña no son correctos favor acercarse algun Administrador para solucionar este inconveniente";
                                System.Windows.Browser.HtmlPage.Window.Alert(Mensaje);
                                AdminOpciones.Controls.LogAuditoria.SaveLogAuditoria("", __Usuario, "05", Mensaje);
                                __Intentos--;
                                if (__Intentos.Equals(0))
                                {
                                    _svcLogin.WebBloqueaUsuarioAsync(__Usuario);
                                }
                                else
                                {
                                    ShowLogin(true);
                                }
                            }
                        }
                    }
                }
                else
                {
                    Mensaje = "El Usuario o la Contraseña no son correctos favor acercarse algun Administrador para solucionar este inconveniente";
                    System.Windows.Browser.HtmlPage.Window.Alert(Mensaje);
                    AdminOpciones.Controls.LogAuditoria.SaveLogAuditoria("", __Usuario, "05", Mensaje);
                    ShowLogin(true);
                }
            }
            else
            {
                Mensaje = "El Usuario o la Contraseña no son correctos favor acercarse algun Administrador para solucionar este inconveniente";
                System.Windows.Browser.HtmlPage.Window.Alert(Mensaje);
                AdminOpciones.Controls.LogAuditoria.SaveLogAuditoria("", __Usuario, "05", Mensaje);
                ShowLogin(true);
            }
        }

        private void ClaveOPT(string strXMLClave)
        {
            try
            {
                ClaveLis = new List<StructClave>();
                xmlClave = XDocument.Parse(strXMLClave);

                foreach (XElement ClavesOPTXML in xmlClave.Descendants("Data"))
                {
                    ClaveLis.Add(
                                  new StructClave(
                                                   ClavesOPTXML.Attribute("Clave").Value,
                                                   ClavesOPTXML.Attribute("Clave1").Value,
                                                   ClavesOPTXML.Attribute("Clave2").Value,
                                                   ClavesOPTXML.Attribute("Clave3").Value,
                                                   ClavesOPTXML.Attribute("Clave4").Value,
                                                   ClavesOPTXML.Attribute("Clave5").Value,
                                                   ClavesOPTXML.Attribute("TipoUsuario").Value,
                                                   DateTime.Parse(ClavesOPTXML.Attribute("FechaExpiracion").Value),
                                                   ClavesOPTXML.Attribute("CambioClave").Value,
                                                   ClavesOPTXML.Attribute("Bloqueado").Value.Equals("1") ? true : false,
                                                   Convert.ToInt32(ClavesOPTXML.Attribute("ResetPassword").Value),
                                                   Convert.ToInt32(ClavesOPTXML.Attribute("LargoClave").Value),
                                                   ClavesOPTXML.Attribute("TipoClave").Value,
                                                   Convert.ToInt32(ClavesOPTXML.Attribute("DiasExpira").Value)
                                                   )
                                );
                }
            }
            catch
            {                
            }
        }

        void _svcLogin_PermisosMenuCompleted(object sender, AdminOpciones.SrvLogin.PermisosMenuCompletedEventArgs e)
        {
            string txtAux;
            String Mensaje;
            txtAux = this.LoginControl.txtUserName.Text;
            XmlResultMenu = e.Result;
            if (XmlResultMenu.Length > 0)
            {
                _svcLogin.ValidaPasswordAsync(txtAux);                
            }
            else
            {
                Mensaje = "El Usuario o la Contraseña no son correctos ";
                Mensaje += "favor acercarse algun Administrador para solucionar este inconveniente";
                System.Windows.Browser.HtmlPage.Window.Alert(Mensaje);
                AdminOpciones.Controls.LogAuditoria.SaveLogAuditoria("", "05", Mensaje);
                LoginControl.btnLogin.IsEnabled = true;
                LoginControl.txtUserName.IsEnabled = true;
                LoginControl.txtPassword.IsEnabled = true;
            }
        }

        void _svcFechaProceso_RetornaCierreMesaCompleted(object sender, AdminOpciones.SrvDetalles.RetornaCierreMesaCompletedEventArgs e)
        {
            try
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

                RefreshMessageTableControl(EstadoMesa_);
            }
            catch
            {
                AdminOpciones.Controls.LogAuditoria.SaveLogAuditoria("", "05", "Servicio: RetornaCierreMesa");
            }
        }
        
        void Menu_event_CierraSession()
        {            
            PageSwitcher ps = this.Parent as PageSwitcher;
            ps.Navigate(new AdminOpciones.Page(wsGlobales.BaseUri,wsGlobales.BaseDir));
            
            this.LoginControl.Visibility = Visibility.Visible;
            this.Menu.Visibility = Visibility.Collapsed;                            
        }

        private void Menu_event_RefreshStatusSystem(string opcion)
        {
            _Opcion = opcion;
            Admin();
        }

        private void Menu_event_RefreshMesa(int status)
        {
            EstadoMesa_ = status;
            RefreshMessageTableControl(status);
        }

        private void RefreshMessageTableControl(int status)
        {
            globales._CierreMesa = status;

            if (status == 0)
            {
                this.Menu.MesaEstadoTxt.Text = "Abierta";
            }
            else
            {
                this.Menu.MesaEstadoTxt.Text = "Cerrada";
            }
        }

        public void btnLogin_Click(object sender, RoutedEventArgs e)
        {            
            string user = this.LoginControl.txtUserName.Text;

            if (user != null && user != "")
            {
                ShowLogin(false);
                _svcLogin.PermisosMenuAsync(user);
            }
        }

        void Admin() 
        {
            string txtUser, txtPass;
            //String Mensaje;            
            txtUser = this.LoginControl.txtUserName.Text;
            txtPass = this.LoginControl.txtPassword.Password;

            _svcFechaProceso.InicioDiaAsync("01/01/2009", "01/01/2009", "01/01/2009", 0);
        }

        private void UserControl_SizeChanged(object sender, SizeChangedEventArgs e)
        {
            Menu.Width = e.NewSize.Width;
            Menu.Height = e.NewSize.Height - 40;
            stackTitle01.Width = e.NewSize.Width;
            stackTitle02.Width = e.NewSize.Width;
        }

        /**
         * Metodo de llenado URL Toma Linea... 
         * 
         */
        
        void _svcValoresArt84_GetUrl_WS_TomaLineaCompleted(object sender, SrvDetalles.GetUrl_WS_TomaLineaCompletedEventArgs e)
        {
            wsGlobales.UriTomaLinea = "";

            try
            {
                if (e != null && e.Result != null)
                {
                    //URL no puede tener espacios, adicionalmente viene con Trim().
                    if (!e.Result.Contains(" "))
                    {
                        wsGlobales.UriTomaLinea = "http://" + e.Result;
                        
                    }
                    else
                    {
                        System.Windows.Browser.HtmlPage.Window.Alert("Ruta servicio Toma de Linea contiene espacios: " + e.Result);
                    }
                }
            }
            catch
            {
                System.Windows.Browser.HtmlPage.Window.Alert("No hay ruta servicio Toma de Linea.");
            }
        }
        
    }
}
