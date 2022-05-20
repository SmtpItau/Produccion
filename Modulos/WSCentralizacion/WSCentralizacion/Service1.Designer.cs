
namespace WSCentralizacion
{
    partial class Service1
    {
        /// <summary> 
        /// Variable del diseñador necesaria.
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary>
        /// Limpiar los recursos que se estén usando.
        /// </summary>
        /// <param name="disposing">true si los recursos administrados se deben desechar; false en caso contrario.</param>
        protected override void Dispose(bool disposing)
        {
            if (disposing && (components != null))
            {
                components.Dispose();
            }
            base.Dispose(disposing);
        }

        #region Código generado por el Diseñador de componentes

        /// <summary> 
        /// Método necesario para admitir el Diseñador. No se puede modificar
        /// el contenido de este método con el editor de código.
        /// </summary>
        private void InitializeComponent()
        {
            components = new System.ComponentModel.Container();
            this.ServiceName = "Service1";

            //this.stLamso = new System.Timers.Timer();
            //((System.ComponentModel.ISupportInitialize)(this.stLamso)).BeginInit();
            //// 
            //// stLamso
            //// 
            //this.stLamso.Enabled = true;
            //this.stLamso.Interval = 1000D;
            //this.stLamso.Elapsed += new System.Timers.ElapsedEventHandler(this.stLamso_Elapsed);
            //// 
            //// Service1
            //// 
            //this.ServiceName = "Service1";
            //((System.ComponentModel.ISupportInitialize)(this.stLamso)).EndInit();

        }

        #endregion

        private System.Timers.Timer stLamso;
    }
}
