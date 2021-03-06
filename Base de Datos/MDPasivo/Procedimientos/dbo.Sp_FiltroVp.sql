USE [MDPasivo]
GO
/****** Object:  StoredProcedure [dbo].[Sp_FiltroVp]    Script Date: 16-05-2022 11:18:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO


CREATE PROCEDURE [dbo].[Sp_FiltroVp]
      (   @Familias   VARCHAR(255)   
      ,   @Emisores   VARCHAR(255) = ' '  
      )
AS
BEGIN

   SET DATEFORMAT dmy
   SET NOCOUNT ON

   IF @Emisores = ' ' BEGIN

       SELECT DISTINCT
              di.diinstser
            , ISNULL(emrut,0)
            , di.digenemi
         FROM CARTERA_DISPONIBLE di
            , CARTERA_PROPIA cp
	    , VIEW_DATOS_GENERALES	
            , VIEW_EMISOR
        WHERE dinumdocu = cpnumdocu
          AND dicorrela = cpcorrela
	  AND ditipcart = '1'
          AND CHARINDEX(RTRIM(LTRIM(diserie)),@Familias) > 0
          AND dinominal > 0
          AND ditipoper = 'CP'
          AND cpnumdocu = dinumdocu     
          AND cpcorrela = dicorrela
          AND cprutcart = dirutcart
--          AND cp.cpseriado = 'S'
	  AND cp.Fecha_PagoMañana <= fecha_proceso
          AND di.digenemi  *= emgeneric

        ORDER BY
              di.diinstser
     

   END ELSE
   BEGIN


       SELECT DISTINCT
              di.diinstser
            , ISNULL(emrut,0)
            , di.digenemi
         FROM CARTERA_DISPONIBLE di
            , CARTERA_PROPIA cp
	    , VIEW_DATOS_GENERALES	
            , VIEW_EMISOR
        WHERE dinumdocu = cpnumdocu
          AND dicorrela = cpcorrela
	  AND ditipcart = '1'
          AND CHARINDEX(RTRIM(LTRIM(di.digenemi)),@Emisores) > 0
          AND dinominal > 0
          AND ditipoper = 'CP'
          AND cpnumdocu = dinumdocu     
          AND cpcorrela = dicorrela
          AND cprutcart = dirutcart
--          AND cp.cpseriado = 'S'
	  AND cp.Fecha_PagoMañana <= fecha_proceso
          AND di.digenemi  *= emgeneric

        ORDER BY
              di.diinstser


   END

   SET NOCOUNT OFF
END

GO
