using System;
using System.Collections.Generic;
using System.Linq;
using System.ServiceProcess;
using System.Text;

namespace Tickers_BCS_RST
{
    static class Program
    {
        /// <summary>
        /// Punto de entrada principal para la aplicación.
        /// </summary>
        static void Main()
        {
            ServiceBase[] ServicesToRun;
            ServicesToRun = new ServiceBase[] 
			{ 
				 new TickersBCSR(),
                 new Bac_Inicio_Dia()

			};
            ServiceBase.Run(ServicesToRun);
        }
    }
}
