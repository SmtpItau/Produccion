USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[BACINSERTIMPOPERA]    Script Date: 11-05-2022 16:43:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


create procedure [dbo].[BACINSERTIMPOPERA]
   (@mercado char(4),
    @numope numeric(8),
    @estado char(20),
    @clienteope char(40),
    @espacio1 char(1),
    @monusd numeric(19,4),
    @monpes numeric(19,4),
    @tipcam numeric(19,4),
    @forpagent char(40),
    @valutaent char(10),
    @forpagrec char(40), 
    @valutarec char(10),   
    @moneda char(4),
    @paridad       numeric(19,4),
    @espacio2 char(1),
    @fechoy char(10),
    @fecoper char(10),
    @hora  char(10),
    @rut  numeric(9),
    @digito  char(1),
    @nombre char(40),
    @cliente char(40),
    @monedacon char(9),
    @montomonori   numeric(19,4))
 
as
begin
set nocount on
insert into TEMPOPE
values(@mercado,@numope,@estado,@clienteope,@espacio1,
@monusd,@monpes,@tipcam,@forpagent,@valutaent,@forpagrec, 
@valutarec,@moneda,@paridad,@fechoy,@fecoper,
@hora,@rut,@digito,@nombre,@cliente,@monedacon,@montomonori)
set nocount off
end



GO
