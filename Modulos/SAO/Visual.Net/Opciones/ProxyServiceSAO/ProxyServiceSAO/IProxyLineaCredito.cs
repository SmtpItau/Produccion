using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.Serialization;
using System.ServiceModel;
using System.ServiceModel.Web;
using System.Text;

namespace ProxyServiceSAO
{
    // NOTA: puede usar el comando "Rename" del menú "Refactorizar" para cambiar el nombre de interfaz "IService1" en el código y en el archivo de configuración a la vez.
    [ServiceContract]
    public interface IProxyLineaCredito
    {

        [OperationContract]
        ProxyClientResult getLineaCode(string clienteAS400, string codigoCliente, string facility, string plazoOP, string montoLinea, string monedaAS400, string action);


    }



}
