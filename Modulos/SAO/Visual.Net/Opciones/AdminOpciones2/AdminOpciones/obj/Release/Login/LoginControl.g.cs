#pragma checksum "V:\1. INSTALACIONES BANCO\20975\3.- Certificacion\Fuentes\Visual.Net\Opciones\AdminOpciones2\AdminOpciones\Login\LoginControl.xaml" "{406ea660-64cf-4c82-b6f0-42d48172a799}" "F91E97491AF26E7DFE5155FCCB869058"
//------------------------------------------------------------------------------
// <auto-generated>
//     Este código fue generado por una herramienta.
//     Versión de runtime:4.0.30319.225
//
//     Los cambios en este archivo podrían causar un comportamiento incorrecto y se perderán si
//     se vuelve a generar el código.
// </auto-generated>
//------------------------------------------------------------------------------

using System;
using System.Windows;
using System.Windows.Automation;
using System.Windows.Automation.Peers;
using System.Windows.Automation.Provider;
using System.Windows.Controls;
using System.Windows.Controls.Primitives;
using System.Windows.Data;
using System.Windows.Documents;
using System.Windows.Ink;
using System.Windows.Input;
using System.Windows.Interop;
using System.Windows.Markup;
using System.Windows.Media;
using System.Windows.Media.Animation;
using System.Windows.Media.Imaging;
using System.Windows.Resources;
using System.Windows.Shapes;
using System.Windows.Threading;


namespace AdminOpciones.Login {
    
    
    public partial class LoginControl : System.Windows.Controls.UserControl {
        
        internal System.Windows.Controls.Canvas LayoutRoot;
        
        internal System.Windows.Controls.Canvas canvasLogin;
        
        internal System.Windows.Controls.TextBox txtUserName;
        
        internal System.Windows.Controls.PasswordBox txtPassword;
        
        internal System.Windows.Controls.Button btnLogin;
        
        private bool _contentLoaded;
        
        /// <summary>
        /// InitializeComponent
        /// </summary>
        [System.Diagnostics.DebuggerNonUserCodeAttribute()]
        public void InitializeComponent() {
            if (_contentLoaded) {
                return;
            }
            _contentLoaded = true;
            System.Windows.Application.LoadComponent(this, new System.Uri("/AdminOpciones;component/Login/LoginControl.xaml", System.UriKind.Relative));
            this.LayoutRoot = ((System.Windows.Controls.Canvas)(this.FindName("LayoutRoot")));
            this.canvasLogin = ((System.Windows.Controls.Canvas)(this.FindName("canvasLogin")));
            this.txtUserName = ((System.Windows.Controls.TextBox)(this.FindName("txtUserName")));
            this.txtPassword = ((System.Windows.Controls.PasswordBox)(this.FindName("txtPassword")));
            this.btnLogin = ((System.Windows.Controls.Button)(this.FindName("btnLogin")));
        }
    }
}

