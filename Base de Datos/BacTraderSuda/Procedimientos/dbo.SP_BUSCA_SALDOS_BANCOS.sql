USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_BUSCA_SALDOS_BANCOS]    Script Date: 13-05-2022 11:31:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_BUSCA_SALDOS_BANCOS]( @FECHA_MOVIMIENTO DATETIME )
as
begin
create table #SALDOS ( cuenta_corta  char(15) default '', 
                       saldo         float    default 0 )
insert #SALDOS select cuenta_corta    ,
                      sum( case 
                           when GEN_MOVIMIENTO_CTA_CTE.tipo_movimiento = 'A' then GEN_MOVIMIENTO_CTA_CTE.monto
                           when GEN_MOVIMIENTO_CTA_CTE.tipo_movimiento = 'C' then GEN_MOVIMIENTO_CTA_CTE.monto * -1.0
                           end ) 
                 from GEN_MOVIMIENTO_CTA_CTE
                where GEN_MOVIMIENTO_CTA_CTE.fecha_movimiento = @fecha_movimiento
                group by GEN_MOVIMIENTO_CTA_CTE.cuenta_corta                    
select #SALDOS.cuenta_corta,
       MECC.cclbanco       ,
       MECC.cclcuenta      ,
       sum( saldo ) 
  from #SALDOS, MECC
 where #SALDOS.cuenta_corta = MECC.cclctacorta
 group by #SALDOS.cuenta_corta, MECC.cclbanco, MECC.cclcuenta
            
drop table #SALDOS
return 0
end   /* fin procedimiento */


GO
