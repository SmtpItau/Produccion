using System;
using System.Data;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Turing2009Connect;
using Turing2009Data.Definitions;
using Turing2009Definitions.Definitions;
using Turing2009Definitions.Struct;

namespace Turing2009Data.Parameters.HedgeBaskets
{

    public class HedgeBasketsLoad : InterfaceQuery
    {

        public DataSet Load()
        {

            DataSet _DataSet = new DataSet();

            _DataSet.Merge(LoadHedgeBaskets());
            _DataSet.Merge(LoadHedgeBasketsDetail());

            return _DataSet;

        }

        private DataTable LoadHedgeBaskets()
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
            _HedgeBaskets += "SELECT 'ID'                           = id\n";
            _HedgeBaskets += "     , 'Description'                  = description\n";
            _HedgeBaskets += "     , 'SwapType'                     = swaptype\n";
            _HedgeBaskets += "     , 'ExchangeNotionalStarting'     = exchangenotionalstarting\n";
            _HedgeBaskets += "     , 'ExchangeNotionalIntermediate' = exchangenotionalintermediate\n";
            _HedgeBaskets += "     , 'ExchangeNotionalEnd'          = exchangenotionalend\n";
            _HedgeBaskets += "     , 'UserCreator'                  = usercreator\n";
            _HedgeBaskets += "     , 'CreatorDate'                  = creatordate\n";
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


        private DataTable LoadHedgeBasketsDetail()
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
            _HedgeBaskets += "     , 'HedgeBasketsID'                = hedgebasketsid\n";
            _HedgeBaskets += "     , 'LegID'                         = legid\n";
            _HedgeBaskets += "     , 'CurrencyID'                    = currencyid\n";
            _HedgeBaskets += "     , 'RateID'                        = rateid\n";
            _HedgeBaskets += "     , 'AssignRate'                    = assignrate\n";
            _HedgeBaskets += "     , 'Convention'                    = convention\n";
            _HedgeBaskets += "     , 'DevelopmentTable'              = developmenttable\n";
            _HedgeBaskets += "     , 'IntervalType'                  = intervaltype\n";
            _HedgeBaskets += "     , 'BrokenPeriod'                  = brokenperiod\n";
            _HedgeBaskets += "     , 'AddressGenerationFixingNumber' = addressgenerationfixingnumber\n";
            _HedgeBaskets += "     , 'AddressGenerationFixingType'   = addressgenerationfixingtype\n";
            _HedgeBaskets += "     , 'IntervalCalendarSantiago'      = intervalcalendarsantiago\n";
            _HedgeBaskets += "     , 'IntervalCalendarNewYork'       = intervalcalendarnewyork\n";
            _HedgeBaskets += "     , 'IntervalCalendarLondres'       = intervalcalendarlondres\n";
            _HedgeBaskets += "     , 'PaymentNumber'                 = paymentnumber\n";
            _HedgeBaskets += "     , 'PaymentType'                   = paymenttype\n";
            _HedgeBaskets += "     , 'PaymentDate'                   = paymentdate\n";
            _HedgeBaskets += "     , 'PaymentCalendarSantiago'       = paymentcalendarsantiago\n";
            _HedgeBaskets += "     , 'PaymentCalendarNewYork'        = paymentcalendarnewyork\n";
            _HedgeBaskets += "     , 'PaymentCalendarLondres'        = paymentcalendarlondres\n";
            _HedgeBaskets += "     , 'FixingNumber'                  = fixingnumber\n";
            _HedgeBaskets += "     , 'FixingType'                    = fixingtype\n";
            _HedgeBaskets += "     , 'FixingDate'                    = fixingdate\n";
            _HedgeBaskets += "     , 'FixingCalendarSantiago'        = fixingcalendarsantiago\n";
            _HedgeBaskets += "     , 'FixingCalendarNewYork'         = fixingcalendarnewyork\n";
            _HedgeBaskets += "     , 'FixingCalendarLondres'         = fixingcalendarlondres\n";
            _HedgeBaskets += "     , 'ConventionCalendar'            = conventioncalendar\n";
            _HedgeBaskets += "     , 'UserCreator'                   = usercreator\n";
            _HedgeBaskets += "     , 'CreatorDate'                   = creatordate\n";
            _HedgeBaskets += "  FROM dbo.HedgeBasketsDetail\n";
            _HedgeBaskets += "SET NOCOUNT OFF\n";

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
