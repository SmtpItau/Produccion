﻿#pragma checksum "\\certapps048\Homologación\Itaú - RTC\CCC\171507048PR\171114104\Software\Fuentes\Visual.Net\Opciones\AdminOpciones2\AdminOpciones\Controls\ControlReportes.xaml" "{406ea660-64cf-4c82-b6f0-42d48172a799}" "9CA9AA8DABA6A8B1E53249D765A75CFF"
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
    
    
    public partial class ControlReportes : System.Windows.Controls.UserControl {
        
        internal System.Windows.Controls.Grid LayoutRoot;
        
        internal System.Windows.Controls.DatePicker Dt_FechaDesde;
        
        internal System.Windows.Controls.DatePicker Dt_FechaHasta;
        
        internal System.Windows.Controls.TextBox txt_Cuenta;
        
        internal System.Windows.Controls.ComboBox cmb_TipoTransac;
        
        internal System.Windows.Controls.TextBox txt_NumeroContrato;
        
        internal System.Windows.Controls.TextBox TextBox1;
        
        internal System.Windows.Controls.Button Btn_Buscar;
        
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
            System.Windows.Application.LoadComponent(this, new System.Uri("/AdminOpciones;component/Controls/ControlReportes.xaml", System.UriKind.Relative));
            this.LayoutRoot = ((System.Windows.Controls.Grid)(this.FindName("LayoutRoot")));
            this.Dt_FechaDesde = ((System.Windows.Controls.DatePicker)(this.FindName("Dt_FechaDesde")));
            this.Dt_FechaHasta = ((System.Windows.Controls.DatePicker)(this.FindName("Dt_FechaHasta")));
            this.txt_Cuenta = ((System.Windows.Controls.TextBox)(this.FindName("txt_Cuenta")));
            this.cmb_TipoTransac = ((System.Windows.Controls.ComboBox)(this.FindName("cmb_TipoTransac")));
            this.txt_NumeroContrato = ((System.Windows.Controls.TextBox)(this.FindName("txt_NumeroContrato")));
            this.TextBox1 = ((System.Windows.Controls.TextBox)(this.FindName("TextBox1")));
            this.Btn_Buscar = ((System.Windows.Controls.Button)(this.FindName("Btn_Buscar")));
        }
    }
}

