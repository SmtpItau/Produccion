USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[BACIMPOPERA]    Script Date: 11-05-2022 16:43:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


create procedure [dbo].[BACIMPOPERA]
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
create table #TEMP(  mercado char(4),
    numope numeric(8),
    estado char(20),
    clienteope char(40),
    espacio1 char(1),
    monusd numeric(19,4),
    monpes numeric(19,4),
    tipcam numeric(19,4),
    forpagent char(40),
    valutaent char(10),
    forpagrec char(40), 
    valutarec char(10),   
    moneda char(4),
    paridad       numeric(19,4),
    fechoy char(10),
    fecoper char(10),
    hora  char(10),
    rut  numeric(9),
    digito  char(1),
    nombre char(40),
    cliente char(40),
    monedacon char(9),
    montomonori   numeric(19,4))
insert into #TEMP 
values(@mercado,@numope,@estado,@clienteope,@espacio1,
@monusd,@monpes,@tipcam,@forpagent,@valutaent,@forpagrec, 
@valutarec,@moneda,@paridad,@fechoy,@fecoper,
@hora,@rut,@digito,@nombre,@cliente,@monedacon,@montomonori)
select * from #TEMP 
drop table #temp 
set nocount off
end
--bacimpopera 'ptas','420','anulada','american express bank ltda.', ' ',1000000.0000,525000000,525.0000,'vale vista','10/06/2000' ,'cheque dolar' ,'09/10/2000' ,'usd' ,1.0000, ' ','28/11/2000','05/10/2000' ,'09:43:39' ,78221830,'0' ,'dresdner banque natio
--nale de paris' ,'dresdner banque nationale de paris' ,'clp' ,1000000.0000



GO
