USE [Bacfwdsuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_RETORNAPRECIOPARIDADANT]    Script Date: 13-05-2022 10:30:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO


CREATE PROCEDURE [dbo].[SP_RETORNAPRECIOPARIDADANT]
   (   @iMoneda      NUMERIC(5) -- Codigo Moneda
   ,   @TipoOper     CHAR(01)   -- 'C':Compra; 'V':Ventas
   ,   @Fecha        DATETIME   -- Fecha de Hoy
   )

AS
BEGIN

   SET NOCOUNT ON

   DECLARE @iPrecioParidad   FLOAT
   DECLARE @FecMax           DATETIME

   SELECT  @iPrecioParidad =0.0

   IF @iMoneda <> 13  AND  @iMoneda <> 999 
   BEGIN


        SELECT  @iPrecioParidad = ISNULL((CASE WHEN @TipoOper = 'C' THEN ISNULL(vmptacmp,0.0) ELSE ISNULL(vmptavta,0.0) END),0.0)   
        FROM  VIEW_VALOR_MONEDA
        WHERE vmfecha  = @Fecha
        AND   vmcodigo = @iMoneda



       IF  @iPrecioParidad = 0.0 
       BEGIN 
               SELECT @FecMax = MAX(vmfecha) 
               FROM VIEW_VALOR_MONEDA  
               WHERE vmcodigo=@iMoneda
               AND   ISNULL( CASE WHEN @TipoOper = 'C' THEN vmptacmp ELSE vmptavta END , 0.0 ) <> 0 



               SELECT  @iPrecioParidad = ISNULL( CASE WHEN @TipoOper = 'C' THEN vmptacmp ELSE vmptavta END , 0.0 )  
               FROM  VIEW_VALOR_MONEDA
               WHERE vmfecha  = @FecMax
               AND   vmcodigo = @iMoneda
            
       END  
            

   END
   ELSE  
   BEGIN 

        
        SELECT  @iPrecioParidad = ISNULL( VMVALOR, 0.0 )  
        FROM  VIEW_VALOR_MONEDA
        WHERE vmfecha  = @Fecha
        AND   vmcodigo = 994


        IF  @iPrecioParidad = 0.0 
        BEGIN 
             SELECT @FecMax = MAX(vmfecha) 
             FROM VIEW_VALOR_MONEDA  
             WHERE vmcodigo=994
             AND   ISNULL( VMVALOR, 0.0 ) <> 0 
 

             SELECT  @iPrecioParidad = ISNULL( VMVALOR, 0.0 )  
             FROM  VIEW_VALOR_MONEDA
             WHERE vmfecha  = @FecMax
             AND   vmcodigo = 994


        END


   END

   SELECT  'Paridad_Precio' = ISNULL(@iPrecioParidad, 0.0)


END

GO
