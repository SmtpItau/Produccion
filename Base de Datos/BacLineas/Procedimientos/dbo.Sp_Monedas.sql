USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[Sp_Monedas]    Script Date: 13-05-2022 10:37:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO






/****** Objeto:  procedimiento  almacenado dbo.Sp_Monedas    fecha de la secuencia de comandos: 03/04/2001 15:18:10 ******/
/****** Objeto:  procedimiento  almacenado dbo.Sp_Monedas    fecha de la secuencia de comandos: 14/02/2001 09:58:30 ******/
/*==========================================================================*/
/*==========================================================================*/
CREATE PROCEDURE [dbo].[Sp_Monedas]
AS
BEGIN
   /*=======================================================================*/
   /*=======================================================================*/
   SELECT       mncodmon              ,
                mnglosa               ,
                mnnemo                ,
                mnfactor              ,
                mnredondeo            ,
                mncodbanco            ,
                mncodsuper            ,
                mnbase                ,
                mnrefusd              ,
                mnlocal               ,
                mnextranj             ,
                mnvalor               ,
                mnrefmerc
          FROM  MONEDA
   ORDER BY mncodmon 
   /*=======================================================================*/
   /*=======================================================================*/
   RETURN
END






GO
