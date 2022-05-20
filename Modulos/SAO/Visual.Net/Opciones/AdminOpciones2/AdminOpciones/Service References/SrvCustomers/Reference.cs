﻿//------------------------------------------------------------------------------
// <auto-generated>
//     Este código fue generado por una herramienta.
//     Versión de runtime:4.0.30319.225
//
//     Los cambios en este archivo podrían causar un comportamiento incorrecto y se perderán si
//     se vuelve a generar el código.
// </auto-generated>
//------------------------------------------------------------------------------

// 
// This code was auto-generated by Microsoft.Silverlight.ServiceReference, version 4.0.50826.0
// 
namespace AdminOpciones.SrvCustomers {
    
    
    [System.CodeDom.Compiler.GeneratedCodeAttribute("System.ServiceModel", "4.0.0.0")]
    [System.ServiceModel.ServiceContractAttribute(ConfigurationName="SrvCustomers.SrvCustomersSoap")]
    public interface SrvCustomersSoap {
        
        [System.ServiceModel.OperationContractAttribute(AsyncPattern=true, Action="http://tempuri.org/getCustomersData", ReplyAction="*")]
        [System.ServiceModel.XmlSerializerFormatAttribute(SupportFaults=true)]
        System.IAsyncResult BegingetCustomersData(System.AsyncCallback callback, object asyncState);
        
        string EndgetCustomersData(System.IAsyncResult result);
        
        [System.ServiceModel.OperationContractAttribute(AsyncPattern=true, Action="http://tempuri.org/getCustomersDataCondicionesGenerales", ReplyAction="*")]
        [System.ServiceModel.XmlSerializerFormatAttribute(SupportFaults=true)]
        System.IAsyncResult BegingetCustomersDataCondicionesGenerales(System.AsyncCallback callback, object asyncState);
        
        string EndgetCustomersDataCondicionesGenerales(System.IAsyncResult result);
    }
    
    [System.CodeDom.Compiler.GeneratedCodeAttribute("System.ServiceModel", "4.0.0.0")]
    public interface SrvCustomersSoapChannel : AdminOpciones.SrvCustomers.SrvCustomersSoap, System.ServiceModel.IClientChannel {
    }
    
    [System.Diagnostics.DebuggerStepThroughAttribute()]
    [System.CodeDom.Compiler.GeneratedCodeAttribute("System.ServiceModel", "4.0.0.0")]
    public partial class getCustomersDataCompletedEventArgs : System.ComponentModel.AsyncCompletedEventArgs {
        
        private object[] results;
        
        public getCustomersDataCompletedEventArgs(object[] results, System.Exception exception, bool cancelled, object userState) : 
                base(exception, cancelled, userState) {
            this.results = results;
        }
        
        public string Result {
            get {
                base.RaiseExceptionIfNecessary();
                return ((string)(this.results[0]));
            }
        }
    }
    
    [System.Diagnostics.DebuggerStepThroughAttribute()]
    [System.CodeDom.Compiler.GeneratedCodeAttribute("System.ServiceModel", "4.0.0.0")]
    public partial class getCustomersDataCondicionesGeneralesCompletedEventArgs : System.ComponentModel.AsyncCompletedEventArgs {
        
        private object[] results;
        
        public getCustomersDataCondicionesGeneralesCompletedEventArgs(object[] results, System.Exception exception, bool cancelled, object userState) : 
                base(exception, cancelled, userState) {
            this.results = results;
        }
        
        public string Result {
            get {
                base.RaiseExceptionIfNecessary();
                return ((string)(this.results[0]));
            }
        }
    }
    
    [System.Diagnostics.DebuggerStepThroughAttribute()]
    [System.CodeDom.Compiler.GeneratedCodeAttribute("System.ServiceModel", "4.0.0.0")]
    public partial class SrvCustomersSoapClient : System.ServiceModel.ClientBase<AdminOpciones.SrvCustomers.SrvCustomersSoap>, AdminOpciones.SrvCustomers.SrvCustomersSoap {
        
        private BeginOperationDelegate onBegingetCustomersDataDelegate;
        
        private EndOperationDelegate onEndgetCustomersDataDelegate;
        
        private System.Threading.SendOrPostCallback ongetCustomersDataCompletedDelegate;
        
        private BeginOperationDelegate onBegingetCustomersDataCondicionesGeneralesDelegate;
        
        private EndOperationDelegate onEndgetCustomersDataCondicionesGeneralesDelegate;
        
        private System.Threading.SendOrPostCallback ongetCustomersDataCondicionesGeneralesCompletedDelegate;
        
        private BeginOperationDelegate onBeginOpenDelegate;
        
        private EndOperationDelegate onEndOpenDelegate;
        
        private System.Threading.SendOrPostCallback onOpenCompletedDelegate;
        
        private BeginOperationDelegate onBeginCloseDelegate;
        
        private EndOperationDelegate onEndCloseDelegate;
        
        private System.Threading.SendOrPostCallback onCloseCompletedDelegate;
        
        public SrvCustomersSoapClient() {
        }
        
        public SrvCustomersSoapClient(string endpointConfigurationName) : 
                base(endpointConfigurationName) {
        }
        
        public SrvCustomersSoapClient(string endpointConfigurationName, string remoteAddress) : 
                base(endpointConfigurationName, remoteAddress) {
        }
        
        public SrvCustomersSoapClient(string endpointConfigurationName, System.ServiceModel.EndpointAddress remoteAddress) : 
                base(endpointConfigurationName, remoteAddress) {
        }
        
        public SrvCustomersSoapClient(System.ServiceModel.Channels.Binding binding, System.ServiceModel.EndpointAddress remoteAddress) : 
                base(binding, remoteAddress) {
        }
        
        public System.Net.CookieContainer CookieContainer {
            get {
                System.ServiceModel.Channels.IHttpCookieContainerManager httpCookieContainerManager = this.InnerChannel.GetProperty<System.ServiceModel.Channels.IHttpCookieContainerManager>();
                if ((httpCookieContainerManager != null)) {
                    return httpCookieContainerManager.CookieContainer;
                }
                else {
                    return null;
                }
            }
            set {
                System.ServiceModel.Channels.IHttpCookieContainerManager httpCookieContainerManager = this.InnerChannel.GetProperty<System.ServiceModel.Channels.IHttpCookieContainerManager>();
                if ((httpCookieContainerManager != null)) {
                    httpCookieContainerManager.CookieContainer = value;
                }
                else {
                    throw new System.InvalidOperationException("No se puede establecer el objeto CookieContainer. Asegúrese de que el enlace cont" +
                            "iene un objeto HttpCookieContainerBindingElement.");
                }
            }
        }
        
        public event System.EventHandler<getCustomersDataCompletedEventArgs> getCustomersDataCompleted;
        
        public event System.EventHandler<getCustomersDataCondicionesGeneralesCompletedEventArgs> getCustomersDataCondicionesGeneralesCompleted;
        
        public event System.EventHandler<System.ComponentModel.AsyncCompletedEventArgs> OpenCompleted;
        
        public event System.EventHandler<System.ComponentModel.AsyncCompletedEventArgs> CloseCompleted;
        
        [System.ComponentModel.EditorBrowsableAttribute(System.ComponentModel.EditorBrowsableState.Advanced)]
        System.IAsyncResult AdminOpciones.SrvCustomers.SrvCustomersSoap.BegingetCustomersData(System.AsyncCallback callback, object asyncState) {
            return base.Channel.BegingetCustomersData(callback, asyncState);
        }
        
        [System.ComponentModel.EditorBrowsableAttribute(System.ComponentModel.EditorBrowsableState.Advanced)]
        string AdminOpciones.SrvCustomers.SrvCustomersSoap.EndgetCustomersData(System.IAsyncResult result) {
            return base.Channel.EndgetCustomersData(result);
        }
        
        private System.IAsyncResult OnBegingetCustomersData(object[] inValues, System.AsyncCallback callback, object asyncState) {
            return ((AdminOpciones.SrvCustomers.SrvCustomersSoap)(this)).BegingetCustomersData(callback, asyncState);
        }
        
        private object[] OnEndgetCustomersData(System.IAsyncResult result) {
            string retVal = ((AdminOpciones.SrvCustomers.SrvCustomersSoap)(this)).EndgetCustomersData(result);
            return new object[] {
                    retVal};
        }
        
        private void OngetCustomersDataCompleted(object state) {
            if ((this.getCustomersDataCompleted != null)) {
                InvokeAsyncCompletedEventArgs e = ((InvokeAsyncCompletedEventArgs)(state));
                this.getCustomersDataCompleted(this, new getCustomersDataCompletedEventArgs(e.Results, e.Error, e.Cancelled, e.UserState));
            }
        }
        
        public void getCustomersDataAsync() {
            this.getCustomersDataAsync(null);
        }
        
        public void getCustomersDataAsync(object userState) {
            if ((this.onBegingetCustomersDataDelegate == null)) {
                this.onBegingetCustomersDataDelegate = new BeginOperationDelegate(this.OnBegingetCustomersData);
            }
            if ((this.onEndgetCustomersDataDelegate == null)) {
                this.onEndgetCustomersDataDelegate = new EndOperationDelegate(this.OnEndgetCustomersData);
            }
            if ((this.ongetCustomersDataCompletedDelegate == null)) {
                this.ongetCustomersDataCompletedDelegate = new System.Threading.SendOrPostCallback(this.OngetCustomersDataCompleted);
            }
            base.InvokeAsync(this.onBegingetCustomersDataDelegate, null, this.onEndgetCustomersDataDelegate, this.ongetCustomersDataCompletedDelegate, userState);
        }
        
        [System.ComponentModel.EditorBrowsableAttribute(System.ComponentModel.EditorBrowsableState.Advanced)]
        System.IAsyncResult AdminOpciones.SrvCustomers.SrvCustomersSoap.BegingetCustomersDataCondicionesGenerales(System.AsyncCallback callback, object asyncState) {
            return base.Channel.BegingetCustomersDataCondicionesGenerales(callback, asyncState);
        }
        
        [System.ComponentModel.EditorBrowsableAttribute(System.ComponentModel.EditorBrowsableState.Advanced)]
        string AdminOpciones.SrvCustomers.SrvCustomersSoap.EndgetCustomersDataCondicionesGenerales(System.IAsyncResult result) {
            return base.Channel.EndgetCustomersDataCondicionesGenerales(result);
        }
        
        private System.IAsyncResult OnBegingetCustomersDataCondicionesGenerales(object[] inValues, System.AsyncCallback callback, object asyncState) {
            return ((AdminOpciones.SrvCustomers.SrvCustomersSoap)(this)).BegingetCustomersDataCondicionesGenerales(callback, asyncState);
        }
        
        private object[] OnEndgetCustomersDataCondicionesGenerales(System.IAsyncResult result) {
            string retVal = ((AdminOpciones.SrvCustomers.SrvCustomersSoap)(this)).EndgetCustomersDataCondicionesGenerales(result);
            return new object[] {
                    retVal};
        }
        
        private void OngetCustomersDataCondicionesGeneralesCompleted(object state) {
            if ((this.getCustomersDataCondicionesGeneralesCompleted != null)) {
                InvokeAsyncCompletedEventArgs e = ((InvokeAsyncCompletedEventArgs)(state));
                this.getCustomersDataCondicionesGeneralesCompleted(this, new getCustomersDataCondicionesGeneralesCompletedEventArgs(e.Results, e.Error, e.Cancelled, e.UserState));
            }
        }
        
        public void getCustomersDataCondicionesGeneralesAsync() {
            this.getCustomersDataCondicionesGeneralesAsync(null);
        }
        
        public void getCustomersDataCondicionesGeneralesAsync(object userState) {
            if ((this.onBegingetCustomersDataCondicionesGeneralesDelegate == null)) {
                this.onBegingetCustomersDataCondicionesGeneralesDelegate = new BeginOperationDelegate(this.OnBegingetCustomersDataCondicionesGenerales);
            }
            if ((this.onEndgetCustomersDataCondicionesGeneralesDelegate == null)) {
                this.onEndgetCustomersDataCondicionesGeneralesDelegate = new EndOperationDelegate(this.OnEndgetCustomersDataCondicionesGenerales);
            }
            if ((this.ongetCustomersDataCondicionesGeneralesCompletedDelegate == null)) {
                this.ongetCustomersDataCondicionesGeneralesCompletedDelegate = new System.Threading.SendOrPostCallback(this.OngetCustomersDataCondicionesGeneralesCompleted);
            }
            base.InvokeAsync(this.onBegingetCustomersDataCondicionesGeneralesDelegate, null, this.onEndgetCustomersDataCondicionesGeneralesDelegate, this.ongetCustomersDataCondicionesGeneralesCompletedDelegate, userState);
        }
        
        private System.IAsyncResult OnBeginOpen(object[] inValues, System.AsyncCallback callback, object asyncState) {
            return ((System.ServiceModel.ICommunicationObject)(this)).BeginOpen(callback, asyncState);
        }
        
        private object[] OnEndOpen(System.IAsyncResult result) {
            ((System.ServiceModel.ICommunicationObject)(this)).EndOpen(result);
            return null;
        }
        
        private void OnOpenCompleted(object state) {
            if ((this.OpenCompleted != null)) {
                InvokeAsyncCompletedEventArgs e = ((InvokeAsyncCompletedEventArgs)(state));
                this.OpenCompleted(this, new System.ComponentModel.AsyncCompletedEventArgs(e.Error, e.Cancelled, e.UserState));
            }
        }
        
        public void OpenAsync() {
            this.OpenAsync(null);
        }
        
        public void OpenAsync(object userState) {
            if ((this.onBeginOpenDelegate == null)) {
                this.onBeginOpenDelegate = new BeginOperationDelegate(this.OnBeginOpen);
            }
            if ((this.onEndOpenDelegate == null)) {
                this.onEndOpenDelegate = new EndOperationDelegate(this.OnEndOpen);
            }
            if ((this.onOpenCompletedDelegate == null)) {
                this.onOpenCompletedDelegate = new System.Threading.SendOrPostCallback(this.OnOpenCompleted);
            }
            base.InvokeAsync(this.onBeginOpenDelegate, null, this.onEndOpenDelegate, this.onOpenCompletedDelegate, userState);
        }
        
        private System.IAsyncResult OnBeginClose(object[] inValues, System.AsyncCallback callback, object asyncState) {
            return ((System.ServiceModel.ICommunicationObject)(this)).BeginClose(callback, asyncState);
        }
        
        private object[] OnEndClose(System.IAsyncResult result) {
            ((System.ServiceModel.ICommunicationObject)(this)).EndClose(result);
            return null;
        }
        
        private void OnCloseCompleted(object state) {
            if ((this.CloseCompleted != null)) {
                InvokeAsyncCompletedEventArgs e = ((InvokeAsyncCompletedEventArgs)(state));
                this.CloseCompleted(this, new System.ComponentModel.AsyncCompletedEventArgs(e.Error, e.Cancelled, e.UserState));
            }
        }
        
        public void CloseAsync() {
            this.CloseAsync(null);
        }
        
        public void CloseAsync(object userState) {
            if ((this.onBeginCloseDelegate == null)) {
                this.onBeginCloseDelegate = new BeginOperationDelegate(this.OnBeginClose);
            }
            if ((this.onEndCloseDelegate == null)) {
                this.onEndCloseDelegate = new EndOperationDelegate(this.OnEndClose);
            }
            if ((this.onCloseCompletedDelegate == null)) {
                this.onCloseCompletedDelegate = new System.Threading.SendOrPostCallback(this.OnCloseCompleted);
            }
            base.InvokeAsync(this.onBeginCloseDelegate, null, this.onEndCloseDelegate, this.onCloseCompletedDelegate, userState);
        }
        
        protected override AdminOpciones.SrvCustomers.SrvCustomersSoap CreateChannel() {
            return new SrvCustomersSoapClientChannel(this);
        }
        
        private class SrvCustomersSoapClientChannel : ChannelBase<AdminOpciones.SrvCustomers.SrvCustomersSoap>, AdminOpciones.SrvCustomers.SrvCustomersSoap {
            
            public SrvCustomersSoapClientChannel(System.ServiceModel.ClientBase<AdminOpciones.SrvCustomers.SrvCustomersSoap> client) : 
                    base(client) {
            }
            
            public System.IAsyncResult BegingetCustomersData(System.AsyncCallback callback, object asyncState) {
                object[] _args = new object[0];
                System.IAsyncResult _result = base.BeginInvoke("getCustomersData", _args, callback, asyncState);
                return _result;
            }
            
            public string EndgetCustomersData(System.IAsyncResult result) {
                object[] _args = new object[0];
                string _result = ((string)(base.EndInvoke("getCustomersData", _args, result)));
                return _result;
            }
            
            public System.IAsyncResult BegingetCustomersDataCondicionesGenerales(System.AsyncCallback callback, object asyncState) {
                object[] _args = new object[0];
                System.IAsyncResult _result = base.BeginInvoke("getCustomersDataCondicionesGenerales", _args, callback, asyncState);
                return _result;
            }
            
            public string EndgetCustomersDataCondicionesGenerales(System.IAsyncResult result) {
                object[] _args = new object[0];
                string _result = ((string)(base.EndInvoke("getCustomersDataCondicionesGenerales", _args, result)));
                return _result;
            }
        }
    }
}