﻿//------------------------------------------------------------------------------
// <auto-generated>
//     Este código fue generado por una herramienta.
//     Versión de runtime:4.0.30319.296
//
//     Los cambios en este archivo podrían causar un comportamiento incorrecto y se perderán si
//     se vuelve a generar el código.
// </auto-generated>
//------------------------------------------------------------------------------

namespace WebServiceFMD.Properties {
    
    
    [global::System.Runtime.CompilerServices.CompilerGeneratedAttribute()]
    [global::System.CodeDom.Compiler.GeneratedCodeAttribute("Microsoft.VisualStudio.Editors.SettingsDesigner.SettingsSingleFileGenerator", "10.0.0.0")]
    internal sealed partial class Settings : global::System.Configuration.ApplicationSettingsBase {
        
        private static Settings defaultInstance = ((Settings)(global::System.Configuration.ApplicationSettingsBase.Synchronized(new Settings())));
        
        public static Settings Default {
            get {
                return defaultInstance;
            }
        }
        
        [global::System.Configuration.ApplicationScopedSettingAttribute()]
        [global::System.Diagnostics.DebuggerNonUserCodeAttribute()]
        [global::System.Configuration.DefaultSettingValueAttribute("True")]
        public bool UseFileLog {
            get {
                return ((bool)(this["UseFileLog"]));
            }
        }
        
        [global::System.Configuration.ApplicationScopedSettingAttribute()]
        [global::System.Diagnostics.DebuggerNonUserCodeAttribute()]
        [global::System.Configuration.DefaultSettingValueAttribute("wsReportes_CM")]
        public string AppName {
            get {
                return ((string)(this["AppName"]));
            }
        }
        
        [global::System.Configuration.ApplicationScopedSettingAttribute()]
        [global::System.Diagnostics.DebuggerNonUserCodeAttribute()]
        [global::System.Configuration.DefaultSettingValueAttribute("Upload")]
        public string UploadFolder {
            get {
                return ((string)(this["UploadFolder"]));
            }
        }
        
        [global::System.Configuration.ApplicationScopedSettingAttribute()]
        [global::System.Diagnostics.DebuggerNonUserCodeAttribute()]
        [global::System.Configuration.DefaultSettingValueAttribute("Download")]
        public string DownloadFolder {
            get {
                return ((string)(this["DownloadFolder"]));
            }
        }
        
        [global::System.Configuration.ApplicationScopedSettingAttribute()]
        [global::System.Diagnostics.DebuggerNonUserCodeAttribute()]
        [global::System.Configuration.DefaultSettingValueAttribute("Templates")]
        public string TemplateFolder {
            get {
                return ((string)(this["TemplateFolder"]));
            }
        }
        
        [global::System.Configuration.ApplicationScopedSettingAttribute()]
        [global::System.Diagnostics.DebuggerNonUserCodeAttribute()]
        [global::System.Configuration.DefaultSettingValueAttribute("True")]
        public bool AllowPaging {
            get {
                return ((bool)(this["AllowPaging"]));
            }
        }
        
        [global::System.Configuration.ApplicationScopedSettingAttribute()]
        [global::System.Diagnostics.DebuggerNonUserCodeAttribute()]
        [global::System.Configuration.DefaultSettingValueAttribute("Reportes")]
        public string DefaultCatalog {
            get {
                return ((string)(this["DefaultCatalog"]));
            }
        }
        
        [global::System.Configuration.ApplicationScopedSettingAttribute()]
        [global::System.Diagnostics.DebuggerNonUserCodeAttribute()]
        [global::System.Configuration.DefaultSettingValueAttribute("False")]
        public bool UseFriendlyLog {
            get {
                return ((bool)(this["UseFriendlyLog"]));
            }
        }
        
        [global::System.Configuration.ApplicationScopedSettingAttribute()]
        [global::System.Diagnostics.DebuggerNonUserCodeAttribute()]
        [global::System.Configuration.DefaultSettingValueAttribute("{0}_{1}_Process.log.txt")]
        public string LogFileName {
            get {
                return ((string)(this["LogFileName"]));
            }
        }
        
        [global::System.Configuration.ApplicationScopedSettingAttribute()]
        [global::System.Diagnostics.DebuggerNonUserCodeAttribute()]
        [global::System.Configuration.DefaultSettingValueAttribute("False")]
        public bool DeleteFiles {
            get {
                return ((bool)(this["DeleteFiles"]));
            }
        }
        
        [global::System.Configuration.ApplicationScopedSettingAttribute()]
        [global::System.Diagnostics.DebuggerNonUserCodeAttribute()]
        [global::System.Configuration.DefaultSettingValueAttribute(@"
        [
        {
        ""DBCatalog"":""Reportes""
        ,""DBMaxConnection"":6
        ,""DBMinConnection"":2
        ,""DBPooling"":true
        ,""DBServerName"":""CORPSQL05""
        ,""DBUserName"":""app_reportes""
        ,""DBUserPass"":""0rbt/Ehi9yeuWpdIcfEZtw==""
        ,""DB_IP_Address"":null
        ,""IntegratedSecurity"":false
        ,""TrustedConnection"":false
        ,""Use_IP_Address"":false
        }
        ,
        {
        ""DBCatalog"": ""Bacfwdsuda""
        ,""DBMaxConnection"":6
        ,""DBMinConnection"":2
        ,""DBPooling"": true
        ,""DBServerName"":""CORPSQL05""
        ,""DBUserName"": ""bacuser""
        ,""DBUserPass"":""TBpzrQQSRg1W/wFJeOPowQ==""
        ,""DB_IP_Address"": null
        ,""IntegratedSecurity"": false
        ,""TrustedConnection"": false
        ,""Use_IP_Address"": false
        }
        ]
      ")]
        public string DBConnections {
            get {
                return ((string)(this["DBConnections"]));
            }
        }
        
        [global::System.Configuration.ApplicationScopedSettingAttribute()]
        [global::System.Diagnostics.DebuggerNonUserCodeAttribute()]
        [global::System.Configuration.DefaultSettingValueAttribute("D:\\Interfaces\\SFMC\\FMD")]
        public string InterfaceRootFolder {
            get {
                return ((string)(this["InterfaceRootFolder"]));
            }
        }
        
        [global::System.Configuration.ApplicationScopedSettingAttribute()]
        [global::System.Diagnostics.DebuggerNonUserCodeAttribute()]
        [global::System.Configuration.DefaultSettingValueAttribute("D:\\Sitios\\SFMC\\FMD\\LOG")]
        public string LogFolder {
            get {
                return ((string)(this["LogFolder"]));
            }
        }
    }
}