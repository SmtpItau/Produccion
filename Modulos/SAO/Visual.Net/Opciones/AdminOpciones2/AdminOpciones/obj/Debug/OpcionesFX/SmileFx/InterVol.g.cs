﻿#pragma checksum "\\certapps048\Homologación\Itaú - RTC\CCC\171507048PR\171114104\Software\Fuentes\Visual.Net\Opciones\AdminOpciones2\AdminOpciones\OpcionesFX\SmileFx\InterVol.xaml" "{406ea660-64cf-4c82-b6f0-42d48172a799}" "845AEDD3E81FCD14B67D911B761A5743"
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


namespace AdminOpciones.OpcionesFX.SmileFx {
    
    
    public partial class InterVol : System.Windows.Controls.UserControl {
        
        internal System.Windows.Controls.Grid LayoutRoot;
        
        internal System.Windows.Controls.TextBox txtStrike;
        
        internal System.Windows.Controls.TextBox txtPlazo;
        
        internal System.Windows.Controls.TextBox txtVol;
        
        internal System.Windows.Controls.TextBox txtFlag;
        
        internal System.Windows.Controls.TextBlock txtSpot;
        
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
            System.Windows.Application.LoadComponent(this, new System.Uri("/AdminOpciones;component/OpcionesFX/SmileFx/InterVol.xaml", System.UriKind.Relative));
            this.LayoutRoot = ((System.Windows.Controls.Grid)(this.FindName("LayoutRoot")));
            this.txtStrike = ((System.Windows.Controls.TextBox)(this.FindName("txtStrike")));
            this.txtPlazo = ((System.Windows.Controls.TextBox)(this.FindName("txtPlazo")));
            this.txtVol = ((System.Windows.Controls.TextBox)(this.FindName("txtVol")));
            this.txtFlag = ((System.Windows.Controls.TextBox)(this.FindName("txtFlag")));
            this.txtSpot = ((System.Windows.Controls.TextBlock)(this.FindName("txtSpot")));
        }
    }
}
