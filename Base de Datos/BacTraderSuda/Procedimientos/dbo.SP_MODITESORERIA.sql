USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_MODITESORERIA]    Script Date: 13-05-2022 11:31:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_MODITESORERIA]
                        ( 
    @parecfecp  datetime ,
   @parestipoper  char(03) ,
   @parednumoper numeric(10,0) ,
   @paredrutcli numeric(10,0) ,
   @paredcodcli numeric(10,0) ,
   @paredmtooper numeric(19,02) , 
   @paresmoneda char(03) ,
   @parespago  char(01) ,
   @pareiforpago char(02)  ,
   @paresretiro  char(01) ,
   @paredrutcart numeric(10,0) )
as
begin
set nocount on
 declare @varpretorno numeric(01,00)
 execute @varpretorno= Sp_Modi_Operacion_Tesoreria 'BTR',
       @parecfecp  ,
      @parestipoper  ,
      @parednumoper ,
      @paredrutcli ,
      @paredcodcli ,
      @paredmtooper ,
      @paresmoneda ,
      @parespago  ,
      @pareiforpago ,
      @paresretiro  ,
      @paredrutcart ,
                                                ''              ,
                                                0.0             ,
                                                ''
 select @varpretorno
set nocount off
end

GO
