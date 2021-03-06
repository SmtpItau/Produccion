USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_BUSCA_FECHA_HABIL]    Script Date: 13-05-2022 11:31:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_BUSCA_FECHA_HABIL]
   (   @fecha       datetime 
   ,   @dias        integer  
   ,   @fecha_habil datetime output 
   )
as
begin

   set nocount on

   declare @mes         integer  ,
           @campo       char(50) ,
           @ano         integer  ,
           @feriado     char(1)  ,
           @nrodia      integer  ,
           @plaza       integer

   declare @iContador   integer
   select  @iContador = 0

   select  @plaza     = folio from GEN_FOLIOS where codigo = 'PLAZA_CHIL'
   select  @nrodia    = (case when @dias < 0 then -1 else 1 end)
   select  @feriado   = 'S'

   if @dias = 0
   begin
      select @fecha_habil = @fecha
      return
   end

   select  @iContador   = 0
   select  @fecha_habil = @fecha

   while @feriado = 'S'
   begin

      select @fecha_habil = dateadd(day, @nrodia, @fecha_habil)

      select @mes = datepart(month, @fecha_habil)
      select @ano = datepart(year , @fecha_habil)

      if @mes = 01 select @campo = feene from VIEW_FERIADO where feano = @ano and feplaza = @plaza
      if @mes = 02 select @campo = fefeb from VIEW_FERIADO where feano = @ano and feplaza = @plaza
      if @mes = 03 select @campo = femar from VIEW_FERIADO where feano = @ano and feplaza = @plaza  
      if @mes = 04 select @campo = feabr from VIEW_FERIADO where feano = @ano and feplaza = @plaza  
      if @mes = 05 select @campo = femay from VIEW_FERIADO where feano = @ano and feplaza = @plaza  
      if @mes = 06 select @campo = fejun from VIEW_FERIADO where feano = @ano and feplaza = @plaza  
      if @mes = 07 select @campo = fejul from VIEW_FERIADO where feano = @ano and feplaza = @plaza  
      if @mes = 08 select @campo = feago from VIEW_FERIADO where feano = @ano and feplaza = @plaza
      if @mes = 09 select @campo = fesep from VIEW_FERIADO where feano = @ano and feplaza = @plaza  
      if @mes = 10 select @campo = feoct from VIEW_FERIADO where feano = @ano and feplaza = @plaza
      if @mes = 11 select @campo = fenov from VIEW_FERIADO where feano = @ano and feplaza = @plaza  
      if @mes = 12 select @campo = fedic from VIEW_FERIADO where feano = @ano and feplaza = @plaza

      if charindex(substring(convert(char(10),@fecha_habil,103),1,2),@campo) = 0
      begin    
         select @iContador = @iContador + 1
         if  @iContador = ABS(@dias)
         begin
            select @feriado = 'N'
         end   
      end 
      -- select @dias , @iContador , @fecha_habil
   end


   return
   
end
GO
