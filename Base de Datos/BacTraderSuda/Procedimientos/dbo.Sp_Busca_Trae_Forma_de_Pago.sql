USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[Sp_Busca_Trae_Forma_de_Pago]    Script Date: 13-05-2022 11:31:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[Sp_Busca_Trae_Forma_de_Pago]


AS 

/***********************************************************************

NOMBRE         : dbo.[Sp_Busca_Trae_Forma_de_Pago].StoredProcedure.sql
AUTOR          : SONDA (Unidad de Desarrollo)
FECHA CREACION : 09/08/2011
DESCRIPCION    : Migracion a SQL 2008
HISTORICO DE CAMBIOS
FECHA        AUTOR           DESCRIPCION   
----------------------------------------------------------------------
**********************************************************************/
BEGIN

SET NOCOUNT ON

SELECT  codigo, glosa , cc2756 from FORMA_DE_PAGO order by glosa 

SET NOCOUNT OFF

END
GO
