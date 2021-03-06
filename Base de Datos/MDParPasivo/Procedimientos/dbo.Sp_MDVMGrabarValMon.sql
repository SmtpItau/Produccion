USE [MDParPasivo]
GO
/****** Object:  StoredProcedure [dbo].[Sp_MDVMGrabarValMon]    Script Date: 16-05-2022 11:09:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO


CREATE PROCEDURE [dbo].[Sp_MDVMGrabarValMon]
       (
        @ncodigo     NUMERIC(03,0)   ,
        @nvalor      NUMERIC(18,10)  ,
        @nvalorcmp   NUMERIC(18,10)  ,
        @nvalorvta   NUMERIC(18,10)  ,
        @cfecha      CHAR(10)
       ) 
AS   
BEGIN 

SET NOCOUNT ON
SET DATEFORMAT dmy

   /*=======================================================================*/
   DECLARE @dfecha      DATETIME

   /*=======================================================================*/
   SELECT @dfecha = CONVERT( DATETIME, @cfecha )

   /*=======================================================================*/

   IF EXISTS( SELECT       vmcodigo,
			   vmvalor ,
			   vmptacmp,
			   vmptavta,
			   vmfecha ,
			/*   vmliborsemanal,
			   vmlibormes1   ,
			   vmlibormes2   ,
			   vmlibormes3   ,
			   vmlibormes4   ,
			   vmlibormes5   ,
			   vmlibormes6   ,
			   vmlibormes7   ,
			   vmlibormes8   ,
			   vmlibormes9   ,
			   vmlibormes10  ,
			   vmlibormes11  ,
			   vmlibormes12  ,*/
 			   --vmtipo,
			   vmparidad,
			   --vmparmer,
			   vmposini,
			   --vmprecoi,
			   --vmparini,
			   --vmprecoc,
			   --vmparidc,
			   vmposic,
			   --vmpreco,
			   --vmpreve,
			   --vmpmeco,
			   --vmpmeve,
			   vmtotco,
			   vmtotve
			   --vmutili,
			   --vmparco,
			   --vmparve,
			   --vmorden,
			   --vmctacmb,
			   --vmcmbini,
			   --vmreval,
			   --vmarbit,
			   --vmparmer1,
			   --vmnumstgo



                     FROM  VALOR_MONEDA 
                     WHERE vmcodigo = @ncodigo  AND
                           vmfecha  = @dfecha
            ) BEGIN

      /*====================================================================*/
      UPDATE       VALOR_MONEDA
             SET   vmvalor  = @nvalor                                       ,
                   vmptacmp = @nvalorcmp                                    ,
                   vmptavta = @nvalorvta
             WHERE vmcodigo = @ncodigo    AND
                   vmfecha  = @dfecha 


   /*=======================================================================*/
   END ELSE BEGIN


      /*====================================================================*/
      INSERT INTO VALOR_MONEDA  ( vmcodigo, vmvalor,   vmptacmp,   vmptavta, vmfecha )
             			VALUES ( @ncodigo, @nvalor, @nvalorcmp, @nvalorvta, @dfecha )

   END


   /*=======================================================================*/
   SET NOCOUNT OFF
   SELECT 0

END



GO
