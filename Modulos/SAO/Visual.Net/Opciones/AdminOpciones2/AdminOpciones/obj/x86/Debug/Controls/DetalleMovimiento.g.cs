﻿#pragma checksum "D:\Bancos\ITAU\Raul\2019-05-31 Fuentes SAO\2019-05-31 Fuentes SAO\Visual.Net\Opciones\AdminOpciones2\AdminOpciones\Controls\DetalleMovimiento.xaml" "{406ea660-64cf-4c82-b6f0-42d48172a799}" "00CA3C66E8AD036F2E655403276EEB28"
//------------------------------------------------------------------------------
// <auto-generated>
//     This code was generated by a tool.
//     Runtime Version:4.0.30319.42000
//
//     Changes to this file may cause incorrect behavior and will be lost if
//     the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

using AdminOpciones.Ejercer;
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
    
    
    public partial class DetalleMovimiento : System.Windows.Controls.UserControl {
        
        internal System.Windows.Controls.Grid LayoutRoot;
        
        internal System.Windows.Controls.Image ExpExcel;
        
        internal System.Windows.Controls.Image SelTodo;
        
        internal System.Windows.Controls.Image Imprimir;
        
        internal System.Windows.Controls.TextBox txtCliID;
        
        internal System.Windows.Controls.ComboBox cmbTContra;
        
        internal System.Windows.Controls.Image Filtro;
        
        internal System.Windows.Controls.Button Bnt_Refresh;
        
        internal System.Windows.Controls.Button Bnt_Anular_Anticipo;
        
        internal System.Windows.Controls.DataGrid dgPersona;
        
        internal System.Windows.Controls.TextBox TextBox1;
        
        internal System.Windows.Controls.TextBlock Block1;
        
        internal Liquid.Dialog _pop;
        
        internal System.Windows.Controls.DataGrid _gridresu;
        
        internal Liquid.Dialog popUpIngSolicitudSDA;
        
        internal AdminOpciones.Ejercer.SolicitudSDA _IngSolicitudSDA;
        
        internal System.Windows.Controls.Button Bnt_Anular_SDA;
        
        internal System.Windows.Controls.Button Btn_ModificaSDA;
        
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
            System.Windows.Application.LoadComponent(this, new System.Uri("/AdminOpciones;component/Controls/DetalleMovimiento.xaml", System.UriKind.Relative));
            this.LayoutRoot = ((System.Windows.Controls.Grid)(this.FindName("LayoutRoot")));
            this.ExpExcel = ((System.Windows.Controls.Image)(this.FindName("ExpExcel")));
            this.SelTodo = ((System.Windows.Controls.Image)(this.FindName("SelTodo")));
            this.Imprimir = ((System.Windows.Controls.Image)(this.FindName("Imprimir")));
            this.txtCliID = ((System.Windows.Controls.TextBox)(this.FindName("txtCliID")));
            this.cmbTContra = ((System.Windows.Controls.ComboBox)(this.FindName("cmbTContra")));
            this.Filtro = ((System.Windows.Controls.Image)(this.FindName("Filtro")));
            this.Bnt_Refresh = ((System.Windows.Controls.Button)(this.FindName("Bnt_Refresh")));
            this.Bnt_Anular_Anticipo = ((System.Windows.Controls.Button)(this.FindName("Bnt_Anular_Anticipo")));
            this.dgPersona = ((System.Windows.Controls.DataGrid)(this.FindName("dgPersona")));
            this.TextBox1 = ((System.Windows.Controls.TextBox)(this.FindName("TextBox1")));
            this.Block1 = ((System.Windows.Controls.TextBlock)(this.FindName("Block1")));
            this._pop = ((Liquid.Dialog)(this.FindName("_pop")));
            this._gridresu = ((System.Windows.Controls.DataGrid)(this.FindName("_gridresu")));
            this.popUpIngSolicitudSDA = ((Liquid.Dialog)(this.FindName("popUpIngSolicitudSDA")));
            this._IngSolicitudSDA = ((AdminOpciones.Ejercer.SolicitudSDA)(this.FindName("_IngSolicitudSDA")));
            this.Bnt_Anular_SDA = ((System.Windows.Controls.Button)(this.FindName("Bnt_Anular_SDA")));
            this.Btn_ModificaSDA = ((System.Windows.Controls.Button)(this.FindName("Btn_ModificaSDA")));
        }
    }
}

