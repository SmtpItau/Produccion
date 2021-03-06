USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_LEER_FPAGO]    Script Date: 11-05-2022 16:43:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[SP_LEER_FPAGO]( @Codigo INTEGER = 0 ,
                                @Moneda INTEGER = 0 )
AS
BEGIN
  SET NOCOUNT ON
     SELECT codigo
           ,glosa
           ,cc2756
           ,diasvalor
           ,glosa2
           , 'No_Borrar'  = 0
           ,costo_de_fondo
       INTO #fpago
       FROM view_forma_de_pago
      WHERE @Codigo = 0 OR 
            @Codigo = codigo
      ORDER BY codigo
     IF @Moneda <> 0  BEGIN
        UPDATE #fpago SET No_Borrar = 1
                     FROM view_moneda_forma_de_pago
                    WHERE @Moneda = mfcodmon AND 
                          codigo  = mfcodfor
        DELETE #fpago WHERE No_Borrar = 0
     END
     SELECT codigo
           ,glosa
           ,cc2756
           ,diasvalor
           ,glosa2
           ,costo_de_fondo
       FROM #fpago
END
GO
