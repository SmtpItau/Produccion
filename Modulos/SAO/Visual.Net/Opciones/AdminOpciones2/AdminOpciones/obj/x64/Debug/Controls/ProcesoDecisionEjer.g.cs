﻿#pragma checksum "D:\Bancos\ITAU\Raul\2019-05-31 Fuentes SAO\2019-05-31 Fuentes SAO\Visual.Net\Opciones\AdminOpciones2\AdminOpciones\Controls\ProcesoDecisionEjer.xaml" "{406ea660-64cf-4c82-b6f0-42d48172a799}" "B9F800D3F1B7B4A9809173D6FFD435FF"
//------------------------------------------------------------------------------
// <auto-generated>
//     This code was generated by a tool.
//     Runtime Version:4.0.30319.42000
//
//     Changes to this file may cause incorrect behavior and will be lost if
//     the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

using Liquid;
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
    
    
    public partial class ProcesoDecisionEjer : System.Windows.Controls.UserControl {
        
        internal System.Windows.Controls.Grid LayoutRoot;
        
        internal System.Windows.Controls.TextBox txtCliRut;
        
        internal System.Windows.Controls.DatePicker Dt_FechaDesde;
        
        internal System.Windows.Controls.DatePicker Dt_FechaHasta;
        
        internal System.Windows.Controls.TextBox txtCliCod;
        
        internal System.Windows.Controls.DataGrid dgPersona;
        
        internal System.Windows.Controls.TextBox TextBox1;
        
        internal System.Windows.Controls.TextBlock Block1;
        
        internal System.Windows.Controls.Button btn_cargar;
        
        internal System.Windows.Controls.Button btn_NoEjercer;
        
        internal System.Windows.Controls.Button btn_Ejercer;
        
        internal System.Windows.Controls.Button btn_OpcPend;
        
        internal System.Windows.Controls.Image SelTodo;
        
        internal Liquid.Dialog _pop;
        
        internal System.Windows.Controls.DataGrid _gridresu;
        
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
            System.Windows.Application.LoadComponent(this, new System.Uri("/AdminOpciones;component/Controls/ProcesoDecisionEjer.xaml", System.UriKind.Relative));
            this.LayoutRoot = ((System.Windows.Controls.Grid)(this.FindName("LayoutRoot")));
            this.txtCliRut = ((System.Windows.Controls.TextBox)(this.FindName("txtCliRut")));
            this.Dt_FechaDesde = ((System.Windows.Controls.DatePicker)(this.FindName("Dt_FechaDesde")));
            this.Dt_FechaHasta = ((System.Windows.Controls.DatePicker)(this.FindName("Dt_FechaHasta")));
            this.txtCliCod = ((System.Windows.Controls.TextBox)(this.FindName("txtCliCod")));
            this.dgPersona = ((System.Windows.Controls.DataGrid)(this.FindName("dgPersona")));
            this.TextBox1 = ((System.Windows.Controls.TextBox)(this.FindName("TextBox1")));
            this.Block1 = ((System.Windows.Controls.TextBlock)(this.FindName("Block1")));
            this.btn_cargar = ((System.Windows.Controls.Button)(this.FindName("btn_cargar")));
            this.btn_NoEjercer = ((System.Windows.Controls.Button)(this.FindName("btn_NoEjercer")));
            this.btn_Ejercer = ((System.Windows.Controls.Button)(this.FindName("btn_Ejercer")));
            this.btn_OpcPend = ((System.Windows.Controls.Button)(this.FindName("btn_OpcPend")));
            this.SelTodo = ((System.Windows.Controls.Image)(this.FindName("SelTodo")));
            this._pop = ((Liquid.Dialog)(this.FindName("_pop")));
            this._gridresu = ((System.Windows.Controls.DataGrid)(this.FindName("_gridresu")));
        }
    }
}
