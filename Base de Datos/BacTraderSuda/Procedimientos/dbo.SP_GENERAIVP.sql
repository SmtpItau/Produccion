USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_GENERAIVP]    Script Date: 13-05-2022 11:31:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_GENERAIVP] 
                              ( @nmes     integer ,
                                @nann     integer ,
                                @nvalipc  float   )    
as
begin
--   set nocount on
   declare @mes      char(02)
   declare @mest     char(02)
   declare @mesa     char(02)
   declare @dfini    datetime
   declare @dffin    datetime
   declare @xfipc    datetime
   declare @xfecha   datetime
   declare @nivpini  float
   declare @f6matipc datetime
   declare @f6matras datetime
   declare @nipc6ma  float
   declare @ndifdias integer
   declare @nfacdias float
   declare @nfacaux  float
   declare @nfactor  float
   declare @nddias   integer
   declare @a        integer
   declare @nvalivp  float
   --*******************************************************************************  
   -- fecha de inicio mes actual
   --*******************************************************************************
   if @nmes < 10 begin
      select @mes = rtrim('0' + convert(char(1),@nmes))
   end else begin
      select @mes = rtrim(convert(char(2),@nmes))
   end
   select @dfini = convert(char(4),@nann) + @mes + '09'
   --******************************************************************************   
   -- fecha de termino mes termino
   --******************************************************************************
   if @nmes = 12 begin
      select @dffin = convert(char(4),@nann + 1) + '0109' 
   end else begin
      if @nmes >=9 begin
         select @mest = rtrim(convert(char(2),@nmes + 1))
      end else begin
         select @mest = '0' + rtrim(convert(char(1),@nmes + 1))
      end
      select @dffin = convert(char(4),@nann) + @mest + '09'
   end
   --******************************************************************************
   -- fecha de i.p.c. mes anterior
   --******************************************************************************
select '1'
select convert(char(4),@nann ) + '0'+ convert(char(2),@nmes - 1) + '01'
--select ltrim(rtrim(convert(char(4),@nann ))) + ltrim(rtrim(convert(char(2),@nmes - 1) + '01')
select @nann ,@nmes 
   if @nmes = 1 begin
      select @xfipc = convert(char(4),@nann - 1) + '1201'
   end else begin
      select @xfipc = convert(char(4),@nann ) + convert(char(2),@nmes - 1) + '01'
   end
   --*****************************************************************************   
   -- buscar valor uf de fecha de inicio
   --*****************************************************************************
   select       @nivpini = vmvalor 
          from  VIEW_VALOR_MONEDA
          where vmcodigo = 997       and
                vmfecha  = @dfini
   select @nivpini = isnull( @nivpini, 0.0 )
   --*****************************************************************************
   -- buscamos 6 meses atras
   --*****************************************************************************
   select @f6matipc = dateadd (month, -6, @xfipc)
   select @f6matras = dateadd (month, -6, @dfini)
   --*****************************************************************************
   -- busqueda del indice del i.p.c.
   --*****************************************************************************
   select       @nipc6ma = vmvalor 
          from  VIEW_VALOR_MONEDA 
          where vmcodigo = 502       and
                vmfecha  = @f6matipc  
   select @nipc6ma = isnull( @nipc6ma, 0)
   --*****************************************************************************
   -- calculo y grabacion de i.v.p.
   --*****************************************************************************
   select @ndifdias = datediff(day, @dfini , @f6matras)
   select @ndifdias = datediff(day, @f6matras, @dfini)
   execute SP_DIV  1.0 , @ndifdias, @nfacdias   output
   execute SP_DIV  @nvalipc, @nipc6ma, @nfacaux output
   select @nfactor = power ( isnull ( @nfacaux, 0.0) , @nfacdias )
   --*****************************************************************************
   --*****************************************************************************
   select @xfecha = dateadd  ( day, 1, @dfini )
   select @nddias = datediff ( day, @xfecha, @dffin) + 1
   select @a = 0
   --*****************************************************************************
   --*****************************************************************************
   while @a < @nddias begin
      select @a = @a + 1
      select @nvalivp = isnull( round ( @nivpini * power ( @nfactor, @a), 2), 0.0 )
      if exists(
                 select vmvalor 
                        from  VIEW_VALOR_MONEDA
                        where vmcodigo   = 997 and 
                              vmfecha = @xfecha
                ) begin
         update      VIEW_VALOR_MONEDA 
                set   vmvalor  = @nvalivp 
                where vmcodigo = 997       and
                      vmfecha  = @xfecha
      end else begin
         insert into VIEW_VALOR_MONEDA ( vmcodigo, vmvalor , vmfecha )
                                    values (      997, @nvalivp, @xfecha )
      end
       
      select @xfecha = dateadd(day, 1, @xfecha)
   end
   --*****************************************************************************
   -- grabamos el i.p.c.
   --*****************************************************************************
   if exists(
             select       vmvalor 
                    from  VIEW_VALOR_MONEDA 
                    where vmcodigo = 502 and
                          vmfecha  = @xfipc
            ) begin
      update VIEW_VALOR_MONEDA  set vmvalor = @nvalipc where vmcodigo = 502
                                          and   vmfecha  = @xfipc
   end else begin
      insert into VIEW_VALOR_MONEDA   ( vmcodigo, vmvalor , vmfecha )
                                 values (      502, @nvalipc, @xfipc  )
   end
   select @xfecha = dateadd  ( day, 1, @dfini )
   select       convert(char(10),vmfecha,103), vmvalor 
          from  VIEW_VALOR_MONEDA 
          where vmcodigo  = 997       and
                vmfecha  >= @xfecha   and
                vmfecha  < dateadd(day,@nddias,@xfecha)                  
--set nocount off       
end
                                          
--execute sp_generaivp 01, 2000,0.2

GO
