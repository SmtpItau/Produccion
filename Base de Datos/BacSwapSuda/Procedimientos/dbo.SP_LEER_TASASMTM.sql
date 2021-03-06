USE [BacSwapSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_LEER_TASASMTM]    Script Date: 13-05-2022 11:02:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_LEER_TASASMTM]( @CodMoneda INTEGER = 0 ,  
                                   @CodTasa   INTEGER = 0 ,
                                   @Desde     INTEGER = 0 ,
                                   @Fecha     CHAR(8) = '')
AS   
BEGIN
   
   SET NOCOUNT ON      --ADO
     
     IF @Fecha = ''
        SELECT @Fecha = CONVERT(CHAR(8),FechaProc,112) FROM SwapGeneral


     SELECT Desde    , 				--  1
            Bid      , Offer   , Tasa,		--  2- 3-4
            Base     , BaseConv,		--  5- 6
            TasaFinal, TasaZCR ,                --  7- 8
            codigomoneda,                       --  9
            ISNULL(a.mnglosa,'******'),         -- 10
            ISNULL(a.mnnemo,'***'),             -- 11
            codigotasa,                         -- 12
            ISNULL(b.tbglosa,'******'),		-- 13
            'Fecha'=CONVERT(CHAR(10),fecha,103) -- 14

       FROM mdtasas    
            LEFT JOIN mdmn    a ON codigomoneda = a.mncodmon  
            LEFT JOIN mdtc    b ON b.tbcateg = 1042 AND codigotasa = b.tbcodigo1

      WHERE (codigomoneda = @CodMoneda OR @CodMoneda =  0)
        AND (codigotasa   = @CodTasa   OR @CodTasa   =  0)
        AND (desde        = @Desde     OR @Desde     =  0)
        AND  fecha        = @Fecha
        --AND codigomoneda *= a.mncodmon  
        --AND (b.tbcateg = 1042 AND codigotasa *= b.tbcodigo1)  

     ORDER BY desde

   SET NOCOUNT OFF      --ADO
END
GO
