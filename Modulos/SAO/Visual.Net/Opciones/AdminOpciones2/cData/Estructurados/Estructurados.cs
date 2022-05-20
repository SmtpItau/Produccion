using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;

namespace cData.Estructurados
{
    public static class Estructurados
    {
        /// <summary>
        /// TBL_RELACION_SAO_LEASING (string)
        /// </summary>
        /// <param name="RutCliente"></param>
        /// <param name="NumeroLeasing"></param>
        /// <param name="NumeroGrupoBienes"></param>
        /// <returns></returns>
        public static DataSet DTListarForwardRelacionados(string RutCliente, string NumeroLeasing, string NumeroGrupoBienes)
        {

            String _Query = @"
            SELECT enc.CaRutCliente, rel.ReNumeroLeasing, rel.ReNumeroBien, rel.ReCaNumContrato, det.CaFechaVcto, det.CaMontoMon1
            FROM TBL_RELACION_SAO_LEASING rel
            ,    dbo.CaEncContrato enc
            ,    dbo.CaDetContrato det
            WHERE rel.ReCaNumContrato = enc.CaNumContrato
            AND enc.CaNumContrato = det.CaNumContrato
            AND enc.CaCodEstructura = 8
            ";

            _Query += " AND enc.CaRutCliente        = " + RutCliente;
            _Query += " AND rel.ReNumeroLeasing     = " + NumeroLeasing;
            _Query += " AND rel.ReNumeroBien        = " + NumeroGrupoBienes;



            cConnectionDB.SqlConnectionDB _Connect = new cConnectionDB.SqlConnectionDB("OPCIONES");
            DataSet _DS;
            enumStatus Status; //copy-paste, revisar.
            String Error;
            String Stack;

            try
            {
                Status = enumStatus.Loading;
                _Connect.Execute(_Query);
                _DS = _Connect.QueryDataSet();
                //_DS.Tables["Query"].TableName = "ListarForwardRelacionados";

                if (_DS.Tables["Query"].Rows.Count.Equals(0))
                {
                    Status = enumStatus.NotFound;
                }
                else
                {
                    Status = enumStatus.Already;
                }
            }
            catch (Exception _Error)
            {
                _DS = null;
                Status = enumStatus.ErrorLoad;
                Error = _Error.StackTrace;
                Stack = _Error.Message;
            }

            return _DS;
        }

        /// <summary>
        /// LEASING_RELACIONADOS_OPT (string)
        /// </summary>
        /// <param name="RutCliente"></param>
        /// <param name="NumeroLeasing"></param>
        /// <param name="NumeroGrupoBienes"></param>
        /// <returns></returns>
//        public static DataSet DTListarForwardRelacionados_(string RutCliente, string NumeroLeasing, string NumeroGrupoBienes)
//        {
//            /*
//             * "<RESULTADO>
//                    <RutCliente>995279800</RutCliente>
//                    <NumeroLeasing>20</NumeroLeasing>
//                    <NumeroGrupoBienes>1</NumeroGrupoBienes>
//                    <NumeroForward>1234</NumeroForward>
//                    <FechaVencimiento>31/12/2015</FechaVencimiento>
//                    <NocionalContrato>10200300.99</NocionalContrato>
//                    <NocionalRemanente>500</NocionalRemanente>
//                </RESULTADO>"
//             * */
//            String _Query = @"
//                SELECT enc.CaRutCliente, rel.numero_leasing, rel.numero_grupo_bien, rel.numero_fwd_relacion, det.CaFechaVcto, det.CaMontoMon1
//                FROM dbo.LEASING_RELACIONADOS_OPT rel
//                   , dbo.CaEncContrato enc
//                   , dbo.CaDetContrato det
//                WHERE rel.numero_fwd_relacion = enc.CanumContrato
//                  AND enc.CaNumContrato = det.CaNumContrato
//                  AND enc.CaCodEstructura = 8
//                ";
//            //MEJORAR: Ojo con los espacios al concatenar para que no quede pegado.
//            _Query += " AND enc.CaRutCliente        = " + RutCliente;
//            _Query += " AND rel.numero_leasing      = " + NumeroLeasing;
//            _Query += " AND rel.numero_grupo_bien   = " + NumeroGrupoBienes;

//            cConnectionDB.SqlConnectionDB _Connect = new cConnectionDB.SqlConnectionDB("OPCIONES");
//            DataSet _DS;
//            enumStatus Status; //copy-paste, revisar.
//            String Error;
//            String Stack;

//            try
//            {
//                Status = enumStatus.Loading;
//                _Connect.Execute(_Query);
//                _DS = _Connect.QueryDataSet();
//                //_DS.Tables["Query"].TableName = "ListarForwardRelacionados";

//                if (_DS.Tables["Query"].Rows.Count.Equals(0))
//                {
//                    Status = enumStatus.NotFound;
//                }
//                else
//                {
//                    Status = enumStatus.Already;
//                }
//            }
//            catch (Exception _Error)
//            {
//                _DS = null;
//                Status = enumStatus.ErrorLoad;
//                Error = _Error.StackTrace;
//                Stack = _Error.Message;
//            }

//            return _DS;
//        }

        /// <summary>
        /// LEASING_RELACIONADOS_OPT (int)
        /// </summary>
        /// <param name="RutCliente"></param>
        /// <param name="NumeroLeasing"></param>
        /// <param name="NumeroGrupoBienes"></param>
        /// <returns></returns>
//        public static DataSet DTListarForwardRelacionados(int RutCliente, long NumeroLeasing, long NumeroGrupoBienes)
//        {
//            /*
//             * "<RESULTADO>
//                    <RutCliente>995279800</RutCliente>
//                    <NumeroLeasing>20</NumeroLeasing>
//                    <NumeroGrupoBienes>1</NumeroGrupoBienes>
//                    <NumeroForward>1234</NumeroForward>
//                    <FechaVencimiento>31/12/2015</FechaVencimiento>
//                    <NocionalContrato>10200300.99</NocionalContrato>
//                    <NocionalRemanente>500</NocionalRemanente>
//                </RESULTADO>"
//             * */
//            String _Query = @"
//                SELECT enc.CaRutCliente, rel.numero_leasing, rel.numero_grupo_bien, rel.numero_fwd_relacion, det.CaFechaVcto, det.CaMontoMon1
//                FROM dbo.LEASING_RELACIONADOS_OPT rel
//                   , dbo.CaEncContrato enc
//                   , dbo.CaDetContrato det
//                WHERE rel.numero_fwd_relacion = enc.CanumContrato
//                  AND enc.CaNumContrato = det.CaNumContrato
//                  AND enc.CaCodEstructura = 8
//                ";
//            //MEJORAR: Ojo con los espacios al concatenar para que no quede pegado.
//            _Query += " AND enc.CaRutCliente        = " + RutCliente.ToString();
//            _Query += " AND rel.numero_leasing      = " + NumeroLeasing.ToString();
//            _Query += " AND rel.numero_grupo_bien   = " + NumeroGrupoBienes.ToString();
            
//            cConnectionDB.SqlConnectionDB _Connect = new cConnectionDB.SqlConnectionDB("OPCIONES");
//            DataSet _DS;
//            enumStatus Status; //copy-paste, revisar.
//            String Error;
//            String Stack;

//            try
//            {
//                Status = enumStatus.Loading;
//                _Connect.Execute(_Query);
//                _DS = _Connect.QueryDataSet();
//                //_DS.Tables["Query"].TableName = "ListarForwardRelacionados";

//                if (_DS.Tables["Query"].Rows.Count.Equals(0))
//                {
//                    Status = enumStatus.NotFound;
//                }
//                else
//                {
//                    Status = enumStatus.Already;
//                }
//            }
//            catch (Exception _Error)
//            {
//                _DS = null;
//                Status = enumStatus.ErrorLoad;
//                Error = _Error.StackTrace;
//                Stack = _Error.Message;
//            }

//            return _DS;
//        }

        /// <summary>
        /// Contiene Forward Relacionados LEASING_RELACIONADOS_OPT (string).
        /// </summary>
        /// <param name="RutCliente"></param>
        /// <param name="NumeroLeasing"></param>
        /// <param name="NumeroGrupoBienes"></param>
        /// <param name="NumeroForward"></param>
        /// <returns></returns>
//        public static DataSet DTValidarForward_(string RutCliente, string NumeroLeasing, string NumeroGrupoBienes, string NumeroForward)
//        {
//            String _Query = @"
//                SELECT enc.CaRutCliente, rel.numero_leasing, rel.numero_grupo_bien, rel.numero_fwd_relacion
//                FROM dbo.LEASING_RELACIONADOS_OPT rel
//                   , dbo.CaEncContrato enc
//                WHERE rel.numero_fwd_relacion = enc.CanumContrato
//                  AND enc.CaCodEstructura = 8
//                ";
//            //MEJORAR: Ojo con los espacios al concatenar para que no quede pegado.
//            _Query += " AND enc.CaRutCliente        = " + RutCliente;
//            _Query += " AND rel.numero_leasing      = " + NumeroLeasing;
//            _Query += " AND rel.numero_grupo_bien   = " + NumeroGrupoBienes;
//            _Query += " AND rel.numero_fwd_relacion = " + NumeroForward;

//            cConnectionDB.SqlConnectionDB _Connect = new cConnectionDB.SqlConnectionDB("OPCIONES");
//            DataSet _DS;
//            enumStatus Status; //copy-paste, revisar.
//            String Error;
//            String Stack;

//            try
//            {
//                Status = enumStatus.Loading;
//                _Connect.Execute(_Query);
//                _DS = _Connect.QueryDataSet();
//                //_DS.Tables["Query"].TableName = "ValidarForward";

//                if (_DS.Tables["Query"].Rows.Count.Equals(0))
//                {
//                    Status = enumStatus.NotFound;
//                }
//                else
//                {
//                    Status = enumStatus.Already;
//                }
//            }
//            catch (Exception _Error)
//            {
//                _DS = null;
//                Status = enumStatus.ErrorLoad;
//                Error = _Error.StackTrace;
//                Stack = _Error.Message;
//            }

//            return _DS;
//        }

        /// <summary>
        /// LEASING_RELACIONADOS_OPT (int)
        /// </summary>
        /// <param name="RutCliente"></param>
        /// <param name="NumeroLeasing"></param>
        /// <param name="NumeroGrupoBienes"></param>
        /// <param name="NumeroForward"></param>
        /// <returns></returns>
//        public static DataSet DTValidarForward(int RutCliente, long NumeroLeasing, long NumeroGrupoBienes, int NumeroForward)
//        {
//            String _Query = @"
//                SELECT enc.CaRutCliente, rel.numero_leasing, rel.numero_grupo_bien, rel.numero_fwd_relacion
//                FROM dbo.LEASING_RELACIONADOS_OPT rel
//                   , dbo.CaEncContrato enc
//                WHERE rel.numero_fwd_relacion = enc.CanumContrato
//                  AND enc.CaCodEstructura = 8
//                ";
//            //MEJORAR: Ojo con los espacios al concatenar para que no quede pegado.
//            _Query += " AND enc.CaRutCliente        = " + RutCliente.ToString();
//            _Query += " AND rel.numero_leasing      = " + NumeroLeasing.ToString();
//            _Query += " AND rel.numero_grupo_bien   = " + NumeroGrupoBienes.ToString();
//            _Query += " AND rel.numero_fwd_relacion = " + NumeroForward.ToString();

//            cConnectionDB.SqlConnectionDB _Connect = new cConnectionDB.SqlConnectionDB("OPCIONES");
//            DataSet _DS;
//            enumStatus Status; //copy-paste, revisar.
//            String Error;
//            String Stack;

//            try
//            {
//                Status = enumStatus.Loading;
//                _Connect.Execute(_Query);
//                _DS = _Connect.QueryDataSet();
//                //_DS.Tables["Query"].TableName = "ValidarForward";

//                if (_DS.Tables["Query"].Rows.Count.Equals(0))
//                {
//                    Status = enumStatus.NotFound;
//                }
//                else
//                {
//                    Status = enumStatus.Already;
//                }
//            }
//            catch (Exception _Error)
//            {
//                _DS = null;
//                Status = enumStatus.ErrorLoad;
//                Error = _Error.StackTrace;
//                Stack = _Error.Message;
//            }

//            return _DS;
//        }

        /// <summary>
        /// Contiene Forward Relacionados TBL_RELACION_SAO_LEASING (string).
        /// </summary>
        /// <param name="RutCliente"></param>
        /// <param name="NumeroLeasing"></param>
        /// <param name="NumeroGrupoBienes"></param>
        /// <param name="NumeroForward"></param>
        /// <returns></returns>
        public static DataSet DTValidarForward(string RutCliente, string NumeroLeasing, string NumeroGrupoBienes, string NumeroForward)
        {

            String _Query = @"
            SELECT enc.CaRutCliente, rel.ReNumeroLeasing, rel.ReNumeroBien, rel.ReCaNumContrato
            FROM dbo.TBL_RELACION_SAO_LEASING rel
            ,    dbo.CaEncContrato enc
            WHERE rel.ReCaNumContrato          = enc.CanumContrato
            AND enc.CaCodEstructura            = 8
            ";
            //MEJORAR: Ojo con los espacios al concatenar para que no quede pegado.
            _Query += " AND enc.CaRutCliente        = " + RutCliente;
            _Query += " AND rel.ReNumeroLeasing     = " + NumeroLeasing;
            _Query += " AND rel.ReNumeroBien        = " + NumeroGrupoBienes;
            _Query += " AND rel.ReCaNumContrato     = " + NumeroForward;

            cConnectionDB.SqlConnectionDB _Connect = new cConnectionDB.SqlConnectionDB("OPCIONES");
            DataSet _DS;
            enumStatus Status; //copy-paste, revisar.
            String Error;
            String Stack;

            try
            {
                Status = enumStatus.Loading;
                _Connect.Execute(_Query);
                _DS = _Connect.QueryDataSet();
                //_DS.Tables["Query"].TableName = "ValidarForward";

                if (_DS.Tables["Query"].Rows.Count.Equals(0))
                {
                    Status = enumStatus.NotFound;
                }
                else
                {
                    Status = enumStatus.Already;
                }
            }
            catch (Exception _Error)
            {
                _DS = null;
                Status = enumStatus.ErrorLoad;
                Error = _Error.StackTrace;
                Stack = _Error.Message;
            }
            return _DS;
        }

    }
}
