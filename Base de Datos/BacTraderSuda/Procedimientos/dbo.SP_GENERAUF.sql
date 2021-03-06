USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_GENERAUF]    Script Date: 13-05-2022 11:31:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_GENERAUF] 
                             ( @nmes     integer ,
                               @nann     integer ,
                               @nvalipc  float   )    
as
begin
   set nocount on
   declare @mes     char(02)
   declare @mest    char(02)
   declare @mesa    char(02)
   declare @dfini   char(10)
   declare @dffin   char(10)
   declare @xfipc   char(10)
   declare @xfecha  char(10)
   declare @xfecini char(10)
   declare @nufini  float
   declare @nddias  integer
   declare @nvaluf  float
   declare @ntotal  float
   declare @ntotal1 float 
   declare @nfactor float
   declare @a       integer
  
-- fecha de inicio
------------------
   -- mes actual
   -------------
   if @nmes < 10  
      select @mes = rtrim('0' + convert(char(1),@nmes))
   else  
      select @mes = rtrim(convert(char(2),@nmes))
   select @dfini = @mes + '/' + '09' + '/' + convert(char(4),@nann) 
   
-- fecha de termino
-------------------
   -- mes termino
   ---------------
   if @nmes = 12 
      begin
        select @mest  = '01'
        select @dffin = @mest + '/' + '09' + '/' + convert(char(4),@nann + 1 )  
      end
   else
      begin
         if @nmes >= 9  
            select @mest = rtrim(convert(char(2),@nmes + 1))
         else
            select @mest = '0' + rtrim(convert(char(1),@nmes + 1))
            select @dffin = @mest + '/' + '09' + '/' + convert(char(4),@nann)  
      end    
 
-- fecha de i.p.c.
-------------------
   -- mes anterior
   ---------------
   if @nmes = 1
      select @mesa = '12'
   else
      select @mesa = convert(char(2),@nmes - 1)
   if datalength(rtrim(@mesa)) = 1  select @mesa = '0' + @mesa
      
   if @nmes = 1
   begin
      select @xfipc = @mesa + '/' + '01' + '/' + convert(char(4),@nann - 1)  
      select @xfecini = convert(char(4),@nann - 1) + @mesa + '09'
   end
   else       
   begin
      select @xfipc = @mesa + '/' + '01' + '/' + convert(char(4),@nann)   
      select @xfecini = convert(char(4),@nann) + @mesa + '09'
   end
-- buscar valor uf de fecha de inicio
-------------------------------------
   select @nufini = vmvalor from valor_moneda
                    where vmcodigo = 998
                    and   vmfecha  = @xfecini
--                    and   vmfecha  = @dfini
   if @nufini = 0 or @nufini is null
      select @nufini = 0.0
-- grabacion de una uf
-------------------------------------
   
   select @xfecha  = convert(char(10),dateadd(day, 1, @dfini),101)
   select @nddias  = datediff(day, @xfecha, @dffin ) + 1
   execute SP_DIV @nvalipc, 100.0, @ntotal output
   select @ntotal  = @ntotal + 1
   execute SP_DIV  1 , @nddias, @ntotal1 output
   select @nfactor = power( @ntotal ,@ntotal1 )
   select @a = 0
   while @a < @nddias
     begin
          select @a = @a + 1
          select @nvaluf = round ( @nufini * ( power ( @nfactor, @a) ), 2)                    
          if exists ( select vmvalor from VIEW_VALOR_MONEDA where vmcodigo = 998 and vmfecha  = @xfecha)
             update VIEW_VALOR_MONEDA set vmvalor = @nvaluf  
                             where vmcodigo = 998
                             and   vmfecha  = @xfecha
          else  
             insert into VIEW_VALOR_MONEDA   ( vmcodigo, vmvalor, vmfecha )
                         values ( 998     , @nvaluf, @xfecha )
          select @xfecha = convert(char(10), dateadd(day, 1, @xfecha),101)
     end 
-- grabar i.p.c.
----------------
   if exists ( select vmvalor from VIEW_VALOR_MONEDA where vmcodigo = 500 and vmfecha  = @xfipc and vmvalor <> 0 )
      update VIEW_VALOR_MONEDA set vmvalor = @nvalipc
               where vmcodigo = 500
               and   vmfecha  = @xfipc
   else  
      insert into VIEW_VALOR_MONEDA   ( vmcodigo, vmvalor, vmfecha )
                  values ( 500     , @nvalipc, @xfipc )
   
   set nocount off
   select  convert(char(10),vmfecha,103), vmvalor from VIEW_VALOR_MONEDA where vmcodigo = 998 
            and   vmfecha  >  @dfini
   return
      
end

GO
