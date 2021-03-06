USE [BacSwapSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_LEERDATOSGENERALES]    Script Date: 13-05-2022 11:02:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_LEERDATOSGENERALES]  
 AS
 BEGIN
 SET NOCOUNT ON      --ADO

 SELECT            'Entidad'         = (SELECT Entidad          From SwapGeneral),
                   'Codigo'          = (SELECT Codigo           From SwapGeneral),
                   'Nombre'          = (SELECT Nombre           From SwapGeneral),
                   'Rut'             = (SELECT Rut              From SwapGeneral),
                   'Direccion'       = (SELECT Direccion        From SwapGeneral),
                   'Comuna'          = (SELECT Comuna           From SwapGeneral), 
		   'Ciudad'          = (SELECT Ciudad           From SwapGeneral), 
                   'Telefono'        = (SELECT Telefono         From SwapGeneral), 
		   'Fax'	     = (SELECT Fax              From SwapGeneral),
		   'FechaAnt'        = (SELECT FechaAnt         From SwapGeneral),
           	   'FechaProc'       = (SELECT FechaProc        From SwapGeneral),
                   'FechaProx'       = (SELECT FechaProx        From SwapGeneral),
		   'Numero_Operacion'= (SELECT Numero_Operacion From SwapGeneral),
		   'RutBCCh'         = (SELECT RutBCCh          From SwapGeneral),
  		   'InicioDia'       = (SELECT InicioDia        From SwapGeneral),
		   'Libor'           = (SELECT Libor            From SwapGeneral),
		   'Paridad'         = (SELECT Paridad          From SwapGeneral),
		   'TasaMtm'         = (SELECT TasaMtm          From SwapGeneral),
		   'Tasas'           = (SELECT Tasas            From SwapGeneral),
		   'FinDia'          = (SELECT FinDia           From SwapGeneral),
		   'CierreMesa'      = (SELECT CierreMesa       From SwapGeneral),
		   'CodigoBanco'     = (SELECT CodigoBanco      From SwapGeneral)
--	FROM SWAPGENERAL	 
    SET NOCOUNT OFF      --ADO
    RETURN 0
END
GO
