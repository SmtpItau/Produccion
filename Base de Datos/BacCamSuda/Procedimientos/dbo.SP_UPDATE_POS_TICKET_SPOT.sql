USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_UPDATE_POS_TICKET_SPOT]    Script Date: 11-05-2022 16:43:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_UPDATE_POS_TICKET_SPOT]
       (
         @_Fecha_Operacion DateTime,
         @_CodMesa Smallint,
         @_CodMoneda Smallint
       )
AS
BEGIN


   DECLARE @COMPRAS FLOAT
   DECLARE @VENTAS  FLOAT
   DECLARE @PMPCOMPRAS FLOAT
   DECLARE @PMPVENTAS  FLOAT
   DECLARE @PMPFIN FLOAT


   IF NOT EXISTS (SELECT * FROM tbl_posTicketSpot
           				  WHERE Fecha_Posicion	= @_Fecha_Operacion
						  AND   CodMoneda		= @_CodMoneda
        				  AND   CodMesa			= @_CodMesa) 

   BEGIN
		INSERT INTO TBL_POSTICKETSPOT
			(	fecha_posicion
			,	codmoneda
			,	codmesa
			,	posicion_anterior
			,	Compras_Dia
			,	Ventas_Dia
			,	Posicion_Actual
			,	pmpInc
			,	pmpCmps
			,	pmpVnts
			,	pmpFin 
			)
		VALUES( @_fecha_operacion, 
                @_CodMoneda,
                @_CodMesa,
				0, 0, 0, 0, 0, 0 , 0 ,0 )
   END
 
   SET @COMPRAS = 0
   SET @VENTAS  = 0
   SET @PMPCOMPRAS = 0
   SET @PMPVENTAS  = 0
   SET @PMPFIN = 0

	SELECT	@COMPRAS			= SUM(MontoMoneda1) + @COMPRAS
	FROM	Tbl_movTicketSpot
	WHERE	Fecha_Operacion		= @_fecha_operacion
	AND		codmoneda1			= @_CodMoneda
	AND		codmesaorigen		= @_CodMesa
	AND		Tipo_Operacion		= 'C'
	AND		Estado_Operacion	= 'V'

   SELECT @VENTAS = SUM(MontoMoneda1)
     FROM Tbl_movTicketSpot
    WHERE Fecha_Operacion = @_fecha_operacion
      AND codmoneda1      = @_CodMoneda
      AND codmesaorigen   = @_CodMesa
      AND Tipo_Operacion  = 'V'
      AND   Estado_Operacion = 'V'

   SELECT @PMPCOMPRAS = SUM(MontoMoneda1 * TipoCambio)
   FROM Tbl_movTicketSpot
   WHERE Fecha_Operacion = @_fecha_operacion
      AND codmoneda1      = @_CodMoneda
      AND codmesaorigen   = @_CodMesa
      AND Tipo_Operacion  = 'C'
      AND   Estado_Operacion = 'V'

  SET @PMPCOMPRAS = @PMPCOMPRAS / case when @COMPRAS = 0 then 1 else @COMPRAS end

   SELECT @PMPVENTAS = SUM(MontoMoneda1 * TipoCambio)
   FROM Tbl_movTicketSpot
   WHERE Fecha_Operacion = @_fecha_operacion
      AND codmoneda1      = @_CodMoneda
      AND codmesaorigen   = @_CodMesa
      AND Tipo_Operacion  = 'V'
      AND   Estado_Operacion = 'V'

   SET @PMPVENTAS = @PMPVENTAS / case when @VENTAS = 0 then 1 else @VENTAS end
   

   SET @COMPRAS = ISNULL( @COMPRAS, 0 )
   SET @VENTAS  = ISNULL(  @VENTAS, 0 )
   SET @PMPCOMPRAS = ISNULL(@PMPCOMPRAS , 0)
   SET @PMPVENTAS = ISNULL(@PMPVENTAS, 0)

   UPDATE tbl_posTicketSpot
      SET Compras_Dia = @COMPRAS
        , Ventas_Dia  = @VENTAS
        , Posicion_Actual = posicion_anterior + @COMPRAS - @VENTAS
        , pmpCmps = @PMPCOMPRAS
        , pmpVnts = @PMPVENTAS
        , pmpFin = ( @COMPRAS * @PMPCOMPRAS + @VENTAS *  @PMPVENTAS) / case when (@COMPRAS + @VENTAS) = 0 then 1 else (@COMPRAS + @VENTAS) end
    WHERE fecha_posicion = @_fecha_operacion
      AND codmoneda      = @_CodMoneda
      AND codmesa        = @_CodMesa

END
GO
