using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;
using Turing2009Connect;
using Turing2009Data.Definitions;
using Turing2009Definitions.Definitions;
using Turing2009Definitions.Struct;

namespace Turing2009Data.Process.HedgeBaskets
{

    public class HedgeBasketsLoad : InterfaceQuery
    {

        public DataTable Load()
        {

            #region "Definición de Variables"

            Turing2009Connect.Connect _Connect;
            DataTable _DTHedgeBaskets;
            string _HedgeBaskets;

            #endregion

            #region "Inicialización de Variables"

            _Connect = new Turing2009Connect.Connect();
            _Connect.QueryType = enumQueryType.Load;

            _DTHedgeBaskets = new DataTable();

            _HedgeBaskets = "";

            #endregion

            #region "Query"

            _HedgeBaskets += "SET NOCOUNT ON\n";
            _HedgeBaskets += "SELECT 'ID'                            = id\n";
            _HedgeBaskets += "     , 'Description'                   = description\n";
            _HedgeBaskets += "     , 'ExchangeNotionalStarting'      = exchangenotionalstarting\n";
            _HedgeBaskets += "     , 'ExchangeNotionalIntermediate'  = exchangenotionalintermediate\n";
            _HedgeBaskets += "     , 'ExchangeNotionalEnd'           = exchangenotionalend\n";
            _HedgeBaskets += "  FROM dbo.HedgeBaskets\n";
            _HedgeBaskets += "SET NOCOUNT OFF\n";

            #endregion

            #region "Ejecución del Query"

            try
            {
                _Connect.Execute("Turing", _HedgeBaskets, "HedgeBaskets");
                _DTHedgeBaskets = _Connect.Table;
            }
            catch (Exception _Error)
            {
                _DTHedgeBaskets = null;
                Error = new StructError(_Error);
                Status = enumStatus.ErrorExecuting;
            }
            finally
            {
                _Connect.Close();
                _Connect = null;
            }

            #endregion

            return _DTHedgeBaskets;

        }

        public DataTable Load(int id, int legID)
        {

            #region "Definición de Variables"

            Turing2009Connect.Connect _Connect;
            DataTable _DTHedgeBaskets;
            string _HedgeBaskets;

            #endregion

            #region "Inicialización de Variables"

            _Connect = new Turing2009Connect.Connect();
            _Connect.QueryType = enumQueryType.Load;

            _DTHedgeBaskets = new DataTable();

            _HedgeBaskets = "";

            #endregion

            #region "Query"

            _HedgeBaskets += "SET NOCOUNT ON\n";
            _HedgeBaskets += "SELECT 'ID'                            = HBD.id\n";
            _HedgeBaskets += "     , 'HedgeBasketsID'                = HBD.hedgebasketsid\n";
            _HedgeBaskets += "     , 'Description'                   = HB.description\n";
            _HedgeBaskets += "     , 'SwapType'                      = HB.SwapType\n";
            _HedgeBaskets += "     , 'ExchangeNotionalStarting'      = HB.exchangenotionalstarting\n";
            _HedgeBaskets += "     , 'ExchangeNotionalIntermediate'  = HB.exchangenotionalintermediate\n";
            _HedgeBaskets += "     , 'ExchangeNotionalEnd'           = HB.exchangenotionalend\n";
            _HedgeBaskets += "     , 'LegID'                         = HBD.legid\n";
            _HedgeBaskets += "     , 'CurrencyID'                    = HBD.currencyid\n";
            _HedgeBaskets += "     , 'CurrencySystemID'              = C.systemoriginal\n";
            _HedgeBaskets += "     , 'RateID'                        = HBD.rateid\n";
            _HedgeBaskets += "     , 'AssignRate'                    = HBD.assignrate\n";
            _HedgeBaskets += "     , 'RateOriginalID'                = R.systemoriginal\n";
            _HedgeBaskets += "     , 'Convention'                    = HBD.convention\n";
            _HedgeBaskets += "     , 'DevelopmentTable'              = HBD.developmenttable\n";
            _HedgeBaskets += "     , 'IntervalType'                  = HBD.intervaltype\n";
            _HedgeBaskets += "     , 'BrokenPeriod'                  = HBD.brokenperiod\n";
            _HedgeBaskets += "     , 'AddressGenerationFixingNumber' = HBD.addressgenerationfixingnumber\n";
            _HedgeBaskets += "     , 'AddressGenerationFixingType'   = HBD.addressgenerationfixingtype\n";
            _HedgeBaskets += "     , 'IntervalCalendarSantiago'      = HBD.intervalcalendarsantiago\n";
            _HedgeBaskets += "     , 'IntervalCalendarNewYork'       = HBD.intervalcalendarnewyork\n";
            _HedgeBaskets += "     , 'IntervalCalendarLondres'       = HBD.intervalcalendarlondres\n";
            _HedgeBaskets += "     , 'PaymentNumber'                 = HBD.paymentnumber\n";
            _HedgeBaskets += "     , 'PaymentType'                   = HBD.paymenttype\n";
            _HedgeBaskets += "     , 'PaymentDate'                   = HBD.paymentdate\n";
            _HedgeBaskets += "     , 'PaymentCalendarSantiago'       = HBD.paymentcalendarsantiago\n";
            _HedgeBaskets += "     , 'PaymentCalendarNewYork'        = HBD.paymentcalendarnewyork\n";
            _HedgeBaskets += "     , 'PaymentCalendarLondres'        = HBD.paymentcalendarlondres\n";
            _HedgeBaskets += "     , 'FixingNumber'                  = HBD.fixingnumber\n";
            _HedgeBaskets += "     , 'FixingType'                    = HBD.fixingtype\n";
            _HedgeBaskets += "     , 'FixingDate'                    = HBD.fixingdate\n";
            _HedgeBaskets += "     , 'FixingCalendarsSntiago'        = HBD.fixingcalendarsantiago\n";
            _HedgeBaskets += "     , 'FixingCalendarNewYork'         = HBD.fixingcalendarnewyork\n";
            _HedgeBaskets += "     , 'FixingCalendarLondres'         = HBD.fixingcalendarlondres\n";
            _HedgeBaskets += "     , 'ConventionCalendar'            = HBD.conventioncalendar\n";
            _HedgeBaskets += "  FROM dbo.HedgeBasketsDetail HBD\n";
            _HedgeBaskets += "       INNER JOIN dbo.HedgeBaskets  HB ON HBD.hedgebasketsid = HB.id\n";
            _HedgeBaskets += "       INNER JOIN dbo.tblCurrency   C  ON HBD.currencyid     = C.ID\n";
            _HedgeBaskets += "       INNER JOIN dbo.tblRate       R  ON HBD.rateid         = R.ID\n";
            _HedgeBaskets += " WHERE HBD.hedgebasketsid              = {0}\n";
            _HedgeBaskets += "   AND HBD.legid                       = {1}\n";
            _HedgeBaskets += "SET NOCOUNT OFF\n";

            _HedgeBaskets = string.Format(_HedgeBaskets, id.ToString(), legID.ToString());

            #endregion

            #region "Ejecución del Query"

            try
            {
                _Connect.Execute("Turing", _HedgeBaskets, "HedgeBasketsDetail");
                _DTHedgeBaskets = _Connect.Table;
            }
            catch (Exception _Error)
            {
                _DTHedgeBaskets = null;
                Error = new StructError(_Error);
                Status = enumStatus.ErrorExecuting;
            }
            finally
            {
                _Connect.Close();
                _Connect = null;
            }

            #endregion

            return _DTHedgeBaskets;

        }

    }

}
