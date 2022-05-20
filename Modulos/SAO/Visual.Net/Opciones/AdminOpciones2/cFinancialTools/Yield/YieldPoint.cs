using System;
using System.ComponentModel;
using System.Collections;
using System.Collections.Generic;
using System.Diagnostics;
using System.Text;

namespace cFinancialTools.Yield
{

    public class YieldPoint
    {

        public YieldPoint()
        {
            Set(0, 0, 0, 0);
        }

        public YieldPoint(int term, double rate)
        {
            Set(term, rate, 0, 0);
        }

        public YieldPoint(int term, double rateBid, double rateOffer, double rateMid)
        {
            Set(term, rateBid, rateOffer, rateMid);
        }

        public int Term { get; set; }
        public double Rate { get; set; }
        public double RateBid { get; set; }
        public double RateOffer { get; set; }
        public double RateMid { get; set; }

        public double Spread{ get; set; }

        protected void Set(int term, double rateBid, double rateOffer, double rateMid)
        {
            Term = term;
            Rate = rateBid;
            RateBid = rateBid;
            RateOffer = rateOffer;
            RateMid = rateMid;
            Spread = 0;
        }

    }

}
