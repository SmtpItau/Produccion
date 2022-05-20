#pragma warning disable 1591
using System;
using System.ServiceProcess;
using CoreLib.Common;
using CoreLib.Helpers;
using WindowsServiceFMD.Common.Collections;
using WindowsServiceFMD.Common.DAO;
using WindowsServiceFMD.Common.DTO;

namespace WindowsServiceFMD
{
    /// <summary>
    /// Windows Service FMD
    /// </summary>
    public static class Program
    {
        private static ModuleTypeCollection<ModuleType> ModuleTypes = new ModuleTypeCollection<ModuleType>();
        private static ReportTypeCollection<ReportType> ReportTypes = new ReportTypeCollection<ReportType>();
        private static string Log_Line { get { return ("=").PadLeft(100, '='); } }
        
        /// <summary>
        /// Punto de entrada principal para la aplicación.
        /// </summary>
        static void Main(string[] args)
        {

            ServiceReport service = new ServiceReport();
            string header = ("Time Stamp").PadRight(25, '\x20') + "\t" + ("Level").PadRight(15, '\x20') + "\tCode\tMessage";


            ModuleTypes = ModuleTypeDao.GetModuleTypeCollection(service.context.DBContext);
            ReportTypes = ReportTypeDao.GetReportTypeCollection(service.context.DBContext);

            LogHelper.WriteLog(service.context, header);
            LogHelper.WriteLog(service.context, Log_Line);
            LogHelper.WriteLog(service.context, "Iniciando Servicio: " + service.ServiceName + " (Servicio de Reportes)",1001, LevelInfo.Informative);                       
            if (Environment.UserInteractive)
            {                
                
                LogHelper.WriteLog(service.context,"Modo Interactivo:ON",1002,LevelInfo.Informative);
                service.InteractiveMode(args);
            }
            else
            {
                LogHelper.WriteLog(service.context, "Modo Interactivo:OFF", 1003, LevelInfo.Informative);
                ServiceBase[] ServicesToRun;
                ServicesToRun = new ServiceBase[] { 
                    service
                };
                ServiceBase.Run(ServicesToRun);                
            }
            LogHelper.WriteLog(service.context, "Deteniendo...  " + service.ServiceName, 1005, LevelInfo.Informative);
            LogHelper.WriteLog(service.context, Log_Line);
        }
    }
}
