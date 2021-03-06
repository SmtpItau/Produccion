USE [Bacfwdsuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_CONTROL_VARIACION_CURVAS_BID_ASK]    Script Date: 13-05-2022 10:30:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO


CREATE PROCEDURE [dbo].[SP_CONTROL_VARIACION_CURVAS_BID_ASK]
(    @codmda  NUMERIC(03) ,
     @ctipoparidad CHAR(01),   
     @npar    FLOAT  ,
     @dfecha  DATETIME 
)
AS BEGIN
   SET NOCOUNT ON
  

   DECLARE @dfechaant     DATETIME       
        ,  @nparcomant    FLOAT          
        ,  @nparvtaant    FLOAT
        ,  @nresul        INT
        ,  @nporcentaje   FLOAT
    
   SELECT @dfechaant = acfecante 
   FROM  MFAC

   SELECT @nporcentaje = tbvalor  
   FROM   view_tabla_general_detalle 
   WHERE  tbcateg =4000
    

   SELECT @nparcomant =(SELECT vmptacmp FROM VIEW_VALOR_MONEDA WHERE vmcodigo = @codmda AND vmfecha  = @dfechaant)
   SELECT @nparvtaant =(SELECT vmptavta FROM VIEW_VALOR_MONEDA WHERE vmcodigo = @codmda AND vmfecha  = @dfechaant) 


   IF  @ctipoparidad ='C'     
       IF (ABS(@nparcomant - @npar) < (@nparcomant * @nporcentaje/100)) 
            SELECT @nresul=1
       ELSE  
            SELECT @nresul=0   
   ELSE 
       IF (ABS(@nparvtaant - @npar) < (@nparvtaant * @nporcentaje/100)) 
            SELECT @nresul=1
       ELSE  
            SELECT @nresul=0   

 SELECT  @nresul

 SET NOCOUNT OFF
END

GO
