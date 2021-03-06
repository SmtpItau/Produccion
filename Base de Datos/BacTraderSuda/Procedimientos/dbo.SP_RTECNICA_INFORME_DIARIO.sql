USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_RTECNICA_INFORME_DIARIO]    Script Date: 13-05-2022 11:31:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_RTECNICA_INFORME_DIARIO]
AS
BEGIN
 SET NOCOUNT ON
 --declaracion de variables locales 
 DECLARE @fecante DATETIME,
  @reserva NUMERIC,
  @saldos  NUMERIC,
  @exceso  NUMERIC,
  @insti   CHAR(100),
  @codigo  CHAR(3)
 --recupero la fecha de proceso
 SELECT  @fecante = acfecante
 FROM  mdac
 
 SELECT  @insti  = acnomprop,
  @codigo =  0-- accodigo
 FROM  mdac
 SELECT @reserva = ( SELECT SUM( reserva_mas ) FROM tbtr_cod_elg ) + ( SELECT SUM( reserva_menos ) FROM tbtr_cod_elg )
     + ( SELECT SUM( monto_ocupado ) FROM tbtr_mnl_me ) 
 SELECT @saldos = ( SELECT SUM( saldo_mas ) FROM tbtr_cod_elg ) + ( SELECT SUM( saldo_menos ) FROM tbtr_cod_elg )
    + ( SELECT SUM( monto_exigible ) FROM tbtr_mnl_me )
 SELECT @exceso = @reserva + ( SELECT SUM( monto ) FROM tbtr_pra_rsv_tcn  WHERE tipo = 2 ) - ( SELECT SUM( monto ) FROM tbtr_pra_rsv_tcn WHERE tipo = 1 )
 SELECT @fecante as fecha, @insti as institucion, @codigo as codigo, @reserva as reserva, @saldos as saldos, @exceso as exceso
END

GO
