USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_ESFERIADO]    Script Date: 13-05-2022 11:31:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
/****** objeto:  procedimiento  almacenado DBO.SP_ESFERIADO    fecha de la secuencia de comandos: 05/04/2001 13:13:24 ******/
CREATE PROCEDURE [dbo].[SP_ESFERIADO] (@dfecha datetime, @cplaza numeric(3))
as
begin
  declare @nmonth   integer
  declare @ccampo   char(05)
  declare @cstrexec varchar(255)
  declare @nano     integer
  select @nmonth = datepart(month, @dfecha)
  select @nano   = datepart(year , @dfecha)
  if @nmonth = 01 select @ccampo = 'feene'
  if @nmonth = 02 select @ccampo = 'fefeb'
  if @nmonth = 03 select @ccampo = 'femar'  
  if @nmonth = 04 select @ccampo = 'feabr'  
  if @nmonth = 05 select @ccampo = 'femay'  
  if @nmonth = 06 select @ccampo = 'fejun'  
  if @nmonth = 07 select @ccampo = 'fejul'  
  if @nmonth = 08 select @ccampo = 'feago'  
  if @nmonth = 09 select @ccampo = 'fesep'  
  if @nmonth = 10 select @ccampo = 'feoct'  
  if @nmonth = 11 select @ccampo = 'fenov'  
  if @nmonth = 12 select @ccampo = 'fedic'  
  select @cstrexec = 'select ' + @ccampo + ' from VIEW_FERIADO where feplaza = ' +  convert(char(3),@cplaza) + ' and feano = ' + convert(char(4),@nano)
  execute (@cstrexec)
  select 'OK'
end


GO
