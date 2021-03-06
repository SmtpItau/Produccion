USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_INTRADAY_GRABAR]    Script Date: 11-05-2022 16:43:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


create procedure [dbo].[SP_INTRADAY_GRABAR]
  (
    @rutcli numeric(9)
   ,@monto  numeric(19,4)
   ,@precio numeric(10,4)
   ,@tipoopera char(1)
   ,@montpesos numeric(19,4)
   ,@operador char(10)
   ,@fecha  datetime
   ,@hora  char(8)
   ,@terminal char(12)
   ,@forpagmn numeric(2)
   ,@forpagmx numeric(2)
   ,@fecpagmn datetime
   ,@fecpagmx datetime
   ,@mercado char(4)
                        ,@moneda        numeric(5) 
                        ,@sistema       char(4)
                        ,@producto      char(5)
                        ,@area          char(5)
                        ,@conta         char(1)
                        ,@COMERCIO      CHAR(6)
                        ,@CONCEPTO      CHAR(3)
  )
as begin
 set nocount on
  declare @codcli      numeric(3)
 declare @nomcli      char(35)
  declare @tctra       numeric(19,4)
 declare @fechaproce  datetime
 declare @parida  numeric(19,4)
 declare @partr  numeric(19,4)
 declare @ussme       numeric(19,4)
 declare @usstr       numeric(19,4)
 declare @rentab  numeric(3)
 declare @pretra  numeric(19,4)
        DECLARE @MONE1          CHAR(3)  
 /*===================================================*/
 select @fechaproce = ( select acfecpro from meac )
 select @codcli     = ( select accodigo from meac )
 select @nomcli     = ( select acnombre from meac )
 select @parida     =  (select vmparidad from view_valor_moneda where vmcodigo = 994 and vmfecha = @fechaproce )
 select @tctra      = @precio
 select @partr      = @parida --vmprecierre
 select @ussme    = (select vmprecierre from view_posicion_spt where vmcodigo = 994 and vmfecha = @fechaproce )
 select @usstr      =  (select vmvalor     from view_valor_moneda where vmcodigo = 994 and vmfecha = @fechaproce )
 select @rentab    = 0
 select @pretra     =  (select vmvalor from view_valor_moneda where vmcodigo = 994 and vmfecha = @fechaproce )
        SELECT @hora       = CONVERT( CHAR(8), GETDATE() ,108 )
          
        SELECT @MONE1      = ( SELECT mnnemo FROM VIEW_MONEDA WHERE mncodmon  = @moneda  )
 execute Sp_Gmovto
           0   --@numope      numeric(7)
                        ,@mercado   --,@tipmer     char(4)
                        ,@tipoopera --,@tipope     char(1)
                        ,@rutcli     
                        ,@codcli     
                        ,@nomcli     
                        ,@MONE1   --MONEDA
                        ,'CLP'    --MONECACNV
                        ,@monto
                        ,@precio      
                        ,@tctra     
                        ,@parida     
                        ,@partr      
                        ,@monto
                        ,@monto      
                        ,@montpesos
                        ,@forpagmn 
                        ,@forpagmx 
                        ,@operador 
                        ,@terminal 
                        ,@hora     
                        ,@fecha    
                        ,0 --@codoma     numeric(3) -- xxx
                        ,'' --@estatus    char(1)
                        ,0 --@codejec    numeric(6)
                        ,@fecpagmn   -- entregamos
                        ,@fecpagmx   -- recibimos
                        ,@rentab    
                        ,0 --@linea      char(1)
   ,1 --@entidad    numeric(10)
                        ,@precio     
                        ,@pretra     
                        ,-1 --@estado     numeric(1) = -1       -- para la captura automatica de fwd   
   ,@sistema --@respon     char(3)
   ,@conta --@cotab      char(1)
   ,'' --@observa    varchar(250)
   ,'' --@swift_corrdonde  varchar(10)
   ,'' --@swift_corrquien  varchar(10)
   ,'' --@swift_corrdesde  varchar(10)
   ,0 --@plaza_corrdonde  numeric(5)
   ,0 --@plaza_corrquien  numeric(5)
   ,0 --@plaza_corrdesde  numeric(5)
                        ,0    -- ,forma_pago_cli_nac
                        ,0   -- ,forma_pago_cli_ext
                        ,''   -- ,valuta_cli_nac
                        ,''   -- ,valuta_cli_ext
                        ,@area
                        ,@COMERCIO
                        ,@CONCEPTO
 set nocount off
end

GO
