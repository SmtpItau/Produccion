USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_FIN_DIA_POS_TICKET_SPOT]    Script Date: 11-05-2022 16:43:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_FIN_DIA_POS_TICKET_SPOT]
AS
BEGIN

   DECLARE @_Fecha_PROC DATETIME
   DECLARE @_Fecha_ANT DATETIME
 
   SELECT @_Fecha_PROC = ACFECPRO
          ,@_Fecha_ANT = ACFECANT
   FROM MEAC 

   DELETE tbl_posTicketSpot 
   WHERE Fecha_Posicion = @_Fecha_PROC
   
   INSERT INTO  tbl_posTicketSpot(Fecha_Posicion 
                                 ,CodMoneda
                                 ,CodMesa
                                 ,Posicion_Anterior
                                 ,Compras_Dia
                                 ,Ventas_Dia
                                 ,Posicion_Actual
                                 ,pmpInc
                                 ,pmpCmps
                                 ,pmpVnts
                                 ,pmpFin)
   SELECT @_Fecha_PROC
        , CodMoneda
        ,CodMesa
        ,Posicion_Actual
        ,0
        ,0
        ,0
        ,pmpFin
        ,0
        ,0
        ,0
   FROM tbl_posTicketSpot
   WHERE Fecha_Posicion = @_Fecha_ANT
END

GO
