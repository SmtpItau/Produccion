using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;
using System.Xml.Linq;
using Turing2009Connect;
using Turing2009Data.Definitions;
using Turing2009Definitions.Definitions;
using Turing2009Definitions.Struct;

namespace Turing2009Data.Pricing.Swap
{

    public class PricingPortfolio : InterfaceQuery
    {

        public DataTable LoadHead(long id)
        {

            #region "Definición de Variables"

            Turing2009Connect.Connect _Connect;
            DataTable _DTPricingSwapHead;
            string _PricingSwapHead;

            #endregion

            #region "Inicialización de Variables"

            _Connect = new Turing2009Connect.Connect();
            _Connect.QueryType = enumQueryType.Load;

            _DTPricingSwapHead = new DataTable();

            _PricingSwapHead = "";

            #endregion

            #region "Query"

            _PricingSwapHead += "SET NOCOUNT ON\n\n";

            _PricingSwapHead += "SELECT 'ID'                           = CMP.numero_operacion\n";
            _PricingSwapHead += "     , 'EntryDate'                    = CMP.fecha_cierre\n";
            _PricingSwapHead += "     , 'PricingDate'                  = SG.fechaproc\n";
            _PricingSwapHead += "     , 'CurrencyPrimarySystem'        = CMP.compra_moneda\n";
            _PricingSwapHead += "     , 'CurrencyPrimary'              = 0\n";
            _PricingSwapHead += "     , 'CurrencyPrimaryMNemonics'     = CONVERT( VARCHAR(20), '' )\n";
            _PricingSwapHead += "     , 'RatePrimarySystem'            = CMP.compra_codigo_tasa\n";
            _PricingSwapHead += "     , 'RatePrimary'                  = 0\n";
            _PricingSwapHead += "     , 'RatePrimaryMNemonics'         = CONVERT( VARCHAR(20), '' )\n";
            _PricingSwapHead += "     , 'AmountPrimary'                = CMP.compra_capital\n";
            _PricingSwapHead += "     , 'ParityPrimary'                = 1.0\n";
            _PricingSwapHead += "     , 'ExchangeRatePrimary'          = 1.0\n";
            _PricingSwapHead += "     , 'MarkToMarketPrimaryUM'        = 0.0\n";
            _PricingSwapHead += "     , 'MarkToMarketPrimaryCLP'       = 0.0\n";
            _PricingSwapHead += "     , 'CurrencySecondarySystem'      = VTA.venta_moneda\n";
            _PricingSwapHead += "     , 'CurrencySecondary'            = 0\n";
            _PricingSwapHead += "     , 'CurrencySecondaryMNemonics'   = CONVERT( VARCHAR(20), '' )\n";
            _PricingSwapHead += "     , 'RateSecondarySystem'          = VTA.venta_codigo_tasa\n";
            _PricingSwapHead += "     , 'RateSecondary'                = 0\n";
            _PricingSwapHead += "     , 'RateSecondaryMNemonics'       = CONVERT( VARCHAR(20), '' )\n";
            _PricingSwapHead += "     , 'AmountSecundary'              = VTA.venta_capital\n";
            _PricingSwapHead += "     , 'ParitySecundary'              = 1.0\n";
            _PricingSwapHead += "     , 'ExchangeRateSecundary'        = 1.0\n";
            _PricingSwapHead += "     , 'MarkToMarketSecundaryUM'      = 0.0\n";
            _PricingSwapHead += "     , 'MarkToMarketSecundaryCLP'     = 0.0\n";
            _PricingSwapHead += "     , 'Parity'                       = VTA.venta_capital / CMP.compra_capital\n";
            _PricingSwapHead += "     , 'Payment'                      = 0.0\n";
            _PricingSwapHead += "     , 'MarkToMarketNet'              = 0.0\n";
            _PricingSwapHead += "     , 'BPV'                          = 0.0\n";
            _PricingSwapHead += "     , 'MarkToMarketDistributionNet'  = 0.0\n";
            _PricingSwapHead += "     , 'ExchangeNotionalStarting'     = ' '\n";
            _PricingSwapHead += "     , 'ExchangeNotionalIntermediate' = ' '\n";
            _PricingSwapHead += "     , 'ExchangeNotionalEnd'          = ' '\n";
            _PricingSwapHead += "     , 'SetPricing'                   = 1\n";
            _PricingSwapHead += "     , 'Comment'                      = CONVERT( VARCHAR(20), '' )\n";
            _PricingSwapHead += "     , 'UserCreator'                  = GetDate()\n";
            _PricingSwapHead += "     , 'UserNick'                     = 0\n";
            _PricingSwapHead += "     , 'UserName'                     = CONVERT( VARCHAR(20), '' )\n";
            _PricingSwapHead += "     , 'Status'                       = 0\n";
            _PricingSwapHead += "  FROM dbo.Cartera                CMP\n";
            _PricingSwapHead += "      INNER JOIN Cartera          VTA   ON CMP.Numero_Operacion   = VTA.Numero_Operacion\n";
            _PricingSwapHead += "                                       AND VTA.estado                   <> 'C'\n";
            _PricingSwapHead += "                                       AND VTA.estado_flujo              = 1\n";
            _PricingSwapHead += "                                       AND VTA.tipo_flujo                = 2\n";
            _PricingSwapHead += "                  INNER JOIN dbo.SwapGeneral  SG    ON 1 = 1\n";
            _PricingSwapHead += " WHERE CMP.numero_operacion          = {0}\n";
            _PricingSwapHead += "   AND CMP.estado                   <> 'C'\n";
            _PricingSwapHead += "   AND CMP.estado_flujo              = 1\n";
            _PricingSwapHead += "   AND CMP.tipo_flujo                = 1\n\n";

            _PricingSwapHead += "SET NOCOUNT OFF\n\n";

            _PricingSwapHead = string.Format(_PricingSwapHead, id.ToString());

            #endregion

            #region "Ejecución del Query"

            try
            {
                _Connect.Execute("BACSWAPSUDA", _PricingSwapHead, "PricingSwapHead");
                _DTPricingSwapHead = _Connect.Table;
            }
            catch (Exception _Error)
            {
                _DTPricingSwapHead = null;
                Error = new StructError(_Error);
                Status = enumStatus.ErrorExecuting;
            }
            finally
            {
                _Connect.Close();
                _Connect = null;
            }

            #endregion

            return _DTPricingSwapHead;

        }

        public DataTable LoadLeg(long id)
        {

            #region "Definición de Variables"

            Turing2009Connect.Connect _Connect;
            DataTable _DTPricingSwapLeg;
            string _PricingSwapLeg;

            #endregion

            #region "Inicialización de Variables"

            _Connect = new Turing2009Connect.Connect();
            _Connect.QueryType = enumQueryType.Load;

            _DTPricingSwapLeg = new DataTable();

            _PricingSwapLeg = "";

            #endregion

            #region "Query"

            _PricingSwapLeg += "SET NOCOUNT ON\n\n";

            _PricingSwapLeg += "SELECT 'ID'                          = tipo_flujo\n";
            _PricingSwapLeg += "     , 'DataID'                      = numero_operacion\n";
            _PricingSwapLeg += "     , 'LegID'                       = tipo_flujo\n";
            _PricingSwapLeg += "     , 'CurrencyID'                  = compra_moneda\n";
            _PricingSwapLeg += "     , 'Amount'                      = compra_capital\n";
            _PricingSwapLeg += "     , 'Parity'                      = 1\n";
            _PricingSwapLeg += "     , 'ExchangeRate'                = 1\n";
            _PricingSwapLeg += "     , 'StartinDdate'                = fecha_inicio\n";
            _PricingSwapLeg += "     , 'ExpiryDate'                  = fecha_termino\n";
            _PricingSwapLeg += "     , 'Convention'                  = compra_base\n";
            _PricingSwapLeg += "     , 'RateID'                      = compra_codigo_tasa\n";
            _PricingSwapLeg += "     , 'Factor'                      = 1\n";
            _PricingSwapLeg += "     , 'Rate'                        = compra_valor_tasa\n";
            _PricingSwapLeg += "     , 'Spread'                      = compra_spread\n";
            _PricingSwapLeg += "     , 'DevelopmentTable'            = 3\n";
            _PricingSwapLeg += "     , 'IntervaleType'               = compra_codamo_interes\n";
            _PricingSwapLeg += "     , 'BrokenPeriod'                = 1\n";
            _PricingSwapLeg += "     , 'PaymentCurrency'             = compra_moneda\n";
            _PricingSwapLeg += "     , 'MarkToMarketUM'              = 0\n";
            _PricingSwapLeg += "     , 'MarkToMarketCLP'             = 0\n";
            _PricingSwapLeg += "     , 'SpreadDistribution'          = 0\n";
            _PricingSwapLeg += "     , 'MarkToMarketDistributionUM'  = 0\n";
            _PricingSwapLeg += "     , 'MarkToMarketDistributionCLP' = 0\n";
            _PricingSwapLeg += "     , 'BackwardnessStartNumber'     = 0\n";
            _PricingSwapLeg += "     , 'BackwardnessStartType'       = 0\n";
            _PricingSwapLeg += "     , 'IntervalCalendarSantiago'    = FeriadoFlujoChile\n";
            _PricingSwapLeg += "     , 'IntervalCalendarNewYork'     = FeriadoFlujoEEUU\n";
            _PricingSwapLeg += "     , 'IntervalCalendarLondres'     = FeriadoFlujoEnglan\n";
            _PricingSwapLeg += "     , 'PaymentNumber'               = 0\n";
            _PricingSwapLeg += "     , 'PaymentType'                 = 0\n";
            _PricingSwapLeg += "     , 'PaymentDate'                 = 0\n";
            _PricingSwapLeg += "     , 'PaymentCalendarSantiago'     = FeriadoLiquiChile\n";
            _PricingSwapLeg += "     , 'PaymentCalendarNewYork'      = FeriadoLiquiEEUU\n";
            _PricingSwapLeg += "     , 'PaymentCalendarLondres'      = FeriadoLiquiEnglan\n";
            _PricingSwapLeg += "     , 'FixingNumber'                = 0\n";
            _PricingSwapLeg += "     , 'FixingType'                  = 0\n";
            _PricingSwapLeg += "     , 'FixingDate'                  = 0\n";
            _PricingSwapLeg += "     , 'FixingCalendarSantiago'      = FeriadoLiquiChile\n";
            _PricingSwapLeg += "     , 'FixingCalendarNewYork'       = FeriadoLiquiEEUU\n";
            _PricingSwapLeg += "     , 'FixingCalendarLondres'       = FeriadoLiquiEnglan\n";
            _PricingSwapLeg += "     , 'ConventionCalendar'          = 5\n";
            _PricingSwapLeg += "     , 'ResetDay'                    = DiasReset\n";
            _PricingSwapLeg += "     , 'YieldProject'                = CONVERT( VARCHAR(20), '' )\n";
            _PricingSwapLeg += "     , 'YieldDiscount'               = CONVERT( VARCHAR(20), '' )\n";
            _PricingSwapLeg += "     , 'TermBenchMark'               = 0\n";
            _PricingSwapLeg += "  FROM dbo.Cartera\n";
            _PricingSwapLeg += " WHERE numero_operacion          = {0}\n";
            _PricingSwapLeg += "   AND estado                   <> 'C'\n";
            _PricingSwapLeg += "   AND estado_flujo              = 1\n";
            _PricingSwapLeg += "   AND tipo_flujo                = 1\n";
            _PricingSwapLeg += "UNION\n";
            _PricingSwapLeg += "SELECT 'ID'                          = tipo_flujo\n";
            _PricingSwapLeg += "     , 'DataID'                      = numero_operacion\n";
            _PricingSwapLeg += "     , 'LegID'                       = tipo_flujo\n";
            _PricingSwapLeg += "     , 'CurrencyID'                  = venta_moneda\n";
            _PricingSwapLeg += "     , 'Amount'                      = venta_capital\n";
            _PricingSwapLeg += "     , 'Parity'                      = 1\n";
            _PricingSwapLeg += "     , 'ExchangeRate'                = 1\n";
            _PricingSwapLeg += "     , 'StartinDdate'                = fecha_inicio\n";
            _PricingSwapLeg += "     , 'ExpiryDate'                  = fecha_termino\n";
            _PricingSwapLeg += "     , 'Convention'                  = venta_base\n";
            _PricingSwapLeg += "     , 'RateID'                      = venta_codigo_tasa\n";
            _PricingSwapLeg += "     , 'Factor'                      = 1\n";
            _PricingSwapLeg += "     , 'Rate'                        = venta_valor_tasa\n";
            _PricingSwapLeg += "     , 'Spread'                      = venta_spread\n";
            _PricingSwapLeg += "     , 'DevelopmentTable'            = 3\n";
            _PricingSwapLeg += "     , 'IntervaleType'               = venta_codamo_interes\n";
            _PricingSwapLeg += "     , 'BrokenPeriod'                = 1\n";
            _PricingSwapLeg += "     , 'PaymentCurrency'             = venta_moneda\n";
            _PricingSwapLeg += "     , 'MarkToMarketUM'              = 0\n";
            _PricingSwapLeg += "     , 'MarkToMarketCLP'             = 0\n";
            _PricingSwapLeg += "     , 'SpreadDistribution'          = 0\n";
            _PricingSwapLeg += "     , 'MarkToMarketDistributionUM'  = 0\n";
            _PricingSwapLeg += "     , 'MarkToMarketDistributionCLP' = 0\n";
            _PricingSwapLeg += "     , 'BackwardnessStartNumber'     = 0\n";
            _PricingSwapLeg += "     , 'BackwardnessStartType'       = 0\n";
            _PricingSwapLeg += "     , 'IntervalCalendarSantiago'    = FeriadoFlujoChile\n";
            _PricingSwapLeg += "     , 'IntervalCalendarNewYork'     = FeriadoFlujoEEUU\n";
            _PricingSwapLeg += "     , 'IntervalCalendarLondres'     = FeriadoFlujoEnglan\n";
            _PricingSwapLeg += "     , 'PaymentNumber'               = 0\n";
            _PricingSwapLeg += "     , 'PaymentType'                 = 0\n";
            _PricingSwapLeg += "     , 'PaymentDate'                 = 0\n";
            _PricingSwapLeg += "     , 'PaymentCalendarSantiago'     = FeriadoLiquiChile\n";
            _PricingSwapLeg += "     , 'PaymentCalendarNewYork'      = FeriadoLiquiEEUU\n";
            _PricingSwapLeg += "     , 'PaymentCalendarLondres'      = FeriadoLiquiEnglan\n";
            _PricingSwapLeg += "     , 'FixingNumber'                = 0\n";
            _PricingSwapLeg += "     , 'FixingType'                  = 0\n";
            _PricingSwapLeg += "     , 'FixingDate'                  = 0\n";
            _PricingSwapLeg += "     , 'FixingCalendarSantiago'      = FeriadoLiquiChile\n";
            _PricingSwapLeg += "     , 'FixingCalendarNewYork'       = FeriadoLiquiEEUU\n";
            _PricingSwapLeg += "     , 'FixingCalendarLondres'       = FeriadoLiquiEnglan\n";
            _PricingSwapLeg += "     , 'ConventionCalendar'          = 5\n";
            _PricingSwapLeg += "     , 'ResetDay'                    = DiasReset\n";
            _PricingSwapLeg += "     , 'YieldProject'                = CONVERT( VARCHAR(20), '' )\n";
            _PricingSwapLeg += "     , 'YieldDiscount'               = CONVERT( VARCHAR(20), '' )\n";
            _PricingSwapLeg += "     , 'TermBenchMark'               = 0\n";
            _PricingSwapLeg += "  FROM dbo.Cartera\n";
            _PricingSwapLeg += " WHERE numero_operacion          = {0}\n";
            _PricingSwapLeg += "   AND estado                   <> 'C'\n";
            _PricingSwapLeg += "   AND estado_flujo              = 1\n";
            _PricingSwapLeg += "   AND tipo_flujo                = 2\n";
            _PricingSwapLeg += "ORDER BY tipo_flujo\n\n";

            _PricingSwapLeg += "SET NOCOUNT OFF\n";

            _PricingSwapLeg = string.Format(_PricingSwapLeg, id);

            #endregion

            #region "Ejecución del Query"

            try
            {
                _Connect.Execute("BACSWAPSUDA", _PricingSwapLeg, "PricingSwapLeg");
                _DTPricingSwapLeg = _Connect.Table;
            }
            catch (Exception _Error)
            {
                _DTPricingSwapLeg = null;
                Error = new StructError(_Error);
                Status = enumStatus.ErrorExecuting;
            }
            finally
            {
                _Connect.Close();
                _Connect = null;
            }

            #endregion

            return _DTPricingSwapLeg;

        }

        public DataTable LoadFlow(long id)
        {

            #region "Definición de Variables"

            Turing2009Connect.Connect _Connect;
            DataTable _DTPricingSwapFlow;
            string _PricingSwapFlow;

            #endregion

            #region "Inicialización de Variables"

            _Connect = new Turing2009Connect.Connect();
            _Connect.QueryType = enumQueryType.Load;

            _DTPricingSwapFlow = new DataTable();

            _PricingSwapFlow = "";

            #endregion

            #region "Comment"

            #region "1"
            //SET NOCOUNT ON

            //DECLARE @CreateTransaction DATETIME

            //SELECT 'ID'                        = numero_operacion * 100 + numero_flujo
            //     , 'DataID'                    = numero_operacion
            //     , 'LegID'                     = tipo_flujo
            //     , 'FlowID'                    = numero_flujo
            //     , 'FixingDate'                = fecha_fijacion_tasa
            //     , 'StartingDate'              = fecha_inicio_flujo
            //     , 'ExpiryDate'                = fecha_vence_flujo
            //     , 'PaymentDate'               = FechaLiquidacion
            //     , 'Balance'                   = case when tipo_flujo = 1 then compra_saldo else venta_saldo end
            //     , 'ExchangePrincipal'         = IntercPrinc
            //     , 'PostPounding'              = ' '
            //     , 'Rate'                      = case when tipo_flujo = 1 then compra_valor_tasa else venta_valor_tasa end
            //     , 'Spread'                    = case when tipo_flujo = 1 then compra_spread else venta_spread end
            //     , 'AmortizationFlow'          = case when tipo_flujo = 1 then compra_amortiza else venta_amortiza end
            //     , 'InterestFlow'              = case when tipo_flujo = 1 then compra_interes else venta_interes end
            //     , 'AditionalFlow'             = case when tipo_flujo = 1 then Compra_Flujo_Adicional else venta_Flujo_Adicional end
            //     , 'TotalFlow'                 = case when tipo_flujo = 1 then compra_amortiza + Compra_Flujo_Adicional + Compra_Flujo_Adicional 
            //                                                              else venta_amortiza + venta_interes + venta_Flujo_Adicional 
            //                                     end
            //     , 'RateDiscount'              = 0
            //     , 'WellFactor'                = 0
            //     , 'AmortizationPresentValue'  = 0
            //     , 'InterestPresentValue'      = 0
            //     , 'AditionalFlowPresentValue' = 0
            //     , 'PresentValue'              = 0
            //  FROM dbo.Cartera
            // WHERE numero_operacion            = 81
            // ORDER BY
            //       tipo_flujo
            //     , numero_flujo

            //SET NOCOUNT OFF
            #endregion

            #region "2"
            //_PricingSwapFlow += "SET NOCOUNT ON\n\n";

            //_PricingSwapFlow += "DECLARE @CreateTransaction DATETIME\n\n";

            //_PricingSwapFlow += "SELECT @CreateTransaction = fecha_cierre\n";
            //_PricingSwapFlow += "  FROM Cartera\n";
            //_PricingSwapFlow += " WHERE Numero_Operacion   = {0}\n";
            //_PricingSwapFlow += "   AND estado                   <> 'C'\n";
            //_PricingSwapFlow += "   AND estado_flujo              = 1\n";
            //_PricingSwapFlow += "   AND tipo_flujo                = 1\n\n";

            //_PricingSwapFlow += "SELECT 'ID'                        = numero_operacion * 100 + numero_flujo\n";
            //_PricingSwapFlow += "     , 'DataID'                    = numero_operacion\n";
            //_PricingSwapFlow += "     , 'LegID'                     = tipo_flujo\n";
            //_PricingSwapFlow += "     , 'FlowID'                    = numero_flujo\n";
            //_PricingSwapFlow += "     , 'FixingDate'                = fecha_fijacion_tasa\n";
            //_PricingSwapFlow += "     , 'StartingDate'              = fecha_inicio_flujo\n";
            //_PricingSwapFlow += "     , 'ExpiryDate'                = fecha_vence_flujo\n";
            //_PricingSwapFlow += "     , 'PaymentDate'               = FechaLiquidacion\n";
            //_PricingSwapFlow += "     , 'Balance'                   = case when tipo_flujo = 1 then compra_saldo else venta_saldo end\n";
            //_PricingSwapFlow += "     , 'ExchangePrincipal'         = IntercPrinc\n";
            //_PricingSwapFlow += "     , 'PostPounding'              = ' '\n";
            //_PricingSwapFlow += "     , 'Rate'                      = case when tipo_flujo = 1 then compra_valor_tasa else venta_valor_tasa end\n";
            //_PricingSwapFlow += "     , 'Spread'                    = case when tipo_flujo = 1 then compra_spread else venta_spread end\n";
            //_PricingSwapFlow += "     , 'AmortizationFlow'          = case when tipo_flujo = 1 then compra_amortiza else venta_amortiza end\n";
            //_PricingSwapFlow += "     , 'InterestFlow'              = case when tipo_flujo = 1 then compra_interes else venta_interes end\n";
            //_PricingSwapFlow += "     , 'AditionalFlow'             = case when tipo_flujo = 1 then Compra_Flujo_Adicional else venta_Flujo_Adicional end\n";
            //_PricingSwapFlow += "     , 'TotalFlow'                 = case when tipo_flujo = 1 then compra_amortiza + Compra_Flujo_Adicional + Compra_Flujo_Adicional\n";
            //_PricingSwapFlow += "                                                              else venta_amortiza + venta_interes + venta_Flujo_Adicional\n";
            //_PricingSwapFlow += "                                     end\n";
            //_PricingSwapFlow += "     , 'RateDiscount'              = 0\n";
            //_PricingSwapFlow += "     , 'WellFactor'                = 0\n";
            //_PricingSwapFlow += "     , 'AmortizationPresentValue'  = 0\n";
            //_PricingSwapFlow += "     , 'InterestPresentValue'      = 0\n";
            //_PricingSwapFlow += "     , 'AditionalFlowPresentValue' = 0\n";
            //_PricingSwapFlow += "     , 'PresentValue'              = 0\n";
            //_PricingSwapFlow += "  FROM dbo.CarteraRes\n";
            //_PricingSwapFlow += " WHERE Fecha_Proceso               = @CreateTransaction\n";
            //_PricingSwapFlow += "   AND numero_operacion            = {0}\n";
            //_PricingSwapFlow += " ORDER BY\n";
            //_PricingSwapFlow += "       tipo_flujo\n";
            //_PricingSwapFlow += "     , numero_flujo\n\n";

            //_PricingSwapFlow += "SET NOCOUNT OFF\n";
            #endregion

            #endregion

            #region "Query"

            _PricingSwapFlow += "SET NOCOUNT ON\n\n";

            _PricingSwapFlow += "SELECT 'ID'                        = numero_operacion * 100 + numero_flujo\n";
            _PricingSwapFlow += "     , 'DataID'                    = numero_operacion\n";
            _PricingSwapFlow += "     , 'LegID'                     = tipo_flujo\n";
            _PricingSwapFlow += "     , 'FlowID'                    = numero_flujo\n";
            _PricingSwapFlow += "     , 'FixingDate'                = fecha_fijacion_tasa\n";
            _PricingSwapFlow += "     , 'StartingDate'              = fecha_inicio_flujo\n";
            _PricingSwapFlow += "     , 'ExpiryDate'                = fecha_vence_flujo\n";
            _PricingSwapFlow += "     , 'PaymentDate'               = FechaLiquidacion\n";
            _PricingSwapFlow += "     , 'Balance'                   = CASE WHEN tipo_flujo = 1 THEN compra_saldo\n";
            _PricingSwapFlow += "                                                              ELSE venta_saldo\n";
            _PricingSwapFlow += "                                     END\n";
            _PricingSwapFlow += "     , 'ExchangePrincipal'         = CASE WHEN IntercPrinc  = 0 THEN ' '\n";
            _PricingSwapFlow += "                                                                ELSE 'X'\n";
            _PricingSwapFlow += "                                     END\n";
            _PricingSwapFlow += "     , 'PostPounding'              = ' '\n";
            _PricingSwapFlow += "     , 'Rate'                      = CASE WHEN tipo_flujo = 1 THEN compra_valor_tasa\n";
            _PricingSwapFlow += "                                                              ELSE venta_valor_tasa\n";
            _PricingSwapFlow += "                                     END\n";
            _PricingSwapFlow += "     , 'Spread'                    = CASE WHEN tipo_flujo = 1 THEN compra_spread\n";
            _PricingSwapFlow += "                                                              ELSE venta_spread\n";
            _PricingSwapFlow += "                                     END\n";
            _PricingSwapFlow += "     , 'AmortizationFlow'          = CASE WHEN tipo_flujo = 1 THEN compra_amortiza\n";
            _PricingSwapFlow += "                                                              ELSE venta_amortiza\n";
            _PricingSwapFlow += "                                     END\n";
            _PricingSwapFlow += "     , 'InterestFlow'              = CASE WHEN tipo_flujo = 1 THEN compra_interes\n";
            _PricingSwapFlow += "                                                              ELSE venta_interes\n";
            _PricingSwapFlow += "                                     END\n";
            _PricingSwapFlow += "     , 'AditionalFlow'             = CASE WHEN tipo_flujo = 1 THEN Compra_Flujo_Adicional\n";
            _PricingSwapFlow += "                                                              ELSE venta_Flujo_Adicional\n";
            _PricingSwapFlow += "                                     END\n";
            _PricingSwapFlow += "     , 'TotalFlow'                 = CASE WHEN tipo_flujo = 1 THEN compra_amortiza + compra_interes + Compra_Flujo_Adicional\n";
            _PricingSwapFlow += "                                                              ELSE venta_amortiza  + venta_interes  + venta_Flujo_Adicional\n";
            _PricingSwapFlow += "                                     END\n";
            _PricingSwapFlow += "     , 'RateDiscount'              = 0\n";
            _PricingSwapFlow += "     , 'WellFactor'                = 0\n";
            _PricingSwapFlow += "     , 'AmortizationPresentValue'  = 0\n";
            _PricingSwapFlow += "     , 'InterestPresentValue'      = 0\n";
            _PricingSwapFlow += "     , 'AditionalFlowPresentValue' = 0\n";
            _PricingSwapFlow += "     , 'PresentValue'              = 0\n";
            _PricingSwapFlow += "  FROM dbo.Cartera\n";
            _PricingSwapFlow += " WHERE numero_operacion            = {0}\n";
            _PricingSwapFlow += " ORDER BY\n";
            _PricingSwapFlow += "       tipo_flujo\n";
            _PricingSwapFlow += "     , numero_flujo\n\n";

            _PricingSwapFlow += "SET NOCOUNT OFF\n";

            _PricingSwapFlow = string.Format(_PricingSwapFlow, id);

            #endregion

            #region "Ejecución del Query"

            try
            {
                _Connect.Execute("BACSWAPSUDA", _PricingSwapFlow, "PricingSwapFlow");
                _DTPricingSwapFlow = _Connect.Table;
            }
            catch (Exception _Error)
            {
                _DTPricingSwapFlow = null;
                Error = new StructError(_Error);
                Status = enumStatus.ErrorExecuting;
            }
            finally
            {
                _Connect.Close();
                _Connect = null;
            }

            #endregion

            return _DTPricingSwapFlow;

        }

    }

}
