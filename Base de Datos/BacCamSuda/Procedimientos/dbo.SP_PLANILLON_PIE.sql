USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_PLANILLON_PIE]    Script Date: 11-05-2022 16:43:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create procedure [dbo].[SP_PLANILLON_PIE]
            ( @fecha char(8) )
as
begin
     set nocount     on
     ------------------------------------------------------------------------------------------------------
     --- crea una tabla de resumen para las planillas de operaciones de cambio
     ------------------------------------------------------------------------------------------------------
     if exists( select name from sysobjects where name = '#RESUMEN_PLANILLAS' and type = 'U' )
        drop table #RESUMEN_PLANILLAS
     create table #RESUMEN_PLANILLAS (
             pos            int             default 0       ,
             tipo           char(1)         default 0       ,
             glosa          varchar(40)     default ''      ,
             codoma         int             default 0       ,
             cant           int             default 0       ,
             monto          float           default 0       ,
             codoma_anu     int             default 0       ,
             cant_anu       int             default 0       ,
             monto_anu      float           default 0       
     )            
     -------------------------------------------------------------------------------------------------------------------
     --- calculo de la seccion iii. grupo de ingresos
     -------------------------------------------------------------------------------------------------------------------
     insert into #RESUMEN_PLANILLAS execute Sp_Planillon_Pie_Seccion3 @fecha, 1,110,1,115,3, '1comercio invisible'
     insert into #RESUMEN_PLANILLAS execute Sp_Planillon_Pie_Seccion3 @fecha, 2,120,1,125,3, '1traspaso'
     insert into #RESUMEN_PLANILLAS execute Sp_Planillon_Pie_Seccion3 @fecha, 3,140,1,145,3, '1compras a bancos y arbitrajes'
     insert into #RESUMEN_PLANILLAS execute Sp_Planillon_Pie_Seccion3 @fecha, 4,  0,0,  0,0, '1casas de cambio y arbitrajes'
     insert into #RESUMEN_PLANILLAS execute Sp_Planillon_Pie_Seccion3 @fecha, 5,130,1,135,3, '1compras al banco central'
     insert into #RESUMEN_PLANILLAS execute Sp_Planillon_Pie_Seccion3 @fecha, 6,  0,0,  0,0, '1compras por cob.fuera de plazo'
     insert into #RESUMEN_PLANILLAS execute Sp_Planillon_Pie_Seccion3 @fecha, 7,540,1,540,3, '1compras por pago antic.cred.ext.'
     insert into #RESUMEN_PLANILLAS execute Sp_Planillon_Pie_Seccion3 @fecha, 8,500,1,500,3, '1com.visible exp. contado'
     insert into #RESUMEN_PLANILLAS execute Sp_Planillon_Pie_Seccion3 @fecha, 9,401,1,401,3, '1com.visible exp. antic. comp.'
     insert into #RESUMEN_PLANILLAS execute Sp_Planillon_Pie_Seccion3 @fecha,10,407,1,407,3, '1com.visible exp. cred. ext.'
     insert into #RESUMEN_PLANILLAS execute Sp_Planillon_Pie_Seccion3 @fecha,11,403,1,403,3, '1com.visible exp. cred. int.'
     insert into #RESUMEN_PLANILLAS execute Sp_Planillon_Pie_Seccion3 @fecha,12,  0,0,  0,0, '1com.visible exp. ablas'
     -------------------------------------------------------------------------------------------------------------------
     --- calculo de la seccion iii. grupo de egresos
     -------------------------------------------------------------------------------------------------------------------
     insert into #RESUMEN_PLANILLAS execute Sp_Planillon_Pie_Seccion3 @fecha, 1,210,2,215,2, '2comercio invisible'
     insert into #RESUMEN_PLANILLAS execute Sp_Planillon_Pie_Seccion3 @fecha, 2,220,2,225,2, '2traspaso'
     insert into #RESUMEN_PLANILLAS execute Sp_Planillon_Pie_Seccion3 @fecha, 3,240,2,245,2, '2ventas a bancos'
     insert into #RESUMEN_PLANILLAS execute Sp_Planillon_Pie_Seccion3 @fecha, 4,  0,0,  0,0, '2casas de cambio y arbitrajes'
     insert into #RESUMEN_PLANILLAS execute Sp_Planillon_Pie_Seccion3 @fecha, 5,  0,0,  0,0, '2cobertura importaciones'
     insert into #RESUMEN_PLANILLAS execute Sp_Planillon_Pie_Seccion3 @fecha, 6,  0,0,  0,0, '2planilla venta de cambios'
     insert into #RESUMEN_PLANILLAS execute Sp_Planillon_Pie_Seccion3 @fecha, 7,230,2,235,2, '2ventas al banco central'
     insert into #RESUMEN_PLANILLAS execute Sp_Planillon_Pie_Seccion3 @fecha, 8,  0,0,  0,0, '2ventas por cob.fuera de plazo'
     insert into #RESUMEN_PLANILLAS execute Sp_Planillon_Pie_Seccion3 @fecha, 9,  0,0,  0,0, '2ventas por pago antic.cred.ext.'
     insert into #RESUMEN_PLANILLAS execute Sp_Planillon_Pie_Seccion3 @fecha,10,  0,0,  0,0, '2cobertura sbf - importac.'
     -------------------------------------------------------------------------------------------------------------------
     --- agrupa los resultados
     -------------------------------------------------------------------------------------------------------------------
     declare @pos      int
     declare @execute  varchar(255)
     select  @pos   = 0
     delete from RPTPLANILLON
      
     insert into RPTPLANILLON (fechainforme, fechaemision, entidad, nombre) 
                      select convert(char(10), convert(datetime, @fecha), 103),
                             datename(weekday,acfecpro)+','+datename(day,acfecpro)+' de '+datename(month,acfecpro)+' de '+datename(year,acfecpro),
                             right( '000' + convert(varchar(3),accodigo),3) , 
                             acnombre
                        from MEAC
     while ( @pos < 12 )  begin
           select @pos = @pos + 1
           ----<< ingreso
           select @execute = 'update RPTPLANILLON set '
           select @execute = @execute + 'iglosa_' + convert(varchar(2),@pos) + '=glosa,' 
           select @execute = @execute + 'icant_'  + convert(varchar(2),@pos) + '=(cant +cant_anu ),' 
           select @execute = @execute + 'imonto_' + convert(varchar(2),@pos) + '=(monto-monto_anu)' 
           select @execute = @execute + ' from #RESUMEN_PLANILLAS'
           select @execute = @execute + ' where pos=' + convert(varchar(2),@pos) + ' and tipo=1'
           execute (@execute)
           ----<< egreso
           select @execute = 'update rptplanillon set '
           select @execute = @execute + 'eglosa_' + convert(varchar(2),@pos) + '=glosa,' 
           select @execute = @execute + 'ecant_'  + convert(varchar(2),@pos) + '=(cant +cant_anu ),' 
           select @execute = @execute + 'emonto_' + convert(varchar(2),@pos) + '=(monto-monto_anu)' 
           select @execute = @execute + ' from #RESUMEN_PLANILLAS'
           select @execute = @execute + ' where pos=' + convert(varchar(2),@pos) + ' and tipo=2'
           execute (@execute)
     end -- while
     -- drop table #resumen_planillas
     set nocount     off
     return 0
end


GO
