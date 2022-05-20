using System;
using System.Collections.Generic;
using System.Text;
using System.Data;

namespace cData.Opciones
{
    public static class ValorizarCarteraData
    {

        #region "Atributos Privados"

        private static enumStatus mStatus;
        private static enumSource mSource;
        private static String mError;
        private static String mStack;

        #endregion

        public static DataSet LoadValorizacionCarteraData(DateTime CaFechaContrato, string CaEstado, DateTime fechaDeProcesoSistema)
        {
            DataSet _DataSetValorizacionCartera = new DataSet();

            if (CaFechaContrato.ToString("dd-MM-yyyy").Equals(fechaDeProcesoSistema.ToString("dd-MM-yyyy")))
            {
                _DataSetValorizacionCartera.Merge(LoadEncContratoData(CaEstado));
                _DataSetValorizacionCartera.Merge(LoadDetContratoData(CaEstado));
                _DataSetValorizacionCartera.Merge(LoadFixing(CaEstado));
                _DataSetValorizacionCartera.Merge(SpotDelta(fechaDeProcesoSistema));
                _DataSetValorizacionCartera.Merge(ForwardDelta(fechaDeProcesoSistema));
            }
            else
            {
                _DataSetValorizacionCartera.Merge(LoadEncContratoResData(CaFechaContrato, CaEstado));
                _DataSetValorizacionCartera.Merge(LoadDetContratoDataRes(CaFechaContrato, CaEstado));
                _DataSetValorizacionCartera.Merge(LoadFixingRes(CaFechaContrato, CaEstado));
                _DataSetValorizacionCartera.Merge(SpotDelta(CaFechaContrato));
                _DataSetValorizacionCartera.Merge(ForwardDelta(fechaDeProcesoSistema));
            }

            return _DataSetValorizacionCartera;
        }

        #region Consultas Diarias

        private static DataTable LoadEncContratoData(string CaEstado)
        {

            String _QueryLoadEnc = "";

            #region "Query Load EncContrato"

            _QueryLoadEnc += "SELECT DISTINCT\n";
            _QueryLoadEnc += "       ENC.caNumContrato\n";
            _QueryLoadEnc += "     , ENC.CaNumFolio\n";
            _QueryLoadEnc += "     , ENC.caCodEstructura\n";
            _QueryLoadEnc += "     , ENC.caCVEstructura\n";
            _QueryLoadEnc += "     , ENC.caFechaContrato\n";
            _QueryLoadEnc += "     , ENC.caFecValorizacion\n";
            _QueryLoadEnc += "     , ENC.CaEstado\n";
            _QueryLoadEnc += "     , ENC.CaCarteraFinanciera\n";
            _QueryLoadEnc += "     , 'FinancialPortfolio' = RTRIM( ISNULL( FPort.tbglosa, '' ) )\n";
            _QueryLoadEnc += "     , ENC.caLibro\n";
            _QueryLoadEnc += "     , 'Book' = RTRIM( ISNULL( Book.tbglosa, '' ) )\n";
            _QueryLoadEnc += "     , ENC.caCarNormativa\n";
            _QueryLoadEnc += "     , 'PortfolioRules' = RTRIM( ISNULL( FRule.tbglosa, '' ) )\n";
            _QueryLoadEnc += "     , ENC.caSubCarNormativa\n";
            _QueryLoadEnc += "     , 'SubPortfolioRules' = RTRIM( ISNULL( FSRul.tbglosa, '' ) )\n";
            _QueryLoadEnc += "     , ENC.caRutCliente\n";
            _QueryLoadEnc += "     , ENC.caCodigo\n";
            _QueryLoadEnc += "     , 'NombreCliente' = ISNULL( CL.clnombre, '' )\n";
            _QueryLoadEnc += "     , ENC.caTipoContrapartida\n";
            _QueryLoadEnc += "     , ENC.CafPagoPrima\n";
            _QueryLoadEnc += "     , OPCION = CASE WHEN ENC.caCodEstructura = '0' THEN DET.CaCallPut\n";
            _QueryLoadEnc += "                     ELSE OE.OpcEstDsc\n";
            _QueryLoadEnc += "                END\n";
            _QueryLoadEnc += "     , ENC.CaLibro\n";
            _QueryLoadEnc += "     , ENC.CaCarNormativa\n";
            _QueryLoadEnc += "     , ENC.CaSubCarNormativa\n";
            _QueryLoadEnc += "     , ENC.CaCarteraFinanciera\n";
            _QueryLoadEnc += "     , ENC.CaCodMonPagPrima\n";
            _QueryLoadEnc += "     , ENC.CaPrimaInicial\n";
            //5843 
            _QueryLoadEnc += "     , CaResultadoVentasML = isnull( ENC.CaResultadoVentasML, 0)\n";  
            _QueryLoadEnc += "     , ENC.CaParMdaPrima\n";
            _QueryLoadEnc += "     , ENC.CaPrimaInicialML\n";
            _QueryLoadEnc += "     , ENC.CafPagoPrima\n";
            _QueryLoadEnc += "     , ENC.CaGlosa\n";
            _QueryLoadEnc += "     , ENC.CaTipoTransaccion\n";
            _QueryLoadEnc += "     , ENC.CaRelacionaPAE\n";
            _QueryLoadEnc += "  FROM dbo.CaEncContrato ENC\n";
            _QueryLoadEnc += "       INNER JOIN dbo.CaDetContrato    DET  ON ENC.CaNumContrato   = DET.CaNumContrato\n";
            _QueryLoadEnc += "       INNER JOIN dbo.OpcionEstructura OE   ON ENC.caCodEstructura = OE.OpcEstCod\n";
            _QueryLoadEnc += "       INNER JOIN lnkBac.BacParamSuda.dbo.Cliente               CL     ON ENC.caRutCliente    = CL.clrut                -- Nuevo\n";
            _QueryLoadEnc += "                                                                      AND ENC.caCodigo        = CL.clcodigo             -- Nuevo\n";
            _QueryLoadEnc += "       INNER JOIN lnkbac.bacparamsuda.dbo.TABLA_GENERAL_DETALLE Book   ON BOOK.tbcateg        = 1552                    -- Nuevo\n";
            _QueryLoadEnc += "                                                                      AND BOOK.tbcodigo1      = ENC.caLibro             -- Nuevo\n";
            _QueryLoadEnc += "       INNER JOIN lnkbac.bacparamsuda.dbo.TABLA_GENERAL_DETALLE FPort  ON FPort.tbcateg       = 204                     -- Nuevo\n";
            _QueryLoadEnc += "                                                                      AND FPort.tbcodigo1     = ENC.CaCarteraFinanciera -- Nuevo\n";
            _QueryLoadEnc += "       INNER JOIN lnkbac.bacparamsuda.dbo.TABLA_GENERAL_DETALLE FRule  ON FRule.tbcateg       = 1111                    -- Nuevo\n";
            _QueryLoadEnc += "                                                                      AND FRule.tbcodigo1     = ENC.CaCarNormativa      -- Nuevo\n";
            _QueryLoadEnc += "       INNER JOIN lnkbac.bacparamsuda.dbo.TABLA_GENERAL_DETALLE FSRul  ON FSRul.tbcateg       = 1554                    -- Nuevo\n";
            _QueryLoadEnc += "                                                                      AND FSRul.tbcodigo1     = ENC.CaSubCarNormativa   -- Nuevo\n";

            if (!CaEstado.Equals(""))
            {
                _QueryLoadEnc += " WHERE " + CaEstado + " \n";
            }

            _QueryLoadEnc += " ORDER BY\n";
            _QueryLoadEnc += "       ENC.caNumContrato\n";

            #endregion

            cConnectionDB.SqlConnectionDB _Connect = new cConnectionDB.SqlConnectionDB("OPCIONES");

            DataTable _DetContratoTable;

            try
            {
                // Definición de la Curva
                mStatus = enumStatus.Loading;
                _Connect.Execute(_QueryLoadEnc);
                _DetContratoTable = _Connect.QueryDataTable();
                _DetContratoTable.TableName = "CaEncContrato";

                if (_DetContratoTable.Rows.Count.Equals(0))
                {
                    mStatus = enumStatus.NotFound;
                }
                else
                {
                    mStatus = enumStatus.Already;
                }

            }
            catch (Exception _Error)
            {
                _DetContratoTable = null;
                mStatus = enumStatus.ErrorLoad;
                mError = _Error.StackTrace;
                mStack = _Error.Message;
            }

            return _DetContratoTable;
        }

        private static DataTable LoadDetContratoData(string CaEstado)
        {

            String _QueryLoadDetContrato = "";

            #region "Query Load DetContrato"

            _QueryLoadDetContrato += "SELECT DISTINCT\n";
            _QueryLoadDetContrato += "       DET.CaNumContrato\n";
            _QueryLoadDetContrato += "     , ENC.CaCodEstructura\n";
            _QueryLoadDetContrato += "     , DET.CaNumEstructura\n";
            _QueryLoadDetContrato += "     , DET.CaVinculacion\n";
            _QueryLoadDetContrato += "     , DET.CaTipoPayOff\n";
            _QueryLoadDetContrato += "     , DET.CaCallPut\n";
            _QueryLoadDetContrato += "     , DET.CaCVOpc\n";
            _QueryLoadDetContrato += "     , DET.CaTipoEjercicio -- Nuevo\n";
            _QueryLoadDetContrato += "     , DET.CaFechaInicioOpc\n";
            _QueryLoadDetContrato += "     , DET.CaFechaVcto\n";
            _QueryLoadDetContrato += "     , DET.CaStrike\n";
            _QueryLoadDetContrato += "     , DET.CaSpotDet\n";
            _QueryLoadDetContrato += "     , DET.CaMontoMon1\n";
            _QueryLoadDetContrato += "     , DET.CaParStrike\n";
            _QueryLoadDetContrato += "     , DET.CACurveMon1\n";
            _QueryLoadDetContrato += "     , DET.CaCurveMon2\n";
            _QueryLoadDetContrato += "     , DET.CaFormaPagoMon1\n";
            _QueryLoadDetContrato += "     , DET.CaFormaPagoMon2\n";
            _QueryLoadDetContrato += "     , DET.CaMdaCompensacion\n";
            _QueryLoadDetContrato += "     , DET.CaFormaPagoComp\n";
            _QueryLoadDetContrato += "     , DET.CaModalidad\n";
            _QueryLoadDetContrato += "     , ENC.CaTipoTransaccion\n";
            _QueryLoadDetContrato += "     , ENC.CaRelacionaPAE\n";
            _QueryLoadDetContrato += "     , DET.CaPorcStrike\n"; //PRD_12567
            _QueryLoadDetContrato += "  FROM dbo.CaDetContrato DET\n";
            _QueryLoadDetContrato += "       INNER JOIN CaEncContrato ENC   ON DET.CaNumContrato = ENC.CaNumContrato\n";
            if (!CaEstado.Equals(""))
            {
                _QueryLoadDetContrato += string.Format(" WHERE {0}\n", CaEstado);
            }
            _QueryLoadDetContrato += "ORDER BY\n";
            _QueryLoadDetContrato += "      DET.CaNumContrato\n";

            #endregion

            cConnectionDB.SqlConnectionDB _Connect = new cConnectionDB.SqlConnectionDB("OPCIONES");

            DataTable _DetContratoTable;

            try
            {
                // Definición de la Curva
                mStatus = enumStatus.Loading;
                _Connect.Execute(_QueryLoadDetContrato);
                _DetContratoTable = _Connect.QueryDataTable();
                _DetContratoTable.TableName = "CaDetContrato";

                if (_DetContratoTable.Rows.Count.Equals(0))
                {
                    mStatus = enumStatus.NotFound;
                }
                else
                {
                    mStatus = enumStatus.Already;
                }

            }
            catch (Exception _Error)
            {
                _DetContratoTable = null;
                mStatus = enumStatus.ErrorLoad;
                mError = _Error.StackTrace;
                mStack = _Error.Message;
            }

            return _DetContratoTable;
        }

        private static DataTable LoadFixing(string CaEstado)
        {

            String _QueryLoadFixing = "";

            #region "Query Load Fixing"

            _QueryLoadFixing += " SELECT DISTINCT FIX.CaNumContrato, \n";
            _QueryLoadFixing += " 		FIX.CaNumEstructura, \n";
            _QueryLoadFixing += " 		FIX.CaFixFecha, \n";
            _QueryLoadFixing += " 		FIX.CaFixNumero, \n";
            _QueryLoadFixing += " 		FIX.CaPesoFij, \n";
            _QueryLoadFixing += " 		FIX.CaVolFij, \n";
            _QueryLoadFixing += " 		FIX.CaFijacion \n";
            _QueryLoadFixing += " FROM CAFixing as FIX INNER JOIN CAEncContrato as ENC \n";
            _QueryLoadFixing += " ON FIX.CaNumContrato = ENC.CaNumContrato \n";
            if (!CaEstado.Equals(""))
            {
                _QueryLoadFixing += "  WHERE " + CaEstado + "\n";
            }
            _QueryLoadFixing += " ORDER BY FIX.CaNumContrato\n";

            #endregion

            cConnectionDB.SqlConnectionDB _Connect = new cConnectionDB.SqlConnectionDB("OPCIONES");

            DataTable _FixingTable;

            try
            {
                // Definición de la Curva
                mStatus = enumStatus.Loading;
                _Connect.Execute(_QueryLoadFixing);
                _FixingTable = _Connect.QueryDataTable();
                _FixingTable.TableName = "CaFixing";

                if (_FixingTable.Rows.Count.Equals(0))
                {
                    mStatus = enumStatus.NotFound;
                }
                else
                {
                    mStatus = enumStatus.Already;
                }

            }
            catch (Exception _Error)
            {
                _FixingTable = null;
                mStatus = enumStatus.ErrorLoad;
                mError = _Error.StackTrace;
                mStack = _Error.Message;
            }

            return _FixingTable;
        }

        #endregion

        #region Consultas Historicas

        private static DataTable LoadEncContratoResData(DateTime fechaRespaldo, string CaEstado)
        {

            String _QueryLoadEncRes = "";

            #region "Query Load EncResContrato"

            _QueryLoadEncRes += "SELECT DISTINCT\n";
            _QueryLoadEncRes += "       ENC.caNumContrato\n";
            _QueryLoadEncRes += "     , ENC.CaNumFolio\n";
            _QueryLoadEncRes += "     , ENC.caCodEstructura\n";
            _QueryLoadEncRes += "     , ENC.caCVEstructura\n";
            _QueryLoadEncRes += "     , ENC.caFechaContrato\n";
            _QueryLoadEncRes += "     , ENC.caFecValorizacion\n";
            _QueryLoadEncRes += "     , ENC.CaEstado\n";
            _QueryLoadEncRes += "     , ENC.CaCarteraFinanciera\n";
            _QueryLoadEncRes += "     , ENC.caLibro\n";
            _QueryLoadEncRes += "     , ENC.caCarNormativa\n";
            _QueryLoadEncRes += "     , ENC.caSubCarNormativa\n";
            _QueryLoadEncRes += "     , ENC.caRutCliente\n";
            _QueryLoadEncRes += "     , ENC.caCodigo\n";
            _QueryLoadEncRes += "     , ENC.caTipoContrapartida\n";
            _QueryLoadEncRes += "     , ENC.CaPrimaInicialML\n";
            _QueryLoadEncRes += "     , ENC.CafPagoPrima\n";
            _QueryLoadEncRes += "     , OPCION = CASE WHEN ENC.caCodEstructura = '0' THEN DET.CaCallPut\n";
            _QueryLoadEncRes += "                     ELSE OE.OpcEstDsc\n";
            _QueryLoadEncRes += "                END\n";
            _QueryLoadEncRes += "     , ENC.CaLibro\n";
            _QueryLoadEncRes += "     , ENC.CaCarNormativa\n";
            _QueryLoadEncRes += "     , ENC.CaSubCarNormativa\n";
            _QueryLoadEncRes += "     , ENC.CaCarteraFinanciera\n";
            _QueryLoadEncRes += "     , ENC.CaCodMonPagPrima\n";
            _QueryLoadEncRes += "     , ENC.CafPagoPrima\n";
            _QueryLoadEncRes += "     , ENC.CaGlosa\n";
            _QueryLoadEncRes += "     , ENC.CaTipoTransaccion\n";
            _QueryLoadEncRes += "     , ENC.CaRelacionaPAE\n";
            _QueryLoadEncRes += "  FROM dbo.CaResEncContrato ENC\n";
            _QueryLoadEncRes += "       INNER JOIN dbo.CaResDetContrato    DET  ON DET.CaNumContrato      = ENC.CaNumContrato\n";
            _QueryLoadEncRes += "                                              AND DET.CaDetFechaRespaldo = ENC.CaEncFechaRespaldo\n";
            _QueryLoadEncRes += "       INNER JOIN dbo.OpcionEstructura    OE   ON ENC.caCodEstructura    = OE.OpcEstCod\n";

            _QueryLoadEncRes += string.Format(" WHERE ENC.CaEncFechaRespaldo ='{0}'\n", fechaRespaldo.ToString("yyyyMMdd"));

            if (!CaEstado.Equals(""))
            {
                _QueryLoadEncRes += " AND " + CaEstado + "\n";
            }

            _QueryLoadEncRes += " ORDER BY\n";
            _QueryLoadEncRes += "       ENC.caNumContrato\n";

            #endregion

            cConnectionDB.SqlConnectionDB _Connect = new cConnectionDB.SqlConnectionDB("OPCIONES");


            DataTable _DetContratoTable;

            try
            {
                // Definición de la Curva
                mStatus = enumStatus.Loading;
                _Connect.Execute(_QueryLoadEncRes);
                _DetContratoTable = _Connect.QueryDataTable();
                _DetContratoTable.TableName = "CaEncContrato";

                if (_DetContratoTable.Rows.Count.Equals(0))
                {
                    mStatus = enumStatus.NotFound;
                }
                else
                {
                    mStatus = enumStatus.Already;
                }

            }
            catch (Exception _Error)
            {
                _DetContratoTable = null;
                mStatus = enumStatus.ErrorLoad;
                mError = _Error.StackTrace;
                mStack = _Error.Message;
            }

            return _DetContratoTable;
        }

        private static DataTable LoadDetContratoDataRes(DateTime CaFechaContrato, string CaEstado)
        {

            String _QueryLoadDetContrato = "";

            #region "Query Load DetContrato"

            _QueryLoadDetContrato += "SELECT DISTINCT\n";
            _QueryLoadDetContrato += "       DET.CaNumContrato\n";
            _QueryLoadDetContrato += "     , ENC.CaCodEstructura\n";
            _QueryLoadDetContrato += "     , DET.CaNumEstructura\n";
            _QueryLoadDetContrato += "     , DET.CaVinculacion\n";
            _QueryLoadDetContrato += "     , DET.CaTipoPayOff\n";
            _QueryLoadDetContrato += "     , DET.CaCallPut\n";
            _QueryLoadDetContrato += "     , DET.CaCVOpc\n";
            _QueryLoadDetContrato += "     , DET.CaFechaInicioOpc\n";
            _QueryLoadDetContrato += "     , DET.CaFechaVcto\n";
            _QueryLoadDetContrato += "     , DET.CaStrike\n";
            _QueryLoadDetContrato += "     , DET.CaSpotDet\n";
            _QueryLoadDetContrato += "     , DET.CaMontoMon1\n";
            _QueryLoadDetContrato += "     , DET.CaParStrike\n";
            _QueryLoadDetContrato += "     , DET.CACurveMon1\n";
            _QueryLoadDetContrato += "     , DET.CaCurveMon2\n";
            _QueryLoadDetContrato += "     , DET.CaFormaPagoMon1\n";
            _QueryLoadDetContrato += "     , DET.CaFormaPagoMon2\n";
            _QueryLoadDetContrato += "     , DET.CaMdaCompensacion\n";
            _QueryLoadDetContrato += "     , DET.CaFormaPagoComp\n";
            _QueryLoadDetContrato += "     , DET.CaModalidad\n";
            _QueryLoadDetContrato += "     , ENC.CaTipoTransaccion\n";
            _QueryLoadDetContrato += "     , ENC.CaRelacionaPAE\n";
            _QueryLoadDetContrato += " FROM dbo.CaResDetContrato DET\n";
            _QueryLoadDetContrato += "       INNER JOIN dbo.CaResEncContrato ENC  ON ENC.CaNumContrato      = DET.CaNumContrato\n";
            _QueryLoadDetContrato += "                                           AND ENC.CaEncFechaRespaldo = DET.CaDetFechaRespaldo\n";

            if (!CaEstado.Equals(""))
            {
                _QueryLoadDetContrato += string.Format("                                                      AND {0}\n", CaEstado);
            }

            _QueryLoadDetContrato += " WHERE DET.CaDetFechaRespaldo = '" + CaFechaContrato.ToString("yyyyMMdd") + "' \n";
            _QueryLoadDetContrato += " ORDER BY\n";
            _QueryLoadDetContrato += "       CaNumContrato\n";

            #endregion

            cConnectionDB.SqlConnectionDB _Connect = new cConnectionDB.SqlConnectionDB("OPCIONES");


            DataTable _DetContratoTable;

            try
            {
                // Definición de la Curva
                mStatus = enumStatus.Loading;
                _Connect.Execute(_QueryLoadDetContrato);
                _DetContratoTable = _Connect.QueryDataTable();
                _DetContratoTable.TableName = "CaDetContrato";

                if (_DetContratoTable.Rows.Count.Equals(0))
                {
                    mStatus = enumStatus.NotFound;
                }
                else
                {
                    mStatus = enumStatus.Already;
                }

            }
            catch (Exception _Error)
            {
                _DetContratoTable = null;
                mStatus = enumStatus.ErrorLoad;
                mError = _Error.StackTrace;
                mStack = _Error.Message;
            }

            return _DetContratoTable;
        }

        private static DataTable LoadFixingRes(DateTime CaFechaContrato, string CaEstado)
        {

            String _QueryLoadFixing = "";

            #region "Query Load Fixing"

            _QueryLoadFixing += "SELECT FIX.CaNumContrato \n";
            _QueryLoadFixing += "     ,FIX.CaNumEstructura \n";
            _QueryLoadFixing += "     , FIX.CaFixFecha \n";
            _QueryLoadFixing += "     , FIX.CaFixNumero \n";
            _QueryLoadFixing += "     , FIX.CaPesoFij \n";
            _QueryLoadFixing += "     , FIX.CaVolFij \n";
            _QueryLoadFixing += "     , FIX.CaFijacion \n";
            _QueryLoadFixing += "  FROM CAResFixing FIX \n";
            _QueryLoadFixing += "       INNER JOIN CaResEncContrato ENC  ON ENC.CaEncFechaRespaldo = '" + CaFechaContrato.ToString("yyyyMMdd") + "' \n";
            _QueryLoadFixing += "                                       AND " + CaEstado + " \n";
            _QueryLoadFixing += "                                       AND ENC.CaNumContrato      = FIX.CaNumContrato \n";
            _QueryLoadFixing += " WHERE FIX.CaFixingFechaRespaldo = '" + CaFechaContrato.ToString("yyyyMMdd") + "' \n";
            _QueryLoadFixing += " ORDER BY FIX.CaNumContrato\n";

            #endregion

            cConnectionDB.SqlConnectionDB _Connect = new cConnectionDB.SqlConnectionDB("OPCIONES");

            DataTable _FixingTable;

            try
            {
                // Definición de la Curva
                mStatus = enumStatus.Loading;
                _Connect.Execute(_QueryLoadFixing);
                _FixingTable = _Connect.QueryDataTable();
                _FixingTable.TableName = "CaFixing";

                if (_FixingTable.Rows.Count.Equals(0))
                {
                    mStatus = enumStatus.NotFound;
                }
                else
                {
                    mStatus = enumStatus.Already;
                }

            }
            catch (Exception _Error)
            {
                _FixingTable = null;
                mStatus = enumStatus.ErrorLoad;
                mError = _Error.StackTrace;
                mStack = _Error.Message;
            }

            return _FixingTable;
        }

        #endregion

        private static DataTable SpotDelta(DateTime fechaVal)
        {

            String _QuerySpotDelta = "";

            _QuerySpotDelta += "declare @Date DATETIME\n";
            _QuerySpotDelta += "SELECT @Date = '" + fechaVal.ToString("yyyyMMdd")+ "'\n";
            _QuerySpotDelta += "SELECT Moneda\n";
            _QuerySpotDelta += "     , 'Origen'= nemo\n";
            _QuerySpotDelta += "     , Saldo_Inicial\n";
            _QuerySpotDelta += "     , OperadoDia\n";
            _QuerySpotDelta += "     , Saldo\n";
            _QuerySpotDelta += "  FROM dbo.tbl_resumen WITH(NOLOCK)\n";
            _QuerySpotDelta += "       INNER JOIN bacparamsuda.dbo.tabla_general_detalle WITH(NOLOCK)  ON tbcateg      = 2700\n";
            _QuerySpotDelta += "                                                                      AND CodigoOrigen = tbcodigo1\n";
            _QuerySpotDelta += " WHERE fecha        = @Date\n";
            _QuerySpotDelta += "   AND CodigoOrigen = 7\n";

            cConnectionDB.SqlConnectionDB _Connect = new cConnectionDB.SqlConnectionDB("BACCAMSUDA");

            DataTable _DetContratoTable;

            try
            {
                // Definición de la Curva
                mStatus = enumStatus.Loading;
                _Connect.Execute(_QuerySpotDelta);
                _DetContratoTable = _Connect.QueryDataTable();
                _DetContratoTable.TableName = "SpotDelta";

                if (_DetContratoTable.Rows.Count.Equals(0))
                {
                    mStatus = enumStatus.NotFound;
                }
                else
                {
                    mStatus = enumStatus.Already;
                }

            }
            catch (Exception _Error)
            {
                _DetContratoTable = null;
                mStatus = enumStatus.ErrorLoad;
                mError = _Error.StackTrace;
                mStack = _Error.Message;
            }

            return _DetContratoTable;
        }

        private static DataTable ForwardDelta(DateTime fechaVal)
        {

            String _QueryFwdDelta = "";

            #region "Query Load DetContrato"

            _QueryFwdDelta += "SET NOCOUNT ON \n";

            _QueryFwdDelta += "DECLARE @DateProcess         DATETIME \n";
            _QueryFwdDelta += "DECLARE @DateSystem          DATETIME \n";
            _QueryFwdDelta += "DECLARE @MontoActivo         FLOAT \n";
            _QueryFwdDelta += "DECLARE @MontoPasivo         FLOAT \n";

            _QueryFwdDelta += "SET @DateProcess = '" + fechaVal.ToString("yyyyMMdd") + "' \n";
            _QueryFwdDelta += "SELECT @DateSystem  = acfecproc FROM MFAC WITH(NOLOCK)\n";

            _QueryFwdDelta += "IF (@DateProcess = @DateSystem) \n";
            _QueryFwdDelta += "BEGIN \n";
            _QueryFwdDelta += "    SELECT @MontoActivo = SUM(camtomon1 / ( 1 + CaTasaSinteticaM1 * DATEDIFF( DAY, @DateProcess, cafecEfectiva ) / 360 )) \n";
            _QueryFwdDelta += "      FROM dbo.MFCA WITH(NOLOCK)\n";
            _QueryFwdDelta += "     WHERE CACODMON1       = 13\n";
            _QueryFwdDelta += "       AND CATIPOPER       = 'C'\n";
            _QueryFwdDelta += "       AND cafecEfectiva   > @DateProcess\n";
            _QueryFwdDelta += "       AND CACODPOS1      <> 10\n";
            _QueryFwdDelta += "       AND cacodcart       = 8\n";

            _QueryFwdDelta += "    SELECT @MontoPasivo    = SUM(camtomon1 / ( 1 + CaTasaSinteticaM1 * DATEDIFF( DAY, @DateProcess, cafecEfectiva ) / 360 )) \n";
            _QueryFwdDelta += "      FROM dbo.MFCA WITH(NOLOCK)\n";
            _QueryFwdDelta += "     WHERE CACODMON1       = 13 \n";
            _QueryFwdDelta += "       AND CATIPOPER       = 'V' \n";
            _QueryFwdDelta += "       AND cafecEfectiva   > @DateProcess \n";
            _QueryFwdDelta += "       AND CACODPOS1      <> 10 \n";
            _QueryFwdDelta += "       AND cacodcart       = 8\n";

            _QueryFwdDelta += "END ELSE \n";
            _QueryFwdDelta += "BEGIN \n";
            _QueryFwdDelta += "    SELECT @MontoActivo    = SUM(camtomon1 / ( 1 + CaTasaSinteticaM1 * DATEDIFF( DAY, @DateProcess, cafecEfectiva ) / 360 )) \n";
            _QueryFwdDelta += "      FROM dbo.MFCARES WITH(NOLOCK)\n";
            _QueryFwdDelta += "     WHERE CACODMON1       = 13 \n";
            _QueryFwdDelta += "       AND CATIPOPER       = 'C' \n";
            _QueryFwdDelta += "       AND CaFechaProceso  = @DateProcess \n";
            _QueryFwdDelta += "       AND cafecEfectiva   > @DateProcess \n";
            _QueryFwdDelta += "       AND CACODPOS1      <> 10 \n";
            _QueryFwdDelta += "       AND cacodcart       = 8\n";

            _QueryFwdDelta += "    SELECT @MontoPasivo    = SUM(camtomon1 / ( 1 + CaTasaSinteticaM1 * DATEDIFF( DAY, @DateProcess, cafecEfectiva ) / 360 )) \n";
            _QueryFwdDelta += "      FROM dbo.MFCARES WITH(NOLOCK)\n";
            _QueryFwdDelta += "     WHERE CACODMON1       = 13 \n";
            _QueryFwdDelta += "       AND CATIPOPER       = 'V' \n";
            _QueryFwdDelta += "       AND CaFechaProceso  = @DateProcess \n";
            _QueryFwdDelta += "       AND cafecEfectiva   > @DateProcess \n";
            _QueryFwdDelta += "       AND CACODPOS1      <> 10 \n";
            _QueryFwdDelta += "       AND cacodcart       = 8\n";

            _QueryFwdDelta += "END \n";

            _QueryFwdDelta += "SET @MontoActivo = ISNULL( @MontoActivo, 0 ) \n";
            _QueryFwdDelta += "SET @MontoPasivo = ISNULL( @MontoPasivo, 0 ) \n";

            _QueryFwdDelta += "SELECT 'MontoActivo' = @MontoActivo \n";
            _QueryFwdDelta += "     , 'MontoPasivo' = @MontoPasivo \n";
            _QueryFwdDelta += "     , 'Neto'        = @MontoActivo - @MontoPasivo \n";

            _QueryFwdDelta += "SET NOCOUNT OFF";

            #endregion

            cConnectionDB.SqlConnectionDB _Connect = new cConnectionDB.SqlConnectionDB("BACFWDSUDA");

            DataTable _DetContratoTable;

            try
            {
                // Definición de la Curva
                mStatus = enumStatus.Loading;
                _Connect.Execute(_QueryFwdDelta);
                _DetContratoTable = _Connect.QueryDataTable();
                _DetContratoTable.TableName = "ForwardDelta";

                if (_DetContratoTable.Rows.Count.Equals(0))
                {
                    mStatus = enumStatus.NotFound;
                }
                else
                {
                    mStatus = enumStatus.Already;
                }

            }
            catch (Exception _Error)
            {
                _DetContratoTable = null;
                mStatus = enumStatus.ErrorLoad;
                mError = _Error.StackTrace;
                mStack = _Error.Message;
            }

            return _DetContratoTable;
        }

    }
}
