USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[SP_FINDBASE]    Script Date: 13-05-2022 10:37:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

/****** Objeto:  procedimiento  almacenado dbo.SP_FINDBASE    fecha de la secuencia de comandos: 03/04/2001 15:18:03 ******/
/****** Objeto:  procedimiento  almacenado dbo.SP_FINDBASE    fecha de la secuencia de comandos: 14/02/2001 09:58:25 ******/
CREATE PROCEDURE [dbo].[SP_FINDBASE]
AS
BEGIN
SELECT mncodmon ,
 mnnemo  ,
 mnsimbol ,
 mnglosa  ,
 mncodsuper ,
 mnnemsuper ,
 mncodbanco ,
 mnnembanco ,
 mnbase  ,
 mnredondeo ,
 mndecimal ,
 mncodpais ,
 mnrrda  ,
 mnfactor ,
 mnrefusd ,
 mnlocal  ,
 mnextranj ,
 mnvalor  , 
 mnrefmerc ,
 mningval ,
 mntipmon ,
 mnperiodo ,
 mnmx  ,
 mncodfox ,
 mnvalfox ,
 mncodcor ,
 codigo_pais ,
 mniso_coddes
  FROM 
   MONEDA
  WHERE 
   ISNULL(mnmx,'')<> 'C'
 
END
-- Sp_FindBase '$$'
 --  select * from mdpa
GO
