USE [Bacfwdsuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_GRABARBIDASK]    Script Date: 13-05-2022 10:30:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_GRABARBIDASK](  @codmda  NUMERIC(03) ,
     @ncodperiodo NUMERIC(03) ,
     @nparcom  FLOAT  ,
     @nparvta  FLOAT  ,
     @nbid   FLOAT  ,
     @nask   FLOAT  ,
     @nfactor NUMERIC(10) ,
     @valor  FLOAT  ,
     @dfecha  DATETIME )
AS BEGIN
   SET NOCOUNT ON
   INSERT INTO MFBIDASK( moneda         ,
    fecha          ,
    periodo        ,
    bid            ,
    ask            ,
    factor         
                       )
       VALUES   ( @codmda        , 
           @dfecha , 
           @ncodperiodo , 
           @nbid   , 
           @nask   , 
           @nfactor 
                       ) 
 IF EXISTS ( SELECT vmvalor FROM VIEW_VALOR_MONEDA WHERE vmcodigo = @codmda AND vmfecha  = @dfecha)
        
  UPDATE VIEW_VALOR_MONEDA  
  SET  vmptacmp = @nparcom ,
   vmptavta = @nparvta ,
   vmvalor  = @valor
  WHERE  vmcodigo = @codmda AND
      vmfecha  = @dfecha
 ELSE  
             INSERT INTO VIEW_VALOR_MONEDA ( vmcodigo , 
    vmvalor         , 
    vmptacmp ,
    vmptavta ,
    vmfecha )
                       VALUES ( @codmda      , 
    @valor  , 
    @nparcom ,
    @nparvta ,  
    @dfecha )
 
   UPDATE VIEW_MONEDA SET mnfactor = @nfactor WHERE mncodmon = @codmda
   SELECT 0
   SET NOCOUNT OFF
END

GO
