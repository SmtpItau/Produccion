#pragma checksum "\\certapps048\Homologación\Itaú - RTC\CCC\171507048PR\171114104\Software\Fuentes\Visual.Net\Opciones\AdminOpciones2\AdminOpciones\Controls\Process.xaml" "{406ea660-64cf-4c82-b6f0-42d48172a799}" "983C3393C9E32A510F948D1015777590"
//------------------------------------------------------------------------------
// <auto-generated>
//     This code was generated by a tool.
//     Runtime Version:4.0.30319.42000
//
//     Changes to this file may cause incorrect behavior and will be lost if
//     the code is regenerated.
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


namespace AdminOpciones.Controls {
    
    
    public partial class Process : System.Windows.Controls.UserControl {
        
        internal System.Windows.Controls.Grid LayoutRoot;
        
        internal System.Windows.Controls.TextBlock textStatus;
        
        internal System.Windows.Controls.Button buttonSalir;
        
        internal System.Windows.Controls.Canvas Mask;
        
        internal System.Windows.Controls.Grid IconLayout;
        
        internal System.Windows.Media.ScaleTransform SpinnerScale;
        
        internal System.Windows.Media.RotateTransform SpinnerRotate;
        
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
            System.Windows.Application.LoadComponent(this, new System.Uri("/AdminOpciones;component/Controls/Process.xaml", System.UriKind.Relative));
            this.LayoutRoot = ((System.Windows.Controls.Grid)(this.FindName("LayoutRoot")));
            this.textStatus = ((System.Windows.Controls.TextBlock)(this.FindName("textStatus")));
            this.buttonSalir = ((System.Windows.Controls.Button)(this.FindName("buttonSalir")));
            this.Mask = ((System.Windows.Controls.Canvas)(this.FindName("Mask")));
            this.IconLayout = ((System.Windows.Controls.Grid)(this.FindName("IconLayout")));
            this.SpinnerScale = ((System.Windows.Media.ScaleTransform)(this.FindName("SpinnerScale")));
            this.SpinnerRotate = ((System.Windows.Media.RotateTransform)(this.FindName("SpinnerRotate")));
        }
    }
}

