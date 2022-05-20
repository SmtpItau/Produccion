using System;
using System.ServiceProcess;
using System.Timers;
using CoreLib.Common;


namespace WindowsServiceFMD
{
    /// <summary>
    /// Extension de CoreLib.Common.AppContext
    /// </summary>
    public class WSAppContext : AppContext
    {
        private Timer _timer = null;
        /// <summary>
        /// Objeto Timer para Servicio Windows
        /// </summary>
        public Timer Timer { get { return _timer; } set { _timer = value; } }

        /// <summary>
        /// Modo de Ejeucion Asincrono/Sincrono.
        /// </summary>
        public bool AsyncMode { get; set; }

        /// <summary>
        /// Intervalo de tiempo para objeto Timer
        /// </summary>
        public int TimeInterval { 
            get { return _TimeInterval; } 
            set {
                if (value > 0) {
                    _TimeInterval = value;
                    _timer.Interval = value;
                }
                else if (value <= 0) {
                    _TimeInterval = 60000; //por defecto
                    _timer.Interval = _TimeInterval;
                }
            }         
        }
        private int _TimeInterval;


        public WSAppContext()
        {
            _timer = new System.Timers.Timer();
            _timer.AutoReset = true;

            //if (this.TimeInterval == 0)
            //{
            //    _timer.Interval = 60000; //por defecto si timeinterval es 0, lo setea a 1 minuto
            //}
            //else
            //{
            //    _timer.Interval = this.TimeInterval;
            //}
            _timer.Elapsed += new ElapsedEventHandler(TimerElapsed);
        }
        
        private void TimerElapsed(object sender, ElapsedEventArgs e)
        {
            if (!Environment.UserInteractive)
            {
                ServiceController servicio = new ServiceController("FMDReportWS");
                _timer.Interval = this.TimeInterval;            
                switch (servicio.Status)    
                {                    
                    case ServiceControllerStatus.ContinuePending:
                        servicio.WaitForStatus(ServiceControllerStatus.Running);
                        return;
                    case ServiceControllerStatus.PausePending:
                        servicio.WaitForStatus(ServiceControllerStatus.Paused);
                        servicio.Start();
                        break;
                    case ServiceControllerStatus.Paused:
                        servicio.WaitForStatus(ServiceControllerStatus.Paused);
                        servicio.Start();
                        break;
                    case ServiceControllerStatus.Running:
                        return;                        
                    case ServiceControllerStatus.StartPending:
                        servicio.WaitForStatus(ServiceControllerStatus.Running);                        
                        return;                        
                    case ServiceControllerStatus.StopPending:
                        servicio.WaitForStatus(ServiceControllerStatus.Stopped);
                        servicio.Start();
                        return;
                    case ServiceControllerStatus.Stopped:
                        servicio.Start();
                        return;
                }                                              
                //servicio.Stop();
                //servicio.WaitForStatus(ServiceControllerStatus.Stopped);
                //servicio.Start();
                //_timer.Interval = this.TimeInterval;            
            }
                           
        }

        public TimeSpan GetRealTime() {
            return DateTime.Now.TimeOfDay;                        
        }

        public DateTime GetRealDate() {
            DateTime aux = DateTime.Now;
            return new DateTime(aux.Year, aux.Month, aux.Day);
        }

    }//fin clase WSAppContext


}
