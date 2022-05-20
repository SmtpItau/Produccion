public enum enumIntervalType
{
    Day = 0,
    DayHoliday = 1,
    Month = 2,
    Year = 3
}

public enum enumDateIntevale
{
    Day = 0,
    Weekend = 1,
    Month = 2,
    Semesters = 3,
    TwoMonth = 4,
    ThreeMonths = 5,
    FourMonths = 6,
    Year = 7
};

public enum enumBrokenPeriod
{
    AtHome = 0,
    AtTheEnd = 1
}

public enum enumFlagBackStarting
{
    Yes = 0,
    Not = 0
}

public enum enumPayment
{
    StartDate = 0,
    FinishDate = 1
}

public enum enumConvention
{
    NotAdjustedMonthEnd = 0,
    PreviousMonthEnd = 1,
    NextMonthEnd = 2,
    NotAdjusted = 3,
    Previous = 4,
    Next = 5,
    PreviousModified = 6,
    NextModified = 7
}

public enum enumFlagFixedFloating
{
    Fixed = 0,
    Floating = 1
}

public enum enumDevelopmentTableType
{
    Bullet = 0,
    AmortizationConstant = 1,
    QuotaFixed = 2
}

public enum enumExchangeNotional
{
    Yes = 0,
    Not = 1
}

public enum enumBasis
{
    Basis_Act_360 = 0,
    Basis_30E_360 = 1,
    Basis_Act_365 = 2,
    Basis_30E_365 = 3,
    Basis_Act_Act = 4,
    Basis_Act_30  = 5,
    Basis_30_30   = 6
}

public enum enumRelacionRespectoDolar
{
    Multiplica = 0,
    Divide = 1
}

public enum enumBasisCurve
{
    YieldAct360 = 0,
    YieldAct365 = 1
}

public enum enumGenerate
{
    OriginalYield = 0,
    CalculateYield = 1
}

public enum enumInterpolateType
{
    InterpolateLineal = 0
}

public enum enumPointStatus
{
    OutRangeRight = -3,
    OutRangeLeft = -2,
    NotFound = -1,
    Initialize = 0,
    Found = 1,
    Interpolate = 2,
}

public enum enumAddressGenerationFixing
{
    Forward = 0,                                                    // Hacia delante
    Backwards = 1                                                   // Hacia atras
}

public enum enumFormulaIndexCalculation
{
    AverageGeometriFactorsCapitalization = 0
}

public enum enumIndexType
{
    Vanilla = 0,
    Exotic = 1,
    ICP = 2
}

public enum enumBootstrappingType
{
    MoneyMarket = 0,
    Forward = 1,
    Swap = 2
}

public enum enumFrecuency
{
    Month = 0,
    TwoMonth = 1,
    ThreeMonth = 2,
    FourMonth = 3,
    Semesters = 4,
    Year = 5
}

public enum enumRate
{
    RateOriginal = 0,
    RateBasis = 1,
    RateOriginalSpread = 2
}

public enum enumSwapLeng
{
    Asset = 0,
    Liabilities = 1
}

public enum enumValuatorForward
{
    ValuatorDiscount = 0,
    ValuatorForwardPriceTheory = 1
}

public enum enumCalculateDate
{
    ExpiryDate = 0,
    EffectiveDate = 1
}

public enum enumValuatorFixingRate
{
    Valuator = 0,
    MartToMarket = 1,
    Sensibilite = 2
}

public enum enumFlagMartTOMarketFixingRate
{
    RateToday = 0,
    RateYesterday = 1,
    RateTomorrow = 2
}

public enum enumPortFolioStatus
{
    Init = 0,
    Process = 1,
    Today = 2,
    NotProcess = 3,
    TodayNotProcess = 4
}

public enum enumSetPrincingLoading
{
    OrginalSystem = 0,
    Riesgo = 1,
    Costo = 2,
    Distribucion = 3,
    Dummy = 4
}