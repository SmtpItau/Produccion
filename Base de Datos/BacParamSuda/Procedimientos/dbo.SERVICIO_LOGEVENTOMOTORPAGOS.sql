USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SERVICIO_LOGEVENTOMOTORPAGOS]    Script Date: 13-05-2022 10:53:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SERVICIO_LOGEVENTOMOTORPAGOS]
(   @MiTag        INTEGER
,   @FechaSistema DATETIME     = ''
,   @Usuario      VARCHAR(15)  = ''
,   @Terminal     VARCHAR(25)  = ''
,   @Sistema      CHAR(3)      = ''
,   @Numero       NUMERIC(9)   = 0
,   @Moneda       VARCHAR(3)   = ''
,   @Estado       VARCHAR(20)  = ''
,   @Proceso      VARCHAR(20)  = ''
,   @Mensaje      VARCHAR(100) = ''
)
as
begin

   set nocount on

   declare @iDataAuxiliar   datetime

   select  @iDataAuxiliar = max(FechaSistema)
   from    LogEventoMotorPagos

   if @iDataAuxiliar <> @FechaSistema
      delete LogEventoMotorPagos

   if @MiTag = 1
   begin
      insert into LogEventoMotorPagos
      select @FechaSistema , @Usuario , @Terminal , @Sistema , @Numero , @Moneda , @Estado , @Proceso , @Mensaje
   end

   if @MiTag = 2
   begin
      delete LogEventoMotorPagos
   end

end
GO
