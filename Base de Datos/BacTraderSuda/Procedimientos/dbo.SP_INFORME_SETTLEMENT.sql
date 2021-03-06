USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_INFORME_SETTLEMENT]    Script Date: 13-05-2022 11:31:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_INFORME_SETTLEMENT]
                  
as
begin
set nocount on
 declare @diferencia        numeric (4),
  @contador          integer    ,
  @registro          integer    ,
  @monto_operacion   float      ,
  @fecha_proceso     datetime   ,
           @fecha_operacion   datetime   ,
           @fecha_vencimiento datetime   ,
           @tipo_operacion    char (4)   ,
           @operacion         numeric    ,
  @valusd            float
        create table #PASS1(  rut_cliente       numeric(10),
                              codigo_rut        char(1),
         nombre      char(50), 
         fecha_proceso     datetime   , 
                              fecha_operacion   datetime   ,
                              fecha_vencimiento datetime   ,
                              tipo_operacion    char(04)   ,
                              operacion         float,
                              monto_operacion   float default 0,
                              monto0            float default 0,
                              monto1            float default 0,
                              monto2            float default 0,
                              monto3            float default 0,
                              monto4            float default 0,
                              monto5            float default 0,
                              monto610          float default 0)
     
 select @contador = 1
 select @valusd = vmvalor  from VIEW_VALOR_MONEDA,MDAC where vmcodigo = 13 and acfecproc = vmfecha 
  
 if @valusd = 0   
         select @valusd = 1  
 insert #PASS1( rut_cliente,
                       codigo_rut,
         nombre, 
                monto_operacion,
         fecha_proceso, 
                       fecha_operacion, 
                       fecha_vencimiento,
                       tipo_operacion, 
                       operacion )
                select distinct
                       rut_cliente,
                       cldv,
         clnombre,
                       (monto_operacion / @valusd), 
         acfecproc, 
                       fecha_operacion, 
                       fecha_vencimiento,
                       tipo_operacion, 
                       operacion
                 from GEN_OPERACIONES,VIEW_CLIENTE  ,MDAC
                 where fecha_vencimiento >= fecha_operacion and rut_cliente = clrut and codigo_rut = clcodigo and
                       fecha_vencimiento >=acfecproc   
 
 while @contador <= @registro
    begin
   set rowcount @contador
   select @monto_operacion   = monto_operacion  ,
          @fecha_proceso     = fecha_proceso    ,
          @fecha_operacion   = fecha_operacion  ,
          @fecha_vencimiento = fecha_vencimiento,
          @tipo_operacion    = tipo_operacion   ,
          @operacion         = operacion
   from #PASS1
    
 select @diferencia =    datediff(day,@fecha_operacion,@fecha_vencimiento) - datediff(day,@fecha_operacion,@fecha_proceso)
 where @fecha_proceso >= @fecha_operacion
 
 --select @diferencia,@fecha_proceso ,@fecha_operacion,@fecha_vencimiento 
 --datediff(day,@fecha_operacion,@fecha_proceso)
 
   set rowcount 0
   select @contador = @contador + 1
 
        if  @diferencia = 0    update #PASS1 set monto0   = monto_operacion where tipo_operacion = @tipo_operacion and operacion = @operacion
  if  @diferencia = 1    update #PASS1 set monto1   = monto_operacion where tipo_operacion = @tipo_operacion and operacion = @operacion
 if  @diferencia = 2    update #PASS1 set monto2   = monto_operacion where tipo_operacion = @tipo_operacion and operacion = @operacion
 
 if  @diferencia = 3    update #PASS1 set monto3   = monto_operacion where tipo_operacion = @tipo_operacion and operacion = @operacion
 if  @diferencia = 4    update #PASS1 set monto4   = monto_operacion where tipo_operacion = @tipo_operacion and operacion = @operacion
 if  @diferencia = 5    update #PASS1 set monto5   = monto_operacion where tipo_operacion = @tipo_operacion and operacion = @operacion
 if  @diferencia > 5    update #PASS1 set monto610 = monto_operacion where tipo_operacion = @tipo_operacion and operacion = @operacion
  end     
 select * from #PASS1
end        


GO
