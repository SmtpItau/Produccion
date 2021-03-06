USE [MDParPasivo]
GO
/****** Object:  StoredProcedure [dbo].[Sp_Monedas]    Script Date: 16-05-2022 11:09:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO



/*==========================================================================*/
/*==========================================================================*/
CREATE PROCEDURE [dbo].[Sp_Monedas]

AS
BEGIN

   SET DATEFORMAT dmy

   /*=======================================================================*/
   /*=======================================================================*/
   SELECT       mncodmon              ,
                mnglosa               ,
                mnnemo                ,
                mnfactor              ,
                mnredondeo            ,
                mncodbanco            ,
                mncodsuper            ,
                mnbase                ,
                mnrefusd              ,
                mnlocal               ,
                mnextranj             ,
                mnvalor               ,
                mnrefmerc
          FROM  MONEDA
            WHERE   ESTADO<>'A'
	  ORDER BY mncodmon	

   /*=======================================================================*/
   /*=======================================================================*/
   RETURN

END



GO
