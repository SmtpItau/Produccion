USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[SP_RIEFIN_LEE_MATRIZ_COVARIANZA]    Script Date: 13-05-2022 10:37:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_RIEFIN_LEE_MATRIZ_COVARIANZA] 
AS
BEGIN

   SET NOCOUNT ON
   
   Begin
       Select Fila, Columna, Valor, TamannoMatriz from RIEFIN_Matriz_Covarianza	
   End 


 
END
GO
