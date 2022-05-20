using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace CoreLib.Common
{
    #region Enums para Mailer
    /// <summary>
    /// Enumerador Formato de Correo
    /// </summary>
    public enum MailFormat
    {
        /// <summary>
        /// Formato HTML para envio de correo
        /// </summary>
        HTML = 0,
        /// <summary>
        /// Formato Texto plano para envio de correo
        /// </summary>
        Text = 1
    }
    #endregion
    #region Enums para CryptoHelper

    /// <summary>
    /// Enumerador para Algoritmo Crytografico.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              
    /// </summary>
    public enum CryptographyAlgorithm
    {
        /// <summary>
        /// Algoritmo de encriptacion y desencriptacion DES
        /// </summary>
        DES = 0,
        /// <summary>
        /// Algoritmo de encriptacion y desencriptacion Triple DES
        /// </summary>
        TripleDES = 1,
        /// <summary>
        /// Algoritmo de encriptacion y desencriptacion Rijndael
        /// </summary>
        Rijndael = 2
    } 
    #endregion
    #region Enums para LogHelper
    
    /// <summary>
    /// Enumerador para niveles de informacion
    /// </summary>
    [Flags()]
    public enum LevelInfo { 
        /// <summary>
        /// Sin nivel de clasificacion.
        /// </summary>
        None        = 0x0, 
        /// <summary>
        /// De caracter solo informativo.
        /// </summary>        
        Informative = 0x1,
        /// <summary>
        /// Indica una advertencia o potencial riesgo de error en el sistema.
        /// </summary>
        Warning     = 0x2,
        /// <summary>
        /// Indica que el registro de log es un error.
        /// </summary>
        Error       = 0x4,
        /// <summary>
        /// Indica que el registro de log es chequeo de sistema.
        /// </summary>
        EngineCheck = 0x8,
        /// <summary>
        /// Indica que el registro de log es chequeo de sistema.
        /// </summary>
        EngineConfig = 0x10,
        /// <summary>
        /// Indica que el registro de log es una exception.
        /// </summary>
        EngineError = 0x20,
        /// <summary>
        /// Indica que se esta en modo debug
        /// </summary>
        DebugMode = 0x40
    }
    #endregion
    
}
