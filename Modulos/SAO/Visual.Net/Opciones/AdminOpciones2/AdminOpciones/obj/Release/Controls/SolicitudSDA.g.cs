#pragma checksum "V:\1 - Banco\20975\3.- Certificacion\Fuentes\Visual.Net\Opciones\AdminOpciones2\AdminOpciones\Controls\SolicitudSDA.xaml" "{406ea660-64cf-4c82-b6f0-42d48172a799}" "A014FAC9B949A6FBB8CC2EB60A842891"
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


namespace AdminOpciones.Ejercer {
    
    
    public partial class SolicitudSDA : System.Windows.Controls.UserControl {
        
        internal System.Windows.Controls.Grid LayoutRoot;
        
        internal System.Windows.Controls.Canvas ContCanvas;
        
        internal System.Windows.Controls.TextBox TxtNumContrato;
        
        internal System.Windows.Controls.DatePicker DtFechaIngreso;
        
        internal System.Windows.Controls.DatePicker DtFechaActivacion;
        
        internal System.Windows.Controls.TextBox TxtMontoAnticipo;
        
        internal System.Windows.Controls.ComboBox CmbTipoAnticipo;
        
        internal System.Windows.Controls.ComboBox CmbFormpago;
        
        internal System.Windows.Controls.TextBox TxtNumFolio;
        
        internal System.Windows.Controls.DatePicker DtFechaVencimiento;
        
        internal System.Windows.Controls.TextBox TxtSumaSolicitud;
        
        internal System.Windows.Controls.Button btnAceptarGuardar;
        
        internal System.Windows.Controls.Button btnCancelarGuardar;
        
        internal System.Windows.Controls.TextBlock TblockNumFolio;
        
        internal System.Windows.Controls.Button BtnModificar;
        
        internal System.Windows.Controls.TextBox TxtNominal;
        
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
            System.Windows.Application.LoadComponent(this, new System.Uri("/AdminOpciones;component/Controls/SolicitudSDA.xaml", System.UriKind.Relative));
            this.LayoutRoot = ((System.Windows.Controls.Grid)(this.FindName("LayoutRoot")));
            this.ContCanvas = ((System.Windows.Controls.Canvas)(this.FindName("ContCanvas")));
            this.TxtNumContrato = ((System.Windows.Controls.TextBox)(this.FindName("TxtNumContrato")));
            this.DtFechaIngreso = ((System.Windows.Controls.DatePicker)(this.FindName("DtFechaIngreso")));
            this.DtFechaActivacion = ((System.Windows.Controls.DatePicker)(this.FindName("DtFechaActivacion")));
            this.TxtMontoAnticipo = ((System.Windows.Controls.TextBox)(this.FindName("TxtMontoAnticipo")));
            this.CmbTipoAnticipo = ((System.Windows.Controls.ComboBox)(this.FindName("CmbTipoAnticipo")));
            this.CmbFormpago = ((System.Windows.Controls.ComboBox)(this.FindName("CmbFormpago")));
            this.TxtNumFolio = ((System.Windows.Controls.TextBox)(this.FindName("TxtNumFolio")));
            this.DtFechaVencimiento = ((System.Windows.Controls.DatePicker)(this.FindName("DtFechaVencimiento")));
            this.TxtSumaSolicitud = ((System.Windows.Controls.TextBox)(this.FindName("TxtSumaSolicitud")));
            this.btnAceptarGuardar = ((System.Windows.Controls.Button)(this.FindName("btnAceptarGuardar")));
            this.btnCancelarGuardar = ((System.Windows.Controls.Button)(this.FindName("btnCancelarGuardar")));
            this.TblockNumFolio = ((System.Windows.Controls.TextBlock)(this.FindName("TblockNumFolio")));
            this.BtnModificar = ((System.Windows.Controls.Button)(this.FindName("BtnModificar")));
            this.TxtNominal = ((System.Windows.Controls.TextBox)(this.FindName("TxtNominal")));
        }
    }
}

