using System;
using System.Data;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Turing2009Connect;
using Turing2009Data.Definitions;
using Turing2009Definitions.Definitions;
using Turing2009Definitions.Struct;

namespace Turing2009Data.Parameters.Configuration
{

    public class ConfigurationPricingSwapLoad : InterfaceQuery
    {

        public DataTable Load()
        {

            #region "Definición de Variables"

            Turing2009Connect.Connect _Connect;
            DataTable _DTConfigurationPricingSwap;
            string _ConfigurationPricingSwap;

            #endregion

            #region "Inicialización de Variables"

            _Connect = new Turing2009Connect.Connect();
            _Connect.QueryType = enumQueryType.Load;

            _DTConfigurationPricingSwap = new DataTable();

            _ConfigurationPricingSwap = "";

            #endregion

            #region "Query"

            _ConfigurationPricingSwap += "SET NOCOUNT ON\n";
            _ConfigurationPricingSwap += "SELECT 'ID'                            = id\n";
            _ConfigurationPricingSwap += "     , 'AssetCurrencyID'               = assetcurrencyid\n";
            _ConfigurationPricingSwap += "     , 'AssetRateID'                   = assetrateid\n";
            _ConfigurationPricingSwap += "     , 'LiabilitiesCurrencyID'         = liabilitiescurrencyid\n";
            _ConfigurationPricingSwap += "     , 'LiabilitiesRateID'             = liabilitiesrateid\n";
            _ConfigurationPricingSwap += "     , 'AddressGenerationFixingNumber' = addressgenerationfixingnumber\n";
            _ConfigurationPricingSwap += "     , 'AddressGenerationFixingType'   = addressgenerationfixingtype\n";
            _ConfigurationPricingSwap += "     , 'IntervalCalendarSantiago'      = intervalcalendarsantiago\n";
            _ConfigurationPricingSwap += "     , 'IntervalCalendarNewYork'       = intervalcalendarnewyork\n";
            _ConfigurationPricingSwap += "     , 'IntervalCalendarLondres'       = intervalcalendarlondres\n";
            _ConfigurationPricingSwap += "     , 'PaymentNumber'                 = paymentnumber\n";
            _ConfigurationPricingSwap += "     , 'PaymentType'                   = paymenttype\n";
            _ConfigurationPricingSwap += "     , 'PaymentDate'                   = paymentdate\n";
            _ConfigurationPricingSwap += "     , 'PaymentCalendarSantiago'       = paymentcalendarsantiago\n";
            _ConfigurationPricingSwap += "     , 'PaymentCalendarNewYork'        = paymentcalendarnewyork\n";
            _ConfigurationPricingSwap += "     , 'PaymentCalendarLondres'        = paymentcalendarlondres\n";
            _ConfigurationPricingSwap += "     , 'FixingNumber'                  = fixingnumber\n";
            _ConfigurationPricingSwap += "     , 'FixingType'                    = fixingtype\n";
            _ConfigurationPricingSwap += "     , 'FixingDate'                    = fixingdate\n";
            _ConfigurationPricingSwap += "     , 'FixingCalendarSantiago'        = fixingcalendarsantiago\n";
            _ConfigurationPricingSwap += "     , 'FixingCalendarNewYork'         = fixingcalendarnewyork\n";
            _ConfigurationPricingSwap += "     , 'FixingCalendarLondres'         = fixingcalendarlondres\n";
            _ConfigurationPricingSwap += "     , 'ConventionCalendar'            = conventioncalendar\n";
            _ConfigurationPricingSwap += "     , 'ResetDay'                      = resetday\n";
            _ConfigurationPricingSwap += "  FROM dbo.tblConfiguration\n";
            _ConfigurationPricingSwap += "SET NOCOUNT OFF\n";

            #endregion

            #region "Ejecución del Query"

            try
            {
                _Connect.Execute("Turing", _ConfigurationPricingSwap, "ConfigurationPricingSwap");
                _DTConfigurationPricingSwap = _Connect.Table;
            }
            catch (Exception _Error)
            {
                _DTConfigurationPricingSwap = null;
                Error = new StructError(_Error);
                Status = enumStatus.ErrorExecuting;
            }
            finally
            {
                _Connect.Close();
                _Connect = null;
            }

            #endregion

            return _DTConfigurationPricingSwap;

        }

    }

}
